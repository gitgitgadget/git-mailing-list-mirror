From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 2/8] branch: reorganize verbose options
Date: Sat, 12 Oct 2013 02:05:58 -0500
Message-ID: <1381561561-20459-6-git-send-email-felipe.contreras@gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNA-0004mg-AT
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab3JLHMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:18 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:56203 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720Ab3JLHMP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:15 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3079417oag.21
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HblAhIbRqfLUaY540XtFo1kQmEfdhqt+vUcHQYUW+e8=;
        b=hOV/LNQkRbOasmfy5Hbijas/TdT6Bcgg4qbhAiVUdukjM3TeaL9qdL6+Ife4bAmN6m
         IEnjfM8hoTF4WutNNtAgJVQxjHxpsqMUsJZKYF8B/z21LMjS9UFCddhwjbbAwQYaeOmk
         co8pNkcv0EM4e+8cZBKAI12G8gikZ8wI6w8atBdIiGtoEZWx/Tg2xlHHzkMpGbl06KzB
         1T+oBgznGP+UEChBiGQG4lwezb5TNBbvpr07P0eJiO5XjV0shuZQ+PkhBPJp0tg3WfY4
         axTUaoo7TAab4AhVSjQumPDDF72/pQtW/S1gZl6rwGzc21sAHMYAeT50UsU/uH7Fvig6
         8nzA==
X-Received: by 10.60.40.67 with SMTP id v3mr18204587oek.16.1381561935144;
        Sat, 12 Oct 2013 00:12:15 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id y1sm101364077oek.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235986>

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
