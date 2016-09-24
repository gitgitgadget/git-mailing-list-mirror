Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B9920985
	for <e@80x24.org>; Sat, 24 Sep 2016 00:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758289AbcIXAOD (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 20:14:03 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34442 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbcIXAOB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 20:14:01 -0400
Received: by mail-pf0-f180.google.com with SMTP id p64so46751817pfb.1
        for <git@vger.kernel.org>; Fri, 23 Sep 2016 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=quxjHNxu+UH2nsgY3VbJOeiXHrpBY4c/xz4gf6nwffY=;
        b=EVcmIpEsqY9IH/qu2aKwbAzRLR+xDzbt16WOc85i8cdXJS/IhlhHklcUmQODn6LMwL
         U8o8s9jqmRvrhVmqNh4JrOQ/bVqfOS5V0t+Bt5imyUzIA3Uq0nyAlU3l9e9Ng1UmAKr0
         pxXw1GajMZr+R28GSvtOVS2eTSnbvDgVmxNTuZTotgSD8GjjCh6b860QAIB4o/puRCbK
         vAZRdUGrj7/CXdAYiBldQjwsJ/5D88VaB4XS+wPeuT/DmYilgBnKa6YD0i++husyNez1
         vEFtj58VU4Wp4f7eBXVQdyl0tsWc7twXEIpoJ0Uzy3c3GbCTjUxmitl3INw1vBSe45i7
         BDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=quxjHNxu+UH2nsgY3VbJOeiXHrpBY4c/xz4gf6nwffY=;
        b=jxAeIms8VtCEHOtr49q74hj5kpVeFfhNDbQejQTAx5tz/MHmwnWew0dRncTXafMPKJ
         6RflrQmfnBF26k79pzCS2DmInCFH42dnKHg99lhqeiCIE9XWboMRId8CMAS6sI0dnbDX
         I6SymOgbjb8hEBcX+7J4CuRMquzmzsLTewkKlgyN8rq/MZxYrN6wnMn1Ii+rApFHPMpj
         ivlCRa8dX+Fojw/OWK5QwAhb383OHHaG/snhPSx84wpaNYLVkK6jt14S2Pc+qOik+Bq2
         c8XkTMKV7p1+apeXFNQjwwXxZ+gecWGCXNj3WuT0j1LVd6d/Jt+fIjJZQWGdjhio5kaQ
         bEkw==
X-Gm-Message-State: AE9vXwNqD9RaUnk36rSZPbjgFHAz0xuJBCguAvwKG0wchmBfE34Thnzt6iOszLjb+KSO6iZt
X-Received: by 10.98.131.193 with SMTP id h184mr16801396pfe.92.1474676040108;
        Fri, 23 Sep 2016 17:14:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4836:46ae:fc5e:2de9])
        by smtp.gmail.com with ESMTPSA id i68sm13990058pfc.25.2016.09.23.17.13.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Sep 2016 17:13:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 3/3 v3] ls-files: add pathspec matching for submodules
Date:   Fri, 23 Sep 2016 17:13:34 -0700
Message-Id: <1474676014-134568-4-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474676014-134568-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pathspecs can be a bit tricky when trying to apply them to submodules.
The main challenge is that the pathspecs will be with respect to the
superproject and not with respect to paths in the submodule.  The
approach this patch takes is to pass in the identical pathspec from the
superproject to the submodule in addition to the submodule-prefix, which
is the path from the root of the superproject to the submodule, and then
we can compare an entry in the submodule prepended with the
submodule-prefix to the pathspec in order to determine if there is a
match.

This patch also permits the pathspec logic to perform a prefix match against
submodules since a pathspec could refer to a file inside of a submodule.
Due to limitations in the wildmatch logic, a prefix match is only done
literally.  If any wildcard character is encountered we'll simply punt
and produce a false positive match.  More accurate matching will be done
once inside the submodule.  This is due to the superproject not knowing
what files could exist in the submodule.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-files.c                     | 134 ++++++++++++++++++++-------------
 dir.c                                  |  46 ++++++++++-
 dir.h                                  |   4 +
 t/t3007-ls-files-recurse-submodules.sh | 126 +++++++++++++++++++++++++++++--
 4 files changed, 248 insertions(+), 62 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 54ab765..8ecffd1 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -177,6 +177,7 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
+	int i;
 
 	argv_array_push(&cp.args, "ls-files");
 	argv_array_push(&cp.args, "--recurse-submodules");
@@ -184,6 +185,29 @@ static void show_gitlink(const struct cache_entry *ce)
 			 GIT_SUBMODULE_PREFIX_ENVIRONMENT,
 			 submodule_prefix ? submodule_prefix : "",
 			 ce->name);
+	/* add options */
+	if (show_eol)
+		argv_array_push(&cp.args, "--eol");
+	if (show_valid_bit)
+		argv_array_push(&cp.args, "-v");
+	if (show_stage)
+		argv_array_push(&cp.args, "--stage");
+	if (show_cached)
+		argv_array_push(&cp.args, "--cached");
+	if (debug_mode)
+		argv_array_push(&cp.args, "--debug");
+	if (line_terminator == '\0')
+		argv_array_push(&cp.args, "-z");
+
+	/*
+	 * Pass in the original pathspec args.  The submodule will be
+	 * responsible for prepending the 'submodule_prefix' prior to comparing
+	 * against the pathspec for matches.
+	 */
+	argv_array_push(&cp.args, "--");
+	for (i = 0; i < pathspec.nr; i++)
+		argv_array_push(&cp.args, pathspec.items[i].original);
+
 	cp.git_cmd = 1;
 	cp.dir = ce->name;
 	status = run_command(&cp);
@@ -193,57 +217,62 @@ static void show_gitlink(const struct cache_entry *ce)
 
 static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 {
+	struct strbuf name = STRBUF_INIT;
 	int len = max_prefix_len;
+	if (submodule_prefix)
+		strbuf_addstr(&name, submodule_prefix);
+	strbuf_addstr(&name, ce->name);
 
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (!match_pathspec(&pathspec, ce->name, ce_namelen(ce),
-			    len, ps_matched,
-			    S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode)))
-		return;
-	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
+	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
 		show_gitlink(ce);
-		return;
-	}
+	} else if (match_pathspec(&pathspec, name.buf, name.len,
+				  len, ps_matched,
+				  S_ISDIR(ce->ce_mode) ||
+				  S_ISGITLINK(ce->ce_mode))) {
+		if (tag && *tag && show_valid_bit &&
+		    (ce->ce_flags & CE_VALID)) {
+			static char alttag[4];
+			memcpy(alttag, tag, 3);
+			if (isalpha(tag[0]))
+				alttag[0] = tolower(tag[0]);
+			else if (tag[0] == '?')
+				alttag[0] = '!';
+			else {
+				alttag[0] = 'v';
+				alttag[1] = tag[0];
+				alttag[2] = ' ';
+				alttag[3] = 0;
+			}
+			tag = alttag;
+		}
 
-	if (tag && *tag && show_valid_bit &&
-	    (ce->ce_flags & CE_VALID)) {
-		static char alttag[4];
-		memcpy(alttag, tag, 3);
-		if (isalpha(tag[0]))
-			alttag[0] = tolower(tag[0]);
-		else if (tag[0] == '?')
-			alttag[0] = '!';
-		else {
-			alttag[0] = 'v';
-			alttag[1] = tag[0];
-			alttag[2] = ' ';
-			alttag[3] = 0;
+		if (!show_stage) {
+			fputs(tag, stdout);
+		} else {
+			printf("%s%06o %s %d\t",
+			       tag,
+			       ce->ce_mode,
+			       find_unique_abbrev(ce->sha1,abbrev),
+			       ce_stage(ce));
+		}
+		write_eolinfo(ce, ce->name);
+		write_name(ce->name);
+		if (debug_mode) {
+			const struct stat_data *sd = &ce->ce_stat_data;
+
+			printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
+			printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
+			printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
+			printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
+			printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
 		}
-		tag = alttag;
 	}
 
-	if (!show_stage) {
-		fputs(tag, stdout);
-	} else {
-		printf("%s%06o %s %d\t",
-		       tag,
-		       ce->ce_mode,
-		       find_unique_abbrev(ce->sha1,abbrev),
-		       ce_stage(ce));
-	}
-	write_eolinfo(ce, ce->name);
-	write_name(ce->name);
-	if (debug_mode) {
-		const struct stat_data *sd = &ce->ce_stat_data;
-
-		printf("  ctime: %d:%d\n", sd->sd_ctime.sec, sd->sd_ctime.nsec);
-		printf("  mtime: %d:%d\n", sd->sd_mtime.sec, sd->sd_mtime.nsec);
-		printf("  dev: %d\tino: %d\n", sd->sd_dev, sd->sd_ino);
-		printf("  uid: %d\tgid: %d\n", sd->sd_uid, sd->sd_gid);
-		printf("  size: %d\tflags: %x\n", sd->sd_size, ce->ce_flags);
-	}
+	strbuf_release(&name);
 }
 
 static void show_ru_info(void)
@@ -568,27 +597,28 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		submodule_prefix = getenv(GIT_SUBMODULE_PREFIX_ENVIRONMENT);
 
 	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
-	     show_killed || show_modified || show_resolve_undo ||
-	     show_valid_bit || show_tag || show_eol))
-		die("ls-files --recurse-submodules can only be used in "
-		    "--cached mode");
+	    (show_deleted || show_others || show_unmerged ||
+	     show_killed || show_modified || show_resolve_undo))
+		die("ls-files --recurse-submodules unsupported mode");
 
 	if (recurse_submodules && error_unmatch)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");
 
-	if (recurse_submodules && argc)
-		die("ls-files --recurse-submodules does not support path "
-		    "arguments");
-
 	parse_pathspec(&pathspec, 0,
 		       PATHSPEC_PREFER_CWD |
 		       PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,
 		       prefix, argv);
 
-	/* Find common prefix for all pathspec's */
-	max_prefix = common_prefix(&pathspec);
+	/*
+	 * Find common prefix for all pathspec's
+	 * This is used as a performance optimization which unfortunately cannot
+	 * be done when recursing into submodules
+	 */
+	if (recurse_submodules)
+		max_prefix = NULL;
+	else
+		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = max_prefix ? strlen(max_prefix) : 0;
 
 	/* Treat unmatching pathspec elements as errors */
diff --git a/dir.c b/dir.c
index 0ea235f..28e9736 100644
--- a/dir.c
+++ b/dir.c
@@ -207,8 +207,9 @@ int within_depth(const char *name, int namelen,
 	return 1;
 }
 
-#define DO_MATCH_EXCLUDE   1
-#define DO_MATCH_DIRECTORY 2
+#define DO_MATCH_EXCLUDE   (1<<0)
+#define DO_MATCH_DIRECTORY (1<<1)
+#define DO_MATCH_SUBMODULE (1<<2)
 
 /*
  * Does 'match' match the given name?
@@ -283,6 +284,32 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 			 item->nowildcard_len - prefix))
 		return MATCHED_FNMATCH;
 
+	/* Perform checks to see if "name" is a super set of the pathspec */
+	if (flags & DO_MATCH_SUBMODULE) {
+		/* name is a literal prefix of the pathspec */
+		if ((namelen < matchlen) &&
+		    (match[namelen] == '/') &&
+		    !ps_strncmp(item, match, name, namelen))
+			return MATCHED_RECURSIVELY;
+
+		/* name" doesn't match up to the first wild character */
+		if (item->nowildcard_len < item->len &&
+		    ps_strncmp(item, match, name,
+			       item->nowildcard_len - prefix))
+			return 0;
+
+		/*
+		 * Here is where we would perform a wildmatch to check if
+		 * "name" can be matched as a directory (or a prefix) against
+		 * the pathspec.  Since wildmatch doesn't have this capability
+		 * at the present we have to punt and say that it is a match,
+		 * potentially returning a false positive
+		 * The submodules themselves will be able to perform more
+		 * accurate matching to determine if the pathspec matches.
+		 */
+		return MATCHED_RECURSIVELY;
+	}
+
 	return 0;
 }
 
@@ -386,6 +413,21 @@ int match_pathspec(const struct pathspec *ps,
 	return negative ? 0 : positive;
 }
 
+/**
+ * Check if a submodule is a superset of the pathspec
+ */
+int submodule_path_match(const struct pathspec *ps,
+			 const char *submodule_name,
+			 char *seen)
+{
+	int matched = do_match_pathspec(ps, submodule_name,
+					strlen(submodule_name),
+					0, seen,
+					DO_MATCH_DIRECTORY |
+					DO_MATCH_SUBMODULE);
+	return matched;
+}
+
 int report_path_error(const char *ps_matched,
 		      const struct pathspec *pathspec,
 		      const char *prefix)
diff --git a/dir.h b/dir.h
index da1a858..97c83bb 100644
--- a/dir.h
+++ b/dir.h
@@ -304,6 +304,10 @@ extern int git_fnmatch(const struct pathspec_item *item,
 		       const char *pattern, const char *string,
 		       int prefix);
 
+extern int submodule_path_match(const struct pathspec *ps,
+				const char *submodule_name,
+				char *seen);
+
 static inline int ce_path_match(const struct cache_entry *ce,
 				const struct pathspec *pathspec,
 				char *seen)
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
index caf3815..4a51d38 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,18 @@ test_expect_success 'ls-files correctly outputs files in submodule' '
 	test_cmp expect actual
 '
 
+test_expect_success 'ls-files correctly outputs files in submodule with -z' '
+	cat | tr "\n" "\0" >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	submodule/c
+	EOF
+
+	git ls-files --recurse-submodules -z >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-files does not output files not added to a repo' '
 	cat >expect <<-\EOF &&
 	.gitmodules
@@ -69,9 +81,111 @@ test_expect_success 'ls-files recurses more than 1 level' '
 	test_cmp expect actual
 '
 
-test_expect_success '--recurse-submodules does not support using path arguments' '
-	test_must_fail git ls-files --recurse-submodules b 2>actual &&
-	test_i18ngrep "does not support path arguments" actual
+test_expect_success '--recurse-submodules and pathspecs setup' '
+	echo e >submodule/subsub/e.txt &&
+	git -C submodule/subsub add e.txt &&
+	git -C submodule/subsub commit -m "adding e.txt" &&
+	echo f >submodule/f.TXT &&
+	echo g >submodule/g.txt &&
+	git -C submodule add f.TXT g.txt &&
+	git -C submodule commit -m "add f and g" &&
+	echo h >h.txt &&
+	mkdir sib &&
+	echo sib >sib/file &&
+	git add h.txt sib/file &&
+	git commit -m "add h and sib/file" &&
+	git init sub &&
+	echo sub >sub/file &&
+	git -C sub add file &&
+	git -C sub commit -m "add file" &&
+	git submodule add ./sub &&
+	git commit -m "added sub" &&
+
+	cat >expect <<-\EOF &&
+	.gitmodules
+	a
+	b/b
+	h.txt
+	sib/file
+	sub/file
+	submodule/.gitmodules
+	submodule/c
+	submodule/f.TXT
+	submodule/g.txt
+	submodule/subsub/d
+	submodule/subsub/e.txt
+	EOF
+
+	git ls-files --recurse-submodules >actual &&
+	test_cmp expect actual &&
+	cat actual &&
+	git ls-files --recurse-submodules "*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules and pathspecs' '
+	cat >expect <<-\EOF &&
+	h.txt
+	submodule/g.txt
+	submodule/subsub/e.txt
+	EOF
+
+	git ls-files --recurse-submodules "*.txt" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules and pathspecs' '
+	cat >expect <<-\EOF &&
+	h.txt
+	submodule/f.TXT
+	submodule/g.txt
+	submodule/subsub/e.txt
+	EOF
+
+	git ls-files --recurse-submodules ":(icase)*.txt" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules and pathspecs' '
+	cat >expect <<-\EOF &&
+	h.txt
+	submodule/f.TXT
+	submodule/g.txt
+	EOF
+
+	git ls-files --recurse-submodules ":(icase)*.txt" ":(exclude)submodule/subsub/*" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules and pathspecs' '
+	cat >expect <<-\EOF &&
+	sub/file
+	EOF
+
+	git ls-files --recurse-submodules "sub" >actual &&
+	test_cmp expect actual &&
+	git ls-files --recurse-submodules "sub/" >actual &&
+	test_cmp expect actual &&
+	git ls-files --recurse-submodules "sub/file" >actual &&
+	test_cmp expect actual &&
+	git ls-files --recurse-submodules "su*/file" >actual &&
+	test_cmp expect actual &&
+	git ls-files --recurse-submodules "su?/file" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--recurse-submodules and pathspecs' '
+	cat >expect <<-\EOF &&
+	sib/file
+	sub/file
+	EOF
+
+	git ls-files --recurse-submodules "s??/file" >actual &&
+	test_cmp expect actual &&
+	git ls-files --recurse-submodules "s???file" >actual &&
+	test_cmp expect actual &&
+	git ls-files --recurse-submodules "s*file" >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success '--recurse-submodules does not support --error-unmatch' '
@@ -82,18 +196,14 @@ test_expect_success '--recurse-submodules does not support --error-unmatch' '
 test_incompatible_with_recurse_submodules () {
 	test_expect_success "--recurse-submodules and $1 are incompatible" "
 		test_must_fail git ls-files --recurse-submodules $1 2>actual &&
-		test_i18ngrep 'can only be used in --cached mode' actual
+		test_i18ngrep 'unsupported mode' actual
 	"
 }
 
-test_incompatible_with_recurse_submodules -v
-test_incompatible_with_recurse_submodules -t
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
-test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
-test_incompatible_with_recurse_submodules --eol
 
 test_done
-- 
2.8.0.rc3.226.g39d4020

