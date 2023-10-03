Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4B7E75459
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbjJCSvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbjJCSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:04 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DF0B7
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:50:59 -0700 (PDT)
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbDsmh4CG889QmQ4bJr/ta/4g/0bdqxUaVC3ROhlp8w=;
        b=B4DTgCcanfea1US20XXGVbyjEctAep62uec15B76zhJVZLN4FoQFxAMuNtUTwQzZd9Ho4q
        oenU4y2nmBNHP+UoPd75bYstLQxkrcCwIZaer3UNdtBT1weSUT+1a9PAPR4D3ZUW4KtRfj
        Di/H+87lP27TMf1x3p0M2pg6eLXHBNdirUFCutPIxWndJNK6JzCEo2qlvKLJvgn8qRlwYG
        jL1iqoWphgg7VqY+BbN6qgVgAJ4upEL4tsOmQdkc43Q9kxbqcpLME/M5bhs5aRItOtIkO+
        0rTMYNtqklkvGWDC2AYMqgTAd8FG12SIw3XdhGEbo5Z+3M1vLNFZih2es/2ylBjg5sc8Qe
        BWHi6FLJzF9MPyAs+UUZM3sLIolPfxTFqfoFwS5h7HWqVpsbYyxVeZUNNjE/Elw5jKf+QM
        Uoxw3z6c3or8iH3VR8EhfMTjxSguJPvOO1o/ONvwMsnrva0cH545ENFkW+za/ptdtj4ZF1
        NsKg2wfik+Og8vTnNls/X3ggTxyJ9763671N0BXY0vVSRYxbpKg9QrUdCn4KKh1ofSrx1t
        vrr1/+wrTwlqWhd3baeuNS5B+h8hM7HMoA9sw06hjcUpu3M6gC01bBnNvKGPsdrYdwbqcV
        QGMgw/Q+BWldO9FuX5KVYbFNqig1qwoqNpS7Yw07vRVP0BTT6NtVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1696359055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kbDsmh4CG889QmQ4bJr/ta/4g/0bdqxUaVC3ROhlp8w=;
        b=ir+koEFtKqb0yXOSkUv/0IUpEEHNEB1nNOFi2wWJoFm0VZC8AP7FCFX/80z5fczZDpbLh8
        7X0gJGmPHvK5B8BA==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To:     git@vger.kernel.org
Cc:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH 5/6] t7419: Test that we correctly handle renamed submodules
Date:   Tue,  3 Oct 2023 20:50:46 +0200
Message-ID: <20231003185047.2697995-5-heftig@archlinux.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org>
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
 <20231003185047.2697995-1-heftig@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the submodule again with an explicitly different name and path. Test
that calling set-branch modifies the correct .gitmodules entries. Make
sure we don't create a section named after the path instead of the name.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 t/t7419-submodule-set-branch.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index 3cd30865a7..a5d1bc5c54 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -38,7 +38,8 @@ test_expect_success 'submodule config cache setup' '
 	(cd super &&
 		git init &&
 		git submodule add ../submodule &&
-		git commit -m "add submodule"
+		git submodule add --name thename ../submodule thepath &&
+		git commit -m "add submodules"
 	)
 '
 
@@ -100,4 +101,31 @@ test_expect_success 'test submodule set-branch -d' '
 	)
 '
 
+test_expect_success 'test submodule set-branch --branch with named submodule' '
+	(cd super &&
+		git submodule set-branch --branch topic thepath &&
+		test_cmp_config topic -f .gitmodules submodule.thename.branch &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.thepath.branch &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		b
+		EOF
+		git -C thepath show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'test submodule set-branch --default with named submodule' '
+	(cd super &&
+		git submodule set-branch --default thepath &&
+		test_cmp_config "" -f .gitmodules --default "" submodule.thename.branch &&
+		git submodule update --remote &&
+		cat <<-\EOF >expect &&
+		a
+		EOF
+		git -C thepath show -s --pretty=%s >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.42.0

