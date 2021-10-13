Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69994C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AEF60E8B
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhJMFUj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237569AbhJMFUi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:20:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F264CC061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:35 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t15so1384629pfl.13
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qfSym00iVBaM1DxV96eOqz2gjEPxdle5KZHz9EqKflw=;
        b=Ii2768tPiCyfCRE9i/jnzDxP2RVDo3dAR/OKAGJNlQwuyUtdyGkMTx/75+2hTkYmY2
         1J0gwA3dSdtJHm+n1WWyMaHkAjdhM+TQuDmRR64I3yV5LhB89y7juhNGos7vRU7epXwI
         +3toCKkwZzS9uaQ4W3cgqc8BLaECGnq4iOp3gpScZhCKKdnSmBQvBZkzkRwN8Jxy35yv
         B0f6dAc/eYNnFgZ80CG8LEekpRRHH8xVa42Do54/O15dYqv2d882iVTSS4PMS6SvjhsM
         o9u5Rwp10bkRm/RPtMrmY0OXiq9XSgCRSRTdB+Kssg/QPyTdbWKTNgi4StNv3N+wTYTr
         DIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qfSym00iVBaM1DxV96eOqz2gjEPxdle5KZHz9EqKflw=;
        b=rFTjFcej4OQAauNBXAEBV7AaRQLkbJBvhacR3KRg9/shFRvVGTFzGtsIT8aI0+iSbw
         OeCj0eIweFNBtgau9SmDrF/JDlYWlITA7APnqxmWBGrkHb3h23w/12XCBzvmkFoO6/ia
         R8H2XYhrYAVMoTwo1MYd/YUR6/8vHElfS7rEWsKhqn7aLGndA8U3xdQ6ic8RXqjDvBMM
         640rlnyDsyS+KKwopqfNr3XT0zaEzrTeE7ScLQhmPwfckqqcyiHJ6QlcpCKWcI/Da31G
         1b0ubnttF0IDToj1U3/00PKXdIivySepEv+ff1qKnIgSSl0rwBIsw2xsz+qaj/FDAFEb
         6PPg==
X-Gm-Message-State: AOAM533spwRFH9iuugLZVj+WmtjfGfQHzyI86i+duZ4Ta2JxRa/T7V51
        S/HTax4JfZG/BxmZX7IZsHg=
X-Google-Smtp-Source: ABdhPJw6CCzkRcEM3/Xy+bkxH290p/8VBBkf/mWc+yz4EbyHEB8Dszepo43sznfp+gp8owllmDS4Cg==
X-Received: by 2002:a63:7010:: with SMTP id l16mr26016614pgc.32.1634102315570;
        Tue, 12 Oct 2021 22:18:35 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:35 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 1/9] submodule--helper: split up ensure_core_worktree()
Date:   Wed, 13 Oct 2021 10:47:57 +0530
Message-Id: <20211013051805.45662-2-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's split up `ensure_core_worktree()` so that we can call it from C
code without needing to deal with command line arguments.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 88ce6be69c..764fcb7dba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2764,17 +2764,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
-static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+static void do_ensure_core_worktree(const char *path)
 {
-	const char *path;
 	const char *cw;
 	struct repository subrepo;
 
-	if (argc != 2)
-		BUG("submodule--helper ensure-core-worktree <path>");
-
-	path = argv[1];
-
 	if (repo_submodule_init(&subrepo, the_repository, path, null_oid()))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
@@ -2794,6 +2788,17 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 		free(abs_path);
 		strbuf_release(&sb);
 	}
+}
+
+static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
+{
+	const char *path;
+
+	if (argc != 2)
+		BUG("submodule--helper ensure-core-worktree <path>");
+
+	path = argv[1];
+	do_ensure_core_worktree(path);
 
 	return 0;
 }
-- 
2.32.0

