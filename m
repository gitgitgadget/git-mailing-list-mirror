Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50F5C64EC4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 16:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCCQ1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 11:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCCQ1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 11:27:42 -0500
X-Greylist: delayed 1468 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Mar 2023 08:27:40 PST
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739591A95B
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=8/xyTECt4B6SFDq0noA/oyuftEFllsYhfQ9kQzU7egc=; b=Lf
        L7NrEdUbhhYuUxKlQiMYVutCf8DqxyC1i5ldLXu8Cw6NvhKcjxllqdojGmyT5ux3MlxzffrqQTvfE
        MUm06Ukc5WjOok21tvnDy3D3CoSyHvb7DbFm5KxAEqO/RL7cnsLZG6RXwjw8JbB7+fdyaVZHwtUvD
        Kb0DFNCEkMrFDLXJxOU/NPbGh7aNQkAWG82JEq+2jh3vEylq59aZpUvWYnCzhBBfIv8C9DqDm/9F9
        Dg4s9hvcySIPKGpRNIOgEHqdK51qEMuA6Lo2tHU/whEna72XOfw97loIV3G9vuVdBnaL02dQ5g7ON
        GvH9YwNIa2mFoWyI+ycq9a5zp1gsTYww==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@keeping.me.uk>)
        id 1pY7sD-0002Gx-Ib;
        Fri, 03 Mar 2023 16:03:09 +0000
From:   John Keeping <john@keeping.me.uk>
To:     git@vger.kernel.org
Cc:     John Keeping <john@keeping.me.uk>
Subject: [PATCH] format-patch: output header for empty commits
Date:   Fri,  3 Mar 2023 16:03:01 +0000
Message-Id: <20230303160301.3659328-1-john@keeping.me.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When formatting an empty commit, it is surprising that a totally empty
file is generated.  Set the flag to always print the header, matching
the behaviour of git-log.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 builtin/log.c           |  1 +
 t/t4014-format-patch.sh | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index a70fba198f..87b4fb2edc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2097,6 +2097,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	/* Always generate a patch */
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+	rev.always_show_header = 1;
 
 	rev.zero_commit = zero_commit;
 	rev.patch_name_max = fmt_patch_name_max;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f3313b8c58..ffc7c60680 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -59,6 +59,10 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m "patchid 3" &&
 
+	git checkout -b empty main &&
+	test_tick &&
+	git commit --allow-empty -m "empty commit" &&
+
 	git checkout main
 '
 
@@ -128,6 +132,12 @@ test_expect_success 'replay did not screw up the log message' '
 	grep "^Side .* with .* backslash-n" actual
 '
 
+test_expect_success 'format-patch empty commit' '
+	git format-patch --stdout main..empty >empty &&
+	grep "^From " empty >from &&
+	test_line_count = 1 from
+'
+
 test_expect_success 'extra headers' '
 	git config format.headers "To: R E Cipient <rcipient@example.com>
 " &&
-- 
2.39.2

