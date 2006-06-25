From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] whatchanged: Default to DIFF_FORMAT_RAW
Date: Sun, 25 Jun 2006 15:39:35 +0300
Message-ID: <20060625153935.6b1e485c.tihirvon@gmail.com>
References: <20060624201843.a5b4f7b9.tihirvon@gmail.com>
	<20060624202153.1001a66c.tihirvon@gmail.com>
	<20060625141102.b68a7cae.tihirvon@gmail.com>
	<7vy7vltppj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 14:39:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuTu9-00061d-Pj
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 14:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWFYMjj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 08:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWFYMjj
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 08:39:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15694 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWFYMjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 08:39:39 -0400
Received: by nf-out-0910.google.com with SMTP id m19so465603nfc
        for <git@vger.kernel.org>; Sun, 25 Jun 2006 05:39:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SlbprjwFJy0x5dn/U3F4G20JR+glICGmNj9/sJBG7jazqKx1cOHeXaqXMCl5ls55Jt+Uz0hYozilzQcGOJsm0IKykkMnQarPAeYX6kBCcz2DHq7eL80sYHMFqwZhez8IuSOi4gC+yHAcImzLhaEClQ86osoIE4MSUo6wBZJNhtk=
Received: by 10.48.223.13 with SMTP id v13mr4052800nfg;
        Sun, 25 Jun 2006 05:39:37 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id p20sm4392661nfc.2006.06.25.05.39.36;
        Sun, 25 Jun 2006 05:39:37 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7vltppj.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22620>

Split cmd_log_wc() to cmd_log_init() and cmd_log_walk() and set default
diff output format for whatchanged to DIFF_FORMAT_RAW.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

  Forget the previous patch, this is cleaner.

 builtin-log.c |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 5b3fadc..28cd8bf 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -14,22 +14,22 @@ #include "builtin.h"
 /* this is in builtin-diff.c */
 void add_head(struct rev_info *revs);
 
-static int cmd_log_wc(int argc, const char **argv, char **envp,
+static void cmd_log_init(int argc, const char **argv, char **envp,
 		      struct rev_info *rev)
 {
-	struct commit *commit;
-
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
-	if (rev->always_show_header) {
-		if (rev->diffopt.pickaxe || rev->diffopt.filter)
-			rev->always_show_header = 0;
-	}
-
+	if (rev->diffopt.pickaxe || rev->diffopt.filter)
+		rev->always_show_header = 0;
 	if (argc > 1)
 		die("unrecognized argument: %s", argv[1]);
+}
+
+static int cmd_log_walk(struct rev_info *rev)
+{
+	struct commit *commit;
 
 	prepare_revision_walk(rev);
 	setup_pager();
@@ -51,7 +51,10 @@ int cmd_whatchanged(int argc, const char
 	rev.diff = 1;
 	rev.diffopt.recursive = 1;
 	rev.simplify_history = 0;
-	return cmd_log_wc(argc, argv, envp, &rev);
+	cmd_log_init(argc, argv, envp, &rev);
+	if (!rev.diffopt.output_format)
+		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+	return cmd_log_walk(&rev);
 }
 
 int cmd_show(int argc, const char **argv, char **envp)
@@ -66,7 +69,8 @@ int cmd_show(int argc, const char **argv
 	rev.always_show_header = 1;
 	rev.ignore_merges = 0;
 	rev.no_walk = 1;
-	return cmd_log_wc(argc, argv, envp, &rev);
+	cmd_log_init(argc, argv, envp, &rev);
+	return cmd_log_walk(&rev);
 }
 
 int cmd_log(int argc, const char **argv, char **envp)
@@ -76,7 +80,8 @@ int cmd_log(int argc, const char **argv,
 	init_revisions(&rev);
 	rev.always_show_header = 1;
 	rev.diffopt.recursive = 1;
-	return cmd_log_wc(argc, argv, envp, &rev);
+	cmd_log_init(argc, argv, envp, &rev);
+	return cmd_log_walk(&rev);
 }
 
 static int istitlechar(char c)
-- 
1.4.1.rc1.g39849-dirty
