From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] branch: colour upstream branches
Date: Sun, 14 Apr 2013 18:38:27 -0500
Message-ID: <1365982707-25455-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 01:39:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URWWV-00031S-6a
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 01:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab3DNXjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 19:39:37 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63385 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab3DNXjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 19:39:36 -0400
Received: by mail-qc0-f174.google.com with SMTP id z24so1321616qcq.5
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 16:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=zU9Z7lO9USTzFPfh8EzshYd3r53qlp5C5M9ZBRunJ/o=;
        b=LjPe3errC/d3ReNmBO4MIG0aTctILJzqBJSBEn8i8NLTG7rXM6APK1NOVnt2Xv5VDF
         dD96UbkYKlBiWMrRCxVhLXzzl3VjEocM6bIa1GYP4oq6fpnLteDelwmOJmc+X+Pz05Ts
         rcB5hRSa7DWkLK5tnF/v3EWyg5nRliEIHpgB6zRmXtmUxit90m7wEXg/GW7LxBcCQL6i
         lUy9wRtAOpGvzHXChUoGnrkGJtWXYWMqLRo7oaeXYuNbKJAfe5sZyS8BkSQTIIgzzZ/C
         7BEGbv+sGC2HRPlGhpzQNOSGKUmTDVZpSlhmvT5Ht6QU7WpF1x2keFqfi60KvSWf1blD
         aRQw==
X-Received: by 10.224.72.148 with SMTP id m20mr20031176qaj.24.1365982776044;
        Sun, 14 Apr 2013 16:39:36 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id k8sm28333227qej.2.2013.04.14.16.39.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 16:39:34 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.643.ge3cc75d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221166>

Otherwise when using 'git branch -vv' it's hard to see them among so
much output.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt |  3 ++-
 builtin/branch.c         | 35 +++++++++++++++++++++++++++--------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bc750d5..302533f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -794,7 +794,8 @@ color.branch::
 color.branch.<slot>::
 	Use customized color for branch coloration. `<slot>` is one of
 	`current` (the current branch), `local` (a local branch),
-	`remote` (a remote-tracking branch in refs/remotes/), `plain` (other
+	`remote` (a remote-tracking branch in refs/remotes/),
+	`upstream` (upstream tracking branch), `plain` (other
 	refs).
 +
 The value for these configuration variables is a list of colors (at most
diff --git a/builtin/branch.c b/builtin/branch.c
index 00d17d2..9696419 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -40,13 +40,15 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RED,		/* REMOTE */
 	GIT_COLOR_NORMAL,	/* LOCAL */
 	GIT_COLOR_GREEN,	/* CURRENT */
+	GIT_COLOR_BLUE,		/* UPSTREAM */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
 	BRANCH_COLOR_PLAIN = 1,
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
-	BRANCH_COLOR_CURRENT = 4
+	BRANCH_COLOR_CURRENT = 4,
+	BRANCH_COLOR_UPSTREAM = 5,
 };
 
 static enum merge_filter {
@@ -71,6 +73,8 @@ static int parse_branch_color_slot(const char *var, int ofs)
 		return BRANCH_COLOR_LOCAL;
 	if (!strcasecmp(var+ofs, "current"))
 		return BRANCH_COLOR_CURRENT;
+	if (!strcasecmp(var+ofs, "upstream"))
+		return BRANCH_COLOR_UPSTREAM;
 	return -1;
 }
 
@@ -417,32 +421,47 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
+	char fancy[80];
 
 	if (!stat_tracking_info(branch, &ours, &theirs)) {
 		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref)
-			strbuf_addf(stat, "[%s] ",
-			    shorten_unambiguous_ref(branch->merge[0]->dst, 0));
+		    show_upstream_ref) {
+			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+			if (want_color(branch_use_color))
+				strbuf_addf(stat, "[%s%s%s] ",
+						branch_get_color(BRANCH_COLOR_UPSTREAM),
+						ref, branch_get_color(BRANCH_COLOR_RESET));
+			else
+				strbuf_addf(stat, "[%s] ", ref);
+		}
 		return;
 	}
 
-	if (show_upstream_ref)
+	if (show_upstream_ref) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
+		if (want_color(branch_use_color))
+			snprintf(fancy, sizeof(fancy), "%s%s%s",
+					branch_get_color(BRANCH_COLOR_UPSTREAM),
+					ref, branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strncpy(fancy, ref, sizeof(fancy));
+	}
+
 	if (!ours) {
 		if (ref)
-			strbuf_addf(stat, _("[%s: behind %d]"), ref, theirs);
+			strbuf_addf(stat, _("[%s: behind %d]"), fancy, theirs);
 		else
 			strbuf_addf(stat, _("[behind %d]"), theirs);
 
 	} else if (!theirs) {
 		if (ref)
-			strbuf_addf(stat, _("[%s: ahead %d]"), ref, ours);
+			strbuf_addf(stat, _("[%s: ahead %d]"), fancy, ours);
 		else
 			strbuf_addf(stat, _("[ahead %d]"), ours);
 	} else {
 		if (ref)
 			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
-				    ref, ours, theirs);
+				    fancy, ours, theirs);
 		else
 			strbuf_addf(stat, _("[ahead %d, behind %d]"),
 				    ours, theirs);
-- 
1.8.2.1.643.ge3cc75d
