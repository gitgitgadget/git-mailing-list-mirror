From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] branch: reorganize verbose options
Date: Fri, 30 Aug 2013 17:59:43 -0500
Message-ID: <1377903583-3550-3-git-send-email-felipe.contreras@gmail.com>
References: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 01:04:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFXk3-0006Xi-MV
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 01:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756631Ab3H3XE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 19:04:29 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:39784 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756238Ab3H3XE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 19:04:26 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so2971628oah.39
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HblAhIbRqfLUaY540XtFo1kQmEfdhqt+vUcHQYUW+e8=;
        b=TP+2AnP1NykcAxAui/7brkI9VHeJgGKS4rbwozJUNTKMSpXKVXrapkDniINnxhxLrR
         4Anlru3KVD0UQhUlwA04ZnmKyPqc98/5OuD0CWEkSe7sY9LC3CqxHA4ywEwke9lG/2Xi
         oI0PcE41e6oVdzrwdGPY/4rbtUNZoOs3IFahr8leths3tWSAI5INrmEs4e9H+qp0uSf8
         sptER0RdigK7hTwLNc+UZ5NJnMotUzOaR1cm+EI01wzam/d4i48+FLVWAroLjHYL+etr
         wsCEKI1DNCxsAGpgh/tfxl1goGhzqFgkyKk5KuFQotmk0VYmSg2TxmKCxK5RaGkM7zHv
         AA1g==
X-Received: by 10.182.110.202 with SMTP id ic10mr8611282obb.73.1377903865957;
        Fri, 30 Aug 2013 16:04:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm420501obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 16:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377903583-3550-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233482>

Showing the upstream tracking branch is more important than how many
commits are ahead/behind, so now 'git branch -v' shows the upstream, but
not the tracking info, and 'git branch -vv' shows all information (as
before).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c         | 22 ++++++++++------------
 t/t6040-tracking-info.sh |  8 ++++----
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index ac17b18..baa1d31 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -417,15 +417,15 @@ static int ref_cmp(const void *r1, const void *r2)
 }
 
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
-		int show_upstream_ref)
+		int show_tracking)
 {
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 
-	if (!stat_tracking_info(branch, &ours, &theirs)) {
-		if (!branch || !branch->merge || !branch->merge[0]->dst || !show_upstream_ref)
+	if (!show_tracking || !stat_tracking_info(branch, &ours, &theirs)) {
+		if (!branch || !branch->merge || !branch->merge[0]->dst)
 			return;
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 		if (want_color(branch_use_color))
@@ -437,15 +437,13 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		return;
 	}
 
-	if (show_upstream_ref) {
-		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
-		if (want_color(branch_use_color))
-			strbuf_addf(&fancy, "%s%s%s",
-					branch_get_color(BRANCH_COLOR_UPSTREAM),
-					ref, branch_get_color(BRANCH_COLOR_RESET));
-		else
-			strbuf_addstr(&fancy, ref);
-	}
+	ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+	if (want_color(branch_use_color))
+		strbuf_addf(&fancy, "%s%s%s",
+				branch_get_color(BRANCH_COLOR_UPSTREAM),
+				ref, branch_get_color(BRANCH_COLOR_RESET));
+	else
+		strbuf_addstr(&fancy, ref);
 
 	if (!ours) {
 		if (ref)
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index ec2b516..86e80eb 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -36,10 +36,10 @@ test_expect_success setup '
 
 script='s/^..\(b.\)[	 0-9a-f]*\[\([^]]*\)\].*/\1 \2/p'
 cat >expect <<\EOF
-b1 ahead 1, behind 1
-b2 ahead 1, behind 1
-b3 behind 1
-b4 ahead 2
+b1 origin/master
+b2 origin/master
+b3 origin/master
+b4 origin/master
 EOF
 
 test_expect_success 'branch -v' '
-- 
1.8.4-fc
