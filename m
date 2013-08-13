From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v5 1/2] branch: not report invalid tracking branch
Date: Tue, 13 Aug 2013 12:53:48 +0800
Message-ID: <96e0ed4f67eaf058466ead9228cad0dcfe1b5c6a.1376369554.git.worldhello.net@gmail.com>
References: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Aug 13 06:55:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V96dm-0007bC-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 13 Aug 2013 06:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab3HMEzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Aug 2013 00:55:24 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:59235 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3HMEzW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Aug 2013 00:55:22 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so4388620pde.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 21:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h54WXxUIvlcLFWKchMcVjJUSLI/+gZAY7QhNQUH/+Z8=;
        b=B+RZM/kxYAYdXufsz1U+k7o8mPlnvi6JKO7gq4/t2BEWV9jtyP8hV7uTK/bh1HaxzM
         ovNe/jUQku9qdRrtcuKjZwF6CMAkFUFTouo7ks4tVg3zkuQ0eXJZY4GzCRfwc3K9smmU
         njWXGzmZbm4pvXMltxr/dtl2wnJaAiXul5aEp3pCiR7jOFTZtR/M4fwtQlMSQb5vuxf/
         W5vnVUADdzT4RgaNZDWlCOYllxE98mwetmnIa6jgekLqrFGe9nsugfOc+368MTySUodv
         XjfUUBm2Y6zkO1OKkhIEV3VxNxb9PNEnpRu1A1U1GopB1GI1PKMC8+UXqL+marmNTgmH
         lchQ==
X-Received: by 10.68.229.2 with SMTP id sm2mr2540416pbc.68.1376369722267;
        Mon, 12 Aug 2013 21:55:22 -0700 (PDT)
Received: from localhost.localdomain ([114.246.129.124])
        by mx.google.com with ESMTPSA id dg3sm41181259pbc.24.2013.08.12.21.55.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 21:55:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.430.g417e2f3
In-Reply-To: <CANYiYbFGBRV+EP8oV_chKvBsHLAAZeKmt0395_z9QD-bBZtErQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232209>

Command "git branch -vv" will report tracking branches, but invalid
tracking branches are also reported. This is because the function
stat_tracking_info() can not distinguish whether the upstream branch
does not exist, or nothing is changed between one branch and its
upstream.

This patch changes the return value of function stat_tracking_info().
Only returns false when there is no tracking branch or the tracking
branch is invalid, otherwise true. If the caller does not like to
report tracking info when nothing changed between the branch and its
upstream, simply checks if num_theirs and num_ours are both 0.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 builtin/branch.c | 18 +++++-------------
 remote.c         | 24 ++++++++++++------------
 wt-status.c      | 13 +++++++++++--
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..359e75d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -424,19 +424,8 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	struct branch *branch = branch_get(branch_name);
 	struct strbuf fancy = STRBUF_INIT;
 
-	if (!stat_tracking_info(branch, &ours, &theirs)) {
-		if (branch && branch->merge && branch->merge[0]->dst &&
-		    show_upstream_ref) {
-			ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
-			if (want_color(branch_use_color))
-				strbuf_addf(stat, "[%s%s%s] ",
-						branch_get_color(BRANCH_COLOR_UPSTREAM),
-						ref, branch_get_color(BRANCH_COLOR_RESET));
-			else
-				strbuf_addf(stat, "[%s] ", ref);
-		}
+	if (!stat_tracking_info(branch, &ours, &theirs))
 		return;
-	}
 
 	if (show_upstream_ref) {
 		ref = shorten_unambiguous_ref(branch->merge[0]->dst, 0);
@@ -448,7 +437,10 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 			strbuf_addstr(&fancy, ref);
 	}
 
-	if (!ours) {
+	if (!ours && !theirs) {
+		if (ref)
+			strbuf_addf(stat, _("[%s]"), fancy.buf);
+	} else if (!ours) {
 		if (ref)
 			strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
 		else
diff --git a/remote.c b/remote.c
index 2433467..c747936 100644
--- a/remote.c
+++ b/remote.c
@@ -1729,7 +1729,8 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 }
 
 /*
- * Return true if there is anything to report, otherwise false.
+ * Return false if cannot stat a tracking branch (not exist or invalid),
+ * otherwise true.
  */
 int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 {
@@ -1740,18 +1741,12 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	const char *rev_argv[10], *base;
 	int rev_argc;
 
-	/*
-	 * Nothing to report unless we are marked to build on top of
-	 * somebody else.
-	 */
+	/* False unless we are marked to build on top of somebody else. */
 	if (!branch ||
 	    !branch->merge || !branch->merge[0] || !branch->merge[0]->dst)
 		return 0;
 
-	/*
-	 * If what we used to build on no longer exists, there is
-	 * nothing to report.
-	 */
+	/* False if what we used to build on no longer exists */
 	base = branch->merge[0]->dst;
 	if (read_ref(base, sha1))
 		return 0;
@@ -1765,9 +1760,12 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	if (!ours)
 		return 0;
 
+	*num_theirs = 0;
+	*num_ours = 0;
+
 	/* are we the same? */
 	if (theirs == ours)
-		return 0;
+		return 1;
 
 	/* Run "rev-list --left-right ours...theirs" internally... */
 	rev_argc = 0;
@@ -1786,8 +1784,6 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	prepare_revision_walk(&revs);
 
 	/* ... and count the commits on each side. */
-	*num_ours = 0;
-	*num_theirs = 0;
 	while (1) {
 		struct commit *c = get_revision(&revs);
 		if (!c)
@@ -1815,6 +1811,10 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
 		return 0;
 
+	/* Nothing to report if neither side has changes. */
+	if (!num_ours && !num_theirs)
+		return 0;
+
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
 	if (!num_theirs) {
diff --git a/wt-status.c b/wt-status.c
index ff4b324..0c6a3a5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1380,15 +1380,24 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	branch = branch_get(s->branch + 11);
 	if (s->is_initial)
 		color_fprintf(s->fp, header_color, _("Initial commit on "));
+
+	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+
+	/*
+	 * Not report tracking info if no tracking branch found
+	 * or no difference found.
+	 */
 	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
-		color_fprintf(s->fp, branch_color_local, "%s", branch_name);
+		fputc(s->null_termination ? '\0' : '\n', s->fp);
+		return;
+	}
+	if (!num_ours && !num_theirs) {
 		fputc(s->null_termination ? '\0' : '\n', s->fp);
 		return;
 	}
 
 	base = branch->merge[0]->dst;
 	base = shorten_unambiguous_ref(base, 0);
-	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", base);
 
-- 
1.8.4.rc1.430.g417e2f3
