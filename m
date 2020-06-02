Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528EFC433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 20:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23275206E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 20:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="SgKwHAfE";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="fkZHIKbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgFBUt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:49:29 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:35944 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgFBUt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 16:49:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id AE57C4059C
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1591130966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=B8rE9makJsYDLjH52S88t3a5/rl6xwPnmxm/cT4N6Lo=;
        b=SgKwHAfES4fsRwe64KyGXqVJxqmZGwxaZVPjqwKXgkYvFQgxO0SRBZFf9J6mOuvIM+mcMQ
        sE89KAHhtAFwlrPWQMndriKCCNDdHMwFX/H+K6Y/CbRU40uo67DawdszSub2tRf5z+mbW1
        aUuzkj0AkvRLWuq8glYmeU+rBrXYjhA=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id 2F6CB3FD48
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1591130965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=B8rE9makJsYDLjH52S88t3a5/rl6xwPnmxm/cT4N6Lo=;
        b=fkZHIKbh6mYRnwvbg3HLhCOQtDfv59Gg07glkR4xjtNZdmo95zzjEWrE2GaeUbC0R3akqt
        JoCpJaLDikyL1H61KHT4/iyvAqsLZbYynh+OqDplIT2UTkgtMIx36Pl7xfYv0OrZsDltBu
        f8RF1dC8chS/zCdSfNIDrCeotUJG5yo=
Date:   Tue, 2 Jun 2020 22:49:24 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     git@vger.kernel.org
Subject: [PATCH] format-patch: generate valid patch with diff.noprefix config
Message-ID: <20200602204924.GA1853335@spk-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With diff.noprefix enabled the patch generated with format-patch does not
include prefix a/ and b/ so not applicable with `git am`.
Solution is to force a_prefix and b_prefix on diffopt.

Signed-off-by: Laurent Arnoud <laurent@spkdev.net>
---
 builtin/log.c           | 2 ++
 t/t4014-format-patch.sh | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index d104d5c688..ca63f8ceda 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1744,6 +1744,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
+	rev.diffopt.a_prefix = "a/";
+	rev.diffopt.b_prefix = "b/";
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index db7e733af9..5d7930e106 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1602,6 +1602,14 @@ test_expect_success 'format patch ignores color.ui' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format patch ignores diff.noprefix' '
+	test_unconfig diff.noprefix &&
+	git format-patch --stdout -1 >expect &&
+	test_config diff.noprefix true &&
+	git format-patch --stdout -1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'cover letter with invalid --cover-from-description and config' '
 	test_config branch.rebuild-1.description "config subject
 
-- 
2.27.0.rc2.129.g29f2dd231a
