Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 797DD20193
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965420AbcHDTwW (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:22 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35626 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965313AbcHDTwT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:19 -0400
Received: by mail-pa0-f45.google.com with SMTP id iw10so85426892pac.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEmMrgsUGpEgHyNsq84AgYJYc43ZAY+tQt5OVHtd3fE=;
        b=EKWWP1zeyZjfYudu/tYSJ2CQvmz3W+Jj2BxcYSF+z6Lqw/9JHWtbDH74IaegCZI3eY
         9tTMnqKK/zizl3c1rBAq+9BH9bZlDiHQ+r5XjlyJlMKJQQipMTKSaZKVQI2Dqf5A6pl+
         jRlOKEvux1eMyppK9iIuCFPJA5/QHRlMWuMfPw+9U0K1JM4rWOq5qurRaEJlccE0AIQO
         b3WEW/8PkiGq6JPY72uElVC0S5sSyGMIoCOrOgPk61CI2Kx5m04WG2BzRIN8TFC5mulD
         P31iSy3h7X+jWwPEgqD5dVKEtmL5yNjfsqR2qk08gnkyKqDo6cVQcirYza6XdfGhs8in
         08bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEmMrgsUGpEgHyNsq84AgYJYc43ZAY+tQt5OVHtd3fE=;
        b=fmSAMOJ/DoatK5reKu2QVkSDgGQhJruoE8p3EFrMNbmPG0JJ7sgH/8AgksjdPWT2/6
         /Uo3gmgWSAWNZd9id+kpq5KNfc6mTIx4Lmoer/DSTebX/ZirL/TTZlnUrdZa6/3MJKGx
         byOzity2jdVck8meUdgZG6Eo86dt/joYG7u83/NtT8lRSb6BSoqMRa3oSH0urgJ9ltEz
         xSWwW/VXAvknBRgk9yyEKveymTPIo5TkvbdewrEEcpKvi0AfE0Nz4RVInm6t7+lVedKL
         FWz01tgSJvPvEIWVK6LtQNgVw6clKxUamv5qHUZ3y+Ferq5p5uKpBfrbLOHU5wsOzGgK
         f9FQ==
X-Gm-Message-State: AEkoousnJX52qtpIHryhRmtrp862JP/NX7m0aglWoOXJfTGUaLvdqU3T2VDnBNtOoIA4TKiR
X-Received: by 10.66.161.225 with SMTP id xv1mr127989523pab.20.1470340337564;
        Thu, 04 Aug 2016 12:52:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id yv9sm22380163pab.0.2016.08.04.12.52.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:17 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] clone: reference flag is used for submodules as well
Date:	Thu,  4 Aug 2016 12:51:59 -0700
Message-Id: <20160804195159.7788-7-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160804195159.7788-1-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When giving a --reference while also giving --recurse, the alternates
for the submodules are assumed to be in the superproject as well.

In case they are not, we error out when cloning the submodule.
However the update command succeeds as usual (with no alternates).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/clone.c                | 22 ++++++++++++++++++----
 t/t7408-submodule-reference.sh | 31 ++++++++++++++++++++++++++++++-
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f044a8c..f586df5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,7 @@ static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_reference = STRING_LIST_INIT_NODUP;
+static struct string_list superreferences = STRING_LIST_INIT_DUP;
 static int option_dissociate;
 static int max_jobs = -1;
 
@@ -280,10 +281,11 @@ static void strip_trailing_slashes(char *dir)
 	*end = '\0';
 }
 
-static int add_one_reference(struct string_list_item *item, void *cb_data)
+static int add_one_reference(struct string_list_item *item, void *cb_dir)
 {
 	char *ref_git;
 	const char *repo;
+	const char *dir = cb_dir;
 	struct strbuf alternate = STRBUF_INIT;
 
 	/* Beware: read_gitfile(), real_path() and mkpath() return static buffer */
@@ -316,6 +318,13 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	if (!access(mkpath("%s/info/grafts", ref_git), F_OK))
 		die(_("reference repository '%s' is grafted"), item->string);
 
+	if (option_recursive) {
+		struct strbuf sb = STRBUF_INIT;
+		char *rel = xstrdup(relative_path(item->string, dir, &sb));
+		string_list_append(&superreferences, rel);
+		strbuf_reset(&sb);
+	}
+
 	strbuf_addf(&alternate, "%s/objects", ref_git);
 	add_to_alternates_file(alternate.buf);
 	strbuf_release(&alternate);
@@ -323,9 +332,9 @@ static int add_one_reference(struct string_list_item *item, void *cb_data)
 	return 0;
 }
 
-static void setup_reference(void)
+static void setup_reference(char *dir)
 {
-	for_each_string_list(&option_reference, add_one_reference, NULL);
+	for_each_string_list(&option_reference, add_one_reference, dir);
 }
 
 static void copy_alternates(struct strbuf *src, struct strbuf *dst,
@@ -736,6 +745,7 @@ static int checkout(void)
 
 	if (!err && option_recursive) {
 		struct argv_array args = ARGV_ARRAY_INIT;
+		static struct string_list_item *item;
 		argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
 
 		if (option_shallow_submodules == 1)
@@ -744,6 +754,10 @@ static int checkout(void)
 		if (max_jobs != -1)
 			argv_array_pushf(&args, "--jobs=%d", max_jobs);
 
+		if (superreferences.nr)
+			for_each_string_list_item(item, &superreferences)
+				argv_array_pushf(&args, "--super-reference=%s", item->string);
+
 		err = run_command_v_opt(args.argv, RUN_GIT_CMD);
 		argv_array_clear(&args);
 	}
@@ -978,7 +992,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_reset(&key);
 
 	if (option_reference.nr)
-		setup_reference();
+		setup_reference(dir);
 
 	fetch_pattern = value.buf;
 	refspec = parse_fetch_refspec(1, &fetch_pattern);
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 1416cbd..2652cfe 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -56,7 +56,8 @@ test_expect_success 'submodule add --reference uses alternates' '
 	(
 		cd super &&
 		git submodule add --reference ../B "file://$base_dir/A" sub &&
-		git commit -m B-super-added
+		git commit -m B-super-added &&
+		git repack -ad
 	) &&
 	test_alternate_usage super/.git/modules/sub/objects/info/alternates super/sub
 '
@@ -68,4 +69,32 @@ test_expect_success 'updating superproject keeps alternates' '
 	test_alternate_usage super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
 '
 
+test_expect_success 'submodules use alternates when cloning a superproject' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone --reference super --recursive super super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_usage .git/objects/info/alternates . &&
+		# test submodule has correct setup
+		test_alternate_usage .git/modules/sub/objects/info/alternates sub
+	)
+'
+
+test_expect_success 'cloning superproject, missing submodule alternates' '
+	test_when_finished "rm -rf super-clone" &&
+	git clone super super2 &&
+	test_must_fail git clone --recursive --reference super2 super2 super-clone &&
+	(
+		cd super-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_usage .git/objects/info/alternates . &&
+		# update of the submodule succeeds
+		git submodule update --init &&
+		# and we have no alternates:
+		test_must_fail test_alternate_usage .git/modules/sub/objects/info/alternates sub &&
+		test_path_is_file sub/file1
+	)
+'
+
 test_done
-- 
2.9.2.572.g9d9644e.dirty

