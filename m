Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9F1C43461
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB62D61057
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 23:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhDSXFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 19:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbhDSXFI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 19:05:08 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A3DC06138A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 16:04:38 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [8.42.69.49])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 63F3A80594;
        Mon, 19 Apr 2021 18:55:00 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] fast-export, fast-import: implement signed-commits
Date:   Mon, 19 Apr 2021 16:54:41 -0600
Message-Id: <20210419225441.3139048-4-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210419225441.3139048-1-lukeshu@lukeshu.com>
References: <20210419225441.3139048-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

fast-export has an existing --signed-tags= flag that controls how to
handle tag signatures.  However, there is no equivalent for commit
signatures; it just silently strips the signature out of the commit
(analogously to --signed-tags=strip).

While signatures are generally problematic for fast-export/fast-import
(because hashes are likely to change), if they're going to support tag
signatures, there's no reason to not also support commit signatures.

So, implement signed-commits.

On the fast-export side, try to be as much like signed-tags as possible,
in both implementation and in user-interface; with the exception that
the default should be `--signed-commits=strip` (compared to the default
`--signed-tags=abort`), in order to continue defaulting to the
historical behavior.  Only bother implementing "gpgsig", not
"gpgsig-sha256"; the existing signed-tag support doesn't implement
"gpgsig-sha256" either.

On the fast-import side, I'm not entirely sure that I got the ordering
correct between "gpgsig" and "encoding" when generating the commit
object.

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 Documentation/git-fast-export.txt | 12 +++++
 Documentation/git-fast-import.txt |  7 +++
 builtin/fast-export.c             | 86 +++++++++++++++++++++++++------
 builtin/fast-import.c             | 15 ++++++
 t/t9350-fast-export.sh            | 70 +++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index d4a2bfe037..6fdb678b54 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -39,6 +39,18 @@ warning will be displayed, with 'verbatim', they will be silently
 exported and with 'warn-verbatim', they will be exported, but you will
 see a warning.
 
+--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed commits.  Since any transformation
+	after the export can change the commit (which can also happen
+	when excluding revisions) the signatures will not match.
++
+When asking to 'abort', this program will die when encountering a
+signed commit.  With 'strip' (which is the default), the commits will
+silently be made unsigned, with 'warn-strip' they will be made
+unsigned but a warning will be displayed, with 'verbatim', they will
+be silently exported and with 'warn-verbatim', they will be exported,
+but you will see a warning.
+
 --tag-of-filtered-object=(abort|drop|rewrite)::
 	Specify how to handle tags whose tagged object is filtered out.
 	Since revisions and files to export can be limited by path,
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 458af0a2d6..3d0c5dbf7d 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -437,6 +437,7 @@ change to the project.
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
+	('gpgsig' LF data)?
 	('encoding' SP <encoding> LF)?
 	data
 	('from' SP <commit-ish> LF)?
@@ -505,6 +506,12 @@ that was selected by the --date-format=<fmt> command-line option.
 See ``Date Formats'' above for the set of supported formats, and
 their syntax.
 
+`gpgsig`
+^^^^^^^^
+
+The optional `gpgsig` command is used to include a PGP/GPG signature
+that signs the commit data.
+
 `encoding`
 ^^^^^^^^^^
 The optional `encoding` command indicates the encoding of the commit
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d121dd2ee6..d48adbc9b9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -30,8 +30,11 @@ static const char *fast_export_usage[] = {
 	NULL
 };
 
+enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_VERBATIM_WARN, SIGN_STRIP_WARN };
+
 static int progress;
-static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
+static enum sign_mode signed_tag_mode = SIGN_ABORT;
+static enum sign_mode signed_commit_mode = SIGN_STRIP;
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
-		signed_tag_mode = WARN;
+		*valptr = SIGN_VERBATIM_WARN;
 	else if (!strcmp(arg, "warn-strip"))
-		signed_tag_mode = WARN_STRIP;
+		*valptr = SIGN_STRIP_WARN;
 	else if (!strcmp(arg, "strip"))
-		signed_tag_mode = STRIP;
+		*valptr = SIGN_STRIP;
 	else
-		return error("Unknown signed-tags mode: %s", arg);
+		return error("Unknown %s mode: %s", opt->long_name, arg);
 	return 0;
 }
 
@@ -499,6 +505,28 @@ static void show_filemodify(struct diff_queue_struct *q,
 	}
 }
 
+static const char *find_signature(const char *begin, const char *end)
+{
+	const char *needle = "\ngpgsig ";
+	char *bod, *eod, *eol;
+
+	bod = memmem(begin, end ? end - begin : strlen(begin),
+		     needle, strlen(needle));
+	if (!bod)
+		return NULL;
+	bod += strlen(needle);
+	eod = strchrnul(bod, '\n');
+	while (eod[0] == '\n' && eod[1] == ' ') {
+		eod = strchrnul(eod+1, '\n');
+	}
+	*eod = '\0';
+
+	while ((eol = strstr(bod, "\n ")))
+		memmove(eol+1, eol+2, strlen(eol+1));
+
+	return bod;
+}
+
 static const char *find_encoding(const char *begin, const char *end)
 {
 	const char *needle = "\nencoding ";
@@ -621,7 +649,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	int saved_output_format = rev->diffopt.output_format;
 	const char *commit_buffer;
 	const char *author, *author_end, *committer, *committer_end;
-	const char *encoding, *message;
+	const char *encoding, *signature, *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
 	const char *refname;
@@ -644,6 +672,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	committer++;
 	committer_end = strchrnul(committer, '\n');
 	message = strstr(committer_end, "\n\n");
+	signature = find_signature(committer_end, message);
 	encoding = find_encoding(committer_end, message);
 	if (message)
 		message += 2;
@@ -703,6 +732,28 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
+	if (signature)
+		switch(signed_commit_mode) {
+		case SIGN_ABORT:
+			die("encountered signed commit %s; use "
+			    "--signed-commits=<mode> to handle it",
+			    oid_to_hex(&commit->object.oid));
+		case SIGN_VERBATIM_WARN:
+			warning("exporting signed commit %s",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_VERBATIM:
+			printf("gpgsig\ndata %u\n%s",
+			       (unsigned)strlen(signature),
+			       signature);
+			break;
+		case SIGN_STRIP_WARN:
+			warning("stripping signature from commit %s",
+			       oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_STRIP:
+			break;
+		}
 	if (!reencoded && encoding)
 		printf("encoding %s\n", encoding);
 	printf("data %u\n%s",
@@ -830,21 +881,21 @@ static void handle_tag(const char *name, struct tag *tag)
 					       "\n-----BEGIN PGP SIGNATURE-----\n");
 		if (signature)
 			switch(signed_tag_mode) {
-			case SIGNED_TAG_ABORT:
+			case SIGN_ABORT:
 				die("encountered signed tag %s; use "
 				    "--signed-tags=<mode> to handle it",
 				    oid_to_hex(&tag->object.oid));
-			case WARN:
+			case SIGN_VERBATIM_WARN:
 				warning("exporting signed tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
-			case VERBATIM:
+			case SIGN_VERBATIM:
 				break;
-			case WARN_STRIP:
+			case SIGN_STRIP_WARN:
 				warning("stripping signature from tag %s",
 					oid_to_hex(&tag->object.oid));
 				/* fallthru */
-			case STRIP:
+			case SIGN_STRIP:
 				message_size = signature + 1 - message;
 				break;
 			}
@@ -1197,7 +1248,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
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
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 3afa81cf9a..74d08e09fd 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -2669,7 +2669,9 @@ static struct hash_list *parse_merge(unsigned int *count)
 
 static void parse_new_commit(const char *arg)
 {
+	static struct strbuf sig = STRBUF_INIT;
 	static struct strbuf msg = STRBUF_INIT;
+	struct string_list siglines = STRING_LIST_INIT_NODUP;
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
@@ -2696,6 +2698,12 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
+	if (!strcmp(command_buf.buf, "gpgsig")) {
+		read_next_command();
+		parse_data(&sig, 0, NULL);
+		read_next_command();
+	} else
+		strbuf_setlen(&sig, 0);
 	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
 		encoding = xstrdup(v);
 		read_next_command();
@@ -2769,8 +2777,15 @@ static void parse_new_commit(const char *arg)
 		strbuf_addf(&new_data,
 			"encoding %s\n",
 			encoding);
+	if (sig.len) {
+		strbuf_addstr(&new_data, "gpgsig ");
+		string_list_split_in_place(&siglines, sig.buf, '\n', -1);
+		strbuf_add_separated_string_list(&new_data, "\n ", &siglines);
+		strbuf_addch(&new_data, '\n');
+	}
 	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
+	string_list_clear(&siglines, 1);
 	free(author);
 	free(committer);
 	free(encoding);
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index db0e58b1e8..49a2827be2 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -8,6 +8,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
 
@@ -278,9 +279,78 @@ test_expect_success 'signed-tags=warn-strip' '
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
+test_expect_success GPG 'signed-commits=abort' '
+
+	test_must_fail git fast-export --signed-commits=abort commit-signing
+
+'
+
+test_expect_success GPG 'signed-commits=verbatim' '
+
+	git fast-export --signed-commits=verbatim --reencode=no commit-signing >output &&
+	grep ^gpgsig output &&
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
+	grep ^gpgsig output &&
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

