From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3] branch: colour upstream branches
Date: Sun, 14 Apr 2013 21:37:49 -0500
Message-ID: <1365993469-6874-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>,
	Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 04:39:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URZK1-0007eO-Dl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 04:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756335Ab3DOCjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 22:39:04 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:34216 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778Ab3DOCjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 22:39:03 -0400
Received: by mail-qa0-f46.google.com with SMTP id p6so310658qad.5
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 19:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=iUytWGV+0uoXRKJznaOzQSMWNgiR4Z1sTwWMkdF3sRk=;
        b=dGFBi0eX7JuAL7DN9GV0nzh6maRiTHXIb7vX1ED6mA1xIz1H1YwxmZwbkIh3xG4Hop
         NOPgE3owZFyiKrbjFMDEuTymLGSfuvql/jK61PlPcQq06FyVagYc7trPCjPAbXPHwaSC
         p8w7ZoznwAgHJqYHB+TaFG+6adsDUYnkkKZMvTtjy2eMzHUA2SQewND2Ju3UL2jF8rrP
         ttOrZU0A/24s8yRkZ4550KdvS8AD0sGak19Ek92l0tzRyccceFeKBLPuVcd9I/poDQZ4
         zFvIrMwljWCFDgYcvdug9mm/Fbl0bstoJYOSe3FCW9/OcySFAwAayfr3xihpfMQ9nroT
         zh4g==
X-Received: by 10.49.60.1 with SMTP id d1mr23890282qer.33.1365993542463;
        Sun, 14 Apr 2013 19:39:02 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id i4sm30022885qai.5.2013.04.14.19.38.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Apr 2013 19:39:01 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.643.ge3cc75d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221185>

Otherwise when using 'git branch -vv' it's hard to see them among so
much output.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

This time with strbuf.

 Documentation/config.txt |  3 ++-
 builtin/branch.c         | 38 ++++++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 9 deletions(-)

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
index 00d17d2..26e9322 100644
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
 
@@ -417,36 +421,54 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	int ours, theirs;
 	char *ref = NULL;
 	struct branch *branch = branch_get(branch_name);
+	struct strbuf fancy;
+
+	strbuf_init(&fancy, 0);
 
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
+			strbuf_addf(&fancy, "%s%s%s",
+					branch_get_color(BRANCH_COLOR_UPSTREAM),
+					ref, branch_get_color(BRANCH_COLOR_RESET));
+		else
+			strbuf_addstr(&fancy, ref);
+	}
+
 	if (!ours) {
 		if (ref)
-			strbuf_addf(stat, _("[%s: behind %d]"), ref, theirs);
+			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
 		else
 			strbuf_addf(stat, _("[behind %d]"), theirs);
 
 	} else if (!theirs) {
 		if (ref)
-			strbuf_addf(stat, _("[%s: ahead %d]"), ref, ours);
+			strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
 		else
 			strbuf_addf(stat, _("[ahead %d]"), ours);
 	} else {
 		if (ref)
 			strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
-				    ref, ours, theirs);
+				    fancy.buf, ours, theirs);
 		else
 			strbuf_addf(stat, _("[ahead %d, behind %d]"),
 				    ours, theirs);
 	}
+	strbuf_release(&fancy);
 	strbuf_addch(stat, ' ');
 	free(ref);
 }
-- 
1.8.2.1.643.ge3cc75d
