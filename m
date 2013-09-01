From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 6/6] branch: display publish branch
Date: Sun,  1 Sep 2013 03:26:42 -0500
Message-ID: <1378024002-26190-7-git-send-email-felipe.contreras@gmail.com>
References: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 01 10:31:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG34e-00018i-Ht
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab3IAIbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:31:51 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61070 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab3IAIbj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:31:39 -0400
Received: by mail-ob0-f174.google.com with SMTP id wd6so3440949obb.5
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f9AbS1WBYmjkijMyuYwiHdiOuUifosPKWaXsLYbckvg=;
        b=KbX8VZCtsAP/SLbc+i0vG0m2WWtO5FNHJcGLyEM7Pf2hoq73wOSdkMWE9WKQ+HmGHY
         B+ReKPTKzlUg9/gYSTyrevraAhg1xhIsFPgh/Mm7pTKwwtpq4R2WUXYkARXEFZCcEQFu
         SCWGzLpQtWsRA+pDh0Z5iIt54y1k7G4EFpRahtSGhE2QFjYGI02yOOgFZ1SVvg5a5GrP
         l2RtTtP7pAQ49LQU89dKFqL191GmdOgrM3fzCW5Eugt+GslqrDDnmqUwh3ghczzRuV9Q
         lcm91YucG0GtZaesjHx8hfXEUz44mizMFzUNp0ssat+3vJLXhS4NQcK1jG1vy9jFSkUr
         IcmQ==
X-Received: by 10.182.148.8 with SMTP id to8mr13079556obb.17.1378024299328;
        Sun, 01 Sep 2013 01:31:39 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id d3sm7754909oek.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Sep 2013 01:31:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-337-g7358a66-dirty
In-Reply-To: <1378024002-26190-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233574>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 48af999..47644ad 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -42,6 +42,7 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* LOCAL */
 	GIT_COLOR_GREEN,	/* CURRENT */
 	GIT_COLOR_BLUE,		/* UPSTREAM */
+	GIT_COLOR_YELLOW,	/* PUBLISH */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
@@ -49,7 +50,8 @@ enum color_branch {
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
 	BRANCH_COLOR_CURRENT = 4,
-	BRANCH_COLOR_UPSTREAM = 5
+	BRANCH_COLOR_UPSTREAM = 5,
+	BRANCH_COLOR_PUBLISH = 6
 };
 
 static enum merge_filter {
@@ -76,6 +78,8 @@ static int parse_branch_color_slot(const char *var, int ofs)
 		return BRANCH_COLOR_CURRENT;
 	if (!strcasecmp(var+ofs, "upstream"))
 		return BRANCH_COLOR_UPSTREAM;
+	if (!strcasecmp(var+ofs, "publish"))
+		return BRANCH_COLOR_PUBLISH;
 	return -1;
 }
 
@@ -424,17 +428,37 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 
+	if (!branch)
+		return;
+
 	if (!stat_tracking_info(branch, &ours, &theirs)) {
-		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref) {
+		if (!show_upstream_ref)
+			return;
+		if (branch->merge && branch->merge[0]->dst) {
 			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
 			if (want_color(branch_use_color))
-				strbuf_addf(stat, "[%s%s%s] ",
+				strbuf_addf(&fancy, "%s%s%s",
 						branch_get_color(BRANCH_COLOR_UPSTREAM),
 						ref, branch_get_color(BRANCH_COLOR_RESET));
 			else
-				strbuf_addf(stat, "[%s] ", ref);
+				strbuf_addstr(&fancy, ref);
+		}
+		if (branch->push.dst) {
+			ref = shorten_unambiguous_ref(branch->push.dst, 0);
+			if (fancy.len)
+				strbuf_addstr(&fancy, ", ");
+			if (want_color(branch_use_color))
+				strbuf_addf(&fancy, "%s%s%s",
+						branch_get_color(BRANCH_COLOR_PUBLISH),
+						ref, branch_get_color(BRANCH_COLOR_RESET));
+			else
+				strbuf_addstr(&fancy, ref);
 		}
+		if (!fancy.len)
+			return;
+		strbuf_addf(stat, _("[%s]"), fancy.buf);
+		strbuf_release(&fancy);
+		strbuf_addch(stat, ' ');
 		return;
 	}
 
@@ -446,6 +470,17 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 					ref, branch_get_color(BRANCH_COLOR_RESET));
 		else
 			strbuf_addstr(&fancy, ref);
+		if (branch->push.dst) {
+			ref = shorten_unambiguous_ref(branch->push.dst, 0);
+			if (fancy.len)
+				strbuf_addstr(&fancy, ", ");
+			if (want_color(branch_use_color))
+				strbuf_addf(&fancy, "%s%s%s",
+						branch_get_color(BRANCH_COLOR_PUBLISH),
+						ref, branch_get_color(BRANCH_COLOR_RESET));
+			else
+				strbuf_addstr(&fancy, ref);
+		}
 	}
 
 	if (!ours) {
-- 
1.8.4-337-g7358a66-dirty
