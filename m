Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805912095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933896AbdCUSwD (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:52:03 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33909 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbdCUSvn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:51:43 -0400
Received: by mail-pg0-f45.google.com with SMTP id 21so64469433pgg.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EptIXX3XWwdNdHuctXor3OVY4FlCpLr2V4O1WRacEEQ=;
        b=nbjWD4rjTpeIMxEmw7AUSlea62XxekSKOexTPbuZnHVasw+qU8QnbIYtgoD05rhpTu
         O14yT+occzu96ChfwRincnJTzhjVw3Q+xuF13nXNWHzmZB6zhcHmJipo6Ez15mBUUJ57
         CmBNsCoaj6uIuzzx0r+bsAkyxfsZBNPpj9vvuspEX4GYUA1McPRBGyvoZNnUffDeA36o
         Xc5u6Hsip5aii5x84e9Dva5MVrnHLgZHA2t6oXbg54J1CY7prkYS5t+iRzSUvz6CNXVQ
         PUhPByIklcliBYBxNZUE7c6a554fEkiKPj48BuEI9UnUnw10BgwZYuy/bkkb0HdrKldI
         BPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EptIXX3XWwdNdHuctXor3OVY4FlCpLr2V4O1WRacEEQ=;
        b=LY+GE1PprnfjFE4GnO1mjCbvOVBClGZ1oakzHa0+MH/1NFrZxmFh5nS/NOlLwhke/w
         bZ2xhDA8Ic7A19FpXCnsZMMi+kPEQCn2togjYYm4oPDmBw7sRvbGH31wc8WNcfsce0qE
         69PrgS53b1tdI6WapChM1PtTYtKrELFy1Mr0BtJL2f4j8h2F5fvKJejll31BWKp7Byrt
         /Jm3wRyCL5mbZHTZ9CmzA6rRiGuJUBAX/YL/fqeiX6eDO93PP358bXxuoE6ZzWgCPbJZ
         ty7ZZKTqZ1Pjhr38KsgXCqzFFto1JHAAotpVWHXVS+IRQgVwcarPYtM4tRDeLdOWx/2H
         KH/g==
X-Gm-Message-State: AFeK/H34V7YlAT36NcLLX3ok5NKOXl9bh5bYTSo9QEf4SGZw+66We4/v+cxc9YONp+JyPZvL
X-Received: by 10.98.60.199 with SMTP id b68mr41312508pfk.102.1490122301649;
        Tue, 21 Mar 2017 11:51:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b114:ae16:71df:23b2])
        by smtp.gmail.com with ESMTPSA id n85sm5273948pfi.101.2017.03.21.11.51.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 11:51:40 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, mfick@codeaurora.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] builtin/describe: introduce --broken flag
Date:   Tue, 21 Mar 2017 11:51:39 -0700
Message-Id: <20170321185139.8300-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.402.g0501f7a28e.dirty
In-Reply-To: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com>
References: <xmqq37e7t902.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-describe tells you the version number you're at, or errors out, e.g.
when you run it outside of a repository, which may happen when downloading
a tar ball instead of using git to obtain the source code.

To keep this property of only erroring out, when not in a repository,
severe (submodule) errors must be downgraded to reporting them gently
instead of having git-describe error out completely.

To achieve that a flag '--broken' is introduced, which is in the same
vein as '--dirty' but uses an actual child process to check for dirtiness.
When that child dies unexpectedly, we'll append '-broken' instead of
'-dirty'.

This patch helps to fix the root cause in [1], which tries to work around
this situation.

[1] ("Work around git describe bug for build.")
https://gerrit-review.googlesource.com/#/c/99851/

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> I probably would
> 
> - introduce a new "git describe --possibly-broken" option;
> 
> - instead of running "diff-index" internally to decide the "-dirty"
>    state, spawn "diff-index" as a separate process;
> 
>  - observe the exit status from "diff-index" and add "-dirty" suffix

This is what this patch does. It doesn't need any preceeding refactor
patches, but comes on its own; developed on origin/master.

Thanks,
Stefan

 Documentation/git-describe.txt |  7 +++++
 builtin/describe.c             | 59 ++++++++++++++++++++++++++++++------------
 t/t6120-describe.sh            | 20 ++++++++++++++
 3 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 8755f3af7b..b71fa7a4ad 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -34,6 +34,13 @@ OPTIONS
 	It means describe HEAD and appends <mark> (`-dirty` by
 	default) if the working tree is dirty.
 
+--broken[=<mark>]::
+	Describe the working tree.
+	It means describe HEAD and appends <mark> (`-broken` by
+	default) if the working tree cannot be examined for dirtiness.
+	This implies `--dirty`, which is the fallback behavior when
+	the working tree examination works.
+
 --all::
 	Instead of using only the annotated tags, use any ref
 	found in `refs/` namespace.  This option enables matching
diff --git a/builtin/describe.c b/builtin/describe.c
index 76c18059bf..37a83520c9 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -9,6 +9,7 @@
 #include "diff.h"
 #include "hashmap.h"
 #include "argv-array.h"
+#include "run-command.h"
 
 #define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
@@ -31,12 +32,7 @@ static int have_util;
 static struct string_list patterns = STRING_LIST_INIT_NODUP;
 static struct string_list exclude_patterns = STRING_LIST_INIT_NODUP;
 static int always;
-static const char *dirty;
-
-/* diff-index command arguments to check if working tree is dirty. */
-static const char *diff_index_args[] = {
-	"diff-index", "--quiet", "HEAD", "--", NULL
-};
+static const char *append, *dirty, *broken;
 
 struct commit_name {
 	struct hashmap_entry entry;
@@ -292,8 +288,8 @@ static void describe(const char *arg, int last_one)
 		display_name(n);
 		if (longformat)
 			show_suffix(0, n->tag ? &n->tag->tagged->oid : &oid);
-		if (dirty)
-			printf("%s", dirty);
+		if (append)
+			printf("%s", append);
 		printf("\n");
 		return;
 	}
@@ -369,8 +365,8 @@ static void describe(const char *arg, int last_one)
 		struct object_id *oid = &cmit->object.oid;
 		if (always) {
 			printf("%s", find_unique_abbrev(oid->hash, abbrev));
-			if (dirty)
-				printf("%s", dirty);
+			if (append)
+				printf("%s", append);
 			printf("\n");
 			return;
 		}
@@ -413,8 +409,8 @@ static void describe(const char *arg, int last_one)
 	display_name(all_matches[0].name);
 	if (abbrev)
 		show_suffix(all_matches[0].depth, &cmit->object.oid);
-	if (dirty)
-		printf("%s", dirty);
+	if (append)
+		printf("%s", append);
 	printf("\n");
 
 	if (!last_one)
@@ -445,6 +441,9 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
 			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
+		{OPTION_STRING, 0, "broken",  &broken, N_("mark"),
+			N_("append <mark> on broken working tree (default: \"-broken\")"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "-broken"},
 		OPT_END(),
 	};
 
@@ -493,10 +492,35 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 		die(_("No names found, cannot describe anything."));
 
 	if (argc == 0) {
-		if (dirty) {
+		if (broken) {
+			struct child_process cp = CHILD_PROCESS_INIT;
+			argv_array_pushl(&cp.args, "diff-index", "--quiet", "HEAD", "--", NULL);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+
+			if (!dirty)
+				dirty = "-dirty";
+
+			switch (run_command(&cp)) {
+			case 0:
+				append = NULL;
+				break;
+			case 1:
+				/* keep dirty as is */
+				append = dirty;
+				break;
+			default:
+				/* diff-index aborted abnormally */
+				append = broken;
+			}
+		} else if (dirty) {
+			struct argv_array args = ARGV_ARRAY_INIT;
 			static struct lock_file index_lock;
 			int fd;
 
+			argv_array_pushl(&args, "diff-index", "--quiet", "HEAD", "--", NULL);
+
 			read_cache_preload(NULL);
 			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
@@ -504,13 +528,16 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
-					    diff_index_args, prefix))
-				dirty = NULL;
+			if (cmd_diff_index(args.argc, args.argv, prefix))
+				append = dirty;
+			else
+				append = NULL;
 		}
 		describe("HEAD", 1);
 	} else if (dirty) {
 		die(_("--dirty is incompatible with commit-ishes"));
+	} else if (broken) {
+		die(_("--broken is incompatible with commit-ishes"));
 	} else {
 		while (argc-- > 0)
 			describe(*argv++, argc == 0);
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 167491fd5b..16952e44fc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -233,4 +233,24 @@ test_expect_success 'describe --contains and --no-match' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup and absorb a submodule' '
+	test_create_repo sub1 &&
+	test_commit -C sub1 initial &&
+	git submodule add ./sub1 &&
+	git submodule absorbgitdirs &&
+	git commit -a -m "add submodule" &&
+	git describe --dirty >expect &&
+	git describe --broken >out &&
+	test_cmp expect out
+'
+
+test_expect_success 'describe chokes on severly broken submodules' '
+	mv .git/modules/sub1/ .git/modules/sub_moved &&
+	test_must_fail git describe --dirty
+'
+test_expect_success 'describe ignoring a borken submodule' '
+	git describe --broken >out &&
+	grep broken out
+'
+
 test_done
-- 
2.12.0.402.g0501f7a28e.dirty

