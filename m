Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95824C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 00:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BD772068E
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 00:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgDFA11 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Apr 2020 20:27:27 -0400
Received: from aibo.runbox.com ([91.220.196.211]:50432 "EHLO aibo1.runbox.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbgDFA11 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Apr 2020 20:27:27 -0400
X-Greylist: delayed 4141 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Apr 2020 20:27:24 EDT
Received: from [10.9.9.202] (helo=mailfront20.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <me@pluvano.com>)
        id 1jLEWn-0003Ch-L4; Mon, 06 Apr 2020 01:18:18 +0200
Received: by mailfront20.runbox with esmtpsa  [Authenticated alias (964124)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1jLEQr-0007fF-F8; Mon, 06 Apr 2020 01:12:03 +0200
From:   Emma Brooks <me@pluvano.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, Emma Brooks <me@pluvano.com>
Subject: [PATCH] format-patch: teach --no-encode-headers
Date:   Sun,  5 Apr 2020 23:11:09 +0000
Message-Id: <20200405231109.8249-1-me@pluvano.com>
X-Mailer: git-send-email 2.26.0.116.g02adfe1ebb
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When commit subjects or authors have non-ASCII characters, git
format-patch Q-encodes them so they can be safely sent over email.
However, if the patch transfer method is something other than email (web
review tools, sneakernet), this only serves to make the patch metadata
harder to read without first applying it (unless you can decode RFC 2047
in your head). git am as well as some email software supports
non-Q-encoded mail as described in RFC 6531.

Add --[no-]encode-headers and format.encodeHeaders to let the user
control this behavior.

Signed-off-by: Emma Brooks <me@pluvano.com>
---
 Documentation/config/format.txt    |  4 +++
 Documentation/git-format-patch.txt |  7 ++++
 builtin/log.c                      |  7 ++++
 log-tree.c                         |  1 +
 pretty.c                           |  6 ++--
 pretty.h                           |  1 +
 revision.c                         |  4 +++
 revision.h                         |  3 +-
 t/t4014-format-patch.sh            | 53 ++++++++++++++++++++++++++++++
 9 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 45c7bd5a8f..ee0eb4c5da 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -57,6 +57,10 @@ format.suffix::
 	`.patch`. Use this variable to change that suffix (make sure to
 	include the dot if you want it).
 
+format.encodeHeaders::
+	Encode email headers that have non-ASCII characters with
+	"Q-encoding" for email transmission. Defaults to true.
+
 format.pretty::
 	The default pretty format for log/show/whatchanged command,
 	See linkgit:git-log[1], linkgit:git-show[1],
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0d4f8951bb..a1483a6a34 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -24,6 +24,7 @@ SYNOPSIS
 		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet]
+		   [--[no-]encode-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
@@ -253,6 +254,12 @@ feeding the result to `git send-email`.
 	containing the branch description, shortlog and the overall diffstat.  You can
 	fill in a description in the file before sending it out.
 
+--[no-]encode-headers::
+	Encode email headers that have non-ASCII characters with
+	"Q-encoding", instead of outputting the headers verbatim. The
+	default is `--encode-headers` unless the `format.encodeHeaders`
+	configuration variable is set.
+
 --interdiff=<previous>::
 	As a reviewer aid, insert an interdiff into the cover letter,
 	or as commentary of the lone patch of a 1-patch series, showing
diff --git a/builtin/log.c b/builtin/log.c
index 83a4a6188e..1a27049c88 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -46,6 +46,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int default_follow;
 static int default_show_signature;
+static int default_encode_headers = 1;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config = 1;
@@ -151,6 +152,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	rev->show_signature = default_show_signature;
+	rev->encode_headers = default_encode_headers;
 	rev->diffopt.flags.allow_textconv = 1;
 
 	if (default_date_mode)
@@ -438,6 +440,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		return git_config_string(&fmt_pretty, var, value);
 	if (!strcmp(var, "format.subjectprefix"))
 		return git_config_string(&fmt_patch_subject_prefix, var, value);
+	if (!strcmp(var, "format.encodeheaders")) {
+		default_encode_headers = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "log.abbrevcommit")) {
 		default_abbrev_commit = git_config_bool(var, value);
 		return 0;
@@ -1719,6 +1725,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.show_notes = show_notes;
 	memcpy(&rev.notes_opt, &notes_opt, sizeof(notes_opt));
 	rev.commit_format = CMIT_FMT_EMAIL;
+	rev.encode_headers = default_encode_headers;
 	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
 	rev.diff = 1;
diff --git a/log-tree.c b/log-tree.c
index 897a90233e..eaec299762 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -693,6 +693,7 @@ void show_log(struct rev_info *opt)
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.preserve_subject = opt->preserve_subject;
+	ctx.encode_headers = opt->encode_headers;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
 	ctx.mailmap = opt->mailmap;
diff --git a/pretty.c b/pretty.c
index 28afc701b6..12959cca4d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -474,7 +474,8 @@ void pp_user_info(struct pretty_print_context *pp,
 		}
 
 		strbuf_addstr(sb, "From: ");
-		if (needs_rfc2047_encoding(namebuf, namelen)) {
+		if (pp->encode_headers &&
+				needs_rfc2047_encoding(namebuf, namelen)) {
 			add_rfc2047(sb, namebuf, namelen,
 				    encoding, RFC2047_ADDRESS);
 			max_length = 76; /* per rfc2047 */
@@ -1767,7 +1768,8 @@ void pp_title_line(struct pretty_print_context *pp,
 	if (pp->print_email_subject) {
 		if (pp->rev)
 			fmt_output_email_subject(sb, pp->rev);
-		if (needs_rfc2047_encoding(title.buf, title.len))
+		if (pp->encode_headers &&
+				needs_rfc2047_encoding(title.buf, title.len))
 			add_rfc2047(sb, title.buf, title.len,
 						encoding, RFC2047_SUBJECT);
 		else
diff --git a/pretty.h b/pretty.h
index 4ad1fc31ff..4840f7e559 100644
--- a/pretty.h
+++ b/pretty.h
@@ -43,6 +43,7 @@ struct pretty_print_context {
 	struct string_list *mailmap;
 	int color;
 	struct ident_split *from_ident;
+	unsigned encode_headers:1;
 
 	/*
 	 * Fields below here are manipulated internally by pp_* functions and
diff --git a/revision.c b/revision.c
index 8136929e23..961a901985 100644
--- a/revision.c
+++ b/revision.c
@@ -2241,6 +2241,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->topo_order = 1;
 		revs->rewrite_parents = 1;
 		revs->graph = graph_init(revs);
+	} else if (!strcmp(arg, "--encode-headers")) {
+		revs->encode_headers = 1;
+	} else if (!strcmp(arg, "--no-encode-headers")) {
+		revs->encode_headers = 0;
 	} else if (!strcmp(arg, "--root")) {
 		revs->show_root_diff = 1;
 	} else if (!strcmp(arg, "--no-commit-id")) {
diff --git a/revision.h b/revision.h
index 475f048fb6..e4dff23d62 100644
--- a/revision.h
+++ b/revision.h
@@ -203,7 +203,8 @@ struct rev_info {
 			use_terminator:1,
 			missing_newline:1,
 			date_mode_explicit:1,
-			preserve_subject:1;
+			preserve_subject:1,
+			encode_headers:1;
 	unsigned int	disable_stdin:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b653dd7d44..d9c0fe7a45 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1160,6 +1160,59 @@ test_expect_success 'format-patch wraps extremely long from-header (rfc2047)' '
 	check_author "Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
 '
 
+cat >expect <<'EOF'
+From: Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar
+ Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo
+ Bar Foo Bar Foo Bar Foo Bar <author@example.com>
+EOF
+test_expect_success 'format-patch wraps extremely long from-header (non-ASCII without Q-encoding)' '
+	echo content >>file &&
+	git add file &&
+	GIT_AUTHOR_NAME="Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar" \
+	git commit -m author-check &&
+	git format-patch --no-encode-headers --stdout -1 >patch &&
+	sed -n "/^From: /p; /^ /p; /^$/q" patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [PATCH] Foö
+EOF
+test_expect_success 'subject lines are unencoded with --no-encode-headers' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "Foö" &&
+	git format-patch --no-encode-headers -1 --stdout >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [PATCH] Foö
+EOF
+test_expect_success 'subject lines are unencoded with format.encodeHeaders=false' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "Foö" &&
+	git config format.encodeHeaders false &&
+	git format-patch -1 --stdout >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [PATCH] =?UTF-8?q?Fo=C3=B6?=
+EOF
+test_expect_success '--encode-headers overrides format.encodeHeaders' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "Foö" &&
+	git config format.encodeHeaders false &&
+	git format-patch --encode-headers -1 --stdout >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
 cat >expect <<'EOF'
 Subject: header with . in it
 EOF
