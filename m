Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C839C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B414D2311B
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 07:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgIYHDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 03:03:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:40430 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgIYHDo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 03:03:44 -0400
Received: (qmail 13164 invoked by uid 109); 25 Sep 2020 07:03:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 07:03:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15984 invoked by uid 111); 25 Sep 2020 07:03:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 03:03:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 03:03:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/8] shortlog: match commit trailers with --group
Message-ID: <20200925070343.GD62741@coredump.intra.peff.net>
References: <20200925070120.GA3669667@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925070120.GA3669667@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a project uses commit trailers, this patch lets you use
shortlog to see who is performing each action. For example,
running:

  git shortlog -ns --group=trailer:reviewed-by

in git.git shows who has reviewed. You can even use a custom
format to see things like who has helped whom:

  git shortlog --format="...helped %an (%ad)" \
               --group=trailer:helped-by

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt | 13 ++++++++++
 builtin/shortlog.c             | 44 +++++++++++++++++++++++++++++++++-
 shortlog.h                     |  4 +++-
 t/t4201-shortlog.sh            | 14 +++++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 41b7679aa1..40752bc573 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -54,6 +54,19 @@ OPTIONS
 +
  - `author`, commits are grouped by author (this is the default)
  - `committer`, commits are grouped by committer (the same as `-c`)
+ - `trailer:<field>`, the `<field>` is interpreted as a case-insensitive
+   commit message trailer (see linkgit:git-interpret-trailers[1]). For
+   example, if your project uses `Reviewed-by` trailers, you might want
+   to see who has been reviewing with
+   `git shortlog -ns --group=trailer:reviewed-by`.
++
+Note that commits that do not include the trailer will not be counted.
+Likewise, commits with multiple trailers (e.g., multiple signoffs) may
+be counted more than once.
++
+The contents of each trailer value are taken literally and completely.
+No mailmap is applied, and the `-e` option has no effect (if the trailer
+contains a username and email, they are both always shown).
 
 -c::
 --committer::
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 880ce19304..e1d9ee909f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -9,6 +9,7 @@
 #include "mailmap.h"
 #include "shortlog.h"
 #include "parse-options.h"
+#include "trailer.h"
 
 static char const * const shortlog_usage[] = {
 	N_("git shortlog [<options>] [<revision-range>] [[--] <path>...]"),
@@ -136,6 +137,8 @@ static void read_from_stdin(struct shortlog *log)
 	case SHORTLOG_GROUP_COMMITTER:
 		match = committer_match;
 		break;
+	case SHORTLOG_GROUP_TRAILER:
+		die(_("using --group=trailer with stdin is not supported"));
 	default:
 		BUG("unhandled shortlog group");
 	}
@@ -163,6 +166,37 @@ static void read_from_stdin(struct shortlog *log)
 	strbuf_release(&oneline);
 }
 
+static void insert_records_from_trailers(struct shortlog *log,
+					 struct commit *commit,
+					 struct pretty_print_context *ctx,
+					 const char *oneline)
+{
+	struct trailer_iterator iter;
+	const char *commit_buffer, *body;
+
+	/*
+	 * Using format_commit_message("%B") would be simpler here, but
+	 * this saves us copying the message.
+	 */
+	commit_buffer = logmsg_reencode(commit, NULL, ctx->output_encoding);
+	body = strstr(commit_buffer, "\n\n");
+	if (!body)
+		return;
+
+	trailer_iterator_init(&iter, body);
+	while (trailer_iterator_advance(&iter)) {
+		const char *value = iter.val.buf;
+
+		if (strcasecmp(iter.key.buf, log->trailer))
+			continue;
+
+		insert_one_record(log, value, oneline);
+	}
+	trailer_iterator_release(&iter);
+
+	unuse_commit_buffer(commit, commit_buffer);
+}
+
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
@@ -197,6 +231,9 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 				      &ident, &ctx);
 		insert_one_record(log, ident.buf, oneline_str);
 		break;
+	case SHORTLOG_GROUP_TRAILER:
+		insert_records_from_trailers(log, commit, &ctx, oneline_str);
+		break;
 	}
 
 	strbuf_release(&ident);
@@ -263,12 +300,17 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 static int parse_group_option(const struct option *opt, const char *arg, int unset)
 {
 	struct shortlog *log = opt->value;
+	const char *field;
 
 	if (unset || !strcasecmp(arg, "author"))
 		log->group = SHORTLOG_GROUP_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
 		log->group = SHORTLOG_GROUP_COMMITTER;
-	else
+	else if (skip_prefix(arg, "trailer:", &field)) {
+		log->group = SHORTLOG_GROUP_TRAILER;
+		free(log->trailer);
+		log->trailer = xstrdup(field);
+	} else
 		return error(_("unknown group type: %s"), arg);
 
 	return 0;
diff --git a/shortlog.h b/shortlog.h
index 9deeeb3ffb..54ce55e9e9 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -18,8 +18,10 @@ struct shortlog {
 
 	enum {
 		SHORTLOG_GROUP_AUTHOR = 0,
-		SHORTLOG_GROUP_COMMITTER
+		SHORTLOG_GROUP_COMMITTER,
+		SHORTLOG_GROUP_TRAILER
 	} group;
+	char *trailer;
 
 	char *common_repo_prefix;
 	int email;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 65e4468746..e97d891a71 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -220,4 +220,18 @@ test_expect_success '--group=committer is the same as --committer' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog --group=trailer:signed-off-by' '
+	git commit --allow-empty -m foo -s &&
+	GIT_COMMITTER_NAME="SOB One" \
+	GIT_COMMITTER_EMAIL=sob@example.com \
+		git commit --allow-empty -m foo -s &&
+	git commit --allow-empty --amend --no-edit -s &&
+	cat >expect <<-\EOF &&
+	     2	C O Mitter <committer@example.com>
+	     1	SOB One <sob@example.com>
+	EOF
+	git shortlog -ns --group=trailer:signed-off-by HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.28.0.1085.g44a0350633

