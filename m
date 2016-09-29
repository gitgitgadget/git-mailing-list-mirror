Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D1420987
	for <e@80x24.org>; Thu, 29 Sep 2016 21:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932929AbcI2Vug (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:50:36 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33317 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbcI2VuT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:50:19 -0400
Received: by mail-pa0-f41.google.com with SMTP id cd13so28237376pac.0
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 14:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1y77MpsT3vIzY1fYt8V5nAYs6tix3CkAd+11LB2zOdE=;
        b=a8Z8vrdNHbW7lNHIMWdXI9LNp7v3NJBiYAAEKog7bXh9jr5648Ufd2+ylCx1zI1Lz/
         08/rJxXNxU0r0dhLqaIR81qZUjJOtFixkteiwR1LZJwljO6qqC6qsQl0taF1ej6+Q6f+
         gEV3L9aTxMlJ34xoW7LpsxuvUkMgoPvEQg+WRr8yG45SLNqjOJV7c9vaLSTa0tA/YNIN
         TKpKC1gBqPVMBBL3a+0Z+AFP7yrr90kFa6J8jh08GsshpvqNiR01dK8lLWQaErX0qIoW
         oVvXYV3R6RAVsS5qvN1YEtBJVD2hwSZorJYxwyr1v1Uwng/p6uWaaoNSJGl6DPyqUbgB
         PDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1y77MpsT3vIzY1fYt8V5nAYs6tix3CkAd+11LB2zOdE=;
        b=TT8ol8ZG0i2Qwhb4h2deT7BsYW9sOJrqcFAGkH95dJbjizgYtovYsWzEry8R2wPqD6
         xy4x5rIFxBdlG/kb5bYnjyA2vvfhEuIqwsDDX0tIEyV4FIeYxJyPlDYeyd7Hzlx1eFVt
         H34baVAG5V7S/Sq47rl7Y01yiBLaNkA5GyzY9IuGbc9xeE1yraKqbxeZSYbnZeoY5/bX
         hzQjvrmJnx32wa53w2GUER4tPcFOQ9Q5FOrlKwt623iIqsBJSk0net2bnwxqHufaImcb
         1qXWdg6YkXOdrYZDA4r+lT/Ue5LY95vTofcdHDS/NRKtISZPGkBrVHdBmPECljqwpqxt
         C+Eg==
X-Gm-Message-State: AA6/9Rk8OARHW8tHfyv7mu2Q+n8GPynn6Sjo/6oJAQgYuQPSbpIsl3/aBq0zxURac5AQpdZH
X-Received: by 10.66.163.5 with SMTP id ye5mr5977545pab.125.1475185818257;
        Thu, 29 Sep 2016 14:50:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4c71:119f:edd5:cf6c])
        by smtp.gmail.com with ESMTPSA id c124sm22495406pfc.52.2016.09.29.14.50.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Sep 2016 14:50:17 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        peff@peff.net, gitster@pobox.com
Subject: [PATCH v6 4/4] ls-files: add pathspec matching for submodules
Date:   Thu, 29 Sep 2016 14:48:43 -0700
Message-Id: <1475185723-36871-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1475185723-36871-1-git-send-email-bmwill@google.com>
References: <1475099443-145608-1-git-send-email-bmwill@google.com>
 <1475185723-36871-1-git-send-email-bmwill@google.com>
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
 Documentation/git-ls-files.txt         |   3 +-
 builtin/ls-files.c                     |  27 +++++++--
 dir.c                                  |  46 +++++++++++++-
 dir.h                                  |   4 ++
 t/t3007-ls-files-recurse-submodules.sh | 108 ++++++++++++++++++++++++++++++++-
 5 files changed, 175 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index ea01d45..51ec9a1 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -140,8 +140,7 @@ a space) at the start of each line:
 
 --recurse-submodules::
 	Recursively calls ls-files on each submodule in the repository.
-	Currently there is only support for the --cached mode without a
-	pathspec.
+	Currently there is only support for the --cached.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 6f744ef..82ec811 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -215,6 +215,7 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
+	int i;
 
 	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
 			 super_prefix ? super_prefix : "",
@@ -225,6 +226,15 @@ static void show_gitlink(const struct cache_entry *ce)
 	/* add supported options */
 	argv_array_pushv(&cp.args, submodules_options.argv);
 
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
@@ -243,7 +253,8 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
+	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
 		show_gitlink(ce);
 	} else if (match_pathspec(&pathspec, name.buf, name.len,
 				  len, ps_matched,
@@ -623,16 +634,20 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		die("ls-files --recurse-submodules does not support "
 		    "--error-unmatch");
 
-	if (recurse_submodules && argc)
-		die("ls-files --recurse-submodules does not support pathspec");
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
index e76fa30..5475855 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -81,9 +81,111 @@ test_expect_success 'ls-files recurses more than 1 level' '
 	test_cmp expect actual
 '
 
-test_expect_success '--recurse-submodules does not support using path arguments' '
-	test_must_fail git ls-files --recurse-submodules b 2>actual &&
-	test_i18ngrep "does not support pathspec" actual
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
-- 
2.10.0

