Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754961F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbcHFUk0 (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:40:26 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33769 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbcHFUkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:40:25 -0400
Received: by mail-pf0-f172.google.com with SMTP id y134so107077776pfg.0
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:40:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NtTBlPwTz9WUSTHTA+3Zg9/kI4FBpPVjJ6v/WE7WK8k=;
        b=lz2fk/kO5e3vSun4BXm+aB3OGLB0DyQgH7LUHU9oyG8wmuVbbalu4BeVtHDfzCdb+8
         vuJAB2lNLf/1gF6s400AhcoFYKtX8lYiwezybUQLLgzLidUjy8pKibe9zi+2cdi3OULy
         z4mI+ukEWjf6ossGT40/rNN0NN7vAD7R8UTIp4B6k6sfBkyO4km8jKceQ9ddusM+7H0p
         2WUUkgmAnEmEIOWS67O78j7TKiKbPKa5nWPCkc+MT1NUGJaPhF2UF7C/xwmmezm0qsIw
         tHahFDeRCpN0canlSeNYosNfceUwq43XJsbpNFWeLm2lCVqLd5d4u7lfGqwQtorHghbO
         dPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NtTBlPwTz9WUSTHTA+3Zg9/kI4FBpPVjJ6v/WE7WK8k=;
        b=UHcbI80kPLQbjnoGSszylJrGwpyRGnmyN/AiITBNjvZiaTW5N/oyOaM5KpJP8hC2Pu
         ncU87TwKd5VnSDqMaoUe9r8455RZDEFlmm38p+bwluVHfQSNZL5tXvhGE/as86O03XFX
         YmM4RN6YxziPd4WgbwOnCDqEHc9/iNEMZbWhuKTznOU9yCegp6MHKI0sH35Q1nO19XiB
         dY9RfL03NnSUNPdoVepPYb+MSSRxvRtG3xEiCKZlyyLlA2b5Ck46sxgFzJPfxRdNLf7M
         nPagQNw9Cuw8PiffU4RylpQrFSpv5k6gpr38XniBmcBOiW+02iu74239J9XTxGpy1sjd
         zCNQ==
X-Gm-Message-State: AEkoouv6ZaD8rriy4DwWg0BeJkF/7IKi+mYSru+qu00yhEbY3X3bnG0qSBkUuaSe9naBLdhh
X-Received: by 10.98.100.67 with SMTP id y64mr140951183pfb.84.1470446623817;
        Fri, 05 Aug 2016 18:23:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id dz13sm30712675pac.44.2016.08.05.18.23.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:43 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 6/6] clone: reference flag is used for submodules as well
Date:	Fri,  5 Aug 2016 18:23:18 -0700
Message-Id: <20160806012318.17968-7-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160806012318.17968-1-sbeller@google.com>
References: <20160806012318.17968-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When giving a --reference while also giving --recurse, the alternates
for the submodules are assumed to be in the superproject as well.

In case they are not, we error out when cloning the submodule.
However we error out completely, we did not record the alternates yet,
so a following update command succeeds as usual (with no alternates).

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-clone.txt    |  5 +++++
 builtin/clone.c                | 22 ++++++++++++++++++----
 t/t7408-submodule-reference.sh | 31 ++++++++++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index ec41d3d..2c6dea6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -100,6 +100,11 @@ objects from the source repository into a pack in the cloned repository.
 +
 *NOTE*: see the NOTE for the `--shared` option, and also the
 `--dissociate` option.
++
+When `--reference` is given together with `--recursive`,
+the reference repository is assumed to contain the submodules
+as well and the submodules are setup as alternates of the
+submodules in the given reference project.
 
 --dissociate::
 	Borrow the objects from reference repositories specified
diff --git a/builtin/clone.c b/builtin/clone.c
index f044a8c..e8272b5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -51,6 +51,7 @@ static int option_progress = -1;
 static enum transport_family family;
 static struct string_list option_config = STRING_LIST_INIT_NODUP;
 static struct string_list option_reference = STRING_LIST_INIT_NODUP;
+static struct string_list super_references = STRING_LIST_INIT_DUP;
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
+		string_list_append(&super_references, rel);
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
 
+		if (super_references.nr)
+			for_each_string_list_item(item, &super_references)
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
index 1d9326e..588d53e 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -53,7 +53,8 @@ test_expect_success 'submodule add --reference uses alternates' '
 	(
 		cd super &&
 		git submodule add --reference ../B "file://$base_dir/A" sub &&
-		git commit -m B-super-added
+		git commit -m B-super-added &&
+		git repack -ad
 	) &&
 	test_alternate_usage super/.git/modules/sub/objects/info/alternates super/sub
 '
@@ -65,4 +66,32 @@ test_expect_success 'updating superproject keeps alternates' '
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

