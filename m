Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A630C5517A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D56222C2
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 22:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420261AbgJYWlv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1420258AbgJYWlt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Oct 2020 18:41:49 -0400
Received: from 0x63.nu (0x63.nu [IPv6:2a02:750:9::199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA267C061755
        for <git@vger.kernel.org>; Sun, 25 Oct 2020 15:41:49 -0700 (PDT)
Received: from ip6-localhost ([::1] helo=localhost.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXq-0007u5-Fn; Sun, 25 Oct 2020 22:27:18 +0100
From:   Anders Waldenborg <anders@0x63.nu>
To:     git@vger.kernel.org
Cc:     Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com
Subject: [PATCH 13/21] trailer: add option to make canonicalization optional
Date:   Sun, 25 Oct 2020 22:26:44 +0100
Message-Id: <20201025212652.3003036-14-anders@0x63.nu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: ::1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on st.localdomain)
        by 0x63.nu with esmtp (Exim 4.90_1)
        (envelope-from <anders@0x63.nu>)
        id 1kWnXq-0007u5-Fn; Sun, 25 Oct 2020 22:27:18 +0100
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

); SAEximRunCond expanded to false

Adds a new `--(no-)canonicalize` option to interpret-trailers. By
default it is on unless `--parse` option is given.

When option is on trailer tokens and separators get canonicalized to
the form they have in config (if there is any config for that
trailer). This is same behavior as before this patch, which allows
this behavior to be disabled with `--no-canonicalize`. `--parse` now
also implies `--no-canonicalize`, if previous behavior with
canonicalization also in parse mode is wanted it needs to be combined
with `--parse --canonicalize`

Signed-off-by: Anders Waldenborg <anders@0x63.nu>
---
 Documentation/git-interpret-trailers.txt |  5 ++-
 builtin/interpret-trailers.c             |  3 ++
 t/t7513-interpret-trailers.sh            | 52 ++++++++++++++++++++++++
 trailer.c                                | 10 +++--
 trailer.h                                |  1 +
 5 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index a4be8aed66..a9e6816525 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -129,13 +129,16 @@ OPTIONS
 
 --parse::
 	A convenience alias for `--only-trailers --only-input
-	--unfold`.
+	--unfold --no-canonicalize`.
 
 --no-divider::
 	Do not treat `---` as the end of the commit message. Use this
 	when you know your input contains just the commit message itself
 	(and not an email or the output of `git format-patch`).
 
+--no-canonicalize::
+	Disable canonicalization of input trailers.
+
 CONFIGURATION VARIABLES
 -----------------------
 
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 84748eafc0..51678657a3 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -81,6 +81,7 @@ static int parse_opt_parse(const struct option *opt, const char *arg,
 	v->only_trailers = 1;
 	v->only_input = 1;
 	v->unfold = 1;
+	v->canonicalize = 0;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
 	return 0;
@@ -105,6 +106,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
+		OPT_BOOL(0, "canonicalize", &opts.canonicalize, N_("canonicalize spelling for trailers with config")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("set parsing options"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat --- specially")),
@@ -112,6 +114,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 				N_("trailer(s) to add"), option_parse_trailer),
 		OPT_END()
 	};
+	opts.canonicalize = 1;
 
 	git_config(git_default_config, NULL);
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 6602790b5f..4b3a2484b5 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -99,6 +99,58 @@ test_expect_success 'with config option on the command line' '
 	test_cmp expected actual
 '
 
+test_expect_success 'spelling and separators are canonicalized from configs with key' '
+	cat >patch <<-\EOF &&
+		non-trailer-line
+
+		ReviEweD-bY :abc
+		ReviEwEd-bY) rst
+		ReviEweD-BY ; xyz
+		aCked-bY) only separator gets normalized
+	EOF
+	cat >expected <<-\EOF &&
+		Reviewed-By: abc
+		Reviewed-By: rst
+		Reviewed-By: xyz
+		aCked-bY: only separator gets normalized
+	EOF
+	git \
+		-c "trailer.separators=:);" \
+		-c "trailer.rb.key=Reviewed-By" \
+		-c "trailer.Acked-By.ifmissing=doNothing" \
+		interpret-trailers --only-trailers --only-input patch >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'spelling and separators are not canonicalized with --parse or --no-canonicalize' '
+	cat >patch <<-\EOF &&
+		non-trailer-line
+
+		ReviEweD-bY :abc
+		ReviEwEd-bY) rst
+		ReviEweD-BY ; xyz
+		aCked-bY) not normalized
+	EOF
+	cat >expected <<-\EOF &&
+		ReviEweD-bY :abc
+		ReviEwEd-bY) rst
+		ReviEweD-BY ; xyz
+		aCked-bY) not normalized
+	EOF
+	git \
+		-c "trailer.separators=:);" \
+		-c "trailer.rb.key=Reviewed-By" \
+		-c "trailer.Acked-By.ifmissing=doNothing" \
+		interpret-trailers --parse patch >actual &&
+	test_cmp expected actual &&
+	git \
+		-c "trailer.separators=:);" \
+		-c "trailer.rb.key=Reviewed-By" \
+		-c "trailer.Acked-By.ifmissing=doNothing" \
+		interpret-trailers --only-trailers --only-input --no-canonicalize patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with only a title in the message' '
 	cat >expected <<-\EOF &&
 		area: change
diff --git a/trailer.c b/trailer.c
index 102eca0127..110d3ed226 100644
--- a/trailer.c
+++ b/trailer.c
@@ -141,14 +141,18 @@ static void free_arg_item(struct arg_item *item)
 	free(item);
 }
 
-static void print_item(FILE *outfile, const struct trailer_item *item)
+static void print_item(FILE *outfile, const struct trailer_item *item,
+		       const struct process_trailer_options *opts)
 {
 	if (item->token) {
 		const char *tok = item->token;
 		const char *sep = (char []){separators[0], ' ', '\0'};
 		const struct conf_info *conf = item->conf;
 
-		if (conf) {
+		if (!opts->canonicalize && item->used_separator)
+			sep = item->used_separator;
+
+		if (opts->canonicalize && conf) {
 			if (conf->key)
 				tok = conf->key;
 			if (conf->nondefault_separator)
@@ -170,7 +174,7 @@ static void print_all(FILE *outfile, struct list_head *head,
 		item = list_entry(pos, struct trailer_item, list);
 		if ((!opts->trim_empty || strlen(item->value) > 0) &&
 		    (!opts->only_trailers || item->token))
-			print_item(outfile, item);
+			print_item(outfile, item, opts);
 	}
 }
 
diff --git a/trailer.h b/trailer.h
index b362b0d44d..aad856da8c 100644
--- a/trailer.h
+++ b/trailer.h
@@ -72,6 +72,7 @@ struct process_trailer_options {
 	int unfold;
 	int no_divider;
 	int value_only;
+	int canonicalize;
 	const struct strbuf *separator;
 	int (*filter)(const struct strbuf *, const char *alias, void *);
 	void *filter_data;
-- 
2.25.1

