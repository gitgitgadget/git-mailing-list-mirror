From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/2] log: decorate HEAD with branch name
Date: Tue, 10 Mar 2015 14:53:21 +0100
Message-ID: <b6960c9364da471a674fb24b8dd35ebdb8269243.1425995310.git.git@drmicha.warpmail.net>
References: <54FEC8D0.2060304@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Julien Cretel <j.cretel@umail.ucc.ie>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 14:53:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVKbH-0000f0-R1
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 14:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbCJNx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 09:53:29 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51748 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751891AbbCJNx0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 09:53:26 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7274A21151
	for <git@vger.kernel.org>; Tue, 10 Mar 2015 09:53:24 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 10 Mar 2015 09:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references:in-reply-to:references; s=
	smtpout; bh=UAzGEid0H+AHuVsxGTetcRsWw3o=; b=lpmPvKQiy7J/64jzk9Ff
	iSVseke3wtyZ7Kais2f5OXDWE1f6qz8i16PV2qkKKDgdBiGsJFsJwrYMTDW5yHWk
	LVFaZhxQ7l7eNIJcXE3DuR8/8rK806op3dNEDh24w2wvF5EqhlWpK6JxE97UqoKY
	QGctqddmwy5Hv5GGPC0ri1w=
X-Sasl-enc: AblkL1Q74+kAb0KbaEKdQMhvT8JMJZDtThBmHZx0eo9c 1425995605
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 88FC1C0029D;
	Tue, 10 Mar 2015 09:53:25 -0400 (EDT)
X-Mailer: git-send-email 2.3.2.346.gb6960c9
In-Reply-To: <54FEC8D0.2060304@drmicha.warpmail.net>
In-Reply-To: <cover.1425995310.git.git@drmicha.warpmail.net>
References: <cover.1425995310.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265236>

From: Junio C Hamano <gitster@pobox.com>

Currently, log decorations do not indicate which branch is checked out
and whether HEAD is detached.

When branch foo is checked out, change the "HEAD, foo" part of the
decorations to "HEAD -> foo". This serves to indicate both ref
decorations (helped by the spacing) as well as their relationshsip.
As a consequence, "HEAD" without any " -> " denotes a detached HEAD now.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    The patch is really Junio's now.
    I just simplified the if's and added colors and tests.
    The spaces around "->" should help to make the branch stick out even
    without colors.

 log-tree.c                        | 77 ++++++++++++++++++++++++++++++++++-----
 t/t4013/diff.log_--decorate_--all |  2 +-
 t/t4207-log-decoration-colors.sh  |  6 +--
 3 files changed, 72 insertions(+), 13 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 53bb526..2c1ed0f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -173,6 +173,43 @@ static void show_children(struct rev_info *opt, struct commit *commit, int abbre
 }
 
 /*
+ * Do we have HEAD in the output, and also the branch it points at?
+ * If so, find that decoration entry for that current branch.
+ */
+static const struct name_decoration *current_pointed_by_HEAD(const struct name_decoration *decoration)
+{
+	const struct name_decoration *list, *head = NULL;
+	const char *branch_name = NULL;
+	unsigned char unused[20];
+	int rru_flags;
+
+	/* First find HEAD */
+	for (list = decoration; list; list = list->next)
+		if (list->type == DECORATION_REF_HEAD) {
+			head = list;
+			break;
+		}
+	if (!head)
+		return NULL;
+
+	/* Now resolve and find the matching current branch */
+	branch_name = resolve_ref_unsafe("HEAD", 0, unused, &rru_flags);
+	if (!(rru_flags & REF_ISSYMREF))
+		return NULL;
+	if (!skip_prefix(branch_name, "refs/heads/", &branch_name))
+		return NULL;
+
+	/* OK, do we have that ref in the list? */
+	for (list = decoration; list; list = list->next)
+		if ((list->type == DECORATION_REF_LOCAL) &&
+		    !strcmp(branch_name, list->name)) {
+			return list;
+		}
+
+	return NULL;
+}
+
+/*
  * The caller makes sure there is no funny color before calling.
  * format_decorations_extended makes sure the same after return.
  */
@@ -184,6 +221,7 @@ void format_decorations_extended(struct strbuf *sb,
 			const char *suffix)
 {
 	const struct name_decoration *decoration;
+	const struct name_decoration *current_and_HEAD;
 	const char *color_commit =
 		diff_get_color(use_color, DIFF_COMMIT);
 	const char *color_reset =
@@ -192,16 +230,37 @@ void format_decorations_extended(struct strbuf *sb,
 	decoration = get_name_decoration(&commit->object);
 	if (!decoration)
 		return;
+
+	current_and_HEAD = current_pointed_by_HEAD(decoration);
 	while (decoration) {
-		strbuf_addstr(sb, color_commit);
-		strbuf_addstr(sb, prefix);
-		strbuf_addstr(sb, color_reset);
-		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
-		if (decoration->type == DECORATION_REF_TAG)
-			strbuf_addstr(sb, "tag: ");
-		strbuf_addstr(sb, decoration->name);
-		strbuf_addstr(sb, color_reset);
-		prefix = separator;
+		/*
+		 * When both current and HEAD are there, only
+		 * show HEAD->current where HEAD would have
+		 * appeared, skipping the entry for current.
+		 */
+		if (decoration != current_and_HEAD) {
+			strbuf_addstr(sb, color_commit);
+			strbuf_addstr(sb, prefix);
+			strbuf_addstr(sb, color_reset);
+			strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
+			if (decoration->type == DECORATION_REF_TAG)
+				strbuf_addstr(sb, "tag: ");
+
+			strbuf_addstr(sb, decoration->name);
+
+			if (current_and_HEAD &&
+			    decoration->type == DECORATION_REF_HEAD) {
+				strbuf_addstr(sb, color_reset);
+				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, " -> ");
+				strbuf_addstr(sb, color_reset);
+				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
+				strbuf_addstr(sb, current_and_HEAD->name);
+			}
+			strbuf_addstr(sb, color_reset);
+
+			prefix = separator;
+		}
 		decoration = decoration->next;
 	}
 	strbuf_addstr(sb, color_commit);
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index 27d3eab..3aa16a9 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -5,7 +5,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD, master)
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
 Merge: 9a6d494 c7a2ab9
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:04:00 2006 +0000
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 6b8ad4f..f8008b6 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -44,10 +44,10 @@ test_expect_success setup '
 '
 
 cat >expected <<EOF
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}${c_commit},\
+${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}${c_commit} ->\
+ ${c_reset}${c_branch}master${c_reset}${c_commit},\
  ${c_reset}${c_tag}tag: v1.0${c_reset}${c_commit},\
- ${c_reset}${c_tag}tag: B${c_reset}${c_commit},\
- ${c_reset}${c_branch}master${c_reset}${c_commit})${c_reset} B
+ ${c_reset}${c_tag}tag: B${c_reset}${c_commit})${c_reset} B
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_tag}tag: A1${c_reset}${c_commit},\
  ${c_reset}${c_remoteBranch}other/master${c_reset}${c_commit})${c_reset} A1
 ${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_stash}refs/stash${c_reset}${c_commit})${c_reset}\
-- 
2.3.2.346.gb6960c9
