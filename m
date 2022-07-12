Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D41C43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbiGLXKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 19:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGLXKb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 19:10:31 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799EC9B1A9
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:30 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id l2so3673683qvt.2
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 16:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYNZgAuTiOavJ/JkYhkf8y8k5mtvvNKydg1YsBBm4zc=;
        b=PL41dNT6JLV/c/PgGGeoyX/HbQxvcdK2c+gLPURKP3Uig+IWwy9HSusr4ZjTc3OL5x
         o6oGFLc4SymiFhFSfQeEEhEy+whtc5iU5R5mlxfcd+ZKNeEGMA0RhDclioD+jfkZCCZb
         T05WnVfAUPfuUDzpxct+Ajcr737B1zWuODnVTCHgJHQm4yYOGeeWHqqLYjCeMnJ4l0np
         vesEwc2tYFl0NKbV2ez6GlQr1RabR22dqqwBTmoV/3RB9gnAC7BLFlbPmhi1YqBMAkhM
         5hIxWA0j/V18P3+Hh6iKekqLMMXzWX6ygPYvzxv7XsZAge1ZUMKi7kLBtDXm/lNxUSWN
         kjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYNZgAuTiOavJ/JkYhkf8y8k5mtvvNKydg1YsBBm4zc=;
        b=re03D2U1ZuzTd3qMNqnoDyOSlXOaCAPFkw/Ic+jB3XVNrg3pfBq8xrfEUZkvpZ9VHN
         RA86+SjAP5J33FYn8QewMf/y3QsnWZtGh16A1asad5T5iQpHqRd8IpfwUu+OQ7VwoUDg
         SV/uMAOg2e2tSkWBhV6FCrMS2u7szqf1p9I3aMQAU31E2UO+CK9dxnL3YsW/GRROqvwF
         kKbuv5olUtiTDtr4Dx27DVsfxL6uzs+CWmmqvHOKsLxeP4dRqGg/L87m2GOpj/SRH9Zd
         QrKKh2RrJ1blSf7nDpcymWJkUK3YJDV483lQBZzZC4Dve6Q2k6QjxLZMSAGM64LyghhR
         T0BA==
X-Gm-Message-State: AJIora+Gum2yxdrg2Fu3laQEl97bItQ5Xzm8MXDGKeyi8/qBCxA/Yx2b
        nq1ZfFzfGSJowV7Cjx0Mn5Bd7rfHGcfcjg==
X-Google-Smtp-Source: AGRyM1tbUYaD3CRhRQAzbjun4gSomXP3vr6tStaabyF6EE6WXhHfr3vycJm3elnGZ8pHwv2uUDBmWQ==
X-Received: by 2002:a05:6214:2302:b0:470:2d10:b6e4 with SMTP id gc2-20020a056214230200b004702d10b6e4mr656074qvb.72.1657667429493;
        Tue, 12 Jul 2022 16:10:29 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m3-20020a05620a24c300b006b53fe19c41sm10798902qkn.14.2022.07.12.16.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 16:10:29 -0700 (PDT)
Date:   Tue, 12 Jul 2022 19:10:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com, peff@peff.net,
        ps@pks.im, wfc@wfchandler.org
Subject: [PATCH 1/3] t5318: demonstrate commit-graph generation v2 corruption
Message-ID: <0a49c86037bac200bb23e1abf9f67363e99c4b7c.1657667404.git.me@ttaylorr.com>
References: <cover.1657667404.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1657667404.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When upgrading a commit-graph using generation v1 to one using
generation v2, it is possible to force Git into a corrupt state where it
(incorrectly) believes that a GDO2 chunk is necessary, *after* deciding
not to write one.

This makes subsequent reads using the commit-graph produce the following
error message:

    fatal: commit-graph requires overflow generation data but has none

Demonstrate this bug by increasing our test coverage to include a
minimal example of upgrading a commit-graph from generation v1 to v2.
The only notable components of this test are:

  - The committer date of the commit is chosen carefully so that the
    offset underflows when computed using a v1 generation number, but
    would not overflow when using v2 generation numbers.

  - The upgrade to generation number v2 must read in the v1 generation
    numbers, which we can do by passing `--changed-paths`, which will
    force the commit-graph internals to call `fill_commit_graph_info()`.

A future patch will squash this bug.

Reported-by: Jeff King <peff@peff.net>
Reproduced-by: Will Chandler <wfc@wfchandler.org>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index fbf0d64578..4d9f62f22d 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -811,4 +811,31 @@ test_expect_success 'set up and verify repo with generation data overflow chunk'
 
 graph_git_behavior 'generation data overflow chunk repo' repo left right
 
+test_expect_failure 'overflow during generation version upgrade' '
+	git init overflow-v2-upgrade &&
+	(
+		cd overflow-v2-upgrade &&
+
+		# This commit will have a date at two seconds past the Epoch,
+		# and a (v1) generation number of 1, since it is a root commit.
+		#
+		# The offset will then be computed as 2-1, which will underflow
+		# to 2^31, which is greater than the v2 offset small limit of
+		# 2^31-1.
+		#
+		# This is sufficient to need a large offset table for the v2
+		# generation numbers.
+		test_commit --date "@2 +0000" base &&
+		git repack -d &&
+
+		# Test that upgrading from generation v1 to v2 correctly
+		# produces the overflow table.
+		git -c commitGraph.generationVersion=1 commit-graph write &&
+		git -c commitGraph.generationVersion=2 commit-graph write \
+			--changed-paths &&
+
+		git rev-list --all
+	)
+'
+
 test_done
-- 
2.37.0.1.g1379af2e9d

