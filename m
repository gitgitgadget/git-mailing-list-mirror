Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0F120135
	for <e@80x24.org>; Thu,  9 Mar 2017 01:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbdCIBdQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 20:33:16 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33016 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754769AbdCIBdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 20:33:15 -0500
Received: by mail-pf0-f182.google.com with SMTP id w189so21853001pfb.0
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 17:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LtLZAO28P08w6G6sV7Ym2IKU82V+27AdAtXDvfu1xmA=;
        b=nGFieKwUF2A58w9xCWGUbXEyiUQ0ErwwtVHuSONNE5RblviiuteE02hpILJ4HVBkNs
         x/mr+8rByKONQUvs+M8GryEYhp5eQYIM/amHC0gXcXvraT3kAKl9e5U30vQgnfIlYhn8
         ykij8eCHWE+gfBNiRieE6cBzImyrrlM39Oo9Ug1dwjDfPfkRZfWysfRa4eAib5yGbHLm
         /oZvV20U6xb5A1RwbHRxA1GAQsD4lXc2WlDqmfxdqIFryKFJCUtAzmi5PqqSGLZu6YPV
         vDRn6gU5S47XiF8aIoxo+7WKiCZOo+N5BYvhAR/ViYtFsr5vy0DCcHo/U4pej/aRWq8P
         IeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LtLZAO28P08w6G6sV7Ym2IKU82V+27AdAtXDvfu1xmA=;
        b=S//ZAEALyaed069tJo4FkE9P+Lc1cCAmuo90Muoe4M6gBUnqnM/INMnUjrFPDhk1VN
         4q3sguxKRVt/Oyiow19m7aU44S6zOIrUtSTpKxaEPx7ShVDmi/mCZsUg2y7++34Tw7sn
         0HO7DOf3vTzaocooeDrO3S6CPi2VPOue+oMUjSk7g5lZerxIBC7Q4spFEi16DZ3zzxq9
         XPJ6T1uO8ajoqmo2jiGwCIqsdzCac5Gf78xb730WW9PxTHtevRLvVh+bxnluSBBldzbZ
         SYfjy8hDPPzk5zPfq99o/qoaDK0zWL1imt4a9mehm4tGlEXdw/dSZMkeyo+Al8tj3YVA
         gQUQ==
X-Gm-Message-State: AMke39n/O3C9sOvOvqA65kl8qonfXRpcQ3ecVTYWmrtZk5JyFUU9tiqae/VsKsGSGP/XleIg
X-Received: by 10.99.48.68 with SMTP id w65mr10514809pgw.203.1489022650474;
        Wed, 08 Mar 2017 17:24:10 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id l71sm8479948pga.7.2017.03.08.17.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Mar 2017 17:24:09 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v2 11/11] submodule add: respect submodule.active and submodule.<name>.active
Date:   Wed,  8 Mar 2017 17:23:45 -0800
Message-Id: <20170309012345.180702-12-bmwill@google.com>
X-Mailer: git-send-email 2.12.0.246.ga2ecc84866-goog
In-Reply-To: <20170309012345.180702-1-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In addition to adding submodule.<name>.url to the config, set
submodule.<name>.active to true unless submodule.active is configured
and the submodule's path matches the configured pathspec.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 git-submodule.sh               | 12 ++++++++++++
 t/t7413-submodule-is-active.sh | 21 +++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 43a393d7e..d90fde655 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -271,6 +271,18 @@ or you are unsure what this means choose another name with the '--name' option."
 	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
+
+	if git config --get submodule.active >/dev/null
+	then
+		# If the submodule being adding isn't already covered by the
+		# current configured pathspec, set the submodule's active flag
+		if ! git submodule--helper is-active "$sm_path"
+		then
+			git config --add submodule."$sm_name".active "true"
+		fi
+	else
+		git config --add submodule."$sm_name".active "true"
+	fi
 }
 
 #
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index c41b899ab..865931978 100755
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
 	git -C super config --unset submodule.sub2.active
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
2.12.0.246.ga2ecc84866-goog

