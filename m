Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25C101FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754008AbdC1XKG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:10:06 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37312 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbdC1XKF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:10:05 -0400
Received: by mail-it0-f41.google.com with SMTP id 190so37635724itm.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZfC0wh/eZSwWy+78+FQuouPCOZEwXZdyCSAK1TAJzJg=;
        b=bUiu1X8ju1CVQ9vQrIuqLTMlMdrYtrx0URvbHnfbimXzlKhqpooaZrE1r5V7HmnHPf
         U5LIlT4rjaPMJUbswi/Q68Eij6Uez0fmQydAW+L16fwN7MSgEcBGnQr4wADmzFJB6a8F
         NLKZPzEU8RNAFv+PB1FDSD7IfM9bBfkUQe19+/Pbfwq+Kp88Yeci8Bcj+481KcU2dJoJ
         ApoWFKminogqgQ/mhrMnQuic7+PY9YFUnM1XX10M7+8uN454UA4CNNq2gK6VlF4OQGbA
         p2d06EGbP08mOXmo6SGyAweYxb/g2obAB506GvOnvWhemanedJ+rd3Lxr8mjv0RoKRHJ
         8z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZfC0wh/eZSwWy+78+FQuouPCOZEwXZdyCSAK1TAJzJg=;
        b=BbG/AnO8bCOaKNd9aQ2HvJFRJltpFrE8Zv5+V4gb0jEF7FvZ+lXShx7amYTJoU6Awn
         1hMgz2xY0Eb1Bb5e0uQGRB9CHEw5jL/2Kbxg9qmwxdnlIkDtV+FuUgTw0xUWzLh2xx26
         TbGbX+YEKfXu4z6z1J6ila4uJh29hL9nBgwYgc0bHXK6U2wcRk7viqLTTNZSbjPF1ZLz
         +Dtj6nr5Bir7MGILAIDjh1b7K/mVlQkPgfvkdoISSfWuN+C7ZtBpDXewGdlOnPMdVgK8
         wydPgU+lqjJX9EURDgp32zboePRrGHk8Npu61ZA7wlzBW1t/Npf1WzpDRt+5evDiM4fE
         4tog==
X-Gm-Message-State: AFeK/H2cqozsysYFtZcU42KI/UPURUBi4SDSnOAlhpiOziIFlmk5zXAJrQM4FxLAIqSL0kQc
X-Received: by 10.36.192.4 with SMTP id u4mr17518249itf.112.1490742584555;
        Tue, 28 Mar 2017 16:09:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:29b8:aa7b:3641:fc6b])
        by smtp.gmail.com with ESMTPSA id f130sm2774957iof.2.2017.03.28.16.09.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Mar 2017 16:09:43 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jrnieder@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule.c: correctly handle nested submodules in is_submodule_modified
Date:   Tue, 28 Mar 2017 16:09:38 -0700
Message-Id: <20170328230938.9887-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.1.438.g67623a8358
In-Reply-To: <20170328230938.9887-1-sbeller@google.com>
References: <20170325003610.15282-1-sbeller@google.com>
 <20170328230938.9887-1-sbeller@google.com>
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
turned into an untracked file on the 'super' level as well.

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

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/git-status.txt |  2 ++
 submodule.c                  | 23 +++++++++++++++++++++--
 t/t3600-rm.sh                |  2 +-
 t/t7506-status-submodule.sh  |  2 +-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 01b457c322..452c6eb875 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -187,6 +187,8 @@ Submodules have more state and instead report
 		m    the submodule has modified content
 		?    the submodule has untracked files
 
+Note that 'm' and '?' are applied recursively, e.g. if a nested submodule
+in a submodule contains an untracked file, this is reported as '?' as well.
 
 If -b is used the short-format status is preceded by a line
 
diff --git a/submodule.c b/submodule.c
index fa21c7bb72..730cc9513a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1078,8 +1078,27 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
 		/* regular untracked files */
 		if (buf.buf[0] == '?')
 			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-		else
-			dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+
+		if (buf.buf[0] == 'u' ||
+		    buf.buf[0] == '1' ||
+		    buf.buf[0] == '2') {
+			/*
+			 * T XY SSSS:
+			 * T = line type, XY = status, SSSS = submodule state
+			 */
+			if (buf.len < 1 + 1 + 2 + 1 + 4)
+				die("BUG: invalid status --porcelain=2 line %s",
+				    buf.buf);
+
+			/* regular unmerged and renamed files */
+			if (buf.buf[5] == 'S' && buf.buf[8] == 'U')
+				/* nested untracked file */
+				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+			if (memcmp(buf.buf + 5, "S..U", 4))
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
index fd057751df..4d6d8f6817 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -346,7 +346,7 @@ test_expect_success 'status with untracked file in nested submodule (porcelain=2
 	git -C super status --porcelain=2 >output &&
 	awk -f suppress_hashes.awk output >output2 &&
 	diff output2 - <<-\EOF
-	1 .M S.M. 160000 160000 160000 HASH HASH sub1
+	1 .M S..U 160000 160000 160000 HASH HASH sub1
 	1 .M S..U 160000 160000 160000 HASH HASH sub2
 	EOF
 '
-- 
2.12.1.438.g67623a8358

