Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD2820958
	for <e@80x24.org>; Wed, 29 Mar 2017 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932604AbdC2W01 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Mar 2017 18:26:27 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:33310 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752944AbdC2W0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2017 18:26:25 -0400
Received: by mail-pg0-f51.google.com with SMTP id x125so20046646pgb.0
        for <git@vger.kernel.org>; Wed, 29 Mar 2017 15:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DNAfWD5EgJpgLHZz6w2cVPAiolD/z1z+cWd6azT6j2U=;
        b=HUN19s7Cnn8YSiqrbhCBgbteP6xcc6EwfHsoUdKOE/Gla3a1NKMVixxOS99Akr0OMk
         Jbv8FrtT68tW2iuIJjfz1yLFXIk0BBHIe+8muFfWThcLkdn81ZKC+BbKBaflo8ycFRC4
         RwMw9yTiRGVprDp0m3JlDmHFlN34eq0DAHTb27jxTu8jCdIRXckG6Ma1tQeqolvghdbE
         V3BpF2SSrn897lXdKucKV0NEchw3dNgITyfONArcXMw1TMpjuBSyttkCWLq5agtwTP3l
         c5Ulocs8RjDc0V38EZekWeVqnb5Qf7vc3EP8DIJu0VQ76Uz4CD4AUmfXG2wz5TGfQ6cB
         mssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DNAfWD5EgJpgLHZz6w2cVPAiolD/z1z+cWd6azT6j2U=;
        b=LgLrTm4y6mtnxusCVeivmFOsTL4UR9Tpko/okcKHRuDE4+G3VZdp0zUTuVlExJGBA3
         SmCbul+X15XEN3tIxlk4Vj/GY5rSdKtV+1T6kw3goOmg1WBeEXXGjQ71kiNyWpDPcvKo
         bwGTyn/EZSFQuz9C0CGEQmIcbDw4EExys5OpfWLgnFqneSnZ+bCz2a7iWatzwKJkf+P8
         yxFmjN5N0O0VX8KXhORJ8mgvge17rlZHQy97myBGhJS7arKMMaUe0oTOlRRUd2qfK9vW
         AGhv3pOdYkeUYTca232bpZlZMqaNj+J1q8Pgr71xQbTtT9vloUQgjVFpvuVvMAaS+qOa
         +y5g==
X-Gm-Message-State: AFeK/H1J0UyG36eVP3XZSdwr5asqEJwLzXSGEvHNJR4UiuRZkUlFPdpgdf4PcHoAMvFcvcUN
X-Received: by 10.98.71.149 with SMTP id p21mr2915813pfi.94.1490826384191;
        Wed, 29 Mar 2017 15:26:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc96:1eab:fd67:9864])
        by smtp.gmail.com with ESMTPSA id 11sm228640pgf.28.2017.03.29.15.26.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 29 Mar 2017 15:26:23 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule.c: correctly handle nested submodules in is_submodule_modified
Date:   Wed, 29 Mar 2017 15:26:16 -0700
Message-Id: <20170329222616.11077-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.442.ge9452a8fbc
In-Reply-To: <20170329222616.11077-1-sbeller@google.com>
References: <20170328230938.9887-1-sbeller@google.com>
 <20170329222616.11077-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Suppose I have a superproject 'super', with two submodules 'super/sub'
and 'super/sub1'. 'super/sub' itself contains a submodule
'super/sub/subsub'. Now suppose I run, from within 'super':

    echo hi >sub/subsub/stray-file
    echo hi >sub1/stray-file

Currently we get would see the following output in git-status:

    git status --short
     m sub
     ? sub1

With this patch applied, the untracked file in the nested submodule is
displayed as an untracked file on the 'super' level as well.

    git status --short
     ? sub
     ? sub1

This doesn't change the output of 'git status --porcelain=1' for nested
submodules, because its output is always ' M' for either untracked files
or local modifications no matter the nesting level of the submodule.

'git status --porcelain=2' is affected by this change in a nested
submodule, though. Without this patch it would report the direct submodule
as modified and having no untracked files. With this patch it would report
untracked files. Chalk this up as a bug fix.

This bug fix also affects the default output (non-short, non-porcelain)
of git-status, which is not tested here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-status.txt |  2 ++
 submodule.c                  | 21 +++++++++++++++++++--
 t/t3600-rm.sh                |  2 +-
 t/t7506-status-submodule.sh  |  4 ++--
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 67f1a910f3..d70abc6afe 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -189,6 +189,8 @@ Submodules have more state and instead report
 since modified content or untracked files in a submodule cannot be added
 via `git add` in the superproject to prepare a commit.
 
+'m' and '?' are applied recursively. For example if a nested submodule
+in a submodule contains an untracked file, this is reported as '?' as well.
 
 If -b is used the short-format status is preceded by a line
 
diff --git a/submodule.c b/submodule.c
index fa21c7bb72..3da65100e3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1078,8 +1078,25 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		/* regular untracked files */
 		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-		else
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			/* T = line type, XY = status, SSSS = submodule state */
+			if (buf.len < strlen("T XY SSSS"))
+				die("BUG: invalid status --porcelain=2 line %s",
+				    buf.buf);
+
+			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+				/* nested untracked file */
+				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+			if (buf.buf[0] == 'u' ||
+			    buf.buf[0] == '2' ||
+			    memcmp(buf.buf + 5, "S..U", 4))
+				/* other change */
+				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+		}
 
 		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
 		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index a6e5c5bd56..b58793448b 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -659,7 +659,7 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 	test -d submod &&
 	test -f submod/.git &&
 	git status -s -uno --ignore-submodules=none >actual &&
-	test_cmp expect.modified_inside actual &&
+	test_cmp expect.modified_untracked actual &&
 	git rm -f submod &&
 	test ! -d submod &&
 	git status -s -uno --ignore-submodules=none >actual &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 1fa2ff2909..055c90736e 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -356,7 +356,7 @@ test_expect_success 'status with untracked file in nested submodule (porcelain=2
 	git -C super status --porcelain=2 >output &&
 	sanitize_output output &&
 	diff output - <<-\EOF
-	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S..U 160000 160000 160000 HASH HASH sub1
 	1 .M S..U 160000 160000 160000 HASH HASH sub2
 	1 .M S..U 160000 160000 160000 HASH HASH sub3
 	EOF
@@ -365,7 +365,7 @@ test_expect_success 'status with untracked file in nested submodule (porcelain=2
 test_expect_success 'status with untracked file in nested submodule (short)' '
 	git -C super status --short >output &&
 	diff output - <<-\EOF
-	 m sub1
+	 ? sub1
 	 ? sub2
 	 ? sub3
 	EOF
-- 
2.12.1.442.ge9452a8fbc

