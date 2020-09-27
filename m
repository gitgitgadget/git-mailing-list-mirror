Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC4C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E55207BC
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 08:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgI0IkR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 04:40:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:42440 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730513AbgI0IkR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 04:40:17 -0400
Received: (qmail 29215 invoked by uid 109); 27 Sep 2020 08:40:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 27 Sep 2020 08:40:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4147 invoked by uid 111); 27 Sep 2020 08:40:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 27 Sep 2020 04:40:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 27 Sep 2020 04:40:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: [PATCH v2 8/8] shortlog: allow multiple groups to be specified
Message-ID: <20200927084015.GH2465761@coredump.intra.peff.net>
References: <20200927083933.GA2222823@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927083933.GA2222823@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that shortlog supports reading from trailers, it can be useful to
combine counts from multiple trailers, or between trailers and authors.
This can be done manually by post-processing the output from multiple
runs, but it's non-trivial to make sure that each name/commit pair is
counted only once.

This patch teaches shortlog to accept multiple --group options on the
command line, and pull data from all of them. That makes it possible to
run:

  git shortlog -ns --group=author --group=trailer:co-authored-by

to get a shortlog that counts authors and co-authors equally.

The implementation is mostly straightforward. The "group" enum becomes a
bitfield, and the trailer key becomes a list. I didn't bother
implementing the multi-group semantics for reading from stdin. It would
be possible to do, but the existing matching code makes it awkward, and
I doubt anybody cares.

The duplicate suppression we used for trailers now covers authors and
committers as well (though in non-trailer single-group mode we can skip
the hash insertion and lookup, since we only see one value per commit).

There is one subtlety: we now care about the case when no group bit is
set (in which case we default to showing the author). The caller in
builtin/log.c needs to be adapted to ask explicitly for authors, rather
than relying on shortlog_init(). It would be possible with some
gymnastics to make this keep working as-is, but it's not worth it for a
single caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-shortlog.txt |  7 ++++
 builtin/log.c                  |  1 +
 builtin/shortlog.c             | 64 ++++++++++++++++++-----------
 shortlog.h                     | 10 ++---
 t/t4201-shortlog.sh            | 74 ++++++++++++++++++++++++++++++++++
 5 files changed, 127 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 3db0db2da0..fd93cd41e9 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -51,6 +51,7 @@ OPTIONS
 	Group commits based on `<type>`. If no `--group` option is
 	specified, the default is `author`. `<type>` is one of:
 +
+--
  - `author`, commits are grouped by author
  - `committer`, commits are grouped by committer (the same as `-c`)
  - `trailer:<field>`, the `<field>` is interpreted as a case-insensitive
@@ -68,6 +69,12 @@ Shortlog will attempt to parse each trailer value as a `name <email>`
 identity. If successful, the mailmap is applied and the email is omitted
 unless the `--email` option is specified. If the value cannot be parsed
 as an identity, it will be taken literally and completely.
+--
++
+If `--group` is specified multiple times, commits are counted under each
+value (but again, only once per unique value in that commit). For
+example, `git shortlog --group=author --group=trailer:co-authored-by`
+counts both authors and co-authors.
 
 -c::
 --committer::
diff --git a/builtin/log.c b/builtin/log.c
index b8824d898f..7f27e9eca1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1195,6 +1195,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	log.in1 = 2;
 	log.in2 = 4;
 	log.file = rev->diffopt.file;
+	log.groups = SHORTLOG_GROUP_AUTHOR;
 	for (i = 0; i < nr; i++)
 		shortlog_add_commit(&log, list[i]);
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 28133aec68..0a5c4968f6 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -130,7 +130,10 @@ static void read_from_stdin(struct shortlog *log)
 	static const char *committer_match[2] = { "Commit: ", "committer " };
 	const char **match;
 
-	switch (log->group) {
+	if (HAS_MULTI_BITS(log->groups))
+		die(_("using multiple --group options with stdin is not supported"));
+
+	switch (log->groups) {
 	case SHORTLOG_GROUP_AUTHOR:
 		match = author_match;
 		break;
@@ -221,13 +224,13 @@ static void strset_clear(struct strset *ss)
 }
 
 static void insert_records_from_trailers(struct shortlog *log,
+					 struct strset *dups,
 					 struct commit *commit,
 					 struct pretty_print_context *ctx,
 					 const char *oneline)
 {
 	struct trailer_iterator iter;
 	const char *commit_buffer, *body;
-	struct strset dups = STRSET_INIT;
 	struct strbuf ident = STRBUF_INIT;
 
 	/*
@@ -243,28 +246,28 @@ static void insert_records_from_trailers(struct shortlog *log,
 	while (trailer_iterator_advance(&iter)) {
 		const char *value = iter.val.buf;
 
-		if (strcasecmp(iter.key.buf, log->trailer))
+		if (!string_list_has_string(&log->trailers, iter.key.buf))
 			continue;
 
 		strbuf_reset(&ident);
 		if (!parse_ident(log, &ident, value))
 			value = ident.buf;
 
-		if (strset_check_and_add(&dups, value))
+		if (strset_check_and_add(dups, value))
 			continue;
 		insert_one_record(log, value, oneline);
 	}
 	trailer_iterator_release(&iter);
 
 	strbuf_release(&ident);
-	strset_clear(&dups);
 	unuse_commit_buffer(commit, commit_buffer);
 }
 
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	struct strbuf ident = STRBUF_INIT;
 	struct strbuf oneline = STRBUF_INIT;
+	struct strset dups = STRSET_INIT;
 	struct pretty_print_context ctx = {0};
 	const char *oneline_str;
 
@@ -282,24 +285,29 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	}
 	oneline_str = oneline.len ? oneline.buf : "<none>";
 
-	switch (log->group) {
-	case SHORTLOG_GROUP_AUTHOR:
+	if (log->groups & SHORTLOG_GROUP_AUTHOR) {
+		strbuf_reset(&ident);
 		format_commit_message(commit,
 				      log->email ? "%aN <%aE>" : "%aN",
 				      &ident, &ctx);
-		insert_one_record(log, ident.buf, oneline_str);
-		break;
-	case SHORTLOG_GROUP_COMMITTER:
+		if (!HAS_MULTI_BITS(log->groups) ||
+		    !strset_check_and_add(&dups, ident.buf))
+			insert_one_record(log, ident.buf, oneline_str);
+	}
+	if (log->groups & SHORTLOG_GROUP_COMMITTER) {
+		strbuf_reset(&ident);
 		format_commit_message(commit,
 				      log->email ? "%cN <%cE>" : "%cN",
 				      &ident, &ctx);
-		insert_one_record(log, ident.buf, oneline_str);
-		break;
-	case SHORTLOG_GROUP_TRAILER:
-		insert_records_from_trailers(log, commit, &ctx, oneline_str);
-		break;
+		if (!HAS_MULTI_BITS(log->groups) ||
+		    !strset_check_and_add(&dups, ident.buf))
+			insert_one_record(log, ident.buf, oneline_str);
+	}
+	if (log->groups & SHORTLOG_GROUP_TRAILER) {
+		insert_records_from_trailers(log, &dups, commit, &ctx, oneline_str);
 	}
 
+	strset_clear(&dups);
 	strbuf_release(&ident);
 	strbuf_release(&oneline);
 }
@@ -366,14 +374,16 @@ static int parse_group_option(const struct option *opt, const char *arg, int uns
 	struct shortlog *log = opt->value;
 	const char *field;
 
-	if (unset || !strcasecmp(arg, "author"))
-		log->group = SHORTLOG_GROUP_AUTHOR;
+	if (unset) {
+		log->groups = 0;
+		string_list_clear(&log->trailers, 0);
+	} else if (!strcasecmp(arg, "author"))
+		log->groups |= SHORTLOG_GROUP_AUTHOR;
 	else if (!strcasecmp(arg, "committer"))
-		log->group = SHORTLOG_GROUP_COMMITTER;
+		log->groups |= SHORTLOG_GROUP_COMMITTER;
 	else if (skip_prefix(arg, "trailer:", &field)) {
-		log->group = SHORTLOG_GROUP_TRAILER;
-		free(log->trailer);
-		log->trailer = xstrdup(field);
+		log->groups |= SHORTLOG_GROUP_TRAILER;
+		string_list_append(&log->trailers, field);
 	} else
 		return error(_("unknown group type: %s"), arg);
 
@@ -391,6 +401,8 @@ void shortlog_init(struct shortlog *log)
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
+	log->trailers.strdup_strings = 1;
+	log->trailers.cmp = strcasecmp;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -400,9 +412,9 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 
 	const struct option options[] = {
-		OPT_SET_INT('c', "committer", &log.group,
-			    N_("Group by committer rather than author"),
-			    SHORTLOG_GROUP_COMMITTER),
+		OPT_BIT('c', "committer", &log.groups,
+			N_("Group by committer rather than author"),
+			SHORTLOG_GROUP_COMMITTER),
 		OPT_BOOL('n', "numbered", &log.sort_by_number,
 			 N_("sort output according to the number of commits per author")),
 		OPT_BOOL('s', "summary", &log.summary,
@@ -454,6 +466,10 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	log.abbrev = rev.abbrev;
 	log.file = rev.diffopt.file;
 
+	if (!log.groups)
+		log.groups = SHORTLOG_GROUP_AUTHOR;
+	string_list_sort(&log.trailers);
+
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
diff --git a/shortlog.h b/shortlog.h
index 89c2dbc5e6..64be879b24 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -17,11 +17,11 @@ struct shortlog {
 	int abbrev;
 
 	enum {
-		SHORTLOG_GROUP_AUTHOR = 0,
-		SHORTLOG_GROUP_COMMITTER,
-		SHORTLOG_GROUP_TRAILER,
-	} group;
-	char *trailer;
+		SHORTLOG_GROUP_AUTHOR = (1 << 0),
+		SHORTLOG_GROUP_COMMITTER = (1 << 1),
+		SHORTLOG_GROUP_TRAILER = (1 << 2),
+	} groups;
+	struct string_list trailers;
 
 	char *common_repo_prefix;
 	int email;
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index a62ee9ed55..3d5c4a2086 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -282,4 +282,78 @@ test_expect_success 'shortlog de-duplicates trailers in a single commit' '
 	test_cmp expect actual
 '
 
+test_expect_success 'shortlog can match multiple groups' '
+	git commit --allow-empty -F - <<-\EOF &&
+	subject one
+
+	this has two trailers that are distinct from the author; it will count
+	3 times in the output
+
+	Some-trailer: User A <a@example.com>
+	Another-trailer: User B <b@example.com>
+	EOF
+
+	git commit --allow-empty -F - <<-\EOF &&
+	subject two
+
+	this one has two trailers, one of which is a duplicate with the author;
+	it will only be counted once for them
+
+	Another-trailer: A U Thor <author@example.com>
+	Some-trailer: User B <b@example.com>
+	EOF
+
+	cat >expect <<-\EOF &&
+	     2	A U Thor
+	     2	User B
+	     1	User A
+	EOF
+	git shortlog -ns \
+		--group=author \
+		--group=trailer:some-trailer \
+		--group=trailer:another-trailer \
+		-2 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'set up option selection tests' '
+	git commit --allow-empty -F - <<-\EOF
+	subject
+
+	body
+
+	Trailer-one: value-one
+	Trailer-two: value-two
+	EOF
+'
+
+test_expect_success '--no-group resets group list to author' '
+	cat >expect <<-\EOF &&
+	     1	A U Thor
+	EOF
+	git shortlog -ns \
+		--group=committer \
+		--group=trailer:trailer-one \
+		--no-group \
+		-1 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-group resets trailer list' '
+	cat >expect <<-\EOF &&
+	     1	value-two
+	EOF
+	git shortlog -ns \
+		--group=trailer:trailer-one \
+		--no-group \
+		--group=trailer:trailer-two \
+		-1 HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stdin with multiple groups reports error' '
+	git log >log &&
+	test_must_fail git shortlog --group=author --group=committer <log
+'
+
 test_done
-- 
2.28.0.1127.ga65787d918
