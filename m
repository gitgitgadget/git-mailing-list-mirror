From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Wed, 23 Dec 2015 15:01:33 -0500
Message-ID: <20151223200133.GA19199@sigill.intra.peff.net>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
 <CACsJy8DDKW4np7N+KA=dpz9uNke0+cyQD-J3U74VM=4WbsjrKQ@mail.gmail.com>
 <20151205074444.GD21639@sigill.intra.peff.net>
 <567A6EE9.3030600@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 23 21:01:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBpbY-0001kP-8D
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 21:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059AbbLWUBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 15:01:38 -0500
Received: from cloud.peff.net ([50.56.180.127]:45651 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756917AbbLWUBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 15:01:36 -0500
Received: (qmail 10525 invoked by uid 102); 23 Dec 2015 20:01:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Dec 2015 14:01:36 -0600
Received: (qmail 10103 invoked by uid 107); 23 Dec 2015 20:01:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Dec 2015 15:01:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Dec 2015 15:01:33 -0500
Content-Disposition: inline
In-Reply-To: <567A6EE9.3030600@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282951>

On Wed, Dec 23, 2015 at 10:52:41AM +0100, Michael Haggerty wrote:

> On 12/05/2015 08:44 AM, Jeff King wrote:
> > [...]
> > I think the config option needs to be extensions.refsBackendType, too,
> > per the logic in 00a09d5 (introduce "extensions" form of
> > core.repositoryformatversion, 2015-06-23). And I guess it needs to bump
> > core.repositoryformatversion to "1".
> 
> I think also, strictly speaking, the extensions.refsBackendType option
> should be ignored if core.repositoryFormatVersion is not "1". In
> practice, it probably makes more sense for the code to error out in that
> case because it is likely the result of a bug.

Yeah, I agree. It's not wrong, but it may be a good indication the user
is confused. Perhaps issuing a warning would be appropriate.

> Note that if the user explicitly chooses the "files" backend, it would
> be preferable to leave "core.repositoryFormatVersion" at "0" (assuming
> that no other extension is being used) and leave
> "extensions.refsBackendType" unset. This approach creates a repository
> that is compatible with older clients that don't know about
> refsBackendTypes.

Also agreed. This is going to be the case for basically every
"extension" option. If the extension config key isn't present, there
will be some default backwards-compatible behavior, and for
compatibility, you are always better off turning off the extension than
setting turning it "on" with that default value. This is the case for
the "preciousObjects" extension: there is no point in setting it to
"false" as opposed to removing it.

So I think the rules for setting an extension value should be:

  1. If you're setting it to the default value, then remove it
     completely.

  2. If you're removing it, and there are no other extensions, set
     repositoryFormatVersion back to 0.

Of course there's currently no code that sets extension values. And
doing step 1 is going to be specific to each extension. So this a
general philosophy to follow, not something we would write in a
function.

-Peff
