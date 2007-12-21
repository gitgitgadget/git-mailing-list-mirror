From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linux 2.6.24-rc6
Date: Thu, 20 Dec 2007 20:58:42 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712202054350.21557@woody.linux-foundation.org>
References: <alpine.LFD.0.9999.0712201731010.21557@woody.linux-foundation.org> <20071221024805.GB8535@fattire.cabal.ca> <20071221030152.GC8535@fattire.cabal.ca> <alpine.LFD.0.9999.0712201937470.21557@woody.linux-foundation.org>
 <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Kyle McMartin <kyle@mcmartin.ca>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 05:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5Zyx-0007qW-64
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 05:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760857AbXLUE7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 23:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760327AbXLUE7B
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 23:59:01 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58021 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753325AbXLUE66 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Dec 2007 23:58:58 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL4whq8007484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 20 Dec 2007 20:58:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBL4wh3D030470;
	Thu, 20 Dec 2007 20:58:43 -0800
In-Reply-To: <alpine.LFD.0.9999.0712202009290.21557@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.712 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69041>



On Thu, 20 Dec 2007, Linus Torvalds wrote:
>
> And here's the git patch to avoid this optimization when there is 
> context.

Actually, the code to finding one '\n' is still needed to avoid the 
(pathological) case of getting a "\No newline", so scrap that one which 
was too aggressive, and use this (simpler) one instead.

Not that it matters in real life, since nobody uses -U0, and "git blame" 
won't care. But let's get it right anyway ;)

This whole function has had more bugs than it has lines.

		Linus

---
 xdiff-interface.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 9ee877c..711029e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -115,15 +115,18 @@ static void trim_common_tail(mmfile_t *a, mmfile_t *b, long ctx)
 	char *bp = b->ptr + b->size;
 	long smaller = (a->size < b->size) ? a->size : b->size;
 
+	if (ctx)
+		return;
+
 	while (blk + trimmed <= smaller && !memcmp(ap - blk, bp - blk, blk)) {
 		trimmed += blk;
 		ap -= blk;
 		bp -= blk;
 	}
 
-	while (recovered < trimmed && 0 <= ctx)
+	while (recovered < trimmed)
 		if (ap[recovered++] == '\n')
-			ctx--;
+			break;
 	a->size -= (trimmed - recovered);
 	b->size -= (trimmed - recovered);
 }
