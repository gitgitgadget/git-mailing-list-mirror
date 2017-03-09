Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1ADB20135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754785AbdCIBdT (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:19 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:35995 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754780AbdCIBdS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:18 -0500
Received: by mail-pg0-f41.google.com with SMTP id g2so2411407pge.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pilcTpRRB10Z4O9Hm40QGBs+seS6Qrdjk2Y7eGGfaHs=;
        b=C9xC4i01pXAtedjh+KsVdKW6JcwcBiBN+6PnnzVGcNQP674x5HKCKW/7AhU34btqz7
         7a7ClXwB3CxkdXwpgKhTiCmxol/HGx++ILWNVE9wreSCGrl0cIdfZKBkc1awME2eQw1a
         kthnce/QYk2vShUJK1Xoxr8LCW4mko+svGZwdubDnQT1bZ6S0ikxZdkuh+RWKAWcBiQa
         H7KqQnYrU3SxNbGP7QE4nJFYbUXh0ot6GnSBgXir47sC9HsX3PHn4RK3mAt3QUec8cwU
         57yjvddaUfKOWbQCuUpBeyNlZc//EoQJWPFacci/PbNg/m38hksD0zds8Lbnpa7pZnQ+
         lZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pilcTpRRB10Z4O9Hm40QGBs+seS6Qrdjk2Y7eGGfaHs=;
        b=lS/SHMfau7Ry3vBioGyNGI+GqghfGypkh4sWtCu0KQ4v4E0/ngXhIvyoRj2gVHpBR8
         eEYLbO6nWKUSrhDRMC2jO4Ux5bn18mLz5OuoDCQJvjuwy8+9ORw22lSVcONvPEtMloRr
         qRjO13ere0Tz87rCDgDHA22achD+7SafVAGFc3rsrYoB0gFzRoYB+3P2j95xuHIXrdAF
         IOD5NtyBsT9SQ9eNxSFJwk3ZhmTkPkPOyn9qUMau/jNP0LeQ3Rj8Kccd3un2Qgbg/PVs
         vAazGG5yesjQ5yvf3OqJyOE3QflSnbwnQwcC3P78bUOEa+rjsQVGaCTpFNBpeV0Qqq8t
         Anmw==
X-Gm-Message-State: AMke39mAcXxtSrItS4eanL8arZ2DSxh5P90ate20Eg+Jcd1OpxijxquWFI5lbK12JetYRP5v
X-Received: by 10.99.116.70 with SMTP id e6mr10355925pgn.135.1489022642757;
        Wed, 08 Mar 2017 17:24:02 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:01 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 06/11] submodule: decouple url and submodule existence
Date:   Wed,  8 Mar 2017 17:23:40 -0800
Message-Id: <20170309012345.180702-7-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently the submodule.<name>.url config option is used to determine
if a given submodule exists and is interesting to the user.  This
however doesn't work very well because the URL is a config option for
the scope of a repository, whereas the existence of a submodule is an
option scoped to the working tree.

In a future with worktree support for submodules, there will be multiple
working trees, each of which may only need a subset of the submodules
checked out.  The URL (which is where the submodule repository can be
obtained) should not differ between different working trees.

It may also be convenient for users to more easily specify groups of
submodules they are interested in as apposed to running "git submodule
init <path>" on each submodule they want checked out in their working
tree.

To this end two config options are introduced, submodule.active and
submodule.<name>.active.  The submodule.active config holds a pathspec
that specifies which submodules should exist in the working tree.  The
submodule.<name>.active config is a boolean flag used to indicate if
that particular submodule should exist in the working tree.

Given these multiple ways to check for a submodule's existence the more
fine-grained submodule.<name>.active option has the highest order of
precedence followed by the pathspec check against submodule.active. To
ensure backwards compatibility, if neither of these options are set git
falls back to checking the submodule.<name>.url option to determine a
submodule's existence.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/config.txt       | 15 ++++++++++--
 submodule.c                    | 36 ++++++++++++++++++++++++---
 t/t7413-submodule-is-active.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 506431267..21037e8c5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2888,8 +2888,9 @@ submodule.<name>.url::
 	The URL for a submodule. This variable is copied from the .gitmodules
 	file to the git config via 'git submodule init'. The user can change
 	the configured URL before obtaining the submodule via 'git submodule
-	update'. After obtaining the submodule, the presence of this variable
-	is used as a sign whether the submodule is of interest to git commands.
+	update'. If neither submodule.<name>.active or submodule.active are
+	set, the presence of this variable is used as a fallback to indicate
+	whether the submodule is of interest to git commands.
 	See linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
 
 submodule.<name>.update::
@@ -2927,6 +2928,16 @@ submodule.<name>.ignore::
 	"--ignore-submodules" option. The 'git submodule' commands are not
 	affected by this setting.
 
+submodule.<name>.active::
+	Boolean value indicating if the submodule is of interest to git
+	commands.  This config option takes precedence over the
+	submodule.active config option.
+
+submodule.active::
+	A repeated field which contains a pathspec used to match against a
+	submodule's path to determine if the submodule is of interest to git
+	commands.
+
 submodule.fetchJobs::
 	Specifies how many submodules are fetched/cloned at the same time.
 	A positive integer allows up to that number of submodules fetched
diff --git a/submodule.c b/submodule.c
index 4c4f033e8..6125736fc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -217,13 +217,41 @@ void gitmodules_config_sha1(const unsigned char *commit_sha1)
 int is_submodule_initialized(const char *path)
 {
 	int ret = 0;
-	const struct submodule *module = NULL;
+	char *key;
+	const struct string_list *sl;
+	const struct submodule *module = submodule_from_path(null_sha1, path);
 
-	module = submodule_from_path(null_sha1, path);
+	/* early return if there isn't a path->module mapping */
+	if (!module)
+		return 0;
+
+	/* submodule.<name>.active is set */
+	key = xstrfmt("submodule.%s.active", module->name);
+	if (!git_config_get_bool(key, &ret)) {
+		free(key);
+		return ret;
+	}
+	free(key);
+
+	sl = git_config_get_value_multi("submodule.active");
 
-	if (module) {
-		char *key = xstrfmt("submodule.%s.url", module->name);
+	if (sl) {
+		struct pathspec ps;
+		struct argv_array args = ARGV_ARRAY_INIT;
+		const struct string_list_item *item;
+
+		for_each_string_list_item(item, sl) {
+			argv_array_push(&args, item->string);
+		}
+
+		parse_pathspec(&ps, 0, 0, 0, args.argv);
+		ret = match_pathspec(&ps, path, strlen(path), 0, NULL, 1);
+
+		argv_array_clear(&args);
+		clear_pathspec(&ps);
+	} else {
 		char *value = NULL;
+		key = xstrfmt("submodule.%s.url", module->name);
 
 		ret = !git_config_get_string(key, &value);
 
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index f18e0c925..c41b899ab 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -28,4 +28,59 @@ test_expect_success 'is-active works with urls' '
 	git -C super submodule--helper is-active sub1
 '
 
+test_expect_success 'is-active works with submodule.<name>.active config' '
+	git -C super config --bool submodule.sub1.active "false" &&
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+
+	git -C super config --bool submodule.sub1.active "true" &&
+	git -C super config --unset submodule.sub1.URL &&
+	git -C super submodule--helper is-active sub1 &&
+
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super config --unset submodule.sub1.active
+'
+
+test_expect_success 'is-active works with basic submodule.active config' '
+	git -C super config --add submodule.active "." &&
+	git -C super config --unset submodule.sub1.URL &&
+
+	git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config submodule.sub1.URL ../sub &&
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active correctly works with paths that are not submodules' '
+	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+
+	git -C super config --add submodule.active "." &&
+	test_must_fail git -C super submodule--helper is-active not-a-submodule &&
+
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active works with exclusions in submodule.active config' '
+	git -C super config --add submodule.active "." &&
+	git -C super config --add submodule.active ":(exclude)sub1" &&
+
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset-all submodule.active
+'
+
+test_expect_success 'is-active with submodule.active and submodule.<name>.active' '
+	git -C super config --add submodule.active "sub1" &&
+	git -C super config --bool submodule.sub1.active "false" &&
+	git -C super config --bool submodule.sub2.active "true" &&
+
+	test_must_fail git -C super submodule--helper is-active sub1 &&
+	git -C super submodule--helper is-active sub2 &&
+
+	git -C super config --unset-all submodule.active &&
+	git -C super config --unset submodule.sub1.active &&
+	git -C super config --unset submodule.sub2.active
+'
+
 test_done
-- 
2.12.0.246.ga2ecc84866-goog

