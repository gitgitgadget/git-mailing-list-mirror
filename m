Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C9FF2092F
	for <e@80x24.org>; Wed,  4 Jan 2017 01:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762317AbdADBsv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jan 2017 20:48:51 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34770 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762313AbdADBss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jan 2017 20:48:48 -0500
Received: by mail-pf0-f181.google.com with SMTP id c4so79260269pfb.1
        for <git@vger.kernel.org>; Tue, 03 Jan 2017 17:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9pdx9gGDNe3Yah+4aww0WpHRmZT1Mfopn3AgXuyIlYA=;
        b=T/t10+PUZBLcX0+W6aobQ10XTWSxbck8kedhv8jjL+o2yRK89QFQJKiBWSoLRVsJr5
         maW/VZCuovkNC0nA9FPa6IAvU2b2vIrOAiFvVGw2F0g7HLEB0OfKbLglxTc+f1RDKNoA
         /wkAZZNyh7QG4Jqxr9qeUrvYun8+F5xPv5O7/WnQP6h0zfLDwPsSY2eosYv2HeXLiCIc
         +NR5GlNWxyPW8wp7qGL8ILSkcc1pqu0U3bHxtM/tRftFVMA09uAx1fpnUhguy6OYvj3V
         jQqRg4X0/hac5KgqFWr/cMGzqf0fFknAg50TEV71ii762Fd1dm2JC1j0oE7Ss7kiOmMw
         8NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9pdx9gGDNe3Yah+4aww0WpHRmZT1Mfopn3AgXuyIlYA=;
        b=haWfMDIMR7zHa0IYi8sU4Fxz888LpGbh/IJ63W//dtQuX754y0Heggo3TxCEc+WzKd
         3D4+1HBQKEUpo04Fo+Wh5r5uhcDcg7wPxI4FxlQdEpsYCz4zQJNL8p9hJ7HOG9rdPPxR
         r03OkC7V2pZTnrE3ufzXi9aTbPz60DgbVZXoVHoDmFtHwaAyqFXz3cTs0KdictTltAcG
         opgXcOwUqQcm/kmTzWX2mKXDR0UIgeucTmE5tSNY/6Ojod/EhVOeERjjTf2yVl2C7Nvm
         v50HUo4BiQLML/TWLoQ/lwOj9hpaflU7pUoSTixv8cNfV3Wppkfdat31+w2vooxwJTKO
         m4zA==
X-Gm-Message-State: AIkVDXKlQxKiyxRZngdktE3Sd/PxuMeuZLjuY3tYIfrHdhpqVARj6P0TDi+QRldVHLYV0YmS
X-Received: by 10.84.234.9 with SMTP id m9mr110436540plk.49.1483494527738;
        Tue, 03 Jan 2017 17:48:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:f014:c1c8:7de6:70a4])
        by smtp.gmail.com with ESMTPSA id p67sm142686280pfb.2.2017.01.03.17.48.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Jan 2017 17:48:47 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, peff@peff.net, bmwill@google.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/2] submodule tests: don't use itself as a submodule
Date:   Tue,  3 Jan 2017 17:48:34 -0800
Message-Id: <20170104014835.22377-2-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.31.g2cc886f
In-Reply-To: <20170104014835.22377-1-sbeller@google.com>
References: <20170104014835.22377-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In reality nobody would run "git submodule add ./. <submodule-path>"
to add the repository to itself as a submodule as this comes with some
nasty surprises, such as infinite recursion when cloning that repository.
However we do this all the time in the test suite, because most of the
time this was the most convenient way to test a very specific thing
for submodule behavior.

This provides an easier way to have submodules in tests, by just setting
TEST_CREATE_SUBMODULE to a non empty string, similar to
TEST_NO_CREATE_REPO.

Make use of it in those tests that add a submodule from ./. except for
the occurrence in create_lib_submodule_repo as there it seems we craft
a repository deliberately for both inside as well as outside use.

The name "pretzel.[non]bare" was chosen deliberate to not introduce
more strings to the test suite containing "sub[module]" as searching for
"sub" already yields a lot of hits from different contexts. "pretzel"
doesn't occur in the test suite yet, so it is a good candidate for
a potential remote for a submodule.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh |  2 ++
 t/t7001-mv.sh             |  5 +++--
 t/t7507-commit-verbose.sh |  4 +++-
 t/t7800-difftool.sh       |  4 +++-
 t/test-lib-functions.sh   | 16 ++++++++++++++++
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 79cdd34a54..58d76d9df8 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -44,6 +44,8 @@ create_lib_submodule_repo () {
 		git branch "no_submodule" &&
 
 		git checkout -b "add_sub1" &&
+		# Adding the repo itself as a submodule is a hack.
+		# Do not imitate this.
 		git submodule add ./. sub1 &&
 		git config -f .gitmodules submodule.sub1.ignore all &&
 		git config submodule.sub1.ignore all &&
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index e365d1ff77..6cb32f3a3a 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='git mv in subdirs'
+TEST_CREATE_SUBMODULE=yes
 . ./test-lib.sh
 
 test_expect_success \
@@ -288,12 +289,12 @@ rm -f moved symlink
 test_expect_success 'setup submodule' '
 	git commit -m initial &&
 	git reset --hard &&
-	git submodule add ./. sub &&
+	git submodule add ./pretzel.bare sub &&
 	echo content >file &&
 	git add file &&
 	git commit -m "added sub and file" &&
 	mkdir -p deep/directory/hierarchy &&
-	git submodule add ./. deep/directory/hierarchy/sub &&
+	git submodule add ./pretzel.bare deep/directory/hierarchy/sub &&
 	git commit -m "added another submodule" &&
 	git branch submodule
 '
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index ed2653d46f..d269900afa 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 
 test_description='verbose commit template'
+TEST_CREATE_SUBMODULE=yes
 . ./test-lib.sh
 
 write_script "check-for-diff" <<\EOF &&
@@ -74,11 +75,12 @@ test_expect_success 'diff in message is retained with -v' '
 
 test_expect_success 'submodule log is stripped out too with -v' '
 	git config diff.submodule log &&
-	git submodule add ./. sub &&
+	git submodule add ./pretzel.bare sub &&
 	git commit -m "sub added" &&
 	(
 		cd sub &&
 		echo "more" >>file &&
+		git add file &&
 		git commit -a -m "submodule commit"
 	) &&
 	(
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 70a2de461a..d13a5d0453 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -7,6 +7,7 @@ test_description='git-difftool
 
 Testing basic diff tool invocation
 '
+TEST_CREATE_SUBMODULE=Yes
 
 . ./test-lib.sh
 
@@ -534,7 +535,8 @@ test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
 '
 
 test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
-	git submodule add ./. submod/ule &&
+	git submodule add ./pretzel.bare submod/ule &&
+	test_commit -C submod/ule second_commit &&
 	test_config -C submod/ule diff.tool checktrees &&
 	test_config -C submod/ule difftool.checktrees.cmd '\''
 		test -d "$LOCAL" && test -d "$REMOTE" && echo good
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 579e812506..aa327a7dff 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -800,6 +800,22 @@ test_create_repo () {
 		error "cannot run git init -- have you built things yet?"
 		mv .git/hooks .git/hooks-disabled
 	) || exit
+	if test -n "$TEST_CREATE_SUBMODULE"
+	then
+		(
+			cd "$repo"
+			TEST_CREATE_SUBMODULE=
+			export TEST_CREATE_SUBMODULE
+			test_create_repo "pretzel.nonbare"
+			test_commit -C "pretzel.nonbare" \
+				"create submodule" "submodule-file" \
+				"submodule-content" "submodule-tag" >&3 2>&4 ||
+				error "cannot run test_commit"
+			git clone --bare "pretzel.nonbare" \
+				  "pretzel.bare" >&3 2>&4 ||
+				  error "cannot clone into bare"
+		)
+	fi
 }
 
 # This function helps on symlink challenged file systems when it is not
-- 
2.11.0.rc2.31.g2cc886f

