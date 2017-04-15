Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A7CD20D09
	for <e@80x24.org>; Sat, 15 Apr 2017 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753746AbdDOKjg (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 06:39:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35568 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753088AbdDOKjb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 06:39:31 -0400
Received: by mail-wr0-f194.google.com with SMTP id l44so14917409wrc.2
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ocTb+NQQNDTbQ6gVm22oAzm7QFjhndLhiqBn6GM9yc8=;
        b=dX+Vh402XdP2J/Gv2EF/omtSo8cc4P5+v4xitOrC5G/qeCtLpXU+DP27kkYZmZokTA
         H1ZQxatwQnbImYE+8m78sWg/nM7QZe1HfWyoMzchhMRo4VlHZf6fz3uYpwqxFJWJ6VK7
         eNHVuE0Cfn9SzwbDGps2d2VHS3k0paRWfXAGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ocTb+NQQNDTbQ6gVm22oAzm7QFjhndLhiqBn6GM9yc8=;
        b=k3sYcTMSejnjn4XOSNc/ftPsm6M+dH3+7DSBHXopTraPWgPcADJNpKUc4Uhte4PWAt
         aQRLZgxnSkpT2Xadm2ELBVCbwaQtjyxui3m/givp/JT7S3c5KO+iL06D8De3p6ODdFLg
         +R9S5Ow9CcnzpMG2rQeqlxRGdZ18uQQbXupnRqkCGZ4B8ywfbc0nVkZ9Njr4SJ5de65q
         /W2etTrcu0ohVPhjIpRC4UMKJW3/y5++0+JIci6djDWa2aM+BdCU/cUSyaIxqhduNLcb
         ZY2J0tm8eVmOnxCFPzH5Izr2/XTbUg0Wh0ZFhRXe/QgxkitUFfKFHgQ63A5JLWtG31lY
         szZA==
X-Gm-Message-State: AN3rC/5IB4k4kWUSJARCB0hkJDK0CrKbCXZzQ/KToMh81tGZ57vwJyDP
        6Q0rNBc4eRi+AA==
X-Received: by 10.223.145.49 with SMTP id j46mr10454349wrj.2.1492252770081;
        Sat, 15 Apr 2017 03:39:30 -0700 (PDT)
Received: from ldiamand-t3610.corp.roku ([81.145.207.254])
        by smtp.gmail.com with ESMTPSA id y63sm2072774wme.31.2017.04.15.03.39.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 15 Apr 2017 03:39:29 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Sam Hocevar <sam@hocevar.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCH 3/3] git-p4: don't use name-rev to get current branch
Date:   Sat, 15 Apr 2017 11:36:09 +0100
Message-Id: <20170415103609.6002-4-luke@diamand.org>
X-Mailer: git-send-email 2.12.2.719.gcbd162c
In-Reply-To: <20170415103609.6002-1-luke@diamand.org>
References: <20170415103609.6002-1-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 was using "git name-rev" to find out the current branch.

That is not safe, since if multiple branches or tags point at
the same revision, the result obtained might not be what is
expected.

Instead use "git symbolic-ref".

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py                | 7 +------
 t/t9807-git-p4-submit.sh | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 584b81775..8d151da91 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -602,12 +602,7 @@ def p4Where(depotPath):
     return clientPath
 
 def currentGitBranch():
-    retcode = system(["git", "symbolic-ref", "-q", "HEAD"], ignore_error=True)
-    if retcode != 0:
-        # on a detached head
-        return None
-    else:
-        return read_pipe(["git", "name-rev", "HEAD"]).split(" ")[1].strip()
+    return read_pipe_text(["git", "symbolic-ref", "--short", "-q", "HEAD"])
 
 def isValidGitDir(path):
     return git_dir(path) != None
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index ae05816e0..3457d5db6 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -139,7 +139,7 @@ test_expect_success 'submit with master branch name from argv' '
 	)
 '
 
-test_expect_failure 'allow submit from branch with same revision but different name' '
+test_expect_success 'allow submit from branch with same revision but different name' '
 	test_when_finished cleanup_git &&
 	git p4 clone --dest="$git" //depot &&
 	(
-- 
2.12.2.719.gcbd162c

