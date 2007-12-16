From: Jeff King <peff@peff.net>
Subject: Re: trim_common_tail bug?
Date: Sun, 16 Dec 2007 02:06:14 -0500
Message-ID: <20071216070614.GA5072@sigill.intra.peff.net>
References: <20071215111621.GA8139@coredump.intra.peff.net> <20071215155150.GA24810@coredump.intra.peff.net> <7vprx7n90t.fsf@gitster.siamese.dyndns.org> <20071215200202.GA3334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 08:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3naI-0002lD-G6
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 08:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbXLPHGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 02:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752306AbXLPHGT
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 02:06:19 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3165 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbXLPHGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 02:06:18 -0500
Received: (qmail 20055 invoked by uid 111); 16 Dec 2007 07:06:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 16 Dec 2007 02:06:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2007 02:06:14 -0500
Content-Disposition: inline
In-Reply-To: <20071215200202.GA3334@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68441>

On Sat, Dec 15, 2007 at 03:02:02PM -0500, Jeff King wrote:

> >   	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
> > 		while (recovered < trimmed && ap[recovered++] != '\n')
> > 	        	; /* nothing */
> > 	}
> > 
> > then (warning: I haven't had my coffee yet)?
> 
> Yes, I think that is equivalent. My sleep-deprived brain keeps thinking
> there must be a more clear way of writing this whole loop, but it
> escapes me at the moment.

And this came to me in a dream. :) It fixes the bug, and I think it is a
bit simpler to see the termination conditions in a single loop. But
please double-check correctness, and that you agree that it is more
readable.

---
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 700def2..98b02ed 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -110,7 +110,7 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 {
 	const int blk = 1024;
-	long trimmed = 0, recovered = 0, i;
+	long trimmed = 0, recovered = 0;
 	char *ap = a->ptr + a->size;
 	char *bp = b->ptr + b->size;
 	long smaller = (a->size < b->size) ? a->size : b->size;
@@ -121,10 +121,9 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 		bp -= blk;
 	}
 
-	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
-		while (recovered < trimmed && ap[recovered] != '\n')
-			recovered++;
-	}
+	while (recovered < trimmed && ctx)
+		if (ap[recovered++] == '\n')
+			ctx--;
 	a->size -= (trimmed - recovered);
 	b->size -= (trimmed - recovered);
 }
