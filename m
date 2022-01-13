Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E562CC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiAMApg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiAMAp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:29 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACFCC061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:29 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id y17-20020a170902d65100b0014a17faf0bdso4261565plh.12
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=L6Tsmqm43GD5VaHnod90Rqvlqn5HvPUlg0IA/sWDnUxaGE6oItdfuNr+/owKEMBYYF
         0IyPCuzYRN3lcD2aP7Nr2eNMF0uPp1DI3MrPXGBhWo9epNnyetPXPGnSC+LXq69szSIj
         NgssSsLU7AiZYXD8epFg580HZn5wr+MZljgrnl7cDvquCgZiXMIH4g7Z3GMxF7GScPB7
         9GqvM3tOc43hQfugHgYZTY/tlAtbGtSoBtaffCtPdAArEVrrziflpANoHKDM7yUYadls
         qU1m/GetIuxnQqkgzNvbQmf/uHEjSexirZ0+GdM3IwMg1EsLhWxnxPCCsXsrWSg6wgiX
         tEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=z15nVnvezYPlUX/bUEJIiNp8ooXCTHKzvUCSZPsV/G8vqcFB+cPvx36Cv/3MH5SYAv
         6cRq3UHpOtl8BMgy7CzOAi58I/opCPPQVPufsVgG13CpKNze8d8g49zchiLkB2EpSbRh
         mGOpgowRm9tq3j4SjI9qGwrW9xfhooZf1r5KtWXje2bJVtgrBSJg6jTXYyYxLkK2jmuj
         1/Ij2BheOl/2YpBvntcam9aejNX8OLEF6cvP5mFY3t+Wxk/XSob8MIWLpuG5w7km86Y2
         VENAUFsK3DVXXLPLnewxnf8FF9MRFHAHiNV8W9hrRipPfyUXTL62h1w2RLC2J5cChCGU
         8iJQ==
X-Gm-Message-State: AOAM533qr1b5B0YeTesxByp0EPI+wleBAw7/9j4WaN54o2QJ89cSz2fS
        Rsz5dD2R6J261UzdNt6mKM6ciOMQR4P/WV5V5ngX+zdk640MUYRVaFslcbLE2/xWZX1Oa15mhT6
        GY4x07B5xk1pmffbAeprNlWa+lD5oTuJU1FyWfKMOkpogrArzfMFJPXsJsBE3RII=
X-Google-Smtp-Source: ABdhPJxN49rd8LtIqQYNu3TIEoqosfTd7auO6m70L7P1R5E6/KOTRo8y+JkmM3f6WHKmhRS/7R9iID7stvonkg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:7202:: with SMTP id
 n2mr1909233pgc.254.1642034728610; Wed, 12 Jan 2022 16:45:28 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:45:00 -0800
In-Reply-To: <20220113004501.78822-1-chooglen@google.com>
Message-Id: <20220113004501.78822-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211222001134.28933-1-chooglen@google.com> <20220113004501.78822-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v4 2/3] fetch: skip tasks related to fetching objects
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_fetch() does the following with the assumption that objects are
fetched:

* Run gc
* Write commit graphs (if enabled by fetch.writeCommitGraph=true)

However, neither of these tasks makes sense if objects are not fetched
e.g. `git fetch --negotiate-only` never fetches objects.

Speed up cmd_fetch() by bailing out early if we know for certain that
objects will not be fetched. cmd_fetch() can bail out early whenever
objects are not fetched, but for now this only considers
--negotiate-only.

The same optimization does not apply to `git fetch --dry-run` because
that actually fetches objects; the dry run refers to not updating refs.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 0a625cb137..7bbff5a029 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2152,6 +2152,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
+	/*
+	 * Skip irrelevant tasks because we know objects were not
+	 * fetched.
+	 *
+	 * NEEDSWORK: as a future optimization, we can return early
+	 * whenever objects were not fetched e.g. if we already have all
+	 * of them.
+	 */
+	if (negotiate_only)
+		goto cleanup;
+
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
-- 
2.33.GIT

