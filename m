From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/WIP v3 22/31] am: don't use git-mailinfo if --rebasing
Date: Thu, 18 Jun 2015 19:25:34 +0800
Message-ID: <1434626743-8552-23-git-send-email-pyokagan@gmail.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 13:27:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Xyq-0005X5-M0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 13:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbbFRL13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 07:27:29 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35642 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbbFRL1L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 07:27:11 -0400
Received: by pdbci14 with SMTP id ci14so6238830pdb.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VuWhYz+886355KWtYo2ywAC6KHeOCQ00/ReMy+0nxBE=;
        b=Km0MEqSlOiyxd7V5zJFYNIWukNjeyy2IDJg3AGqlwpTwaXCfLPWj74mYjDBALQNZHq
         Lti2FHftsJQK2iGAR9wHl4KCozeO9sXAy3RYuIhnjf98mdEdncLGEj49tE23ZR4GgQrZ
         LYIb/Ky0vIgFJnNikGq37XmOPGDVNuTg04Im1jlDMYmRoi//JBLD99y+zMbPbygiaw1x
         y5qS4ZG02WpY93GgafjgLCKsanFlKIjSqA0QgjJTFtW6FsaupJuowBkmCmzvd6Ye9NSs
         2q4+uVQdoXO53kitVRWukE/8qpEFbbpGEQsqmQVP6z8NVNg3UzOmr2kwpNmdgTeT5JEg
         nnhw==
X-Received: by 10.70.15.1 with SMTP id t1mr20005348pdc.155.1434626831460;
        Thu, 18 Jun 2015 04:27:11 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id j9sm5443016pdl.65.2015.06.18.04.27.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Jun 2015 04:27:10 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271990>

Since 5e835ca (rebase: do not munge commit log message, 2008-04-16),
git am --rebasing no longer gets the commit log message from the patch,
but reads it directly from the commit identified by the "From " header
line.

Since 43c2325 (am: use get_author_ident_from_commit instead of mailinfo
when rebasing, 2010-06-16), git am --rebasing also gets the author name,
email and date directly from the commit.

Since 0fbb95d (am: don't call mailinfo if $rebasing, 2012-06-26), git am
--rebasing does not use git-mailinfo to get the patch body, but rather
generates it directly from the commit itself.

The above 3 commits introduced a separate parse_patch() code path in
git-am.sh's --rebasing mode that bypasses git-mailinfo. Re-implement
this code path in builtin/am.c as parse_patch_rebase().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 9afa3bb..0d7e37c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -21,6 +21,8 @@
 #include "sequencer.h"
 #include "revision.h"
 #include "merge-recursive.h"
+#include "revision.h"
+#include "log-tree.h"
 
 /**
  * Returns 1 if the file is empty or does not exist, 0 otherwise.
@@ -50,6 +52,30 @@ static const char *firstline(const char *msg)
 	return sb.buf;
 }
 
+/**
+ * Iterate over lines, each terminated by c, in a string, without modifying the
+ * string itself. begin will be set to the beginning of the line, while end
+ * will be set to the line termination or null character at the end of the line
+ * or string. On the first call, begin and end must be initialized to the
+ * string to be iterated over. E.g.:
+ *
+ *	const char *begin, *end, *str = "1\n2\n3";
+ *	begin = end = str;
+ *	while (!getbufline(&begin, &end, '\n'))
+ *		...
+ */
+static int getbufline(const char **begin, const char **end, int c)
+{
+	if (!**end)
+		return EOF;
+	else if (**end == c)
+		*begin = *end + 1;
+	else
+		*begin = *end;
+	*end = strchrnul(*begin, c);
+	return 0;
+}
+
 enum patch_format {
 	PATCH_FORMAT_UNKNOWN = 0,
 	PATCH_FORMAT_MBOX
@@ -675,6 +701,126 @@ static int parse_patch(struct am_state *state, const char *patch)
 }
 
 /**
+ * Sets commit_id to the commit hash where the patch was generated from.
+ * Returns 0 on success, -1 on failure.
+ */
+static int get_patch_commit_sha1(unsigned char *commit_id, const char *patch)
+{
+	struct strbuf sb = STRBUF_INIT;
+	FILE *fp = xfopen(patch, "r");
+	const char *x;
+
+	if (strbuf_getline(&sb, fp, '\n'))
+		return -1;
+
+	if (!skip_prefix(sb.buf, "From ", &x))
+		return -1;
+
+	if (get_sha1_hex(x, commit_id) < 0)
+		return -1;
+
+	strbuf_release(&sb);
+	fclose(fp);
+	return 0;
+}
+
+/**
+ * Sets state->msg, state->author_name, state->author_email, state->author_date
+ * to the commit's respective info.
+ */
+static void get_commit_info(struct am_state *state, struct commit *commit)
+{
+	const char *buf, *begin, *end;
+
+	buf = logmsg_reencode(commit, NULL, get_commit_output_encoding());
+	begin = end = buf;
+
+	while (!getbufline(&begin, &end, '\n')) {
+		const char *x;
+
+		if (skip_prefix(begin, "author ", &x)) {
+			struct ident_split split;
+			const char *date;
+
+			if (split_ident_line(&split, x, end - x) < 0) {
+				struct strbuf sb = STRBUF_INIT;
+
+				strbuf_add(&sb, x, end - x);
+				die(_("invalid ident line: %s"), sb.buf);
+			}
+
+			if (split.name_begin)
+				strbuf_add(&state->author_name,
+					split.name_begin,
+					split.name_end - split.name_begin);
+
+			if (split.mail_begin)
+				strbuf_add(&state->author_email,
+					split.mail_begin,
+					split.mail_end - split.mail_begin);
+
+			date = show_ident_date(&split, DATE_NORMAL);
+			strbuf_addstr(&state->author_date, date);
+		} else if (begin == end) {
+			end++;
+			break;
+		}
+	}
+
+	strbuf_addstr(&state->msg, end);
+}
+
+/**
+ * Writes commit as a patch to $state_dir/patch.
+ */
+static void write_commit_patch(const struct am_state *state, struct commit *commit)
+{
+	struct rev_info rev_info;
+	FILE *fp;
+
+	fp = xfopen(am_path(state, "patch"), "w");
+	init_revisions(&rev_info, NULL);
+	rev_info.diff = 1;
+	rev_info.abbrev = 0;
+	rev_info.disable_stdin = 1;
+	rev_info.show_root_diff = 1;
+	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
+	rev_info.no_commit_id = 1;
+	DIFF_OPT_SET(&rev_info.diffopt, BINARY);
+	DIFF_OPT_SET(&rev_info.diffopt, FULL_INDEX);
+	rev_info.diffopt.use_color = 0;
+	rev_info.diffopt.file = fp;
+	rev_info.diffopt.close_file = 1;
+	add_pending_object(&rev_info, &commit->object, "");
+	diff_setup_done(&rev_info.diffopt);
+	log_tree_commit(&rev_info, commit);
+}
+
+/**
+ * Like parse_patch(), but parses the patch by looking up its commit ID
+ * directly. This is used in --rebasing mode to bypass git-mailinfo's munging
+ * of patches.
+ *
+ * Will always return 0 as the patch should never be skipped.
+ */
+static int parse_patch_rebase(struct am_state *state, const char *patch)
+{
+	struct commit *commit;
+	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
+
+	if (get_patch_commit_sha1(commit_sha1, patch) < 0)
+		die(_("could not parse %s"), patch);
+
+	commit = lookup_commit_or_die(commit_sha1, patch);
+
+	get_commit_info(state, commit);
+
+	write_commit_patch(state, commit);
+
+	return 0;
+}
+
+/**
  * Dies with a user-friendly message on how to proceed after resolving the
  * problem. This message can be overridden with state->resolvemsg.
  */
@@ -885,12 +1031,17 @@ static void am_run(struct am_state *state)
 
 	while (state->cur <= state->last) {
 		const char *patch = am_path(state, msgnum(state));
-		int apply_status;
+		int apply_status, skip;
 
 		if (!file_exists(patch))
 			goto next;
 
-		if (parse_patch(state, patch))
+		if (state->rebasing)
+			skip = parse_patch_rebase(state, patch);
+		else
+			skip = parse_patch(state, patch);
+
+		if (skip)
 			goto next; /* patch should be skipped */
 
 		write_author_script(state);
-- 
2.1.4
