Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC54C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBAB2311B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgIYHCP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:02:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40418 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgIYHCP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:02:15 -0400
Received: (qmail 13150 invoked by uid 109); 25 Sep 2020 07:02:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:02:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15951 invoked by uid 111); 25 Sep 2020 07:02:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:02:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:02:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/8] shortlog: refactor committer/author grouping
Message-ID: <20200925070211.GB62741@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for adding more grouping types, let's
refactor the committer/author grouping code. In particular:

  - the master option is now "--group", to make it clear
    that the various group types are mutually exclusive. The
    "--committer" option is an alias for "--group=committer".

  - we keep an enum rather than a binary flag, to prepare
    for more values

  - we prefer switch statements to ternary assignment, since
    other group types will need more custom code

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  9 ++++++
 builtin/shortlog.c             | 59 +++++++++++++++++++++++++++-------
 shortlog.h                     |  6 +++-
 t/t4201-shortlog.sh            |  5 +++
 4 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index a72ea7f7ba..41b7679aa1 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -47,9 +47,18 @@ OPTIONS
 
 	Each pretty-printed commit will be rewrapped before it is shown.
 
+--group=<type>::
+	By default, `shortlog` collects and collates author identities;
+	using `--group` will collect other fields.
+	`<type>` is one of:
++
+ - `author`, commits are grouped by author (this is the default)
+ - `committer`, commits are grouped by committer (the same as `-c`)
+
 -c::
 --committer::
 	Collect and show committer identities instead of authors.
+	This is an alias for `--group=committer`.
 
 -w[<width>[,<indent1>[,<indent2>]]]::
 	Linewrap the output by wrapping each line at `width`.  The first
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index edcf2e0d54..880ce19304 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -129,7 +129,17 @@ static void read_from_stdin(struct shortlog *log)
 	static const char *committer_match[2] = { "Commit: ", "committer " };
 	const char **match;
 
-	match = log->committer ? committer_match : author_match;
+	switch (log->group) {
+	case SHORTLOG_GROUP_AUTHOR:
+		match = author_match;
+		break;
+	case SHORTLOG_GROUP_COMMITTER:
+		match = committer_match;
+		break;
+	default:
+		BUG("unhandled shortlog group");
+	}
+
 	while (strbuf_getline_lf(&ident, stdin) != EOF) {
 		const char *v;
 		if (!skip_prefix(ident.buf, match[0], &v) &&
@@ -158,27 +168,36 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
-	const char *fmt;
+	const char *oneline_str;
 
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
 	ctx.print_email_subject = 1;
 	ctx.date_mode.type = DATE_NORMAL;
 	ctx.output_encoding = get_log_output_encoding();
 
-	fmt = log->committer ?
-		(log->email ? "%cN <%cE>" : "%cN") :
-		(log->email ? "%aN <%aE>" : "%aN");
-
-	format_commit_message(commit, fmt, &ident, &ctx);
 	if (!log->summary) {
 		if (log->user_format)
 			pretty_print_commit(&ctx, commit, &oneline);
 		else
 			format_commit_message(commit, "%s", &oneline, &ctx);
 	}
-
-	insert_one_record(log, ident.buf, oneline.len ? oneline.buf : "<none>");
+	oneline_str = oneline.len ? oneline.buf : "<none>";
+
+	switch (log->group) {
+	case SHORTLOG_GROUP_AUTHOR:
+		format_commit_message(commit,
+				      log->email ? "%aN <%aE>" : "%aN",
+				      &ident, &ctx);
+		insert_one_record(log, ident.buf, oneline_str);
+		break;
+	case SHORTLOG_GROUP_COMMITTER:
+		format_commit_message(commit,
+				      log->email ? "%cN <%cE>" : "%cN",
+				      &ident, &ctx);
+		insert_one_record(log, ident.buf, oneline_str);
+		break;
+	}
 
 	strbuf_release(&ident);
 	strbuf_release(&oneline);
@@ -241,6 +260,21 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int parse_group_option(const struct option *opt, const char *arg, int unset)
+{
+	struct shortlog *log = opt->value;
+
+	if (unset || !strcasecmp(arg, "author"))
+		log->group = SHORTLOG_GROUP_AUTHOR;
+	else if (!strcasecmp(arg, "committer"))
+		log->group = SHORTLOG_GROUP_COMMITTER;
+	else
+		return error(_("unknown group type: %s"), arg);
+
+	return 0;
+}
+
+
 void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
@@ -260,8 +294,9 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 
 	const struct option options[] = {
-		OPT_BOOL('c', "committer", &log.committer,
-			 N_("Group by committer rather than author")),
+		OPT_SET_INT('c', "committer", &log.group,
+			    N_("Group by committer rather than author"),
+			    SHORTLOG_GROUP_COMMITTER),
 		OPT_BOOL('n', "numbered", &log.sort_by_number,
 			 N_("sort output according to the number of commits per author")),
 		OPT_BOOL('s', "summary", &log.summary,
@@ -271,6 +306,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F('w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
 			N_("Linewrap output"), PARSE_OPT_OPTARG,
 			&parse_wrap_args),
+		OPT_CALLBACK(0, "group", &log, N_("field"),
+			N_("Group by field"), parse_group_option),
 		OPT_END(),
 	};
 
diff --git a/shortlog.h b/shortlog.h
index 2fa61c4294..9deeeb3ffb 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -15,7 +15,11 @@ struct shortlog {
 	int in2;
 	int user_format;
 	int abbrev;
-	int committer;
+
+	enum {
+		SHORTLOG_GROUP_AUTHOR = 0,
+		SHORTLOG_GROUP_COMMITTER
+	} group;
 
 	char *common_repo_prefix;
 	int email;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index d3a7ce6bbb..65e4468746 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -215,4 +215,9 @@ test_expect_success 'shortlog --committer (external)' '
 	test_cmp expect actual
 '
 
+test_expect_success '--group=committer is the same as --committer' '
+	git shortlog -ns --group=committer HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0.1085.g44a0350633

