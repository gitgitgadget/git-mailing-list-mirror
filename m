From: Jeff King <peff@peff.net>
Subject: Re: [RFD/PATCH] add: ignore only ignored files
Date: Thu, 20 Nov 2014 10:56:21 -0500
Message-ID: <20141120155621.GA30273@peff.net>
References: <3f78d6c1e35c87049daaac6cb1257ea8310a90bb.1416408015.git.git@drmicha.warpmail.net>
 <20141119191502.GC9908@peff.net>
 <xmqqbno2rhlz.fsf@gitster.dls.corp.google.com>
 <546DB778.2000000@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:56:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrU5u-0006uo-MF
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 16:56:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757572AbaKTP4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 10:56:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:42796 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757564AbaKTP4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 10:56:24 -0500
Received: (qmail 13407 invoked by uid 102); 20 Nov 2014 15:56:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 09:56:23 -0600
Received: (qmail 13290 invoked by uid 107); 20 Nov 2014 15:56:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Nov 2014 10:56:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2014 10:56:21 -0500
Content-Disposition: inline
In-Reply-To: <546DB778.2000000@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 10:42:16AM +0100, Michael J Gruber wrote:

> >> Perhaps we could do a hybrid: add the files that were not ignored, but
> >> then still exit non-zero. Careful scripts need to check the exit status
> >> of "git add" anyway, and sloppy humans with over-broad wildcards
> >> typically do not care about the exit status.
> > 
> > ;-)
> > 
> 
> You can simply say "Michael" in your last subclause above :)
> 
> I'm wondering whether that behaviour change (without --ignore-errors) is
> OK - I don't mind, but hey, I usually don't.

I can't think of a case that it really hurts, but then I have not
thought too hard on it. If you want to play with it, I think the patch
is as simple as:

diff --git a/builtin/add.c b/builtin/add.c
index ae6d3e2..1074e32 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -284,7 +284,7 @@ static int add_files(struct dir_struct *dir, int flags)
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
 		fprintf(stderr, _("Use -f if you really want to add them.\n"));
-		die(_("no files added"));
+		exit_status = 1;
 	}
 
 	for (i = 0; i < dir->nr; i++)

It needs a tweak to t3700.35, which expects the "fatal:" line on stderr.
But other than that, it passes all tests. So it must be good, right? :)

-Peff
