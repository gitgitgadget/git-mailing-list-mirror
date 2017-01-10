Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39C3420756
	for <e@80x24.org>; Tue, 10 Jan 2017 20:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751489AbdAJUnE (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 15:43:04 -0500
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33426 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbdAJUms (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 15:42:48 -0500
Received: by mail-qk0-f179.google.com with SMTP id s140so165033717qke.0
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=An93Dv4a9Gvwen2DRP+YlLxFK+mjew8zuT/jIE9K0FY=;
        b=KWtI41f7zhABmKdrmZOKX2BRm4Udpie/wPr7jwrVtnXQEHeGEuntkhFTI2hUTcvMDU
         Afq/P7KJccotkpeJ3nwT/gpj2wmZTxaSEmc4qRy+2t68WqCZXnXOBvC6D9aW/XVK8IfF
         iZogzhsykeOYiUt30rQGLDLeBHzrTsr3K033o7pTyM3hTA0SsjbjhazLinPYoDs1hwOn
         iDFwFBXpJ+Vi1A1FJd8W/3YJLxzKbHfmezBxPCUq11aX7lYO0mY9jACz+16/f2H4mcwN
         jLr544MGZSPFQoISCfg9Io12CMsaJtKMJPh5aYsXCN4n2dRUj+zW9LlHWO9IWIixJz2d
         Z8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=An93Dv4a9Gvwen2DRP+YlLxFK+mjew8zuT/jIE9K0FY=;
        b=rnJrm8XMUiDDLFMIKuhoZCzgg4X8FCVnmMTkhNkGtTLzvub77TambyBDjA7sVWnQRo
         LgVtHUX4/GiSBKJWTNwBfad/BxjIEicbo1TpkKbynn+67DZ6PH8o+3kXH/udIn7MIXp2
         5ADzaywMEq1arNUjbycFrP2gaK/MZ2Zfx7ukmZPIgD2wspIpjVRPNW5iZtor9/HjNzv7
         o7T4I11i02Y5WicMuwos3Uui9hYw0JuezQ0aii3cJMV+/EpeojvnOgU1NP+UP7GzAJzv
         Qhyvehfgas7NKve0EbDwblOrsumSrYEUKH2O6YRJ0eYXNBjiIstkwP/i+McwaIkJQtcN
         9MBQ==
X-Gm-Message-State: AIkVDXLcqKAmBUu8WyxqwBhN9KnwiI2DdX4rCPYZXLaN8JyoHoefgOuuNyfl7lbnPgdoR3x9
X-Received: by 10.55.134.1 with SMTP id i1mr4786155qkd.219.1484080967873;
        Tue, 10 Jan 2017 12:42:47 -0800 (PST)
Received: from hansenr.cam.corp.google.com ([172.29.73.70])
        by smtp.gmail.com with ESMTPSA id z189sm2238137qkb.42.2017.01.10.12.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Jan 2017 12:42:47 -0800 (PST)
From:   Richard Hansen <hansenr@google.com>
To:     git@vger.kernel.org
Cc:     davvid@gmail.com, j6t@kdbg.org, hansenr@google.com,
        sbeller@google.com, simon@ruderich.org, gitster@pobox.com
Subject: [PATCH v5 12/14] t7610: add test case for rerere+mergetool+subdir bug
Date:   Tue, 10 Jan 2017 15:42:00 -0500
Message-Id: <20170110204202.21779-13-hansenr@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170110204202.21779-1-hansenr@google.com>
References: <20170109232941.43637-1-hansenr@google.com>
 <20170110204202.21779-1-hansenr@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If rerere is enabled and mergetool is run from a subdirectory,
mergetool always prints "No files need merging".  Add an expected
failure test case for this situation.

Signed-off-by: Richard Hansen <hansenr@google.com>
---
 t/t7610-mergetool.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index c031ecd9e..b36fde1c0 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -216,7 +216,7 @@ test_expect_success 'mergetool skips autoresolved' '
 	test "$output" = "No files need merging"
 '
 
-test_expect_success 'mergetool merges all from subdir' '
+test_expect_success 'mergetool merges all from subdir (rerere disabled)' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count branch1 &&
 	test_config rerere.enabled false &&
@@ -234,6 +234,25 @@ test_expect_success 'mergetool merges all from subdir' '
 	)
 '
 
+test_expect_failure 'mergetool merges all from subdir (rerere enabled)' '
+	test_when_finished "git reset --hard" &&
+	git checkout -b test$test_count branch1 &&
+	test_config rerere.enabled true &&
+	rm -rf .git/rr-cache &&
+	(
+		cd subdir &&
+		test_must_fail git merge master &&
+		( yes "r" | git mergetool ../submod ) &&
+		( yes "d" "d" | git mergetool --no-prompt ) &&
+		test "$(cat ../file1)" = "master updated" &&
+		test "$(cat ../file2)" = "master new" &&
+		test "$(cat file3)" = "master new sub" &&
+		( cd .. && git submodule update -N ) &&
+		test "$(cat ../submod/bar)" = "master submodule" &&
+		git commit -m "branch2 resolved by mergetool from subdir"
+	)
+'
+
 test_expect_success 'mergetool skips resolved paths when rerere is active' '
 	test_when_finished "git reset --hard" &&
 	test_config rerere.enabled true &&
-- 
2.11.0.390.gc69c2f50cf-goog

