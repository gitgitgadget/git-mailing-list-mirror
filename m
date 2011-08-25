From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 5/5] branch: give patchsame count with -vvv
Date: Thu, 25 Aug 2011 10:30:22 +0200
Message-ID: <1b532b894c26c6b31c94760222715b5eb5cc45bb.1314259226.git.git@drmicha.warpmail.net>
References: <4E5607E0.1050300@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Schubert <mschub@elegosoft.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 10:30:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwVKl-0008Qu-1a
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 10:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752941Ab1HYIak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 04:30:40 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39709 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752879Ab1HYIah (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 04:30:37 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7D0F92077C;
	Thu, 25 Aug 2011 04:30:36 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 25 Aug 2011 04:30:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=9H
	lIY9BRg2gTfkZXvRz3Ws3DPQM=; b=ZKijTO6X80V/llz4Fi6fyI9L5YiU6snQ9F
	AnVw1Ofi+0a1qFeYOkncNKDLd/umbyBVH0SDackOnzGSHllsYPSy+8ZdB+U1Bfln
	+coUQBJ9mjCRExsiMSsoWD9yfrQgzAuEVmq3QNDW30X4grcolofGkwhwovoVds6O
	s6SVC1hZ8=
X-Sasl-enc: WTw/jYvxEMFaiPhhrCuHvWLzXbTWuCVxAj06foXFs6Ik 1314261035
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D371984014F;
	Thu, 25 Aug 2011 04:30:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <4E5607E0.1050300@drmicha.warpmail.net>
In-Reply-To: <cover.1314259226.git.git@drmicha.warpmail.net>
References: <cover.1314259226.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180070>

This results in output like such as

  mjg/attr-filetype                    9d2536e [origin/next: ahead 35,
behind 1430, same 46] attr: make attributes depend on file type

all on one line.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-branch.txt |    2 ++
 builtin/branch.c             |   24 ++++++++++++++++--------
 remote.c                     |   12 +++++++++---
 remote.h                     |    2 +-
 t/t6040-tracking-info.sh     |   19 ++++++++++++++++++-
 wt-status.c                  |    2 +-
 6 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 59d729a..770b2e4 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -117,6 +117,8 @@ OPTIONS
 	Show sha1 and commit subject line for each head, along with
 	the name of the upstream branch (if any). If given twice, print
 	the relationship to the upstream branch (ahead/behind), as well.
+	If given three times, show ahead/behind/same information like
+	`git rev-list --count --cherry-mark`.
 	`--list` is implied by all verbosity options.
 
 --abbrev=<length>::
diff --git a/builtin/branch.c b/builtin/branch.c
index 21ef5fc..0984bb7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -361,7 +361,7 @@ static int ref_cmp(const void *r1, const void *r2)
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		int verbose)
 {
-	int ours, theirs;
+	int ours, theirs, patchsame = 0;
 	struct branch *branch = branch_get(branch_name);
 
 	/* verbose >= 1 */
@@ -370,14 +370,22 @@ static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 	strbuf_addch(stat, '[');
 	strbuf_addstr(stat, shorten_unambiguous_ref(branch->merge[0]->dst, 0));
 
-	if (verbose >= 2 && stat_tracking_info(branch, &ours, &theirs)) {
-		strbuf_addstr(stat, ": ");
-		if (!ours)
-			strbuf_addf(stat, _("behind %d"), theirs);
-		else if (!theirs)
+	if (verbose >= 2 && stat_tracking_info(branch, &ours, &theirs, (verbose >=3) ? &patchsame : NULL)) {
+		strbuf_addstr(stat, _(": "));
+		const char *sep = "";
+		if (ours) {
 			strbuf_addf(stat, _("ahead %d"), ours);
-		else
-			strbuf_addf(stat, _("ahead %d, behind %d"), ours, theirs);
+			sep = _(", ");
+		}
+		if (theirs) {
+			strbuf_addstr(stat, sep);
+			strbuf_addf(stat, _("behind %d"), theirs);
+			sep = _(", ");
+		}
+		if (patchsame) {
+			strbuf_addstr(stat, sep);
+			strbuf_addf(stat, _("same %d"), patchsame);
+		}
 	}
 	strbuf_addstr(stat, "] ");
 }
diff --git a/remote.c b/remote.c
index b8ecfa5..40cebef 100644
--- a/remote.c
+++ b/remote.c
@@ -1510,7 +1510,7 @@ int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1)
 /*
  * Return true if there is anything to report, otherwise false.
  */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs, int *num_patchsame)
 {
 	unsigned char sha1[20];
 	struct commit *ours, *theirs;
@@ -1553,6 +1553,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	rev_argv[rev_argc++] = NULL;
 	rev_argv[rev_argc++] = "--left-right";
 	rev_argv[rev_argc++] = symmetric;
+	if (num_patchsame)
+		rev_argv[rev_argc++] = "--cherry-mark";
 	rev_argv[rev_argc++] = "--";
 	rev_argv[rev_argc] = NULL;
 
@@ -1567,11 +1569,15 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs)
 	/* ... and count the commits on each side. */
 	*num_ours = 0;
 	*num_theirs = 0;
+	if (num_patchsame)
+		*num_patchsame = 0;
 	while (1) {
 		struct commit *c = get_revision(&revs);
 		if (!c)
 			break;
-		if (c->object.flags & SYMMETRIC_LEFT)
+		if (c->object.flags & PATCHSAME)
+			(*num_patchsame)++;
+		else if (c->object.flags & SYMMETRIC_LEFT)
 			(*num_ours)++;
 		else
 			(*num_theirs)++;
@@ -1591,7 +1597,7 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
 	int num_ours, num_theirs;
 	const char *base;
 
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs))
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs, NULL))
 		return 0;
 
 	base = branch->merge[0]->dst;
diff --git a/remote.h b/remote.h
index 9a30a9d..31c1f28 100644
--- a/remote.h
+++ b/remote.h
@@ -149,7 +149,7 @@ enum match_refs_flags {
 };
 
 /* Reporting of tracking info */
-int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
+int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs, int *num_patchsame);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 9539882..f8bff61 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -24,6 +24,7 @@ test_expect_success setup '
 		advance d &&
 		git checkout -b b2 origin &&
 		git reset --hard b1 &&
+		git cherry-pick origin &&
 		git checkout -b b3 origin &&
 		git reset --hard HEAD^ &&
 		git checkout -b b4 origin &&
@@ -53,7 +54,7 @@ test_expect_success 'branch -v' '
 
 cat >expect <<\EOF
 b1 origin/master: ahead 1, behind 1
-b2 origin/master: ahead 1, behind 1
+b2 origin/master: ahead 2, behind 1
 b3 origin/master: behind 1
 b4 origin/master: ahead 2
 EOF
@@ -67,6 +68,22 @@ test_expect_success 'branch -vv' '
 	test_i18ncmp expect actual
 '
 
+cat >expect <<\EOF
+b1 origin/master: ahead 1, behind 1
+b2 origin/master: ahead 1, same 2
+b3 origin/master: behind 1
+b4 origin/master: ahead 2
+EOF
+
+test_expect_success 'branch -vvv' '
+	(
+		cd test &&
+		git branch -vvv
+	) |
+	sed -n -e "$script" >actual &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'checkout' '
 	(
 		cd test && git checkout b1
diff --git a/wt-status.c b/wt-status.c
index 8836a52..522318a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -890,7 +890,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 	branch = branch_get(s->branch + 11);
 	if (s->is_initial)
 		color_fprintf(s->fp, header_color, _("Initial commit on "));
-	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
+	if (!stat_tracking_info(branch, &num_ours, &num_theirs, NULL)) {
 		color_fprintf_ln(s->fp, branch_color_local,
 			"%s", branch_name);
 		return;
-- 
1.7.6.845.gc3c05
