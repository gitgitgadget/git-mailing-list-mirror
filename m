Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F0BC004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 22:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjASWWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 17:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjASWVg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 17:21:36 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3087A4B4A5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:06:20 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id e184-20020a6369c1000000b0049de6cfcc40so1604108pgc.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 14:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DhMNmkuPrG3pJMubkyUVu+MpAAv07MNEdsuXrxZzDZg=;
        b=mP8rzvca+Hy5of4kteevEZvnSO3XA8OFCPI+VRfndi6s68saKVPCcKDH5FLKrOxOAz
         W1UAqPiI2of3LzuLaQJXqlfrQz5SJXqUOVB68fqkNu+BvVXGthz5R169/Ony7myOBEn2
         ovRZVuyjTVHSaXqDO1pEvXpJcq3k2dA/XZiO+5yv9nfQZsNWxhb1R6Qj6D73ddh6UZoR
         AsM3qDHLw1FnxA9Ej9tsJPsIEyYukzCIPGyONdzdArBLTqHjMs+CUbmZ/qm1enw3UoyL
         fw+7Cyr8vhJhYedvAfSZxYI8/RVCKjgzbKW4iOiDx3ki/oYyZ0gYNbMDQ1af0e8fZqC6
         M6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DhMNmkuPrG3pJMubkyUVu+MpAAv07MNEdsuXrxZzDZg=;
        b=hHeTebJpG9vStWgFyUYb/Nm8Xs6ci5BG+woJZq2cbMxqCkqWQ0quopNmVhFni529Je
         vDGJKMbV7ToiEwpW9L6r7rXOqcjzyf64nyDd/yu9KL1oBiG6My3BFdAVt+UgJYBQrzux
         ZWH5hdVgGMA5HPqeYf/ArnOvMUOGohPUPcUxOkutg2JTzZ3R/u4f+p5AsvC+iGxfxGWG
         Q8gCEJrXUNnp7PO413b88TDk1nk2FNTdDxFuqUNr8LJ57FIjbKSqt9xPIB9aONT9++/g
         /yRNw30kG2JRwVmJ2u9SqCTpPBj6CiPZzEEOKSWeb2oKCGqYGQBYIuKhQee8RnDMvYeJ
         8XBg==
X-Gm-Message-State: AFqh2kpz4e19En9qgMHjHyZ97C/GIRf6jv+cULF4fje5rY0CIDU2LIvB
        ejQQsfLlEufbr8yk83oJazCuZlt2nv3GZazcDOLp9gMIe8oAxZWUi9MeDgeMEkCiNeqpyF9mgBJ
        4VX7W0U1LfYtGATweGO2bEB2KFOBwFxjJBrpuNFp5nvPGvCBG9Py6XLOONHoBKYSjIg==
X-Google-Smtp-Source: AMrXdXs9zvNq0ZzH9GHmdzr+tAJ2RlPgNJvkr/LiONxrsTXYv+C7m28KVKh82D2fU+ksSRPW4zzbkby6P71BZ0U=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:aa7:850f:0:b0:58d:acfe:7c34 with SMTP id
 v15-20020aa7850f000000b0058dacfe7c34mr1132408pfn.39.1674165979649; Thu, 19
 Jan 2023 14:06:19 -0800 (PST)
Date:   Thu, 19 Jan 2023 22:05:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119220538.1522464-1-calvinwan@google.com>
Subject: [PATCH] fetch: fix duplicate remote parallel fetch bug
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fetching in parallel from a remote group with a duplicated remote results
in the following:

error: cannot lock ref '<ref>': is at <oid> but expected <oid>

This doesn't happen in serial since fetching from the same remote that
has already been fetched from is a noop. Therefore, remove any duplicated
remotes after remote groups are parsed.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 builtin/fetch.c          | 1 +
 t/t5506-remote-groups.sh | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b06e454cbd..508ab2670c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2225,6 +2225,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			argv++;
 		}
 	}
+	string_list_remove_duplicates(&list, 0);
 
 	if (negotiate_only) {
 		struct oidset acked_commits = OIDSET_INIT;
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index 5bac03ede8..0e176175a3 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -99,4 +99,13 @@ test_expect_success 'updating remote name updates that remote' '
 	! repo_fetched two
 '
 
+test_expect_success 'updating group in parallel with a duplicate remote does not fail (fetch)' '
+	mark fetch-group-duplicate &&
+	update_repo one &&
+	git config --add remotes.duplicate one &&
+	git config --add remotes.duplicate one &&
+	git -c fetch.parallel=2 remote update duplicate &&
+	repo_fetched one
+'
+
 test_done
-- 
2.39.0.246.g2a6d74b583-goog

