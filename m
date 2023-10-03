Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34C3E75459
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbjJCSvM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjJCSvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:06 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB217B0
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:51:03 -0700 (PDT)
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzKwc3oVfjU8sGsm6fRmVT8/bFjzFbmqeWDjaielQtg=;
        b=0aOK0Dzd0JNF7eMR7vuxqnvUJfGhsyPCzed4lG+AgjRrPyErQ+tSU77wHTgV+jZEc7/dXb
        K/XLhpaaD+ANeYVveUe2gLH29zx2TSFGwlbIccpGLOSxCXar/CqLYRN3bG/yFNDza7Oy1d
        wsBKz2vjrDMBLqOPJnpdrqPsJE1MXWeDMLRw32EeIH3nYd1gydFJSSo1NzFHPYt4pZQN0A
        OlmKI9MXcLyiJKh0PoO1FUdOJmbXsp1eErFHCqDq9DXnDJ/R4S6s/wjiG4FMeqUF29Z2eU
        62dngoZgG0u0NkIoTSudP7E3v2AMqNPjTfN1+S+pbqZhb3uMMjxsBTizTLrYgJxA5z8Cc2
        hvlFwYfXcWLT/zqVepuy8VHnmq7SBa/fnSfaGwI3L5JGcletBCjzewUL3uvqewsnI8QsvE
        ErAt4CdCI8xynS2h1VlRYqQlNWxp5AmAEsj7c7NcOsZLa6r4/Z+w6kJv8drWjcfCAKdwoi
        c0FyI78XU3RXGxZJaXsA0MGMdTBGY4KfAs5YOWPYbUTYcemVcMehFNaUJa5z36+CJeLpkf
        i1BDzAVm7r4puo6DFPioKFq2i5ToTaRhEQGK5oHXqumihJXmrt50JdfuQCkqG8nAz/lk1t
        bhW8g3QvB6+j7UCjQRdqizeLInjNQktURovF6st75lYrwk8MZGlZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zzKwc3oVfjU8sGsm6fRmVT8/bFjzFbmqeWDjaielQtg=;
        b=knj6J/3upcWudGG6OfJgHz9rOZiZkXhyfjqVBoocCbvYsc5F+CbvMMx8tf03NlUiOXjt1f
        xuLm8lXi6F6TGmDg==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To:     git@vger.kernel.org
Cc:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH 6/6] t7420: Test that we correctly handle renamed submodules
Date:   Tue,  3 Oct 2023 20:50:47 +0200
Message-ID: <20231003185047.2697995-6-heftig@archlinux.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org>
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
 <20231003185047.2697995-1-heftig@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a second submodule with a name that differs from its path. Test
that calling set-url modifies the correct .gitmodules entries. Make sure
we don't create a section named after the path instead of the name.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7420-submodule-set-url.sh | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/t/t7420-submodule-set-url.sh b/t/t7420-submodule-set-url.sh
index aa63d806fe..bf7f15ee79 100755
--- a/t/t7420-submodule-set-url.sh
+++ b/t/t7420-submodule-set-url.sh
@@ -25,34 +25,56 @@ test_expect_success 'submodule config cache setup' '
 		git add file &&
 		git commit -ma
 	) &&
+	mkdir namedsubmodule &&
+	(
+		cd namedsubmodule &&
+		git init &&
+		echo 1 >file &&
+		git add file &&
+		git commit -m1
+	) &&
 	mkdir super &&
 	(
 		cd super &&
 		git init &&
 		git submodule add ../submodule &&
-		git commit -m "add submodule"
+		git submodule add --name thename ../namedsubmodule thepath &&
+		git commit -m "add submodules"
 	)
 '
 
 test_expect_success 'test submodule set-url' '
-	# add a commit and move the submodule (change the url)
+	# add commits and move the submodules (change the urls)
 	(
 		cd submodule &&
 		echo b >>file &&
 		git add file &&
 		git commit -mb
 	) &&
 	mv submodule newsubmodule &&
 
+	(
+		cd namedsubmodule &&
+		echo 2 >>file &&
+		git add file &&
+		git commit -m2
+	) &&
+	mv namedsubmodule newnamedsubmodule &&
+
 	git -C newsubmodule show >expect &&
+	git -C newnamedsubmodule show >>expect &&
 	(
 		cd super &&
 		test_must_fail git submodule update --remote &&
 		git submodule set-url submodule ../newsubmodule &&
 		test_cmp_config ../newsubmodule -f .gitmodules submodule.submodule.url &&
+		git submodule set-url thepath ../newnamedsubmodule &&
+		test_cmp_config ../newnamedsubmodule -f .gitmodules submodule.thename.url &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.thepath.url &&
 		git submodule update --remote
 	) &&
 	git -C super/submodule show >actual &&
+	git -C super/thepath show >>actual &&
 	test_cmp expect actual
 '
 
-- 
2.42.0

