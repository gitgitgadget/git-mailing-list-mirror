Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87F220958
	for <e@80x24.org>; Tue, 21 Mar 2017 00:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755749AbdCUAS5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 20:18:57 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33886 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbdCUAS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 20:18:56 -0400
Received: by mail-pf0-f175.google.com with SMTP id p189so49388571pfp.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 17:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oKyEPhI66V9x2WikEnzYI19AFNQ58Bxr0pYc0vUy+uQ=;
        b=lhWzHKc6uG23HT0+w/xcdk6+w6d9nqq0+b/GmLFTiO6u+Zk4aNG3B/oTvVUvrOKcR0
         Q3RgOd33C+8v0oxTFezREmTwRx27T+9BD5ygSW12IvhXxPZJy+lUcc0mGnus5zuT9wlq
         1Tlu5bb+Iwqty4hyM/2TmI0y+DV8e2t9n1SSwFaFER83GHf10+E7FDvSCNjVAmOTbuuz
         DxdhaEZVnGehAnsfq6AqCWHQ923yb9v2IWvEzrK91BdamMbh/cSyxUWS0+SSN/m/ImsR
         kU9vALgD566NVe9q/o0DuxquvmgzxprP6yhZ5La4PtRQtZh0NpVdgzNMnGsPkgzaAn3a
         KWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oKyEPhI66V9x2WikEnzYI19AFNQ58Bxr0pYc0vUy+uQ=;
        b=aju8s5LOVsgccMPJKRRcYBdzxFgQNIsP2n6Dzq7txxdbHlP8FsetoJBqMbIERIB69i
         R+Y7oYPom82YXSlkKbzHSDnN6AWKYZSJUVFY21/G03dgDZmkaZq0G/UIYca8Ty1CRiGZ
         6bKvrHVuvJJ3E/5fOhWR+4bEqEi4BI0SK2H79qwoLMLgAllHO5KxND6uVj3AWkNTojyU
         rsWscbSXSmpEpx21fLDj++l0zgDr6hnoZ9YZRXiIGgcaEbcZGtiZdtQXTPXR//dYXy9T
         DbWsFePO5ssS7sLizYJtqVtg+T+cgQzKScC73lnFmCrOriij4pB3nhE1go2vlKe2iqeF
         nzVQ==
X-Gm-Message-State: AFeK/H15zMwor8EcX4JfeCITBe7O77M/F0kOiRfDtH9hxK0eR75o9/kx7xggNE7W+B8WGxyj
X-Received: by 10.84.195.129 with SMTP id j1mr42704671pld.88.1490055126253;
        Mon, 20 Mar 2017 17:12:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:38a6:f549:ebc4:4d51])
        by smtp.gmail.com with ESMTPSA id r17sm6602306pfa.13.2017.03.20.17.12.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Mar 2017 17:12:05 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, mfick@codeaurora.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] builtin/describe: introduce --submodule-error-as-dirty flag
Date:   Mon, 20 Mar 2017 17:11:56 -0700
Message-Id: <20170321001156.21915-4-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.402.g0501f7a28e
In-Reply-To: <20170321001156.21915-1-sbeller@google.com>
References: <20170321001156.21915-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-describe tells you the version number you're at, or errors out, e.g.
when you run it outside of a repository, which may happen when downloading
a tar ball instead of using git to obtain the source code.

To keep this property of only erroring out, when not in a repository,
severe submodule errors must be downgraded to reporting them gently
instead of having git-describe error out completely.

This patch helps to fix the root cause in [1], which tries to work around
this situation.

[1] ("Work around git describe bug for build.")
https://gerrit-review.googlesource.com/#/c/99851/

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/describe.c  | 17 ++++++++++-------
 t/t6120-describe.sh | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 76c18059bf..569fef9ecf 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -31,13 +31,9 @@ static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
+static int gentle_submodule_errors;
 static const char *dirty;
 
-/* diff-index command arguments to check if working tree is dirty. */
-static const char *diff_index_args[] = {
-	"diff-index", "--quiet", "HEAD", "--", NULL
-};
-
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -442,6 +438,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			   N_("do not consider tags matching <pattern>")),
 		OPT_BOOL(0, "always",        &always,
 			N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "submodule-error-as-dirty", &gentle_submodule_errors,
+			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
@@ -496,6 +494,12 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		if (dirty) {
 			static struct lock_file index_lock;
 			int fd;
+			struct argv_array args = ARGV_ARRAY_INIT;
+
+			argv_array_push(&args, "diff-index");
+			if (gentle_submodule_errors)
+				argv_array_push(&args, "--gentle-submodule-errors");
+			argv_array_pushl(&args, "--quiet", "HEAD", "--", NULL);
 
 			read_cache_preload(NULL);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
@@ -504,8 +508,7 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
-					    diff_index_args, prefix))
+			if (!cmd_diff_index(args.argc, args.argv, prefix))
 				dirty = NULL;
 		}
 		describe("HEAD", 1);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 167491fd5b..99e5ba44b7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -233,4 +233,21 @@ test_expect_success 'describe --contains and --no-match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup and absorb a submodule' '
+	test_create_repo sub1 &&
+	test_commit -C sub1 initial &&
+	git submodule add ./sub1 &&
+	git submodule absorbgitdirs &&
+	git commit -a -m "add submodule"
+'
+
+test_expect_success 'describe chokes on severly broken submodules' '
+	mv .git/modules/sub1/ .git/modules/sub_moved &&
+	test_must_fail git describe --dirty
+'
+test_expect_success 'describe ignoring a borken submodule' '
+	git describe --dirty --submodule-error-as-dirty >out &&
+	grep dirty out
+'
+
 test_done
-- 
2.12.0.402.g4b3201c2d6.dirty

