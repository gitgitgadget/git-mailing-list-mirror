Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E76C433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 09:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243095AbiCWJP2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 05:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243086AbiCWJPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 05:15:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FBE75C3D
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:44 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p8so1021285pfh.8
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 02:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u1MMu1Eg9zHoUexbH/JvOn9zvm6XnzHJnDc3qWW1ZHY=;
        b=VWzR2CjzXro9gtKrOdTZedgbUMbShPFjsAeHvsV+JbQUC4DFjZm8Hu55zEGMvALSbv
         RrJtLGEqPza8WqY2ZMCW2GicPjBTOex4DAIOAqRwo7+f45RKz9zF5DGa3eAlLiffQMvZ
         wBsptsetWiskzfZsNXmR1LGdGajdBmls4XTfoE6C3ZOsI8uOf3BwXCeKEeqwug1mkwne
         Y4aRr/fsU5Ge1XCiE13DFXwAwlZhQKSmpvtZivWj/eU+7kisoBXzIbF+QNO2HZ+xfO8O
         sEPChRZxF8r5Ae86sTtZTUxo3T0GBQyl0bmuW9eBv4e6T1t43revKyvAcpIDrr5ak1DW
         XXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u1MMu1Eg9zHoUexbH/JvOn9zvm6XnzHJnDc3qWW1ZHY=;
        b=0tcOn4sOiVMegb/Vr0UTSQIQPqOQgSJm7lD6CRurpYmJbquPRuCHb/yyVx06Ef+3AE
         IxHN51yDEVMzo93DFYIIeYBr6zzkck/KjMTlZXIF4shwXhtV+zpeDbnu/KHmbpALwuNh
         UiViUGvVQVgvXAgQfU3+MFCznpEjM6rDRsJ69CWbnrij+KIicrlcGDafaDyEwT1swa79
         bKvY4HvUkJARApZgvWJ1DT25CQqabULuaA5GRUm2jYjBJ7Z+RpfKk7fv+ijjLuafvDlO
         UFBACAkY793n5fTSULGh7pZqWuHF/uMtHmzqma8fQCpZTuxLOqexA2LDxHR/TfYJMbGo
         VsSw==
X-Gm-Message-State: AOAM530QdGpniMnpIpWFtgdC7H7kmLWNQYSyKBy7ZlEkJLMpwDtcTeMm
        0wKT+OjYhOm/NmP2zaTdmSI=
X-Google-Smtp-Source: ABdhPJyIj0U8OuhK4+wU4wKRtDbX7mF24M106g1xYrSUdqQMv8Hqh5joWOkH8tp79dFUkiXqWAeqaw==
X-Received: by 2002:a05:6a00:a0f:b0:4e1:309:83c0 with SMTP id p15-20020a056a000a0f00b004e1030983c0mr33746441pfh.68.1648026823618;
        Wed, 23 Mar 2022 02:13:43 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.39])
        by smtp.gmail.com with ESMTPSA id s135-20020a63778d000000b0038259e54389sm10224261pgc.19.2022.03.23.02.13.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2022 02:13:43 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, martin.agren@gmail.com,
        peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: [PATCH v14 08/15] ls-tree: fix "--name-only" and "--long" combined use bug
Date:   Wed, 23 Mar 2022 17:13:08 +0800
Message-Id: <1d1808bdf0a07b500d9242dcfdbe4831f612c67f.1648026472.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.34.1.404.g92931a4a2c.dirty
In-Reply-To: <cover.1648026472.git.dyroneteng@gmail.com>
References: <cover.1648026472.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we execute "git ls-tree" with combined "--name-only" and "--long"
, only the pathname will be printed, the size is omitted (the original
discoverer was Peff in [1]).

This commit fix this issue by using `OPT_CMDMODE()` instead to make both
of them mutually exclusive.

[1] https://public-inbox.org/git/YZK0MKCYAJmG+pSU@coredump.intra.peff.net/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 builtin/ls-tree.c       | 12 ++++++------
 t/t3103-ls-tree-misc.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index d4be71bad2..7be4c13228 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -123,12 +123,12 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("terminate entries with NUL byte"), 0),
-		OPT_BIT('l', "long", &ls_options, N_("include object size"),
-			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
-			LS_NAME_ONLY),
+		OPT_CMDMODE('l', "long", &ls_options, N_("include object size"),
+			    LS_SHOW_SIZE),
+		OPT_CMDMODE(0, "name-only", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
+		OPT_CMDMODE(0, "name-status", &ls_options, N_("list only filenames"),
+			    LS_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
 		OPT_BOOL(0, "full-tree", &full_tree,
diff --git a/t/t3103-ls-tree-misc.sh b/t/t3103-ls-tree-misc.sh
index d18ba1bd84..d9d7fa932f 100755
--- a/t/t3103-ls-tree-misc.sh
+++ b/t/t3103-ls-tree-misc.sh
@@ -23,4 +23,13 @@ test_expect_success 'ls-tree fails with non-zero exit code on broken tree' '
 	test_must_fail git ls-tree -r HEAD
 '
 
+for opts in \
+	"--name-only --long" \
+	"--name-status --long"
+do
+	test_expect_success "usage: incompatible options: $opts" '
+		test_expect_code 129 git ls-tree $opts $tree
+    '
+done
+
 test_done
-- 
2.34.1.404.g92931a4a2c.dirty

