Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B631F453
	for <e@80x24.org>; Thu, 25 Oct 2018 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeJZAwF (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 20:52:05 -0400
Received: from mail.ao2.it ([92.243.12.208]:44377 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbeJZAwE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 20:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=0rkLkTx/9bNUXCFTxXiGTCZwM1g0SOGEVxOT1o5q2wM=;
        b=W+PwoxEIEf3SFBKd2ADNM6y2pyrpbP75iRgKKviS88iWbVFz6WJRBv6NKfqVVmxMZJLBqx8dcLj0K8mCECdws8NL22G2p/WBpHI7UvvUEMwGtwIjJ3FIPtUEcs7X+oKAW08hzdXeEVAHq+8qHPBrEfN0HzPBxzUreF4Ujdu0+SbVHIo0vcYfANZfoA8tyB2T4RsPWzgE5OYy9Nq46YuOP3sZMfjAycmaBXgLBfG+iThu0GoUlNBTELvXSBeVh/Wf+ctFwuH1qwlA6x3SX1cWRy9UucXVOyKQ05l8cDX339PjdOrpkI1Ae1VPXJSU8lEjXDtYEy4s2HDma7ktfZM7XA==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1gFiKo-0003L3-4i; Thu, 25 Oct 2018 18:18:10 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1gFiL5-0004VL-Fg; Thu, 25 Oct 2018 18:18:27 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v7 06/10] submodule: use the 'submodule--helper config' command
Date:   Thu, 25 Oct 2018 18:18:09 +0200
Message-Id: <20181025161813.17252-7-ao2@ao2.it>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025161813.17252-1-ao2@ao2.it>
References: <20181025161813.17252-1-ao2@ao2.it>
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
2.19.1

