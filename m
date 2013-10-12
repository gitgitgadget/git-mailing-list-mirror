From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH try2 8/8] branch: display publish branch
Date: Sat, 12 Oct 2013 02:06:00 -0500
Message-ID: <1381561561-20459-8-git-send-email-felipe.contreras@gmail.com>
References: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Cc: Matthieu Moy <matthieu.moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtPY-0006VD-KW
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab3JLHOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:48 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34648 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3JLHMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:20 -0400
Received: by mail-ob0-f177.google.com with SMTP id wm4so3409401obc.22
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6atV1S8bW4jLPReZD2yh0Vw/WMthQSiZHJI4mOpBV6w=;
        b=WRmiYRQnMHLLzlWmahxEDw9aJ7p7A9uiQkLb3/6QRXR7rqeS7YNOWaA3Dgqrzy1u2C
         is4ROe1qEu2tIylLZZh5OU3zVtS2I3KG7+nnd+kOlj2K0a++6c8B007BfOI6FL49LE2V
         WU7MtiwV4+AhvVUT8E0n2gUlezpTMqbGpk5/fFHJvvfTIW+Ww/ZMQW8rSH/OgPQd7791
         Ns7PhATbYDSSa6RJK3XymB5Jt6FiS+bEXjZ1LFgvQRAzHifH1OmfSkPgWGHFf6oxsmEI
         eXh9sueLd+StvvYHnYttpTTDwXNvB2UaIsq+i17xrGGhSVj9IrEaEAqKPVP2QssY3al1
         CypQ==
X-Received: by 10.182.246.74 with SMTP id xu10mr17770676obc.23.1381561940306;
        Sat, 12 Oct 2013 00:12:20 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm28650892obc.12.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561561-20459-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236035>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/branch.c | 52 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index cf33e1c..9f15f7e 100644
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
 
@@ -424,16 +428,35 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 
+	if (!branch)
+		return;
+
 	if (!show_tracking || !stat_tracking_info(branch, &ours, &theirs)) {
-		if (!branch || !branch->merge || !branch->merge[0]->dst)
+		if (branch->merge && branch->merge[0]->dst) {
+			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+			if (want_color(branch_use_color))
+				strbuf_addf(&fancy, "%s%s%s",
+						branch_get_color(BRANCH_COLOR_UPSTREAM),
+						ref, branch_get_color(BRANCH_COLOR_RESET));
+			else
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
+		}
+		if (!fancy.len)
 			return;
-		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
-		if (want_color(branch_use_color))
-			strbuf_addf(stat, "[%s%s%s] ",
-					branch_get_color(BRANCH_COLOR_UPSTREAM),
-					ref, branch_get_color(BRANCH_COLOR_RESET));
-		else
-			strbuf_addf(stat, "[%s] ", ref);
+		strbuf_addf(stat, _("[%s]"), fancy.buf);
+		strbuf_release(&fancy);
+		strbuf_addch(stat, ' ');
 		return;
 	}
 
@@ -444,6 +467,17 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 				ref, branch_get_color(BRANCH_COLOR_RESET));
 	else
 		strbuf_addstr(&fancy, ref);
+	if (branch->push.dst) {
+		ref = shorten_unambiguous_ref(branch->push.dst, 0);
+		if (fancy.len)
+			strbuf_addstr(&fancy, ", ");
+		if (want_color(branch_use_color))
+			strbuf_addf(&fancy, "%s%s%s",
+					branch_get_color(BRANCH_COLOR_PUBLISH),
+					ref, branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strbuf_addstr(&fancy, ref);
+	}
 
 	if (!ours) {
 		if (ref)
-- 
1.8.4-fc
