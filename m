From: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Make git-apply --stat less butt-ugly with long filenames
Date: Thu, 28 Jul 2005 20:37:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507282031180.3307@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 29 05:38:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyLhL-0004z7-8D
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 05:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVG2Dh7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 23:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVG2Dh7
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 23:37:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44170 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261552AbVG2Dha (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 23:37:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6T3bOjA028988
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Jul 2005 20:37:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6T3bOXS006531;
	Thu, 28 Jul 2005 20:37:24 -0700
To: Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


When git-apply was printing out long filenames, it used to just truncate
them to show the last "max_len" characters of the filename. Which can be
really quite ugly (note the two filenames that have just been silently 
truncated from the beginning - it looks even worse when there are lots 
of them, like there were in the current v2.6.13-rc4 cris arch update):

 Documentation/video4linux/README.saa7134           |    9
 Documentation/video4linux/bttv/Cards               |   74
 umentation/video4linux/hauppauge-wintv-cx88-ir.txt |   54
 Documentation/video4linux/lifeview.txt             |   42
 mentation/video4linux/not-in-cx2388x-datasheet.txt |   41
 Documentation/w1/w1.generic                        |  107

With this patch it now looks like so:

 Documentation/video4linux/README.saa7134           |    9
 Documentation/video4linux/bttv/Cards               |   74
 .../video4linux/hauppauge-wintv-cx88-ir.txt        |   54
 Documentation/video4linux/lifeview.txt             |   42
 .../video4linux/not-in-cx2388x-datasheet.txt       |   41
 Documentation/w1/w1.generic                        |  107

ie we've made it clear with an ellipsis that we've cut off something from 
the beginning, and it also tries to do it cleanly at a subdirectory level.

Signed-off-by: Linus "good taste" Torvalds <torvalds@osdl.org>
---
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -737,6 +737,7 @@ static const char minuses[]= "----------
 
 static void show_stats(struct patch *patch)
 {
+	const char *prefix = "";
 	char *name = patch->new_name;
 	int len, max, add, del, total;
 
@@ -750,8 +751,15 @@ static void show_stats(struct patch *pat
 	max = max_len;
 	if (max > 50)
 		max = 50;
-	if (len > max)
+	if (len > max) {
+		char *slash;
+		prefix = "...";
+		max -= 3;
 		name += len - max;
+		slash = strchr(name, '/');
+		if (slash)
+			name = slash;
+	}
 	len = max;
 
 	/*
@@ -770,7 +778,7 @@ static void show_stats(struct patch *pat
 		add = (add * max + max_change / 2) / max_change;
 		del = total - add;
 	}
-	printf(" %-*s |%5d %.*s%.*s\n",
+	printf(" %s%-*s |%5d %.*s%.*s\n", prefix,
 		len, name, patch->lines_added + patch->lines_deleted,
 		add, pluses, del, minuses);
 }
