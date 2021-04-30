Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58897C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 197356140C
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 23:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhD3X0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 19:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhD3X0h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 19:26:37 -0400
Received: from mav.lukeshu.com (mav.lukeshu.com [IPv6:2001:19f0:5c00:8069:5400:ff:fe26:6a86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182FEC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 16:25:49 -0700 (PDT)
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id BF42780590;
        Fri, 30 Apr 2021 19:25:45 -0400 (EDT)
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
Subject: [PATCH v4 0/5] fast-export, fast-import: add support for signed-commits
Date:   Fri, 30 Apr 2021 17:25:32 -0600
Message-Id: <20210430232537.1131641-1-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423164118.693197-1-lukeshu@lukeshu.com>
References: <20210423164118.693197-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

fast-export has an existing --signed-tags= option that controls how to
handle tag signatures.  However, there is no equivalent for commit
signatures; it just silently strips the signature out of the commit
(analogously to --signed-tags=strip).

So implement a --signed-commits= flag in fast-export, and implement
the receiving side of it in fast-import.

I believe that this revision addresses all of the feedback so far,
with the exceptions that: (1) I have not implemented Elijah's
suggestion to implement a flag on fast-import to validate signatures.
While I agree that this would be a useful feature, I consider it to be
beyond the scope of this work. (2) The added tests still use `test -s
err`, as that's what's used by the other existing tests.

Notable changes in v4 include adjusting fast-export to not butcher
memory from get_commit_buffer (both adding a new commit to fix
existing butchery, and adjusting the code added in the final commit),
and changing the default to --signed-commits=abort, but adding a
`FAST_EXPORT_SIGNED_COMMITS_NOABORT=1` environment variable.

Luke Shumaker (5):
  git-fast-import.txt: add missing LF in the BNF
  fast-export: rename --signed-tags='warn' to 'warn-verbatim'
  git-fast-export.txt: clarify why 'verbatim' may not be a good idea
  fast-export: do not modify memory from get_commit_buffer
  fast-export, fast-import: add support for signed-commits

 Documentation/git-fast-export.txt |  25 ++++-
 Documentation/git-fast-import.txt |  20 +++-
 builtin/fast-export.c             | 181 ++++++++++++++++++++++--------
 builtin/fast-import.c             |  23 ++++
 t/t9350-fast-export.sh            | 104 +++++++++++++++++
 5 files changed, 303 insertions(+), 50 deletions(-)

Range-diff against v3:
1:  ee767f3a8f ! 1:  3116d531ab git-fast-import.txt: add missing LF in the BNF
    @@ Commit message
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
     
    +
    + ## Notes ##
    +    v2: no changes
    +    v3: no changes
    +    v4: no changes
    +
      ## Documentation/git-fast-import.txt ##
     @@ Documentation/git-fast-import.txt: change to the project.
      	original-oid?
2:  4612dbcdd5 ! 2:  b035fae93c fast-export: rename --signed-tags='warn' to 'warn-verbatim'
    @@ Commit message
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
     
    +
    + ## Notes ##
    +    v2:
    +     - Reword commit message based on feedback from Taylor.
    +     - Fix copy-pasto in the test, noticed by Taylor.
    +     - Add a comment to the tests.
    +     - Fix whitespace in the tests.
    +    v3:
    +     - Document that --signed-tags='warn' is a deprecated synonym for
    +       --signed-tags='warn-verbatim', rather than leaving it
    +       undocumented, based on feedback from Eric.
    +    v4:
    +     - Don't give the "deprecated synonym" mention in the docs its own
    +       paragraph.
    +     - Don't just rename the user-facing string, also rename the internal
    +       enum item from WARN to WARN_VERBATIM.
    +
      ## Documentation/git-fast-export.txt ##
     @@ Documentation/git-fast-export.txt: OPTIONS
      	Insert 'progress' statements every <n> objects, to be shown by
    @@ Documentation/git-fast-export.txt: When asking to 'abort' (which is the default)
      warning will be displayed, with 'verbatim', they will be silently
     -exported and with 'warn', they will be exported, but you will see a
     -warning.
    -+exported and with 'warn-verbatim', they will be exported, but you will
    -+see a warning.
    -++
    -+`warn` is a deprecated synonym of `warn-verbatim`.
    ++exported and with 'warn-verbatim' (or 'warn', a deprecated synonym),
    ++they will be exported, but you will see a warning.
      
      --tag-of-filtered-object=(abort|drop|rewrite)::
      	Specify how to handle tags whose tagged object is filtered out.
     
      ## builtin/fast-export.c ##
    +@@ builtin/fast-export.c: static const char *fast_export_usage[] = {
    + };
    + 
    + static int progress;
    +-static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    ++static enum { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    + static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
    + static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
    + static int fake_missing_tagger;
     @@ builtin/fast-export.c: static int parse_opt_signed_tag_mode(const struct option *opt,
      		signed_tag_mode = SIGNED_TAG_ABORT;
      	else if (!strcmp(arg, "verbatim") || !strcmp(arg, "ignore"))
      		signed_tag_mode = VERBATIM;
     -	else if (!strcmp(arg, "warn"))
    +-		signed_tag_mode = WARN;
     +	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
    - 		signed_tag_mode = WARN;
    ++		signed_tag_mode = WARN_VERBATIM;
      	else if (!strcmp(arg, "warn-strip"))
      		signed_tag_mode = WARN_STRIP;
    + 	else if (!strcmp(arg, "strip"))
    +@@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
    + 				die("encountered signed tag %s; use "
    + 				    "--signed-tags=<mode> to handle it",
    + 				    oid_to_hex(&tag->object.oid));
    +-			case WARN:
    ++			case WARN_VERBATIM:
    + 				warning("exporting signed tag %s",
    + 					oid_to_hex(&tag->object.oid));
    + 				/* fallthru */
     
      ## t/t9350-fast-export.sh ##
     @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=verbatim' '
-:  ---------- > 3:  38b1ea78fd git-fast-export.txt: clarify why 'verbatim' may not be a good idea
-:  ---------- > 4:  1c34b843fb fast-export: do not modify memory from get_commit_buffer
3:  e57f82e443 ! 5:  788542f669 fast-export, fast-import: implement signed-commits
    @@ Metadata
     Author: Luke Shumaker <lukeshu@datawire.io>
     
      ## Commit message ##
    -    fast-export, fast-import: implement signed-commits
    +    fast-export, fast-import: add support for signed-commits
     
    -    fast-export has an existing --signed-tags= flag that controls how to
    -    handle tag signatures.  However, there is no equivalent for commit
    -    signatures; it just silently strips the signature out of the commit
    -    (analogously to --signed-tags=strip).
    +    fast-export has a --signed-tags= option that controls how to handle tag
    +    signatures.  However, there is no equivalent for commit signatures; it
    +    just silently strips the signature out of the commit (analogously to
    +    --signed-tags=strip).
     
         While signatures are generally problematic for fast-export/fast-import
         (because hashes are likely to change), if they're going to support tag
         signatures, there's no reason to not also support commit signatures.
     
    -    So, implement signed-commits.
    +    So, implement a --signed-commits= option that mirrors the --signed-tags=
    +    option.
     
         On the fast-export side, try to be as much like signed-tags as possible,
    -    in both implementation and in user-interface; with the exception that
    -    the default should be `--signed-commits=warn-strip` (compared to the
    -    default `--signed-tags=abort`), in order to avoid breaking the
    -    historical behavior (it will now print a warning while doing that
    -    behavior, though).
    +    in both implementation and in user-interface.  This will changes the
    +    default behavior to '--signed-commits=abort' from what is now
    +    '--signed-commits=strip'.  In order to provide an escape hatch for users
    +    of third-party tools that call fast-export and do not yet know of the
    +    --signed-commits= option, add an environment variable
    +    'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' that changes the default to
    +    '--signed-commits=warn-strip'.
     
         Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
     
    +
    + ## Notes ##
    +    v2:
    +     - Remove erroneous remark about ordering from the commit message.
    +     - Adjust the stream syntax to include the hash algorithm, as
    +       suggested by brian.
    +     - Add support for sha256 (based on lots of useful information from
    +       brian).  It does not support multiply-signed commits.
    +     - Shorten the documentation, based on feedback from Taylor.
    +     - Add comments, based on feedback from Taylor.
    +     - Change the default from `--signed-commits=strip` to
    +       `--signed-commits=warn-strip`.  This shouldn't break anyone, and
    +       means that users get useful feedback by default.
    +    v3: no changes
    +    v4:
    +     - Reword the commit message based on feedback from Junio.
    +     - v1-v3 renamed enum items to SIGN_VERBATIM_WARN and SIGN_STRIP_WARN,
    +       rename them to SIGN_WARN_VERBATIM and SIGN_WARN_STRIP instead.
    +     - Rewrite find_signature() as find_commit_multiline_header().  Don't
    +       have it butcher the memory that we pass to it; have it return its
    +       own buffer.
    +     - Change the default from `--signed-commits=warn-strip` to
    +       `--signed-commits=abort`, to match `--signed-tags`.
    +     - Add a FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 env-var to change the
    +       default to `--signed-commits=warn-strip`.
    +
      ## Documentation/git-fast-export.txt ##
    -@@ Documentation/git-fast-export.txt: see a warning.
    - +
    - `warn` is a deprecated synonym of `warn-verbatim`.
    +@@ Documentation/git-fast-export.txt: they will be exported, but you will see a warning.  'verbatim' and
    + transformations affecting tags will be performed, or if you do not
    + care that the resulting tag will have an invalid signature.
      
     +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
     +	Specify how to handle signed commits.  Behaves exactly as
    -+	--signed-tags (but for commits), except that the default is
    -+	'warn-strip' rather than 'abort'.
    ++	'--signed-tags', but for commits.
    +++
    ++Earlier versions this command that did not have '--signed-commits'
    ++behaved as if '--signed-commits=strip'.  As an escape hatch for users
    ++of tools that call 'git fast-export' but do not yet support
    ++'--signed-commits', you may set the environment variable
    ++'FAST_EXPORT_SIGNED_COMMITS_NOABORT=1' in order to change the default
    ++from 'abort' to 'warn-strip'.
     +
      --tag-of-filtered-object=(abort|drop|rewrite)::
      	Specify how to handle tags whose tagged object is filtered out.
    @@ builtin/fast-export.c: static const char *fast_export_usage[] = {
      	NULL
      };
      
    -+enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_VERBATIM_WARN, SIGN_STRIP_WARN };
    ++enum sign_mode { SIGN_ABORT, SIGN_VERBATIM, SIGN_STRIP, SIGN_WARN_VERBATIM, SIGN_WARN_STRIP };
     +
      static int progress;
    --static enum { SIGNED_TAG_ABORT, VERBATIM, WARN, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
    +-static enum { SIGNED_TAG_ABORT, VERBATIM, WARN_VERBATIM, WARN_STRIP, STRIP } signed_tag_mode = SIGNED_TAG_ABORT;
     +static enum sign_mode signed_tag_mode = SIGN_ABORT;
    -+static enum sign_mode signed_commit_mode = SIGN_STRIP_WARN;
    ++static enum sign_mode signed_commit_mode = SIGN_ABORT;
      static enum { TAG_FILTERING_ABORT, DROP, REWRITE } tag_of_filtered_mode = TAG_FILTERING_ABORT;
      static enum { REENCODE_ABORT, REENCODE_YES, REENCODE_NO } reencode_mode = REENCODE_ABORT;
      static int fake_missing_tagger;
    @@ builtin/fast-export.c: static int anonymize;
     -		signed_tag_mode = VERBATIM;
     +		*valptr = SIGN_VERBATIM;
      	else if (!strcmp(arg, "warn-verbatim") || !strcmp(arg, "warn"))
    --		signed_tag_mode = WARN;
    -+		*valptr = SIGN_VERBATIM_WARN;
    +-		signed_tag_mode = WARN_VERBATIM;
    ++		*valptr = SIGN_WARN_VERBATIM;
      	else if (!strcmp(arg, "warn-strip"))
     -		signed_tag_mode = WARN_STRIP;
    -+		*valptr = SIGN_STRIP_WARN;
    ++		*valptr = SIGN_WARN_STRIP;
      	else if (!strcmp(arg, "strip"))
     -		signed_tag_mode = STRIP;
     +		*valptr = SIGN_STRIP;
    @@ builtin/fast-export.c: static int anonymize;
      	return 0;
      }
      
    -@@ builtin/fast-export.c: static void show_filemodify(struct diff_queue_struct *q,
    - 	}
    +@@ builtin/fast-export.c: static void anonymize_ident_line(const char **beg, const char **end)
    + 	*end = out->buf + out->len;
      }
      
    -+static const char *find_signature(const char *begin, const char *end, const char *key)
    ++/*
    ++ * find_commit_multiline_header is similar to find_commit_header,
    ++ * except that it handles multi-line headers, rathar than simply
    ++ * returning the first line of the header.
    ++ *
    ++ * The returned string has had the ' ' line continuation markers
    ++ * removed, and points to staticly allocated memory (not to memory
    ++ * within 'msg'), so it is only valid until the next call to
    ++ * find_commit_multiline_header.
    ++ *
    ++ * If the header is found, then *end is set to point at the '\n' in
    ++ * msg that immediately follows the header value.
    ++ */
    ++static const char *find_commit_multiline_header(const char *msg,
    ++						const char *key,
    ++						const char **end)
     +{
    -+	static struct strbuf needle = STRBUF_INIT;
    -+	char *bod, *eod, *eol;
    ++	static struct strbuf val = STRBUF_INIT;
    ++	const char *bol, *eol;
    ++	size_t len;
     +
    -+	strbuf_reset(&needle);
    -+	strbuf_addch(&needle, '\n');
    -+	strbuf_addstr(&needle, key);
    -+	strbuf_addch(&needle, ' ');
    ++	strbuf_reset(&val);
     +
    -+	bod = memmem(begin, end ? end - begin : strlen(begin),
    -+		     needle.buf, needle.len);
    -+	if (!bod)
    ++	bol = find_commit_header(msg, key, &len);
    ++	if (!bol)
     +		return NULL;
    -+	bod += needle.len;
    -+
    -+	/*
    -+	 * In the commit object, multi-line header values are stored
    -+	 * by prefixing continuation lines begin with a space.  So
    -+	 * within the commit object, it looks like
    -+	 *
    -+	 *     "gpgsig -----BEGIN PGP SIGNATURE-----\n"
    -+	 *     " Version: GnuPG v1.4.5 (GNU/Linux)\n"
    -+	 *     " \n"
    -+	 *     " base64_pem_here\n"
    -+	 *     " -----END PGP SIGNATURE-----\n"
    -+	 *
    -+	 * So we need to look for the first '\n' that *isn't* followed
    -+	 * by a ' ' (or the first '\0', if no such '\n' exists).
    -+	 */
    -+	eod = strchrnul(bod, '\n');
    -+	while (eod[0] == '\n' && eod[1] == ' ') {
    -+		eod = strchrnul(eod+1, '\n');
    ++	eol = bol + len;
    ++	strbuf_add(&val, bol, len);
    ++
    ++	while (eol[0] == '\n' && eol[1] == ' ') {
    ++		bol = eol + 2;
    ++		eol = strchrnul(bol, '\n');
    ++		strbuf_addch(&val, '\n');
    ++		strbuf_add(&val, bol, eol - bol);
     +	}
    -+	*eod = '\0';
    -+
    -+	/*
    -+	 * We now have the value as it's stored in the commit object.
    -+	 * However, we want the raw value; we want to return
    -+	 *
    -+	 *     "-----BEGIN PGP SIGNATURE-----\n"
    -+	 *     "Version: GnuPG v1.4.5 (GNU/Linux)\n"
    -+	 *     "\n"
    -+	 *     "base64_pem_here\n"
    -+	 *     "-----END PGP SIGNATURE-----\n"
    -+	 *
    -+	 * So now we need to strip out all of those extra spaces.
    -+	 */
    -+	while ((eol = strstr(bod, "\n ")))
    -+		memmove(eol+1, eol+2, strlen(eol+1));
    -+
    -+	return bod;
    ++
    ++	*end = eol;
    ++	return val.buf;
     +}
     +
    - static const char *find_encoding(const char *begin, const char *end)
    + static char *reencode_message(const char *in_msg,
    + 			      const char *in_encoding, size_t in_encoding_len)
      {
    - 	const char *needle = "\nencoding ";
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
    - 	int saved_output_format = rev->diffopt.output_format;
    - 	const char *commit_buffer;
      	const char *author, *author_end, *committer, *committer_end;
    + 	const char *encoding;
    + 	size_t encoding_len;
     +	const char *signature_alg = NULL, *signature;
    - 	const char *encoding, *message;
    + 	const char *message;
      	char *reencoded = NULL;
      	struct commit_list *p;
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
      	committer++;
    - 	committer_end = strchrnul(committer, '\n');
    - 	message = strstr(committer_end, "\n\n");
    -+	if ((signature = find_signature(committer_end, message, "gpgsig")))
    + 	commit_buffer_cursor = committer_end = strchrnul(committer, '\n');
    + 
    +-	/* find_commit_header() gets a `+ 1` because
    +-	 * commit_buffer_cursor points at the trailing "\n" at the end
    +-	 * of the previous line, but find_commit_header() wants a
    ++	/* find_commit_header() and find_commit_multiline_header() get
    ++	 * a `+ 1` because commit_buffer_cursor points at the trailing
    ++	 * "\n" at the end of the previous line, but they want a
    + 	 * pointer to the beginning of the next line. */
    ++
    + 	encoding = find_commit_header(commit_buffer_cursor + 1, "encoding", &encoding_len);
    + 	if (encoding)
    + 		commit_buffer_cursor = encoding + encoding_len;
    + 
    ++	if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig", &commit_buffer_cursor)))
     +		signature_alg = "sha1";
    -+	else if ((signature = find_signature(committer_end, message, "gpgsig-sha256")))
    ++	else if ((signature = find_commit_multiline_header(commit_buffer_cursor + 1, "gpgsig-sha256", &commit_buffer_cursor)))
     +		signature_alg = "sha256";
    - 	encoding = find_encoding(committer_end, message);
    ++
    + 	message = strstr(commit_buffer_cursor, "\n\n");
      	if (message)
      		message += 2;
     @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct rev_info *rev,
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
     +	if (signature)
     +		switch(signed_commit_mode) {
     +		case SIGN_ABORT:
    -+			die("encountered signed commit %s",
    ++			die("encountered signed commit %s; use "
    ++			    "--signed-commits=<mode> to handle it",
     +			    oid_to_hex(&commit->object.oid));
    -+		case SIGN_VERBATIM_WARN:
    ++		case SIGN_WARN_VERBATIM:
     +			warning("exporting signed commit %s",
     +				oid_to_hex(&commit->object.oid));
     +			/* fallthru */
    @@ builtin/fast-export.c: static void handle_commit(struct commit *commit, struct r
     +			       (unsigned)strlen(signature),
     +			       signature);
     +			break;
    -+		case SIGN_STRIP_WARN:
    -+			warning("stripping signature from commit %s; use"
    -+				"--signed-commits=<mode> to handle it differently",
    ++		case SIGN_WARN_STRIP:
    ++			warning("stripping signature from commit %s",
     +				oid_to_hex(&commit->object.oid));
     +			/* fallthru */
     +		case SIGN_STRIP:
     +			break;
     +		}
      	if (!reencoded && encoding)
    - 		printf("encoding %s\n", encoding);
    + 		printf("encoding %.*s\n", (int)encoding_len, encoding);
      	printf("data %u\n%s",
     @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      					       "\n-----BEGIN PGP SIGNATURE-----\n");
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      				die("encountered signed tag %s; use "
      				    "--signed-tags=<mode> to handle it",
      				    oid_to_hex(&tag->object.oid));
    --			case WARN:
    -+			case SIGN_VERBATIM_WARN:
    +-			case WARN_VERBATIM:
    ++			case SIGN_WARN_VERBATIM:
      				warning("exporting signed tag %s",
      					oid_to_hex(&tag->object.oid));
      				/* fallthru */
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
     +			case SIGN_VERBATIM:
      				break;
     -			case WARN_STRIP:
    -+			case SIGN_STRIP_WARN:
    ++			case SIGN_WARN_STRIP:
      				warning("stripping signature from tag %s",
      					oid_to_hex(&tag->object.oid));
      				/* fallthru */
    @@ builtin/fast-export.c: static void handle_tag(const char *name, struct tag *tag)
      				message_size = signature + 1 - message;
      				break;
      			}
    +@@ builtin/fast-export.c: static int parse_opt_anonymize_map(const struct option *opt,
    + 
    + int cmd_fast_export(int argc, const char **argv, const char *prefix)
    + {
    ++	const char *env_signed_commits_noabort;
    + 	struct rev_info revs;
    + 	struct object_array commits = OBJECT_ARRAY_INIT;
    + 	struct commit *commit;
     @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
      			    N_("show progress after <n> objects")),
      		OPT_CALLBACK(0, "signed-tags", &signed_tag_mode, N_("mode"),
    @@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const ch
      		OPT_CALLBACK(0, "tag-of-filtered-object", &tag_of_filtered_mode, N_("mode"),
      			     N_("select handling of tags that tag filtered objects"),
      			     parse_opt_tag_of_filtered_mode),
    +@@ builtin/fast-export.c: int cmd_fast_export(int argc, const char **argv, const char *prefix)
    + 	if (argc == 1)
    + 		usage_with_options (fast_export_usage, options);
    + 
    ++	env_signed_commits_noabort = getenv("FAST_EXPORT_SIGNED_COMMITS_NOABORT");
    ++	if (env_signed_commits_noabort && *env_signed_commits_noabort)
    ++		signed_commit_mode = SIGN_WARN_STRIP;
    ++
    + 	/* we handle encodings */
    + 	git_config(git_default_config, NULL);
    + 
     
      ## builtin/fast-import.c ##
     @@ builtin/fast-import.c: static struct hash_list *parse_merge(unsigned int *count)
    @@ t/t9350-fast-export.sh: test_expect_success 'signed-tags=warn-strip' '
     +
     +'
     +
    ++test_expect_success GPG 'signed-commits default' '
    ++
    ++	unset FAST_EXPORT_SIGNED_COMMITS_NOABORT &&
    ++	test_must_fail git fast-export --reencode=no commit-signing &&
    ++
    ++	FAST_EXPORT_SIGNED_COMMITS_NOABORT=1 git fast-export --reencode=no commit-signing >output 2>err &&
    ++	! grep ^gpgsig output &&
    ++	grep "^encoding ISO-8859-1" output &&
    ++	test -s err &&
    ++	sed "s/commit-signing/commit-strip-signing/" output |
    ++		(cd new &&
    ++		 git fast-import &&
    ++		 test $COMMIT_SIGNING != $(git rev-parse --verify refs/heads/commit-strip-signing))
    ++
    ++'
    ++
     +test_expect_success GPG 'signed-commits=abort' '
     +
     +	test_must_fail git fast-export --signed-commits=abort commit-signing
-- 
2.31.1

Happy hacking,
~ Luke Shumaker
