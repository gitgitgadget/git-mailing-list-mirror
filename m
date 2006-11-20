X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff opens too many files?
Date: Mon, 20 Nov 2006 13:02:24 -0800
Message-ID: <7vfycd25nj.fsf@assigned-by-dhcp.cox.net>
References: <fcaeb9bf0611200212s6ddb0518k24f85223acfed08b@mail.gmail.com>
	<Pine.LNX.4.64.0611200832450.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 21:02:38 +0000 (UTC)
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611200832450.3692@woody.osdl.org> (Linus
	Torvalds's message of "Mon, 20 Nov 2006 09:00:55 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31938>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmGHd-00021n-83 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 22:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966692AbWKTVC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 16:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966731AbWKTVC0
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 16:02:26 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11915 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S966692AbWKTVCZ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 16:02:25 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120210225.HJLT4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 20
 Nov 2006 16:02:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id p91v1V00d1kojtg0000000; Mon, 20 Nov 2006
 16:01:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Junio? This is your speciality, I'm not sure how painful it would be to 
> unmap and remap on demand.. (or switch it to some kind of "keep the last 
> <n> mmaps active" kind of thing to avoid having thousands and thousands of 
> mmaps active).
>
> One simple thing that might be worth it is to simply _not_ use mmap() at 
> all for small files. If a file is less than 1kB, it might be better to do 
> a malloc() and a read() - partly because it avoids having tons of file 
> descriptors, but partly because it's also more efficient from a virtual 
> memory usage perspective (not that you're probably very likely to ever 
> really hit that problem in practice).
>
> Nguyen - that "use malloc+read" thing might be a quick workaround, but 
> only if you have tons of _small_ files (and if you can't easily just 
> increase file-max). 

So here is a lunch-time hack to get Nguyen unstuck.

-- >8 --
[PATCH] diff.c: avoid mmap() of small files in populate_filespec()

This would hopefully behave better in VM usage.  It is not a
real fix if you are dealing with truly huge diff, in which case
we would have to LRU out the data in memory for filespecs that
are not used in immediate future.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/diff.c b/diff.c
index 3315378..af50b6f 100644
--- a/diff.c
+++ b/diff.c
@@ -1294,11 +1294,22 @@ int diff_populate_filespec(struct diff_f
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		if (s->size < MINIMUM_MMAP) {
+			s->data = xmalloc(s->size);
+			s->should_free = 1;
+			if (xread(fd, s->data, s->size) != s->size) {
+				free(s->data);
+				goto err_empty;
+			}
+		}
+		else {
+			s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE,
+				       fd, 0);
+			s->should_munmap = 1;
+		}
 		close(fd);
 		if (s->data == MAP_FAILED)
 			goto err_empty;
-		s->should_munmap = 1;
 	}
 	else {
 		char type[20];
diff --git a/diffcore.h b/diffcore.h
index 2249bc2..f129aa0 100644
--- a/diffcore.h
+++ b/diffcore.h
@@ -21,6 +21,7 @@
 #define DEFAULT_MERGE_SCORE  36000 /* maximum for break-merge to happen 60%) */
 
 #define MINIMUM_BREAK_SIZE     400 /* do not break a file smaller than this */
+#define MINIMUM_MMAP	      4096 /* do not mmap a file smaller than this */
 
 struct diff_filespec {
 	unsigned char sha1[20];
