From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v4 21/44] builtin-am: bypass git-mailinfo when --rebasing
Date: Sun, 28 Jun 2015 22:05:43 +0800
Message-ID: <1435500366-31700-22-git-send-email-pyokagan@gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 16:08:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9DG9-0002cL-Mi
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 16:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718AbbF1OIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 10:08:34 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33478 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbbF1OHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 10:07:51 -0400
Received: by pdjn11 with SMTP id n11so101603982pdj.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 07:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ud7vGkQvTwlNOfQ0tSJ9vRRTpXDnJ8Rsn+dgejSqXcs=;
        b=E//kMC6jcmbNkYE5f9/RITew/KMh9t6vONxbcssw3MqKm2TycFYKEs0MSS7QFLNY06
         BdyBtNEBaRGWsUZoAS1CbgBB1fgUAxE7M1pRknqySslVVhYNkQJogXb5qDVMmHY1vwSo
         gGy2Cr7D9G1O0wUDyTVWQmxZAWLZ80JazG74yTSvyxkHN//TwovHPBV/tJjYbihFPuZ7
         paB+2Ld3URiUaRqumjnZYsFN1AgEv24LZmwLCOH1HIa7edlcvBPOUl2CO+xIbdkLyW/C
         UCk4F0TfU6mw9Fw9v56y8cPz/wdtgEGmyxlvMggsXJdzRbAAMtGZfw7DCxRMiq448JNd
         XMZg==
X-Received: by 10.68.181.163 with SMTP id dx3mr22162572pbc.5.1435500471278;
        Sun, 28 Jun 2015 07:07:51 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id qa1sm39244820pab.0.2015.06.28.07.07.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 28 Jun 2015 07:07:49 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc0.76.gb2c6e93
In-Reply-To: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272901>

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

The above 3 commits introduced a separate parse_mail() code path in
git-am.sh's --rebasing mode that bypasses git-mailinfo. Re-implement
this code path in builtin/am.c as parse_mail_rebase().

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 builtin/am.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index ca8f07b..9af8ad2 100644
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
@@ -822,6 +824,129 @@ finish:
 }
 
 /**
+ * Sets commit_id to the commit hash where the mail was generated from.
+ * Returns 0 on success, -1 on failure.
+ */
+static int get_mail_commit_sha1(unsigned char *commit_id, const char *mail)
+{
+	struct strbuf sb = STRBUF_INIT;
+	FILE *fp = xfopen(mail, "r");
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
+	const char *buffer, *ident_line, *author_date, *msg;
+	size_t ident_len;
+	struct ident_split ident_split;
+	struct strbuf sb = STRBUF_INIT;
+
+	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
+
+	ident_line = find_commit_header(buffer, "author", &ident_len);
+
+	if (split_ident_line(&ident_split, ident_line, ident_len) < 0) {
+		strbuf_add(&sb, ident_line, ident_len);
+		die(_("invalid ident line: %s"), sb.buf);
+	}
+
+	assert(!state->author_name);
+	if (ident_split.name_begin) {
+		strbuf_add(&sb, ident_split.name_begin,
+			ident_split.name_end - ident_split.name_begin);
+		state->author_name = strbuf_detach(&sb, NULL);
+	} else
+		state->author_name = xstrdup("");
+
+	assert(!state->author_email);
+	if (ident_split.mail_begin) {
+		strbuf_add(&sb, ident_split.mail_begin,
+			ident_split.mail_end - ident_split.mail_begin);
+		state->author_email = strbuf_detach(&sb, NULL);
+	} else
+		state->author_email = xstrdup("");
+
+	author_date = show_ident_date(&ident_split, DATE_NORMAL);
+	strbuf_addstr(&sb, author_date);
+	assert(!state->author_date);
+	state->author_date = strbuf_detach(&sb, NULL);
+
+	assert(!state->msg);
+	msg = strstr(buffer, "\n\n");
+	if (!msg)
+		die(_("unable to parse commit %s"), sha1_to_hex(commit->object.sha1));
+	state->msg = xstrdup(msg + 2);
+	state->msg_len = strlen(state->msg);
+}
+
+/**
+ * Writes `commit` as a patch to the state directory's "patch" file.
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
+ * Like parse_mail(), but parses the mail by looking up its commit ID
+ * directly. This is used in --rebasing mode to bypass git-mailinfo's munging
+ * of patches.
+ *
+ * Will always return 0 as the patch should never be skipped.
+ */
+static int parse_mail_rebase(struct am_state *state, const char *mail)
+{
+	struct commit *commit;
+	unsigned char commit_sha1[GIT_SHA1_RAWSZ];
+
+	if (get_mail_commit_sha1(commit_sha1, mail) < 0)
+		die(_("could not parse %s"), mail);
+
+	commit = lookup_commit_or_die(commit_sha1, mail);
+
+	get_commit_info(state, commit);
+
+	write_commit_patch(state, commit);
+
+	return 0;
+}
+
+/**
  * Applies current patch with git-apply. Returns 0 on success, -1 otherwise. If
  * `index_file` is not NULL, the patch will be applied to that index.
  */
@@ -1025,12 +1150,17 @@ static void am_run(struct am_state *state)
 
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
-		int apply_status;
+		int apply_status, skip;
 
 		if (!file_exists(mail))
 			goto next;
 
-		if (parse_mail(state, mail))
+		if (state->rebasing)
+			skip = parse_mail_rebase(state, mail);
+		else
+			skip = parse_mail(state, mail);
+
+		if (skip)
 			goto next; /* mail should be skipped */
 
 		write_author_script(state);
-- 
2.5.0.rc0.76.gb2c6e93
