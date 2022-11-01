Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24CDC4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiKAUcW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKAUcV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:32:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3971C139
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:32:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h206so9898211iof.10
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GnSr5ypPntbKCJVsaAl0KWqWlSLe2Wn+43mVc1T0uWQ=;
        b=DGgt5pEJVi+TQF/d58UOjJGeFO6AlCVy3YA6UEt3DNAi8IG8YZ9MgA0XC+ptOaW/eA
         guOLW3+ST2LaMCoj6rQSCh/wb+j7JWoccxZl6B4MeKm4RsLBlehNzhRxOLUqhK5Dtt8u
         IWelSy9Wp9ijX+aTg1NexQzBxKEMZve5OF5wcVzon9RMdB+KIDjldpqYPjilDlaQp/ig
         HiiYDsibyPHz/SxLBAFXq3Ise3QoWqezSdH0032xWF1B/oU3yoZTJkBgrFsSmW23Vt3x
         MjM0IdukQk2AusF8GvfthcPBreedaEQ+8//fDFbjr4w8TdPOuIKbuipNFZZOduxzC9xz
         L18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnSr5ypPntbKCJVsaAl0KWqWlSLe2Wn+43mVc1T0uWQ=;
        b=Gdi3n+gvqyvX67hCVPfQ8APFKu0XFEnGjB6OmEewU4/VGfgPhbctncwrumGmk9BqUD
         lzpJW3AR2+vK+2NbHy1pi2MoAeCd4GGeKL/x4AMk2e4yM1Y3SKuOET2ee/s2X/tKK60w
         E1grT+vwfMn3G9ZfG8B11cdoXiwvNROVFA0dXu98fSQGCLhXSlRtnDdfwlcU/ekj2JIy
         AopGPl6wrNZzIuI0tlnHmXgUjXIHox32NM/2gFVbKFU6loTvgEz1oopL7s8K7qhTRK5P
         OG3xUxqkCHi8J9S2PUYKexj+nBz6ix/w4/dP+9VWd9nePJIzs38tuuSK94avRq9DenV+
         1n3g==
X-Gm-Message-State: ACrzQf09EiliE4IdS34KkK6Fjn8OVrfPc9pBGT2Jhg2P5bI7ZcM7iJJ0
        6E+pNQ+zoNfb0RwByQnR/9X7Nn9YzheZZ1ux
X-Google-Smtp-Source: AMsMyM7X5IOex20rfCPNkc49UNbD8Pl08wmffTBAA4dqEFRqWhhjFT9DPi0whkTf7qvIOei4DuWBhw==
X-Received: by 2002:a02:cb02:0:b0:375:4e64:117 with SMTP id j2-20020a02cb02000000b003754e640117mr10727812jap.256.1667334739829;
        Tue, 01 Nov 2022 13:32:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a25-20020a027359000000b00365d1d1cc58sm4101731jae.118.2022.11.01.13.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:32:19 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:32:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Martin von Zweigbergk <martinvonz@google.com>
Subject: [PATCH] branch: gracefully handle '-d' on detached HEAD
Message-ID: <c68f4b140f2495a35c5f30bec4e2e56c246160f4.1667334672.git.me@ttaylorr.com>
References: <Y2F9lkCWf/2rjT2E@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2F9lkCWf/2rjT2E@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Since 67affd5173 (git-branch -D: make it work even when on a
yet-to-be-born branch, 2006-11-24), 'git branch -d' refuses to work when
orphaned, since there is no HEAD to resolve.

But since 67affd5173, there have been other checks, like 99c419c915
(branch -d: base the "already-merged" safety on the branch it merges
with, 2009-12-29), which makes it OK to delete a branch if it is merged
to HEAD or its upstream.

99c419c915 makes the check in 67affd5173 wrong, since it's OK to delete
a branch if it is merged to its upstream.

Since the code in delete_branches() tolerates a NULL head_rev perfectly
fine, make it non-fatal to fail to resolve a commit object at HEAD.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
OK, here's that patch. Since Peff wrote the main portion of it, he gets
authorship credit. My version comes with a test, which we should
consider picking up.

Even though it doesn't resolve Martin's original scenario (i.e., he'd
still have to use -D or -f to actually delete 'main' there), I still
think the bugfix is worth pursuing in its own right.

 builtin/branch.c  | 5 +----
 t/t3200-branch.sh | 7 +++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 15be0c03ef..f6ff9084c8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -235,11 +235,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	branch_name_pos = strcspn(fmt, "%");

-	if (!force) {
+	if (!force)
 		head_rev = lookup_commit_reference(the_repository, &head_oid);
-		if (!head_rev)
-			die(_("Couldn't look up commit object for HEAD"));
-	}

 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b..464d3f610b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,13 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '

+test_expect_success 'git branch -d on detached HEAD' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	test_must_fail git branch -d main 2>err &&
+	grep "not fully merged" err
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	git rev-parse --verify refs/heads/t &&
--
2.38.0.16.g393fd4c6db
