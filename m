Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBC7C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 08:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiBPIVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 03:21:25 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBPIVY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 03:21:24 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B992722E7
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:21:11 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d27so2110488wrc.6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 00:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2v3X1szMnq9BiamJFKV03GDVWE9Wa9Egc9wzpswz5z0=;
        b=oe7pghroe3zk15kj1YcmKfWbVgS5dh0NLDtUOv1xREQqi/tsJ+oj9JDX6Oag7TgkO/
         hBPOd/y/n7/76ywRH1+4ll3xGwqlqeVbcr1ySiW1diMP5tOqPXFGLnmiOZ3THsc/roUD
         I9BP63I8JxPag4B/AGid6GxGo0DDregiJ4DlU2NGO/bmNFU0PKb1U5VtfrOa7vYcgWmI
         LqM9cXaKp+qDGwnH9DjZ31frtl9Urfjg7tOq0zBV3+oYkiUB32xlXQC6j/2DZDBf9VOq
         GkFoARtKCr8BZhtDj4wf9nnP9+1KlZWlfR1g3m11al+QGTBI6MNs3/cJza14P14X2kT3
         XT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2v3X1szMnq9BiamJFKV03GDVWE9Wa9Egc9wzpswz5z0=;
        b=s/N+R9xA7IP7rnwI0l+/Hd1uLvxrl1zSB3qSs4hWd8iF76ZT+047h9+QBT8D873rVU
         n0oZMBs3JY5UB9oWoNVX28QC6DNoHXs5TyzoRHjciHF0MtbC0rteGxywG1zXzXQIGeY7
         V7a6ajR+LNWHZrBR0mrPFhYW1kfWPppvPpGW7h42+tzDxVtZtRr3m0fxIcqjvPXJwW76
         R+rzpffj0E5Q4xKQ0dzij+/5DuYCW4Msh3GmIJhp2jwzv+2WW/E7HxjBzzkfRQDkz3vB
         7j5np0ZvyJNz3w9FJmepkgygq1wQbYZlUg/OWF4Kghj+FwxSVVQEuZPrtFD/BstzLfvC
         0GxQ==
X-Gm-Message-State: AOAM530dLrYOOc+qOlrSg9Fu2h2r6G9mPjFCWp6eMg6wp5VTi7hKoVPs
        Q5VjUZ+Ref3cFQBdVPLqde66FO8ayfWAUg==
X-Google-Smtp-Source: ABdhPJxB96pt93iUe75sDjIY/hOL1p8/mtQEFD+GyOR8+3YSN1Ud48Nifkb6Q3PChdpAkemMILuiMw==
X-Received: by 2002:a5d:6a43:0:b0:1e3:1830:802f with SMTP id t3-20020a5d6a43000000b001e31830802fmr1277530wrw.485.1644999670211;
        Wed, 16 Feb 2022 00:21:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p2sm17460687wmc.33.2022.02.16.00.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 00:21:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] commit: fix "author_ident" leak
Date:   Wed, 16 Feb 2022 09:21:05 +0100
Message-Id: <patch-1.2-25202a1d07f-20220216T081844Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g2d2d4be19de
In-Reply-To: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in cmd_commit(), since 4c28e4ada03 (commit: die before
asking to edit the log message, 2010-12-20) we have been freeing the
"author_ident" "struct strbuf", but not in the case where
prepare_to_commit() returns non-zero.

This fixes a leak demonstrated by e.g. "t3505-cherry-pick-empty.sh",
but unfortunately we cannot mark it or other affected tests as passing
now with "TEST_PASSES_SANITIZE_LEAK=true" as we'll need to fix many
other memory leaks before doing so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6b99ac276d8..696b3527adf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1689,6 +1689,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct commit *current_head = NULL;
 	struct commit_extra_header *extra = NULL;
 	struct strbuf err = STRBUF_INIT;
+	int ret = 0;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_commit_usage, builtin_commit_options);
@@ -1723,8 +1724,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	   running hooks, writing the trees, and interacting with the user.  */
 	if (!prepare_to_commit(index_file, prefix,
 			       current_head, &s, &author_ident)) {
+		ret = 1;
 		rollback_index_files();
-		return 1;
+		goto cleanup;
 	}
 
 	/* Determine parents */
@@ -1822,7 +1824,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
-	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
 	if (update_head_with_reflog(current_head, &oid, reflog_msg, &sb,
@@ -1863,7 +1864,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 
+cleanup:
+	strbuf_release(&author_ident);
 	UNLEAK(err);
 	UNLEAK(sb);
-	return 0;
+	return ret;
 }
-- 
2.35.1.1028.g2d2d4be19de

