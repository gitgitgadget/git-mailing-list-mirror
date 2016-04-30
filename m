From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v15 7/7] t/t7507: tests for broken behavior of status
Date: Sun,  1 May 2016 01:33:36 +0530
Message-ID: <1462046616-2582-7-git-send-email-pranit.bauva@gmail.com>
References: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 22:04:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awb8B-0001FU-Fw
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 22:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbcD3UEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2016 16:04:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34725 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752455AbcD3UEn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Apr 2016 16:04:43 -0400
Received: by mail-pf0-f195.google.com with SMTP id 145so15365669pfz.1
        for <git@vger.kernel.org>; Sat, 30 Apr 2016 13:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hsxf1mHwOV35GoLJ1lU8kH/+CTOCKN+cQzCTMA5Y72U=;
        b=ifGLSwS5Epe2xdNCv4X0Ch7kKAWknxn5McPQcyHZYqafidRKhSRFxwIoBHn6BsqVZV
         Rw61f155UKv9tw7yEWslfcPf0kfsKSbOJDrTpc6mcpUmkdeyhCukiEnqxU8ZGy4pS/uq
         yKQD12u+b9HN161hJKOASxrHd20Zi6/CvjfSr3LyK2DnYobOoISOZ+1NpU69dBeOaG2y
         zOBFuOnTbcSbRmc/6p26L1u8D3umcrzDzx8nzVLlVHvjxd0xJwx/nkbc7ErnplVjN40X
         A7+/bhapgEcPTcUnFo4IoCGQdIEh/l7tWyn7T2/dvfT3XLhmbve9hUMpEGAntERPq/9/
         L19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hsxf1mHwOV35GoLJ1lU8kH/+CTOCKN+cQzCTMA5Y72U=;
        b=ADkOf1iGuNsPj8P8ehJjQ93E6BwYV2hvmrQ2mVemhFxxKSLMk/tsgK+DYP4GYB7GsB
         cTTYxcWFnHyvP8wUbP/NPuv/TTAM533wrBR+6qhEsnOfsjONk/2byrMZrXc3T+gYXzyf
         wPXN9BwjWapnskpLVhGeuV9yZmfswqb9mAT130FbWsE457Ux6OOQ6cezJWuEADXTUBVM
         ST6+5ltDZiREbL6RiKN44cvn69aPN2pdyjjJqHYpv6gxCMoeLRdLBDRmtRmVw1IAOnHW
         +yoJH/WuYv+rDuuS6+CuXl5Nqn/p2o+KdShkluOp/fDS3tMFg7FaD3uaY/K8uk9TXFSe
         Nm/Q==
X-Gm-Message-State: AOPr4FV0JEveyhaFNjcV+7j1h8wdLKv47KhKYcDuhqaM2gSO9icztmyIrrYlRxEon/5KPw==
X-Received: by 10.98.52.195 with SMTP id b186mr39300543pfa.9.1462046682361;
        Sat, 30 Apr 2016 13:04:42 -0700 (PDT)
Received: from localhost.localdomain ([27.106.101.191])
        by smtp.gmail.com with ESMTPSA id h85sm33329025pfj.52.2016.04.30.13.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Apr 2016 13:04:41 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462046616-2582-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293133>

Variable named 'verbose' in builtin/commit.c is consumed by git-status
and git-commit so if a new verbose related behavior is introduced in
git-commit, then it should not affect the behavior of git-status.

One previous commit (title: commit: add a commit.verbose config
variable) introduced a new config variable named commit.verbose,
so care should be taken that it would not affect the behavior of
status.

Another previous commit (title: "parse-options.c: make OPTION_COUNTUP
respect "unspecified" values") changes the initial value of verbose
from 0 to -1. This can cause git-status to display a verbose output even
when it isn't supposed to.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
This is a split off from the previous patch 6/6 as suggested by Eric
Sunshine.

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 t/t7507-commit-verbose.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index 2bb6d8d..00e0c3d 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -144,4 +144,14 @@ do
 	"
 done
 
+test_expect_success 'status ignores commit.verbose=true' '
+	git -c commit.verbose=true status >actual &&
+	! grep "^diff --git" actual
+'
+
+test_expect_success 'status does not verbose without --verbose' '
+	git status >actual &&
+	! grep "^diff --git" actual
+'
+
 test_done
-- 
2.8.1
