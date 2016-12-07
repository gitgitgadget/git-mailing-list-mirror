Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D65EF1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 18:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932556AbcLGSnv (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 13:43:51 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:34345 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932444AbcLGSnu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 13:43:50 -0500
Received: by mail-wj0-f193.google.com with SMTP id xy5so51303141wjc.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 10:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=N8I+NiUeIJ4imEXT7d7dj7TdiWb6GypTLdAdC3MKzCQ=;
        b=zR5p3miGt8+77hRLy7LUzGq2IyYHvHeAnbd7q9XXjleQFCAo8Mp1bKGGWy72kKFtbu
         hlF84V4T7O34YLQHXNuKb6dv2/HiVruve6Vt8fF+BIyHnv6s2LB2Q3GyxL+RuIeCqUwr
         LIH3sZmp74VuoiqtcofCdh33W1f8q+GIvgh/xnfdzpOIUtHJiENop8Krt7qJkQFLBy/H
         8GdJMwI+GjRNFskJSWu1PIMqj/Q9Zj7knvPEGXJOCGmh6d8HBP/hHI2u15bxcUVCs/Xk
         //o/5wHVWhLI+kCYaWGKCkGiBuVNtKGe69etcy4FOeA5NdHMY4FdKQ/bfk6FK986tdpH
         90SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N8I+NiUeIJ4imEXT7d7dj7TdiWb6GypTLdAdC3MKzCQ=;
        b=TjvrEHNodSmJ36+2PjK6lR3B45dnvN7bESc+AqukQp4naNfP3vSL94Fy2UFyDq/5dG
         72B2SoUoSK0IjkiYdnXRg/OIs3q71Kc0Aq72gEtR+g2u3zyOrffdPIlUFL/AX9mfs1ez
         KP71D6PkLLv+OoidCU33+xtlFEod5iMdN7OTySt4dJUmieG2SF74oxz8F4JvdPqkeMBC
         MP2cVrRw2o63VOnJeh4FFKLt3Xzfh3KIHHdJdZhZ7ZMIA1WaHkSHwGahFGj/1DxLWx39
         HHkg6UGXXgljp+mo61UlBqFSjD5vtIWMda0pgqg7kr9zER1HvVJFWnhsacqxmWIbVqqS
         Ey5Q==
X-Gm-Message-State: AKaTC007Q8QbhWn3g2Gc5SzLZvSbC41shPyiPmaGdZiFgUHS6zndEfPyJACesMwv3uD7aQ==
X-Received: by 10.194.111.231 with SMTP id il7mr58881683wjb.52.1481136229033;
        Wed, 07 Dec 2016 10:43:49 -0800 (PST)
Received: from localhost.localdomain ([104.131.203.210])
        by smtp.gmail.com with ESMTPSA id d64sm11070905wmh.3.2016.12.07.10.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Dec 2016 10:43:48 -0800 (PST)
From:   vi0oss@gmail.com
To:     git@vger.kernel.org
Cc:     stefanbeller@gmail.com, Vitaly _Vi Shukela <vi0oss@gmail.com>
Subject: [PATCH] submodule--helper: set alternateLocation for cloned submodules
Date:   Wed,  7 Dec 2016 21:42:48 +0300
Message-Id: <20161207184248.6130-1-vi0oss@gmail.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vitaly _Vi Shukela <vi0oss@gmail.com>

Git v2.11 introduced "git clone --recursive --referece ...",
but it didn't put the alternates for _nested_ submodules.

This patch makes all not just the root repository, but also
all submodules (recursively) have submodule.alternateLocation
and submodule.alternateErrorStrategy configured, making Git
search for possible alternates for nested submodules as well.

As submodule's alternate target does not end in .git/objects
(rather .git/modules/qqqqqq/objects), this alternate target
path restriction for in add_possible_reference_from_superproject
relates from "*.git/objects" to just */objects".

New tests have been added to t7408-submodule-reference.

Signed-off-by: Vitaly _Vi Shukela <vi0oss@gmail.com>
---
 builtin/submodule--helper.c    | 24 ++++++++++++--
 t/t7408-submodule-reference.sh | 73 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4beeda5..93dae62 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -498,9 +498,9 @@ static int add_possible_reference_from_superproject(
 
 	/*
 	 * If the alternate object store is another repository, try the
-	 * standard layout with .git/modules/<name>/objects
+	 * standard layout with .git/(modules/<name>)+/objects
 	 */
-	if (ends_with(alt->path, ".git/objects")) {
+	if (ends_with(alt->path, "/objects")) {
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
@@ -672,6 +672,26 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		die(_("could not get submodule directory for '%s'"), path);
 	git_config_set_in_file(p, "core.worktree",
 			       relative_path(path, sm_gitdir, &rel_path));
+
+	/* setup alternateLocation and alternateErrorStrategy in the cloned submodule if needed */
+	{
+		char *sm_alternate = NULL, *error_strategy = NULL;
+
+		git_config_get_string("submodule.alternateLocation", &sm_alternate);
+		if (sm_alternate) {
+			git_config_set_in_file(p, "submodule.alternateLocation",
+						   sm_alternate);
+		}
+		git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
+		if (error_strategy) {
+			git_config_set_in_file(p, "submodule.alternateErrorStrategy",
+						   error_strategy);
+		}
+
+		free(sm_alternate);
+		free(error_strategy);
+	}
+
 	strbuf_release(&sb);
 	strbuf_release(&rel_path);
 	free(sm_gitdir);
diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
index 1c1e289..7b64725 100755
--- a/t/t7408-submodule-reference.sh
+++ b/t/t7408-submodule-reference.sh
@@ -125,4 +125,77 @@ test_expect_success 'ignoring missing submodule alternates passes clone and subm
 	)
 '
 
+test_expect_success 'preparing second superproject with a nested submodule' '
+	test_create_repo supersuper &&
+	(
+		cd supersuper &&
+		echo I am super super. >file &&
+		git add file &&
+		git commit -m B-super-super-initial
+		git submodule add "file://$base_dir/super" subwithsub &&
+		git commit -m B-super-super-added &&
+		git submodule update --init --recursive &&
+		git repack -ad
+	) &&
+	echo not cleaning supersuper
+'
+
+# At this point there are three root-level positories: A, B, super and super2
+
+test_expect_success 'nested submodule alternate in works and is actually used' '
+	test_when_finished "rm -rf supersuper-clone" &&
+	git clone --recursive --reference supersuper supersuper supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# immediate submodule has alternate:
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
+		# nested submodule also has alternate:
+		test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
+test_expect_success 'missing nested submodule alternate fails clone and submodule update' '
+	test_when_finished "rm -rf supersuper-clone supersuper2" &&
+	git clone supersuper supersuper2 &&
+	(
+		cd supersuper2 &&
+		git submodule update --init
+	) &&
+	test_must_fail git clone --recursive --reference supersuper2 supersuper2 supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule fails
+		test_must_fail git submodule update --init --recursive &&
+		# immediate submodule has alternate:
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
+		# but nested submodule has no alternate:
+		test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
+test_expect_success 'missing nested submodule alternate in --reference-if-able mode' '
+	test_when_finished "rm -rf supersuper-clone supersuper2" &&
+	git clone supersuper supersuper2 &&
+	(
+		cd supersuper2 &&
+		git submodule update --init
+	) &&
+	git clone --recursive --reference-if-able supersuper2 supersuper2 supersuper-clone &&
+	(
+		cd supersuper-clone &&
+		# test superproject has alternates setup correctly
+		test_alternate_is_used .git/objects/info/alternates . &&
+		# update of the submodule fails
+		test_must_fail git submodule update --init --recursive &&
+		# immediate submodule has alternate:
+		test_alternate_is_used .git/modules/subwithsub/objects/info/alternates subwithsub
+		# but nested submodule has no alternate:
+		test_must_fail test_alternate_is_used .git/modules/subwithsub/modules/sub/objects/info/alternates subwithsub/sub
+	)
+'
+
 test_done
-- 
2.10.2

