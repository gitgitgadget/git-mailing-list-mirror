Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EEAC43460
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA2A61418
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhD3X0y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 19:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhD3X0t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 19:26:49 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D0C06138B
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 16:26:00 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 32D8D80590;
        Fri, 30 Apr 2021 19:26:00 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v4 5/5] fast-export, fast-import: add support for signed-commits
Date:   Fri, 30 Apr 2021 17:25:37 -0600
Message-Id: <20210430232537.1131641-6-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430232537.1131641-1-lukeshu@lukeshu.com>
References: <20210423164118.693197-1-lukeshu@lukeshu.com>
 <20210430232537.1131641-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

fast-export has a --signed-tags= option that controls how to handle tag
signatures.  However, there is no equivalent for commit signatures; it
just silently strips the signature out of the commit (analogously to
--signed-tags=strip).

While signatures are generally problematic for fast-export/fast-import
(because hashes are likely to change), if they're going to support tag
signatures, there's no reason to not also support commit signatures.

So, implement a --signed-commits= option that mirrors the --signed-tags=
option.

On the fast-export side, try to be as much like signed-tags as possible,
in both implementation and in user-interface.  This will changes the
default behavior to '--signed-commits=abort' from what is now
'--signed-commits=strip'.  In order to provide an escape hatch for users
of third-party tools that call fast-export and do not yet know of the
--signed-commits= option, add an environment variable
'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' that changes the default to
'--signed-commits=warn-strip'.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---

Notes:
    v2:
     - Remove erroneous remark about ordering from the commit message.
     - Adjust the stream syntax to include the hash algorithm, as
       suggested by brian.
     - Add support for sha256 (based on lots of useful information from
       brian).  It does not support multiply-signed commits.
     - Shorten the documentation, based on feedback from Taylor.
     - Add comments, based on feedback from Taylor.
     - Change the default from `--signed-commits=strip` to
       `--signed-commits=warn-strip`.  This shouldn't break anyone, and
       means that users get useful feedback by default.
    v3: no changes
    v4:
     - Reword the commit message based on feedback from Junio.
     - v1-v3 renamed enum items to SIGN_VERBATIM_WARN and SIGN_STRIP_WARN,
       rename them to SIGN_WARN_VERBATIM and SIGN_WARN_STRIP instead.
     - Rewrite find_signature() as find_commit_multiline_header().  Don't
       have it butcher the memory that we pass to it; have it return its
       own buffer.
     - Change the default from `--signed-commits=warn-strip` to
       `--signed-commits=abort`, to match `--signed-tags`.
     - Add a FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 env-var to change the
       default to `--signed-commits=warn-strip`.

 Documentation/git-fast-export.txt |  11 +++
 Documentation/git-fast-import.txt |  18 +++++
 builtin/fast-export.c             | 120 +++++++++++++++++++++++++-----
 builtin/fast-import.c             |  23 ++++++
 t/t9350-fast-export.sh            |  86 +++++++++++++++++++++
 5 files changed, 240 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index a364812d9f..7a946e2ede 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -43,6 +43,17 @@ they will be exported, but you will see a warning.  'verbatim' and
 transformations affecting tags will be performed, or if you do not
 care that the resulting tag will have an invalid signature.
 
+--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed commits.  Behaves exactly as
+	'--signed-tags', but for commits.
++
+Earlier versions this command that did not have '--signed-commits'
+behaved as if '--signed-commits=strip'.  As an escape hatch for users
+of tools that call 'git fast-export' but do not yet support
+'--signed-commits', you may set the environment variable
+'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
+from 'abort' to 'warn-strip'.
+
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
 	Since revisions and files to export can be limited by path,
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 458af0a2d6..4955c94305 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -431,12 +431,21 @@ and control the current import process.  More detailed discussion
 Create or update a branch with a new commit, recording one logical
 change to the project.
 
+////
+Yes, it's intentional that the 'gpgsig' line doesn't have a trailing
+`LF`; the the definition of `data` has a byte-count prefix, so it
+doesn't need an `LF` to act as a terminator (and `data` also already
+includes an optional trailing `LF?` just in case you want to include
+one).
+////
+
 ....
 	'commit' SP <ref> LF
 	mark?
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
+	('gpgsig' SP <alg> LF data)?
 	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
@@ -505,6 +514,15 @@ that was selected by the --date-format=<fmt> command-line option.
 See ``Date Formats'' above for the set of supported formats, and
 their syntax.
 
+`gpgsig`
+^^^^^^^^
+
+The optional `gpgsig` command is used to include a PGP/GPG signature
+that signs the commit data.
+
+Here <alg> specifies which hashing algorithm is used for this
+signature, either `sha1` or `sha256`.
+
 `encoding`
 ^^^^^^^^^^
 The optional `encoding` command indicates the encoding of the commit
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 81f3fb1f05..075630f185 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -30,8 +30,11 @@ static const char *fast_export_usage[] = {
 	NULL
 };
 
+enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
+
 static int progress;
-static enum { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum sign_mode signed_tag_mode = SIGN_ABORT;
+static enum sign_mode signed_commit_mode = SIGN_ABORT;
 static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
 static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
 static int fake_missing_tagger;
@@ -48,21 +51,24 @@ static int anonymize;
 static struct hashmap anonymized_seeds;
 static struct revision_sources revision_sources;
 
-static int parse_opt_signed_tag_mode(const struct option *opt,
+static int parse_opt_sign_mode(const struct option *opt,
 				     const char *arg, int unset)
 {
-	if (unset || !strcmp(arg, "abort"))
-		signed_tag_mode = SIGNED_TAG_ABORT;
+	enum sign_mode *valptr = opt->value;
+	if (unset)
+		return 0;
+	else if (!strcmp(arg, "abort"))
+		*valptr = SIGN_ABORT;
 	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
-		signed_tag_mode = VERBATIM;
+		*valptr = SIGN_VERBATIM;
 	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
-		signed_tag_mode = WARN_VERBATIM;
+		*valptr = SIGN_WARN_VERBATIM;
 	else if (!strcmp(arg, "warn-strip"))
-		signed_tag_mode = WARN_STRIP;
+		*valptr = SIGN_WARN_STRIP;
 	else if (!strcmp(arg, "strip"))
-		signed_tag_mode = STRIP;
+		*valptr = SIGN_STRIP;
 	else
-		return error("Unknown signed-tags mode: %s", arg);
+		return error("Unknown %s mode: %s", opt->long_name, arg);
 	return 0;
 }
 
@@ -600,6 +606,46 @@ static void anonymize_ident_line(const char **beg, const char **end)
 	*end = out->buf + out->len;
 }
 
+/*
+ * find_commit_multiline_header is similar to find_commit_header,
+ * except that it handles multi-line headers, rathar than simply
+ * returning the first line of the header.
+ *
+ * The returned string has had the ' ' line continuation markers
+ * removed, and points to staticly allocated memory (not to memory
+ * within 'msg'), so it is only valid until the next call to
+ * find_commit_multiline_header.
+ *
+ * If the header is found, then *end is set to point at the '\n' in
+ * msg that immediately follows the header value.
+ */
+static const char *find_commit_multiline_header(const char *msg,
+						const char *key,
+						const char **end)
+{
+	static struct strbuf val = STRBUF_INIT;
+	const char *bol, *eol;
+	size_t len;
+
+	strbuf_reset(&val);
+
+	bol = find_commit_header(msg, key, &len);
+	if (!bol)
+		return NULL;
+	eol = bol + len;
+	strbuf_add(&val, bol, len);
+
+	while (eol[0] == '\n' && eol[1] == ' ') {
+		bol = eol + 2;
+		eol = strchrnul(bol, '\n');
+		strbuf_addch(&val, '\n');
+		strbuf_add(&val, bol, eol - bol);
+	}
+
+	*end = eol;
+	return val.buf;
+}
+
 static char *reencode_message(const char *in_msg,
 			      const char *in_encoding, size_t in_encoding_len)
 {
@@ -619,6 +665,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	const char *author, *author_end, *committer, *committer_end;
 	const char *encoding;
 	size_t encoding_len;
+	const char *signature_alg = NULL, *signature;
 	const char *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
@@ -644,14 +691,20 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	committer++;
 	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
 
-	/* find_commit_header() gets a `+ 1` because
-	 * commit_buffer_cursor points at the trailing "\n" at the end
-	 * of the previous line, but find_commit_header() wants a
+	/* find_commit_header() and find_commit_multiline_header() get
+	 * a `+ 1` because commit_buffer_cursor points at the trailing
+	 * "\n" at the end of the previous line, but they want a
 	 * pointer to the beginning of the next line. */
+
 	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
 	if (encoding)
 		commit_buffer_cursor = encoding + encoding_len;
 
+	if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
+		signature_alg = "sha1";
+	else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
+		signature_alg = "sha256";
+
 	message = strstr(commit_buffer_cursor, "\n\n");
 	if (message)
 		message += 2;
@@ -712,6 +765,29 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
+	if (signature)
+		switch(signed_commit_mode) {
+		case SIGN_ABORT:
+			die("encountered signed commit %s; use "
+			    "--signed-commits=<mode> to handle it",
+			    oid_to_hex(&commit->object.oid));
+		case SIGN_WARN_VERBATIM:
+			warning("exporting signed commit %s",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_VERBATIM:
+			printf("gpgsig %s\ndata %u\n%s",
+			       signature_alg,
+			       (unsigned)strlen(signature),
+			       signature);
+			break;
+		case SIGN_WARN_STRIP:
+			warning("stripping signature from commit %s",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_STRIP:
+			break;
+		}
 	if (!reencoded && encoding)
 		printf("encoding %.*s\n", (int)encoding_len, encoding);
 	printf("data %u\n%s",
@@ -839,21 +915,21 @@ static void handle_tag(const char *name, struct tag *tag)
 					       "\n-----BEGIN PGP SIGNATURE-----\n");
 		if (signature)
 			switch(signed_tag_mode) {
-			case SIGNED_TAG_ABORT:
+			case SIGN_ABORT:
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
 				    oid_to_hex(&tag->object.oid));
-			case WARN_VERBATIM:
+			case SIGN_WARN_VERBATIM:
 				warning("exporting signed tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
-			case VERBATIM:
+			case SIGN_VERBATIM:
 				break;
-			case WARN_STRIP:
+			case SIGN_WARN_STRIP:
 				warning("stripping signature from tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
-			case STRIP:
+			case SIGN_STRIP:
 				message_size = signature + 1 - message;
 				break;
 			}
@@ -1192,6 +1268,7 @@ static int parse_opt_anonymize_map(const struct option *opt,
 
 int cmd_fast_export(int argc, const char **argv, const char *prefix)
 {
+	const char *env_signed_commits_noabort;
 	struct rev_info revs;
 	struct object_array commits = OBJECT_ARRAY_INIT;
 	struct commit *commit;
@@ -1206,7 +1283,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			    N_("show progress after <n> objects")),
 		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, N_("mode"),
 			     N_("select handling of signed tags"),
-			     parse_opt_signed_tag_mode),
+			     parse_opt_sign_mode),
+		OPT_CALLBACK(0, "signed-commits", &signed_commit_mode, N_("mode"),
+			     N_("select handling of signed commits"),
+			     parse_opt_sign_mode),
 		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
 			     N_("select handling of tags that tag filtered objects"),
 			     parse_opt_tag_of_filtered_mode),
@@ -1247,6 +1327,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (argc == 1)
 		usage_with_options (fast_export_usage, options);
 
+	env_signed_commits_noabort = getenv("FAST_EXPORT_SIGNED_COMMITS_NOABORT");
+	if (env_signed_commits_noabort && *env_signed_commits_noabort)
+		signed_commit_mode = SIGN_WARN_STRIP;
+
 	/* we handle encodings */
 	git_config(git_default_config, NULL);
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3afa81cf9a..ee7516dd38 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2669,10 +2669,13 @@ static struct hash_list *parse_merge(unsigned int *count)
 
 static void parse_new_commit(const char *arg)
 {
+	static struct strbuf sig = STRBUF_INIT;
 	static struct strbuf msg = STRBUF_INIT;
+	struct string_list siglines = STRING_LIST_INIT_NODUP;
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
+	char *sig_alg = NULL;
 	char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
@@ -2696,6 +2699,13 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
+	if (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
+		sig_alg = xstrdup(v);
+		read_next_command();
+		parse_data(&sig, 0, NULL);
+		read_next_command();
+	} else
+		strbuf_setlen(&sig, 0);
 	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
 		encoding = xstrdup(v);
 		read_next_command();
@@ -2769,10 +2779,23 @@ static void parse_new_commit(const char *arg)
 		strbuf_addf(&new_data,
 			"encoding %s\n",
 			encoding);
+	if (sig_alg) {
+		if (!strcmp(sig_alg, "sha1"))
+			strbuf_addstr(&new_data, "gpgsig ");
+		else if (!strcmp(sig_alg, "sha256"))
+			strbuf_addstr(&new_data, "gpgsig-sha256 ");
+		else
+			die("Expected gpgsig algorithm sha1 or sha256, got %s", sig_alg);
+		string_list_split_in_place(&siglines, sig.buf, '\n', -1);
+		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
+		strbuf_addch(&new_data, '\n');
+	}
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
+	string_list_clear(&siglines, 1);
 	free(author);
 	free(committer);
+	free(sig_alg);
 	free(encoding);
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 892737439b..cd51c78418 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -8,6 +8,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
 
@@ -284,9 +285,94 @@ test_expect_success 'signed-tags=warn-strip' '
 	test -s err
 '
 
+test_expect_success GPG 'set up signed commit' '
+
+	# Generate a commit with both "gpgsig" and "encoding" set, so
+	# that we can test that fast-import gets the ordering correct
+	# between the two.
+	test_config i18n.commitEncoding ISO-8859-1 &&
+	git checkout -f -b commit-signing main &&
+	echo Sign your name > file-sign &&
+	git add file-sign &&
+	git commit -S -m "signed commit" &&
+	COMMIT_SIGNING=$(git rev-parse --verify commit-signing)
+
+'
+
+test_expect_success GPG 'signed-commits default' '
+
+	unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
+	test_must_fail git fast-export --reencode=no commit-signing &&
+
+	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
+	! grep ^gpgsig output &&
+	grep "^encoding ISO-8859-1" output &&
+	test -s err &&
+	sed "s/commit-signing/commit-strip-signing/" output |
+		(cd new &&
+		 git fast-import &&
+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
+
+'
+
+test_expect_success GPG 'signed-commits=abort' '
+
+	test_must_fail git fast-export --signed-commits=abort commit-signing
+
+'
+
+test_expect_success GPG 'signed-commits=verbatim' '
+
+	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
+	grep "^gpgsig sha" output &&
+	grep "encoding ISO-8859-1" output &&
+	(cd new &&
+	 git fast-import &&
+	 test $COMMIT_SIGNING = $(git rev-parse --verify refs/heads/commit-signing)) <output
+
+'
+
+test_expect_success GPG 'signed-commits=warn-verbatim' '
+
+	git fast-export --signed-commits=warn-verbatim --reencode=no commit-signing >output 2>err &&
+	grep "^gpgsig sha" output &&
+	grep "encoding ISO-8859-1" output &&
+	test -s err &&
+	(cd new &&
+	 git fast-import &&
+	 test $COMMIT_SIGNING = $(git rev-parse --verify refs/heads/commit-signing)) <output
+
+'
+
+test_expect_success GPG 'signed-commits=strip' '
+
+	git fast-export --signed-commits=strip --reencode=no commit-signing >output &&
+	! grep ^gpgsig output &&
+	grep "^encoding ISO-8859-1" output &&
+	sed "s/commit-signing/commit-strip-signing/" output |
+		(cd new &&
+		 git fast-import &&
+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
+
+'
+
+test_expect_success GPG 'signed-commits=warn-strip' '
+
+	git fast-export --signed-commits=warn-strip --reencode=no commit-signing >output 2>err &&
+	! grep ^gpgsig output &&
+	grep "^encoding ISO-8859-1" output &&
+	test -s err &&
+	sed "s/commit-signing/commit-strip-signing/" output |
+		(cd new &&
+		 git fast-import &&
+		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
+
+'
+
 test_expect_success 'setup submodule' '
 
 	git checkout -f main &&
+	{ git update-ref -d refs/heads/commit-signing || true; } &&
 	mkdir sub &&
 	(
 		cd sub &&
-- 
2.31.1

