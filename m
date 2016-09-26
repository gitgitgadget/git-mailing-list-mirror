Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD8BD207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 22:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933271AbcIZWrW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 18:47:22 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33879 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932241AbcIZWrU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 18:47:20 -0400
Received: by mail-pa0-f43.google.com with SMTP id gp7so10076941pac.1
        for <git@vger.kernel.org>; Mon, 26 Sep 2016 15:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tSJcyBZFGnsWQTbFRloa5GbxpnaQj0cEln/MreJ4dcg=;
        b=ooYpuBSjjkTcmnlID6nekNwvTLUVwTCd8X7wPoYj/EbEim9xfIySjLEyDJ0NH95odY
         Uzuu12r94+PkFIxeSg+wgjm7B41PSeWCRvjU6YOAeYT5gjaX0OgBOmJfzQqx91CyKuYR
         e6ihNaUpP26gG7aDtmNrz9fEXXZ/jxi2Mp7dPdd/odr+Gv2pnpk7T66iA/BtIBkGeOVr
         BuxJg0jZcl0/x3SUffIkTdwa3lYpWI4C5/dD/Kl6pXCzVTvqSFv7L9Usx2/9DU2J9f8s
         k2RMvw5IFnhaecOMECc3RgRopfa4+6+Ha5h6nFtCiZWyjVsx2qHc6zRFsPJf8Lz0tnKL
         JUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tSJcyBZFGnsWQTbFRloa5GbxpnaQj0cEln/MreJ4dcg=;
        b=macwOp4uFEMltbGu40op96+jUf1Kc33yiAFfaTxUxEFxjlEl6V+e8qzMZ17nIlCJaC
         V7DpHekwuCzcAFxNJoaPeldMriOGqVXopeqrm/bpyFb5xGNOzylonH0b4+x77LBIPuC3
         CEQGEH+ohzYCbNjes/9tDa3aEhcHz0sXATroYzxpWsSL3A2TSSyNDGku1XtyPcAJLd8t
         Fjw8H7jPolZelWEDCeC1KmjKaOJE5sMqvBAgKuD10PV21V4EG98CvROAWqDDMz7n6ujR
         Wd9C0ljF1VxYY3u9pqC4GooHWdndrpaL1ZJ/k0hxS+iwFX6RRebxHY1oI8Av8aqMJTkh
         xj1w==
X-Gm-Message-State: AE9vXwPXgOSQAnNxk3slYqz+tBEnRA6ZS1ucRdRprqvoHVpGiNLEpBq0Pp2NMeeaFYhZzHRS
X-Received: by 10.66.232.106 with SMTP id tn10mr42669292pac.17.1474930034728;
        Mon, 26 Sep 2016 15:47:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:9046:8098:b971:afcc])
        by smtp.gmail.com with ESMTPSA id i4sm33424773pav.27.2016.09.26.15.47.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Sep 2016 15:47:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 4/4 v4] ls-files: add pathspec matching for submodules
Date:   Mon, 26 Sep 2016 15:46:43 -0700
Message-Id: <1474930003-83750-5-git-send-email-bmwill@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <1474930003-83750-1-git-send-email-bmwill@google.com>
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
 <1474930003-83750-1-git-send-email-bmwill@google.com>
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
 builtin/ls-files.c                     |  28 ++++++---
 dir.c                                  |  46 +++++++++++++-
 dir.h                                  |   4 ++
 t/t3007-ls-files-recurse-submodules.sh | 108 ++++++++++++++++++++++++++++++++-
 4 files changed, 174 insertions(+), 12 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a39367f..2488a02 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -199,6 +199,7 @@ static void show_gitlink(const struct cache_entry *ce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	int status;
+	int i;
 
 	argv_array_pushf(&cp.args, "--submodule-prefix=%s%s/",
 			 submodule_prefix ? submodule_prefix : "",
@@ -209,6 +210,15 @@ static void show_gitlink(const struct cache_entry *ce)
 	/* add supported options */
 	argv_array_pushv(&cp.args, recurse_submodules_opts.argv);
 
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
@@ -227,7 +237,8 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
 	if (len >= ce_namelen(ce))
 		die("git ls-files: internal error - cache entry not superset of prefix");
 
-	if (recurse_submodules && S_ISGITLINK(ce->ce_mode)) {
+	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
+	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
 		show_gitlink(ce);
 	} else if (match_pathspec(&pathspec, name.buf, name.len,
 				  len, ps_matched,
@@ -608,17 +619,20 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
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
index 40767da..4a51d38 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -81,9 +81,111 @@ test_expect_success 'ls-files recurses more than 1 level' '
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
-- 
2.8.0.rc3.226.g39d4020

