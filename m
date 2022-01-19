Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F2C433EF
	for <git@archiver.kernel.org>; Wed, 19 Jan 2022 00:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350331AbiASABK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 19:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350326AbiASABJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 19:01:09 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D023BC06173E
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id c72-20020a621c4b000000b004c33fe0a79dso513370pfc.21
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 16:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=L8lK1D1YgCeWjW2b1QdMkN6K/aDS0t5PU6zU6ORBcJLKftYF7Tzy9QiFP0gn5Go6vW
         8zkeqcLgCnY2vuJeweLsF0Qo9t9fAuUySHf7D+0xeIHr+o8eePRVXGPIcyqRSOwrjjex
         Cp5nGY3XLre3ZDt9oEirULoEw15nmNYDohGgdWxTOPyim9xyyWiL7Fw5SmXEucF4rf8b
         bxHndf3nfN3lP02D6WtZ5K1aL5XmzZ2lt086Sdwv7l6o2HBG+IoLRrihYXfxnosBzHqT
         nJ3lA6NagE1CNQ/IJ42rky1rNrXH0yzZRySAqF7AwAP8q7OvAsRJ2KMfBwZZN2QsbVXL
         hVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kBbByrNFRfyeFLe4U8KRGl9oHeldlad0vXOAejrxrTo=;
        b=JCnD2zcTw5PZ9+BT1CO99uQr/VvwjYVcTUtrDwW/dOObVfxKltRbmbmfqHmC5o19mi
         fkbugRMs0awan8e55PFI4FcRiErtTZGHZGoRnR3/DNz3cCxvb4RODfQhp3Pn0Jp1v6YX
         E6hyRmWqRIwr6r5KOmJhvfonoZBpPObY6dds+xGcDN1+SXaqBdnu9+p6jVKMxbEO75+0
         c7M8q/6czkQK+HfuImAMWjzK0m57/RQQW5Uw9NtUxPKidBCKK3PLgyT9TKK4XZc4MJpo
         6MTAsGm3pm6JE3RuxDaZRczfY+53lMg6KApSvjHBUcKvn/rSiyJZMgOSrYyVp73TklIP
         rcOg==
X-Gm-Message-State: AOAM531dr9gRE/KnN5mpRqhaDyHjvTNx3O6LbgjAJS2u7pldUib10qv4
        VnCZn//pLtw8cBV4QmrP2E7E8diJXDI2TCY5DIyAC1r4PAmxsjs2sIIk+4ubBJnO7AG79f4eU/A
        bLHUXyfPsceoab/p3BxqoUg26UQb/EZmXvqn9JovELskKlaEAiAlPT7ultOmdz6Y=
X-Google-Smtp-Source: ABdhPJxeHXbrlo4V79kcBhXfKe2AWV06/45dmdnpy3se6b7hiDxv4lB4x5+0bEp49fEq4Y0Y6dcDg0DVXoZAwA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:410a:: with SMTP id
 u10mr241879pjf.1.1642550468701; Tue, 18 Jan 2022 16:01:08 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:00:55 -0800
In-Reply-To: <20220119000056.58503-1-chooglen@google.com>
Message-Id: <20220119000056.58503-3-chooglen@google.com>
Mime-Version: 1.0
References: <20220118185453.33710-1-chooglen@google.com> <20220119000056.58503-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v6 2/3] fetch: skip tasks related to fetching objects
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

