From: Jeff King <peff@peff.net>
Subject: Re: [RFC] ident: support per-path configs by matching the path
 against a pattern
Date: Fri, 10 Jul 2015 11:43:08 -0400
Message-ID: <20150710154308.GA29395@peff.net>
References: <0000014e7752e758-a0bf7acb-2d0f-4492-8004-8eeeb9b2f042-000000@eu-west-1.amazonses.com>
 <xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 17:43:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDaSK-0005Bf-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 17:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbbGJPnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 11:43:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:58589 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754023AbbGJPnL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 11:43:11 -0400
Received: (qmail 13847 invoked by uid 102); 10 Jul 2015 15:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 10:43:11 -0500
Received: (qmail 8999 invoked by uid 107); 10 Jul 2015 15:43:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Jul 2015 11:43:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jul 2015 11:43:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr3ogkpz5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273821>

On Fri, Jul 10, 2015 at 08:10:54AM -0700, Junio C Hamano wrote:

> I do agree it is a good feature to have to allow you to keep a
> centralized registry of possible configuration in a single place,
> e.g. $HOME/.gitconfig, and selectively apply pieces for multiple
> places.
> 
> Having said that, a few comments.
> 
>  - It feels very hacky to only do this for the ident.  You would
>    want to have, (conceptually, not necessarily at the syntax level)
>    something more along the lines of:
> 
>    	if path matches this pattern
>         	[user]
>                 	email = address
>                         name = name
> 	end
> 
>    to allow any configuration to be covered by this new "selectively
>    use from the centralized registry" feature.

Yeah, I agree it would be nice to cover all config keys. Since it's
syntactically difficult to add conditionals to the existing config
format, I tried to leave open a space for this in the "include" design.
That is, right now:

  [include]
  path = foo

will unconditionally include "foo". But something like:

  [include "gitdir:bar"]
  path = foo

could do so only when the "gitdir:bar" conditional is satisfied (where
that is just a syntax I made up to mean fnmatch("bar", $GIT_DIR)). So
like user.<pattern>.*, we still put our section-specific hack into one
special section, but that one place is capable of chaining to multiple
other config keys. :)

My only request is that any conditional we add have some prefix (like
"gitdir:") so that we have space to add more types later if we choose.

There's discussion on this topic somewhere on the list, but I didn't
bother to dig it up. I don't think it adds anything over what I
summarized above.

-Peff
