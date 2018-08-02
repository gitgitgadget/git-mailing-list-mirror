Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036291F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbeHBQTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:18 -0400
Received: from ao2.it ([92.243.12.208]:54931 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbeHBQTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:17 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006hz-Pc; Thu, 02 Aug 2018 15:45:39 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwR-0002hF-0Z; Thu, 02 Aug 2018 15:46:59 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 05/12] submodule: use the 'submodule--helper config' command
Date:   Thu,  2 Aug 2018 15:46:27 +0200
Message-Id: <20180802134634.10300-6-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180802134634.10300-1-ao2@ao2.it>
References: <20180802134634.10300-1-ao2@ao2.it>
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the 'submodule--helper config' command in git-submodules.sh to avoid
referring explicitly to .gitmodules by the hardcoded file path.

This makes it possible to access the submodules configuration in a more
controlled way.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---

Note that there are other instances of "git config -f .gitmodules" in test
files, but I am not touching those for now.


 git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 8b5ad59bde..ff258e2e8c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -72,7 +72,7 @@ get_submodule_config () {
 	value=$(git config submodule."$name"."$option")
 	if test -z "$value"
 	then
-		value=$(git config -f .gitmodules submodule."$name"."$option")
+		value=$(git submodule--helper config submodule."$name"."$option")
 	fi
 	printf '%s' "${value:-$default}"
 }
@@ -283,11 +283,11 @@ or you are unsure what this means choose another name with the '--name' option."
 	git add --no-warn-embedded-repo $force "$sm_path" ||
 	die "$(eval_gettext "Failed to add submodule '\$sm_path'")"
 
-	git config -f .gitmodules submodule."$sm_name".path "$sm_path" &&
-	git config -f .gitmodules submodule."$sm_name".url "$repo" &&
+	git submodule--helper config submodule."$sm_name".path "$sm_path" &&
+	git submodule--helper config submodule."$sm_name".url "$repo" &&
 	if test -n "$branch"
 	then
-		git config -f .gitmodules submodule."$sm_name".branch "$branch"
+		git submodule--helper config submodule."$sm_name".branch "$branch"
 	fi &&
 	git add --force .gitmodules ||
 	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
-- 
2.18.0

