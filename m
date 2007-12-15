From: Jeff King <peff@peff.net>
Subject: Re: trim_common_tail bug?
Date: Sat, 15 Dec 2007 10:51:50 -0500
Message-ID: <20071215155150.GA24810@coredump.intra.peff.net>
References: <20071215111621.GA8139@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 16:52:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3ZJJ-00086P-4g
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 16:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbXLOPvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 10:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753653AbXLOPvy
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 10:51:54 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2006 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbXLOPvy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 10:51:54 -0500
Received: (qmail 6269 invoked by uid 111); 15 Dec 2007 15:51:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 15 Dec 2007 10:51:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Dec 2007 10:51:50 -0500
Content-Disposition: inline
In-Reply-To: <20071215111621.GA8139@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68392>

On Sat, Dec 15, 2007 at 06:16:21AM -0500, Jeff King wrote:

> Something seems to be not quite right with the trim_common_tail code in
> xdiff-interface.c. The diff I just sent for contrib/completion looks
> fine (as I sent it) when I comment out trim_common_tail. But using
> the current master, it looks like this:

Hrm. It feels like there is an off-by-one when recovering the context
lines; we end the inner loop at the newline, but then we never skip past
it. So we end up counting only one line total, and even that ends up
with a missing newline. Something like this fixes it for me, but
somebody please double check.

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 700def2..eb60e88 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -124,6 +124,8 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 	for (i = 0, recovered = 0; recovered < trimmed && i <= ctx; i++) {
 		while (recovered < trimmed && ap[recovered] != '\n')
 			recovered++;
+		if (recovered < trimmed && ap[recovered] == '\n')
+			recovered++;
 	}
 	a->size -= (trimmed - recovered);
 	b->size -= (trimmed - recovered);
