Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612F3C6379F
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjASXAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjASW7b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:59:31 -0500
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7549658988
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:49:12 -0800 (PST)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id DCD91420D;
        Thu, 19 Jan 2023 14:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1674167949;
        bh=de3uKI9zyE3K27Q3lzTByHEZ3x6sDGPlm8f/EaMbh9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=alqgyoujwlYSjZggmQ+wXxtydhG6wVmOq8Z56Gj3FscJIztDHpUAjkVUYlO4Dyv5k
         CaEjnRwfCeLoNkx3LpOTDAiTjTRXscgEqkAEg8f4Stc+9ZD9o4igjiWWPDIM+DV/dY
         2cuKr+kp20Ok1i1LlqhVlsECNXlZqZ1R4ZUpDOPg=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     git@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/5] format-patch: Add support for --{to,cc}-cmd flags
Date:   Thu, 19 Jan 2023 14:38:58 -0800
Message-Id: <20230119223858.29262-6-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119223858.29262-1-zev@bewilderbeest.net>
References: <20230119223858.29262-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Having these flags available for format-patch instead of only on
send-email makes it much easier to use an automated command to do the
bulk of the recipient-selection work but still manually adjust it if
desired.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 builtin/log.c           |  10 +++
 log-tree.c              | 179 +++++++++++++++++++++++++++++++++++++++-
 revision.h              |   2 +
 t/t4014-format-patch.sh |  19 +++++
 4 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index c0c7b8544d73..da3edb2a8299 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1877,6 +1877,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	int creation_factor = -1;
+	char *to_cmd_arg = NULL;
+	char *cc_cmd_arg = NULL;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1929,6 +1931,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("add email header"), header_callback),
 		OPT_CALLBACK(0, "to", NULL, N_("email"), N_("add To: header"), to_callback),
 		OPT_CALLBACK(0, "cc", NULL, N_("email"), N_("add Cc: header"), cc_callback),
+		OPT_STRING(0, "to-cmd", &to_cmd_arg, N_("command"),
+		           N_("command to generate To: addresses for a patch")),
+		OPT_STRING(0, "cc-cmd", &cc_cmd_arg, N_("command"),
+		           N_("command to generate Cc: addresses for a patch")),
 		OPT_CALLBACK_F(0, "from", &from, N_("ident"),
 			    N_("set From address to <ident> (or committer ident if absent)"),
 			    PARSE_OPT_OPTARG, from_callback),
@@ -2031,6 +2037,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	rev.to_recipients = &extra_to;
 	rev.cc_recipients = &extra_cc;
+
+	rev.to_cmd = to_cmd_arg;
+	rev.cc_cmd = cc_cmd_arg;
+
 	rev.extra_headers = to_free = strbuf_detach(&buf, NULL);
 
 	if (from) {
diff --git a/log-tree.c b/log-tree.c
index 7aa2841dd803..6fdc3a3ffb7f 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -20,6 +20,7 @@
 #include "help.h"
 #include "range-diff.h"
 #include "strmap.h"
+#include "run-command.h"
 
 static struct decoration name_decoration = { "object names" };
 static int decoration_loaded;
@@ -652,11 +653,175 @@ static void next_commentary_block(struct rev_info *opt, struct strbuf *sb)
 	opt->shown_dashes = 1;
 }
 
+/*
+ * Aims to mirror git-send-email.perl's function of the same name, returning a
+ * malloc()ed string that the caller must free().
+ */
+static char *sanitize_address(const struct rev_info *opt, const char *entry)
+{
+	int escaped = 0;
+	const char *inp;
+	char *tmp, *outp;
+	struct strbuf addr = STRBUF_INIT;
+	struct pretty_print_context ctx = {0};
+
+	/* Skip over any leading whitespace */
+	while (isspace(*entry))
+		entry++;
+
+	outp = tmp = xmalloc(strlen(entry) + 1);
+
+	/* Remove non-escaped quotes */
+	for (inp = entry; *inp; inp++) {
+		if (escaped) {
+			escaped = 0;
+		} else {
+			switch (*inp) {
+			case '\\':
+				escaped = 1;
+				/* fallthrough */
+			case '"':
+				continue;
+			}
+		}
+		*outp++ = *inp;
+	}
+	*outp = '\0';
+
+	ctx.fmt = opt->commit_format;
+	ctx.mailmap = opt->mailmap;
+	ctx.encode_email_headers = opt->encode_email_headers;
+	ctx.output_encoding = get_log_output_encoding();
+	ctx.name_and_address_only = 1;
+
+	pp_user_info(&ctx, NULL, &addr, tmp, get_log_output_encoding());
+
+	free(tmp);
+
+	return strbuf_detach(&addr, NULL);
+}
+
+/*
+ * Given 'text' as the output of a --to-cmd or --cc-cmd command, add each
+ * entry to 'list'.
+ */
+static void ingest_recipients_to_list(const char *text, const struct rev_info *opt,
+				      struct string_list *list)
+{
+	struct string_list_item *item;
+	struct string_list lines = STRING_LIST_INIT_DUP;
+
+	string_list_split(&lines, text, '\n', -1);
+
+	for_each_string_list_item(item, &lines) {
+		char *addr = sanitize_address(opt, item->string);
+		if (*addr)
+			string_list_append_nodup(list, addr);
+		else
+			free(addr);
+	}
+
+	string_list_clear(&lines, 0);
+}
+
+/*
+ * Generate a temporary patch file for the given commit, returning its path as
+ * a malloc()ed string the caller must free (and should unlink when finished
+ * with it).
+ */
+static char *generate_temp_patch(struct commit *commit)
+{
+	char path[PATH_MAX];
+	char *diff_output_arg;
+	struct strbuf diff_output_arg_buf = STRBUF_INIT;
+	struct child_process diffproc = CHILD_PROCESS_INIT;
+
+	xsnprintf(path, sizeof(path), ".git-temp-diff.XXXXXX");
+	close(xmkstemp(path));
+
+	strbuf_addf(&diff_output_arg_buf, "--output=%s", path);
+	diff_output_arg = strbuf_detach(&diff_output_arg_buf, NULL);
+
+	diffproc.git_cmd = 1;
+	strvec_push(&diffproc.args, "format-patch");
+	strvec_push(&diffproc.args, "-1");
+	strvec_push(&diffproc.args, diff_output_arg);
+	strvec_push(&diffproc.args, oid_to_hex(&commit->object.oid));
+
+	if (run_command(&diffproc))
+		die(_("Error generating temporary diff"));
+
+	free(diff_output_arg);
+
+	return xstrdup(path);
+}
+
+/*
+ * Execute a --to-cmd or --cc-cmd command on a temporary patch file, adding
+ * each recipient produced to 'list'.
+ */
+static void run_recipients_command(const char *cmd, const char *tmpdiff,
+				   const struct rev_info *opt,
+				   struct string_list *list)
+{
+	char *full_cmd;
+	char *cmd_output;
+	struct strbuf cmd_output_buf = STRBUF_INIT;
+	struct strbuf cmd_buf = STRBUF_INIT;
+	struct child_process cmdproc = CHILD_PROCESS_INIT;
+
+	strbuf_addf(&cmd_buf, "%s %s", cmd, tmpdiff);
+	full_cmd = strbuf_detach(&cmd_buf, NULL);
+
+	cmdproc.use_shell = 1;
+	strvec_push(&cmdproc.args, full_cmd);
+	if (capture_command(&cmdproc, &cmd_output_buf, 1024))
+		die(_("Error generating recipients list: command failed"));
+
+	cmd_output = strbuf_detach(&cmd_output_buf, NULL);
+	ingest_recipients_to_list(cmd_output, opt, list);
+
+	free(cmd_output);
+	free(full_cmd);
+}
+
+/*
+ * Generate a To or Cc header into 'buf', where 'header' is "To" or "Cc",
+ * 'fixed' is the list of fixed recipients (e.g. those specified by --to or
+ * --cc, optional), 'cmd' is the (optional) --to-cmd or --cc-cmd argument to
+ * generate recipients, and 'tmpdiff' is the path of a temp file containing a
+ * patch file to run 'cmd' on (mandatory if 'cmd' is non-NULL).
+ */
+static void headerize_recipients(const char *header, const char *tmpdiff,
+				 const struct rev_info *opt,
+				 const struct string_list *fixed,
+				 const char *cmd, struct strbuf *buf)
+{
+	struct string_list_item *item;
+	struct string_list recipients = STRING_LIST_INIT_DUP;
+
+	if (fixed) {
+		for_each_string_list_item(item, fixed)
+			string_list_append(&recipients, item->string);
+	}
+
+	if (cmd)
+		run_recipients_command(cmd, tmpdiff, opt, &recipients);
+
+	string_list_sort(&recipients);
+	string_list_remove_duplicates(&recipients, 0);
+
+	recipients_to_header_buf(header, buf, &recipients);
+
+	string_list_clear(&recipients, 0);
+}
+
 void show_log(struct rev_info *opt)
 {
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct strbuf hdrbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
+	char *tmpdiff = NULL;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
 	const char *extra_headers = opt->extra_headers;
@@ -715,6 +880,18 @@ void show_log(struct rev_info *opt)
 	 */
 	graph_show_commit(opt->graph);
 
+	/* Generate dynamic To/Cc lists as needed */
+	if (opt->to_cmd || opt->cc_cmd)
+		tmpdiff = generate_temp_patch(commit);
+
+	headerize_recipients("To", tmpdiff, opt, opt->to_recipients, opt->to_cmd, &hdrbuf);
+	headerize_recipients("Cc", tmpdiff, opt, opt->cc_recipients, opt->cc_cmd, &hdrbuf);
+
+	if (tmpdiff) {
+		unlink_or_warn(tmpdiff);
+		free(tmpdiff);
+	}
+
 	/*
 	 * Print header line of header..
 	 */
@@ -780,8 +957,6 @@ void show_log(struct rev_info *opt)
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
-	format_recipients(opt, &hdrbuf);
-
 	if (extra_headers)
 		strbuf_addstr(&hdrbuf, extra_headers);
 
diff --git a/revision.h b/revision.h
index 330d351b2e4c..9611309ae496 100644
--- a/revision.h
+++ b/revision.h
@@ -285,6 +285,8 @@ struct rev_info {
 	int		add_signoff;
 	struct string_list *to_recipients;
 	struct string_list *cc_recipients;
+	const char	*to_cmd;
+	const char	*cc_cmd;
 	const char	*extra_headers;
 	const char	*log_reencode;
 	const char	*subject_prefix;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ba5fd0efe2ae..2387bda4f272 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -228,6 +228,25 @@ test_expect_failure 'configuration To: header (rfc2047)' '
 	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs9
 '
 
+test_expect_success 'dynamic To: header (ascii)' '
+	git config --unset-all format.to &&
+	git format-patch --to-cmd="echo \"R E Cipient <rcipient@example.com>\" #" --stdout main..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: R E Cipient <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_success 'dynamic To: header (rfc822)' '
+	git format-patch --to-cmd="echo \"R. E. Cipient <rcipient@example.com>\" #" --stdout main..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: \"R. E. Cipient\" <rcipient@example.com>\$" hdrs10
+'
+
+test_expect_success 'dynamic To: header (rfc2047)' '
+	git format-patch --to-cmd="echo \"R Ä Cipient <rcipient@example.com>\" #" --stdout main..side >patch10 &&
+	sed -e "/^\$/q" patch10 >hdrs10 &&
+	grep "^To: =?UTF-8?q?R=20=C3=84=20Cipient?= <rcipient@example.com>\$" hdrs10
+'
+
 # check_patch <patch>: Verify that <patch> looks like a half-sane
 # patch email to avoid a false positive with !grep
 check_patch () {
-- 
2.39.1.236.ga8a28b9eace8

