From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 2/2] branch: reorganize verbose options
Date: Sat, 12 Oct 2013 02:00:29 -0500
Message-ID: <1381561229-19947-3-git-send-email-felipe.contreras@gmail.com>
References: <1381561229-19947-1-git-send-email-felipe.contreras@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:06:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtHe-0001Ff-LL
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab3JLHGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:06:37 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:38904 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab3JLHGg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:06:36 -0400
Received: by mail-ob0-f173.google.com with SMTP id wo20so3439744obc.18
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HblAhIbRqfLUaY540XtFo1kQmEfdhqt+vUcHQYUW+e8=;
        b=fi80vVkCh6d8XmHrRQI+uqsHawupWiOctnR5CDUcCsyYzu38v8Ejx2aBXjPRDAIRP6
         wugofwLJFzgagPBR3e8jJjuZo1/Pi/tZnsMHrx1z1Cr7d11gqbD4j9qQ/r/cO5JTRY0H
         6D9qBT+P/dHNIGubWIbcXpSR9wtxCq3/ai6snQ9IVu/iOR8VXYdKB8TPD42xcPufBpd3
         PAr4ajXLQws6Ott2BoSKzYD/bTB3HlTgPAF819glxe9SMS83uExAc+7AsUz5hKrdCdK3
         vDerIYctyDVKg9N0t5kceaJXYU9SSMlpiymPRcpSsYxIhCXC3DobBUJyt9Z6rVJZX8gG
         wb0A==
X-Received: by 10.182.28.134 with SMTP id b6mr17868513obh.27.1381561595720;
        Sat, 12 Oct 2013 00:06:35 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm101353686oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:06:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561229-19947-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235947>

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
