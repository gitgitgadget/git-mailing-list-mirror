Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9292D2095D
	for <e@80x24.org>; Sat, 18 Mar 2017 01:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbdCRBVl (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 21:21:41 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34845 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751107AbdCRBVk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 21:21:40 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so38823949pfx.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 18:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4LgFl/hufl18QgeIRfeg0EFUjVN/hJIFNE9WT4HD0ok=;
        b=OhRsqapX8a0lRhq6GNNYc+WF/sIDFZP8PewLY5eUCWLysoSB++tOTn6cTNxGFtuFCP
         qjhKIgA24cMYo0Y/OdrTuC1PEXCoj0nqOgU5ZmATRnD3+Lcy9lkH8n/FfrVkmnYFDVw8
         Q3MsYEFGUaGhUqwTw5C/JaiN8D5Xxf/ngfO6DfkAipgzt2qz/Ll3OiuDCClIxteXVP2m
         OmIdxoxTvQPwSLq4bA2xyOa5nhhf3zOC6bw2LSqXRRArpxF8MgkXx7w1RWdW3PyK+OnK
         VAWOgxGNac1eegv+luuro8aJi1HS4sfEYx8Hng0QbxGo41L54sdZm55OVfUba0DUVC9h
         Sc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4LgFl/hufl18QgeIRfeg0EFUjVN/hJIFNE9WT4HD0ok=;
        b=LxnZ2g5n2Po2tF46odD988NXCaIMvZDG7ffbXUzrfxmoOrSr+eW4g9hquKCHZfjrUn
         UPVRbTaLGcWKVyGnkjFOclEJZtua70y1uIXj4lXp/r/cOvbVKTVR7RfRevHlmfGB7iw/
         7dOO/mV8m+hbZuvIEEvEKDAwTitvjK98OijFRyiXjnWy2ODtj4SMMaQsfc28KJhHwg29
         nW9hWMPvZJ+P2lbSX+TVVmdEOufYI06X5tZXeMCSQuHZN6rCHJMW5QgOmTPXmG8CPFL9
         D2SBMBovt88mtHnPN2nOCr+ovMb98SoxamMmt6E7ivJWEMFBq2DyqsJKtRslDI4cqcsC
         rBtQ==
X-Gm-Message-State: AFeK/H2I9mCdTbiJhGwDcvXnk2dxC0A/STSrwgz0Rk1oyCy9v/Gf8lI89etP7QfDCR/J10tz
X-Received: by 10.99.116.84 with SMTP id e20mr5348265pgn.135.1489790309746;
        Fri, 17 Mar 2017 15:38:29 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id d3sm18699763pfc.51.2017.03.17.15.38.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 15:38:28 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 10/10] submodule add: respect submodule.active and submodule.<name>.active
Date:   Fri, 17 Mar 2017 15:38:05 -0700
Message-Id: <20170317223805.95271-11-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.367.g23dc2f6d3c-goog
In-Reply-To: <20170317223805.95271-1-bmwill@google.com>
References: <20170316222952.53801-1-bmwill@google.com>
 <20170317223805.95271-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to adding submodule.<name>.url to the config, set
submodule.<name>.active to true unless submodule.active is configured
and the submodule's path matches the configured pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh               | 14 ++++++++++++++
 t/t7413-submodule-is-active.sh | 21 +++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index db94dea3b..6ec35e5fc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -278,6 +278,20 @@ or you are unsure what this means choose another name with the '--name' option."
 	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
+
+	# NEEDSWORK: In a multi-working-tree world, this needs to be
+	# set in the per-worktree config.
+	if git config --get submodule.active >/dev/null
+	then
+		# If the submodule being adding isn't already covered by the
+		# current configured pathspec, set the submodule's active flag
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			git config submodule."$sm_name".active "true"
+		fi
+	else
+		git config submodule."$sm_name".active "true"
+	fi
 }
 
 #
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index ea1644b58..9c785b07e 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -15,6 +15,12 @@ test_expect_success 'setup' '
 	test_commit -C super initial &&
 	git -C super submodule add ../sub sub1 &&
 	git -C super submodule add ../sub sub2 &&
+
+	# Remove submodule.<name>.active entries in order to test in an
+	# environment where only URLs are present in the conifg
+	git -C super config --unset submodule.sub1.active &&
+	git -C super config --unset submodule.sub2.active &&
+
 	git -C super commit -a -m "add 2 submodules at sub{1,2}"
 '
 
@@ -83,4 +89,19 @@ test_expect_success 'is-active with submodule.active and submodule.<name>.active
 	git -C super submodule--helper is-active sub2
 '
 
+test_expect_success 'is-active, submodule.active and submodule add' '
+	test_when_finished "rm -rf super2" &&
+	git init super2 &&
+	test_commit -C super2 initial &&
+	git -C super2 config --add submodule.active "sub*" &&
+
+	# submodule add should only add submodule.<name>.active
+	# to the config if not matched by the pathspec
+	git -C super2 submodule add ../sub sub1 &&
+	test_must_fail git -C super2 config --get submodule.sub1.active &&
+
+	git -C super2 submodule add ../sub mod &&
+	git -C super2 config --get submodule.mod.active
+'
+
 test_done
-- 
2.12.0.367.g23dc2f6d3c-goog

