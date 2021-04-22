Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2021C433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3C561409
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 00:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343930AbhDVAhd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 20:37:33 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:60102 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhDVAhc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 20:37:32 -0400
Received: from lukeshu-dw-thinkpad (c-73-229-136-185.hsd1.co.comcast.net [73.229.136.185])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 4A71980590;
        Wed, 21 Apr 2021 20:36:58 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson " <sandals@crustytoothpaste.net>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH v2 3/3] fast-export, fast-import: implement signed-commits
Date:   Wed, 21 Apr 2021 18:27:49 -0600
Message-Id: <20210422002749.2413359-4-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422002749.2413359-1-lukeshu@lukeshu.com>
References: <20210422002749.2413359-1-lukeshu@lukeshu.com>
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
the default should be `--signed-commits=warn-strip` (compared to the
default `--signed-tags=abort`), in order to avoid breaking the
historical behavior (it will now print a warning while doing that
behavior, though).

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
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

 Documentation/git-fast-export.txt |   5 ++
 Documentation/git-fast-import.txt |  18 +++++
 builtin/fast-export.c             | 121 ++++++++++++++++++++++++++----
 builtin/fast-import.c             |  23 ++++++
 t/t9350-fast-export.sh            |  70 +++++++++++++++++
 5 files changed, 222 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index d4a2bfe037..2ff1719f8b 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -39,6 +39,11 @@ warning will be displayed, with 'verbatim', they will be silently
 exported and with 'warn-verbatim', they will be exported, but you will
 see a warning.
 
+--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
+	Specify how to handle signed commits.  Behaves exactly as
+	--signed-tags (but for commits), except that the default is
+	'warn-strip' rather than 'abort'.
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
index d121dd2ee6..2b1101d104 100644
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
+static enum sign_mode signed_commit_mode = SIGN_STRIP_WARN;
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
 
@@ -499,6 +505,60 @@ static void show_filemodify(struct diff_queue_struct *q,
 	}
 }
 
+static const char *find_signature(const char *begin, const char *end, const char *key)
+{
+	static struct strbuf needle = STRBUF_INIT;
+	char *bod, *eod, *eol;
+
+	strbuf_reset(&needle);
+	strbuf_addch(&needle, '\n');
+	strbuf_addstr(&needle, key);
+	strbuf_addch(&needle, ' ');
+
+	bod = memmem(begin, end ? end - begin : strlen(begin),
+		     needle.buf, needle.len);
+	if (!bod)
+		return NULL;
+	bod += needle.len;
+
+	/*
+	 * In the commit object, multi-line header values are stored
+	 * by prefixing continuation lines begin with a space.  So
+	 * within the commit object, it looks like
+	 *
+	 *     "gpgsig -----BEGIN PGP SIGNATURE-----\n"
+	 *     " Version: GnuPG v1.4.5 (GNU/Linux)\n"
+	 *     " \n"
+	 *     " base64_pem_here\n"
+	 *     " -----END PGP SIGNATURE-----\n"
+	 *
+	 * So we need to look for the first '\n' that *isn't* followed
+	 * by a ' ' (or the first '\0', if no such '\n' exists).
+	 */
+	eod = strchrnul(bod, '\n');
+	while (eod[0] == '\n' && eod[1] == ' ') {
+		eod = strchrnul(eod+1, '\n');
+	}
+	*eod = '\0';
+
+	/*
+	 * We now have the value as it's stored in the commit object.
+	 * However, we want the raw value; we want to return
+	 *
+	 *     "-----BEGIN PGP SIGNATURE-----\n"
+	 *     "Version: GnuPG v1.4.5 (GNU/Linux)\n"
+	 *     "\n"
+	 *     "base64_pem_here\n"
+	 *     "-----END PGP SIGNATURE-----\n"
+	 *
+	 * So now we need to strip out all of those extra spaces.
+	 */
+	while ((eol = strstr(bod, "\n ")))
+		memmove(eol+1, eol+2, strlen(eol+1));
+
+	return bod;
+}
+
 static const char *find_encoding(const char *begin, const char *end)
 {
 	const char *needle = "\nencoding ";
@@ -621,6 +681,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	int saved_output_format = rev->diffopt.output_format;
 	const char *commit_buffer;
 	const char *author, *author_end, *committer, *committer_end;
+	const char *signature_alg = NULL, *signature;
 	const char *encoding, *message;
 	char *reencoded = NULL;
 	struct commit_list *p;
@@ -644,6 +705,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	committer++;
 	committer_end = strchrnul(committer, '\n');
 	message = strstr(committer_end, "\n\n");
+	if ((signature = find_signature(committer_end, message, "gpgsig")))
+		signature_alg = "sha1";
+	else if ((signature = find_signature(committer_end, message, "gpgsig-sha256")))
+		signature_alg = "sha256";
 	encoding = find_encoding(committer_end, message);
 	if (message)
 		message += 2;
@@ -703,6 +768,29 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	printf("%.*s\n%.*s\n",
 	       (int)(author_end - author), author,
 	       (int)(committer_end - committer), committer);
+	if (signature)
+		switch(signed_commit_mode) {
+		case SIGN_ABORT:
+			die("encountered signed commit %s",
+			    oid_to_hex(&commit->object.oid));
+		case SIGN_VERBATIM_WARN:
+			warning("exporting signed commit %s",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_VERBATIM:
+			printf("gpgsig %s\ndata %u\n%s",
+			       signature_alg,
+			       (unsigned)strlen(signature),
+			       signature);
+			break;
+		case SIGN_STRIP_WARN:
+			warning("stripping signature from commit %s; use"
+				"--signed-commits=<mode> to handle it differently",
+				oid_to_hex(&commit->object.oid));
+			/* fallthru */
+		case SIGN_STRIP:
+			break;
+		}
 	if (!reencoded && encoding)
 		printf("encoding %s\n", encoding);
 	printf("data %u\n%s",
@@ -830,21 +918,21 @@ static void handle_tag(const char *name, struct tag *tag)
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
@@ -1197,7 +1285,10 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
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
index 36b84eff36..45952358ca 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -8,6 +8,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
 
@@ -284,9 +285,78 @@ test_expect_success 'signed-tags=warn-strip' '
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

