From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 6 Mar 2013 15:03:47 -0500
Message-ID: <20130306200347.GA20312@sigill.intra.peff.net>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 21:04:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDKZU-0004Uh-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 21:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab3CFUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 15:03:50 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38316 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098Ab3CFUDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 15:03:50 -0500
Received: (qmail 28672 invoked by uid 107); 6 Mar 2013 20:05:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 15:05:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 15:03:47 -0500
Content-Disposition: inline
In-Reply-To: <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217540>

On Wed, Mar 06, 2013 at 08:26:57PM +0100, Antoine Pelisse wrote:

> > however the difference isn't that easy to spot any more. I expected
> >
> >         diff --cc file
> >         index a07e697,5080129..0000000
> >         --- a/file
> >         +++ b/file
> >         @@@ -12,7 -12,7 +12,12 @@@
> >           12
> >           13
> >           14
> >         ++<<<<<<< ours
> >          +15
> >         ++||||||| base
> >         ++=======
> >         + 16
> >         ++>>>>>>> theirs
> >           17
> >           18
> >           19
> 
> This is not correct, it would mean that 12, 13, 14, 17, 18, 19 are in
> base, while they are not.

Yeah, I agree it is a bit of a lie, as you are not seeing the full
picture of what was in the base. That is why we intentionally dial down
the conflict simplification level when using diff3. If you apply this
patch to git:

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 9e13b25..f381e0c 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -420,15 +420,6 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1,
 	int style = xmp->style;
 	int favor = xmp->favor;
 
-	if (style == XDL_MERGE_DIFF3) {
-		/*
-		 * "diff3 -m" output does not make sense for anything
-		 * more aggressive than XDL_MERGE_EAGER.
-		 */
-		if (XDL_MERGE_EAGER < level)
-			level = XDL_MERGE_EAGER;
-	}
-
 	c = changes = NULL;
 
 	while (xscr1 && xscr2) {

then it will produce the output that Uwe expects. While it can be
misleading, I also think it can make some conflicts (like this one) much
easier to understand. I don't see any reason we can't have a "zealous
diff3" mode to let people view this output, as long as it is not the
default.

-Peff
