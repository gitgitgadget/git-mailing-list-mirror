Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6C71F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbeJEUE4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:56 -0400
Received: from mail.ao2.it ([92.243.12.208]:44965 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbeJEUE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=eAqGR3AV3oY53gGFvQsnMClrkn5wGaWMgp2BoTNuM8o=;
        b=D96p6FMMTUYfHnHD8OOxn/NpIArTLB4vlg8kxilzxiySRdWk58icNCcmQhmu2a3pFuebvichMRTubPoWe+GFDtDzUbufFkRycnAcAEgtM1HLgAHVSkWKGmL7gfhvJJqYZq6q0kFGqW0NBf/jiqwSJ3CMPR9Sb1Q24Zq4o6LV7M3/ySkgGpCDCnYueGPLVU3H/bWxnwFbgIOVsC7GfcriI6qHk4jUMDpclF4vvQyb8AGIVwfnYAnQlydxEBYZdFofOkfs9b3XyyrtrVbW6uTjpkXMkaBzZrdp0DxN0PN/tQOWb08Ml4tiLsbOKM9cTlOjmoE7iAhttuLm9GQafwsuYg==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8PlU-0003BM-5T; Fri, 05 Oct 2018 15:03:32 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g8Pnx-00049C-Kx; Fri, 05 Oct 2018 15:06:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v6 06/10] submodule: use the 'submodule--helper config' command
Date:   Fri,  5 Oct 2018 15:05:57 +0200
Message-Id: <20181005130601.15879-7-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005130601.15879-1-ao2@ao2.it>
References: <20181005130601.15879-1-ao2@ao2.it>
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
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
 git-submodule.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1b568e29b9..0805fadf47 100755
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
2.19.0

