Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F1AC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhLIFPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhLIFPo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:15:44 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27ECC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:12:11 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id w4so4247508ilv.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dG2oC2hAMnM8Vv/C9ymF93xZ/cNTakzKzjTvTjl/HkA=;
        b=H679TtiGWIvJQqsvmNRxzYtMv2Klq1dEDLvZWt6Iy0A/OrEqBOUMaOqgG1dr518g2D
         b2ul3klB9CmsMaeoo0tvWYQJwaKgnCga9KEiDz7G7sM3HiCxtSWjrzUtiJo9eT9W/ZI0
         1aUqXg3zchEYVeGI8X41LYrIlEnhK8+eGKNv8Rih2y5a7xmwhsTC5qgd7hem+lSkHuiO
         tKc1qMQj5b7gpQZPw61acCHptwJj6Qz/A3A5glxjnLtrrERlI4dJZpiV32VjQ7/tw1BY
         cWO/b1emSyYiFAB7SJTN4OIGpC7mDVQA1n4sUHc+8px5GBq3jANTunO49k9+XDbpPwXC
         tO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dG2oC2hAMnM8Vv/C9ymF93xZ/cNTakzKzjTvTjl/HkA=;
        b=UxXielPqKkB3nq6PZFxPIVBERj97xKrjSDBVqJYS5WT2G++k3KbNX8fmVOtEIvwNg6
         ruylcQzoZ+ABUKP2zmsKoCQNqhmyBx5FjJp3Mzp6pxlwoPdh3MINwUiMwbpsh5+bwBBB
         J4j6oiQbtWVZ4IN6AVl/1ii4xbHH8rm8pBW+ZssNpN9UrMkUvYVHq8OMeAA1UfW3r2pp
         Rje3s417mHFKR3DGkM/nmGLgJ/KR4SNjmu2opn5zGvOVH4KHtJ8vro3ludfw9rcf2Ghf
         xYgcddT1hsqT9HKzNe1uaKQg6CM5fMrW2kUkI+3FifvYzEJASu8NnG5F+Dd0t3YVEmMl
         edqQ==
X-Gm-Message-State: AOAM533h/74jlGes0uBSZvEiS6CKxs7zIrRxL/wR1lk1QNtUMZacm9wx
        1VdRbHAtHkD6cPn3AkCcHFFpCW8c8UeOIg==
X-Google-Smtp-Source: ABdhPJzRsKqDdiZKXmFIXi/U+gvs3kjOU5NkOsishOzy6JUOyamMPTAsYCNOQFagjWIz7a8fMBsbRA==
X-Received: by 2002:a05:6e02:f0f:: with SMTP id x15mr12811600ilj.26.1639026730629;
        Wed, 08 Dec 2021 21:12:10 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id b8sm3127401iow.2.2021.12.08.21.12.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Dec 2021 21:12:10 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <ericsunshine@gmail.com>
Subject: [PATCH 03/19] t1020: avoid aborting entire test script when one test fails
Date:   Thu,  9 Dec 2021 00:10:59 -0500
Message-Id: <20211209051115.52629-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd
In-Reply-To: <20211209051115.52629-1-sunshine@sunshineco.com>
References: <20211209051115.52629-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Although `exit 1` is the proper way to signal a test failure from within
a subshell, its use outside any subshell should be avoided since it
aborts the entire script rather than aborting only the failed test.
Instead, a simple `return 1` is the proper idiom for signaling failure
outside a subshell since it aborts only the test in question, not the
entire script.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t1020-subdirectory.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index c2df75e495..da19c06fb5 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -22,7 +22,7 @@ test_expect_success 'update-index and ls-files' '
 	git update-index --add one &&
 	case "$(git ls-files)" in
 	one) echo pass one ;;
-	*) echo bad one; exit 1 ;;
+	*) echo bad one; return 1 ;;
 	esac &&
 	(
 		cd dir &&
@@ -34,7 +34,7 @@ test_expect_success 'update-index and ls-files' '
 	) &&
 	case "$(git ls-files)" in
 	dir/two"$LF"one) echo pass both ;;
-	*) echo bad; exit 1 ;;
+	*) echo bad; return 1 ;;
 	esac
 '
 
@@ -57,7 +57,7 @@ test_expect_success 'diff-files' '
 	echo d >>dir/two &&
 	case "$(git diff-files --name-only)" in
 	dir/two"$LF"one) echo pass top ;;
-	*) echo bad top; exit 1 ;;
+	*) echo bad top; return 1 ;;
 	esac &&
 	# diff should not omit leading paths
 	(
-- 
2.34.1.307.g9b7440fafd

