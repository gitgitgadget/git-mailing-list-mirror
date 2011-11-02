From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] Git 1.7.8.rc0
Date: Wed, 2 Nov 2011 14:10:41 -0400
Message-ID: <20111102181041.GA5366@sigill.intra.peff.net>
References: <7vfwi9rc0g.fsf@alter.siamese.dyndns.org>
 <4EAEAE13.50101@atlas-elektronik.com>
 <4EAFC18A.1070502@atlas-elektronik.com>
 <7vmxcfn23i.fsf@alter.siamese.dyndns.org>
 <loom.20111101T205618-231@post.gmane.org>
 <loom.20111101T211624-511@post.gmane.org>
 <20111102180327.GA30668@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Stefan Naewe <stefan.naewe@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 19:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLfH0-00073o-1L
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 19:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab1KBSKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 14:10:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60284
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249Ab1KBSKo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 14:10:44 -0400
Received: (qmail 15070 invoked by uid 107); 2 Nov 2011 18:16:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 14:16:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 14:10:41 -0400
Content-Disposition: inline
In-Reply-To: <20111102180327.GA30668@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184652>

On Wed, Nov 02, 2011 at 02:03:27PM -0400, Jeff King wrote:

> Without using a configured remote, try this (with .netrc configured):
> 
>   git push https://github.com/user/repo.git :refs/heads/nothing
> 
> which should work, and then this:
> 
>   git push https://user@github.com/user/repo.git :refs/heads/nothing
> 
> which will do the "must hit enter to accept password" thing.
> 
> That fails even with v1.7.7. I didn't bisect, but it has been there
> quite a while (v1.6.6 has it, but v1.6.5 has a weird error, so I didn't
> bisect further).

OK, I see the issue.

The logic is "if we have a username, but not a password, then ask for
the password before trying any http" (this is what avoids the extra
round trip).

But if you are using netrc, we don't parse it ourselves. We just tell
curl "when you are making the request, check netrc, too".

So the ideal logic is:

  1. look in netrc

  2. If we have a username and no password, ask for password

  3. Otherwise, try it and see if we get a 401.

But we can't do that, because (1) and (3) happen atomically inside of
curl.

The simplest thing is to just drop the behavior in (2), and let it drop
to a 401. The extra round trip probably isn't that big a deal.

The other option is to start parsing netrc ourselves, or do the extra
round trip if we detect ~/.netrc or something. But that last one is
getting pretty hackish.

-Peff
