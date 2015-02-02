From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv5] sha1_file: fix iterating loose alternate objects
Date: Mon, 2 Feb 2015 15:27:33 -0500
Message-ID: <20150202202733.GB28915@peff.net>
References: <E05CAD49-755C-4F26-A527-597B1AD412D8@jonathonmah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathon Mah <me@jonathonmah.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YINau-0001Zz-3j
	for gcvg-git-2@plane.gmane.org; Mon, 02 Feb 2015 21:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbbBBU1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2015 15:27:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:44226 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964927AbbBBU1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2015 15:27:35 -0500
Received: (qmail 17476 invoked by uid 102); 2 Feb 2015 20:27:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 14:27:35 -0600
Received: (qmail 11512 invoked by uid 107); 2 Feb 2015 20:28:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 02 Feb 2015 15:28:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Feb 2015 15:27:33 -0500
Content-Disposition: inline
In-Reply-To: <E05CAD49-755C-4F26-A527-597B1AD412D8@jonathonmah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263286>

On Mon, Feb 02, 2015 at 12:05:54PM -0800, Jonathon Mah wrote:

> Simplified test per Junio (verified that it fails before and passes
> now). Punting on Jeff's "more elaborate example".

I think that's fine. I started to try to create such an example, but
it's actually rather tricky. If the alternate has the tip object, then
one of these must be true:

  1. It has all of the objects the tip depends on.

  2. It is missing an object, and this tip is part of the referenced
     history.

  3. It is missing an object, but this part of history is not
     referenced.

In case (1), we do not care about deleting objects from the base
repository; we already have another copy in the alternate.

In case (2), the alternate is corrupt, and all bets are off.

In case (3), we can only have dropped the object from the alternate by
pruning it and keeping the tip object that refers to it. Which is the
exact thing that this new code was added to avoid (to always keep
depended-upon objects).

So I actually do not see how the situation would come up in practice,
and possibly we could drop the iteration of the alternates' loose
objects entirely from this code. But certainly that is orthogonal to
Jonathon's fix (which is a true regression for the less-exotic case that
his test demonstrates).

-Peff
