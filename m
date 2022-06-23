Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDFC43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 11:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiFWLmG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 07:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiFWLl5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 07:41:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3474BFFD
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:53 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k7so17939328plg.7
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JkEnir3dEuowaiIAGgpmBD7eo16ymK2kzWe/eJtpUy0=;
        b=MO+Un+nyLoGpUMuSEimuRYHF+KhTciJaXhBjPHpo7IwoE1wWzST6cHTVjN9qelvsAL
         aZi0RMjncnFHlQM7EeuRv8xYErYYncoxOVKbkrZSiDsQsH2VN6lQafPSyGkvXg548cLT
         wion0MajawY9qlNWsGn+xRbcrcNNMJrSUlzeqUbF7DZvO6+w64do+2qf/BjCNLsG//Ug
         YNc2Mol/BChNs1mhNr4ASPHnRA9n3lVaIWGuBp3Ny5KxcL02aM6veevpYrrMVR76OB86
         vh+ziDkW4sG8x9YrUixyLXsZacNgQu2ZHhZkJC2+bTmrrvD3IMg4VxyuepnoqZngf6kw
         pyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JkEnir3dEuowaiIAGgpmBD7eo16ymK2kzWe/eJtpUy0=;
        b=ut9+a13CWWWGNeOSmRnfQRiq95GeBaauUBtJYG4lgdfMr/3lZWiAId85mJjT5KXuI+
         kaELrou85PRF8dGsUCqnC5t+dpkvwj7JuUTkTT1zZ2FRPiM9Ter3dXuRzJBhElmWFQRp
         BhTyVa/oDrxG74hP/j2qblxkA7wTyYGQWYfUoISSkLAaxDqHMEJ23gylM4OU2QqF9uDz
         ehyK+42TRUoYFHO5slL35Yk00bnBHrVbJwiVQ6DrrJVzDCsR5SLc+1m8kDKeUJP+CdgW
         tCLygCdVU3oZlpEJiEPhnNv5fXRTYRIRAS+dVTmHOd207wtCk1RAJdMnzZxqSwOSmkqC
         oL7A==
X-Gm-Message-State: AJIora+3h2Wb/CcAumXZrIUEJp2gZhfQWKetLys2vke8orR7/sqSmIOw
        SJr9VtW2as/JRWmQ5vWEDckD4A3HOGkdd/qC
X-Google-Smtp-Source: AGRyM1sW4OdyLUx2LJ6hbHn1GUqRY+JHd/Uq9NFBrigg0M3v6VSES7SS80d/dHRLzeZbZey1ud1DCQ==
X-Received: by 2002:a17:902:e5c2:b0:16a:62c7:4190 with SMTP id u2-20020a170902e5c200b0016a62c74190mr227846plf.110.1655984513234;
        Thu, 23 Jun 2022 04:41:53 -0700 (PDT)
Received: from ffyuanda.localdomain ([112.195.146.236])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a7e8700b001ec4f258028sm1629299pjl.55.2022.06.23.04.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:41:52 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     shaoxuan.yuan02@gmail.com
Cc:     derrickstolee@github.com, git@vger.kernel.org, gitster@pobox.com,
        vdye@github.com
Subject: [PATCH v4 5/7] mv: check if <destination> exists in index to handle overwriting
Date:   Thu, 23 Jun 2022 19:41:18 +0800
Message-Id: <20220623114120.12768-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
References: <20220331091755.385961-1-shaoxuan.yuan02@gmail.com>
 <20220623114120.12768-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Originally, moving a sparse file into cone can result in unwarned
overwrite of existing entry. The expected behavior is that if the
<destination> exists in the entry, user should be prompted to supply
a [-f|--force] to carry out the operation, or the operation should
fail.

Add a check mechanism to do that.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c                  | 15 ++++++++++++---
 t/t7002-mv-sparse-checkout.sh |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index d1b3229be6..40a3a5c5ff 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -202,11 +202,20 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 				bad = _("bad source");
 				goto act_on_entry;
 			}
-
-			if (!ignore_sparse)
+			if (!ignore_sparse) {
 				string_list_append(&only_match_skip_worktree, src);
-			else
+				goto act_on_entry;
+			}
+			/* Check if dst exists in index */
+			if (cache_name_pos(dst, strlen(dst)) < 0) {
 				modes[i] = SPARSE;
+				goto act_on_entry;
+			}
+			if (!force) {
+				bad = _("destination exists");
+				goto act_on_entry;
+			}
+			modes[i] = SPARSE;
 			goto act_on_entry;
 		}
 		if (!strncmp(src, dst, length) &&
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 1510b5ed6a..6d2fb4f8d2 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -262,7 +262,7 @@ test_expect_success 'can move out-of-cone file with --sparse' '
 	test_path_is_file sub/file1
 '
 
-test_expect_failure 'refuse to move sparse file to existing destination' '
+test_expect_success 'refuse to move sparse file to existing destination' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir folder1 &&
 	touch folder1/file1 &&
@@ -275,7 +275,7 @@ test_expect_failure 'refuse to move sparse file to existing destination' '
 	test_cmp expect stderr
 '
 
-test_expect_failure 'move sparse file to existing destination with --force and --sparse' '
+test_expect_success 'move sparse file to existing destination with --force and --sparse' '
 	test_when_finished "cleanup_sparse_checkout" &&
 	mkdir folder1 &&
 	touch folder1/file1 &&
-- 
2.35.1

