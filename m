Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5CBC43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 05:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiFXF2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiFXF2r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 01:28:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D5B63610
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:28:46 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso1761128pjh.4
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIZwaynDR8kedmi5MHOA7J5a7J547EsUi+lKhglp4uU=;
        b=1xvk+p2Ctf12AA9ZPIiJwGdg0m3QnZloCLolpnAx5rgJj+JEWAANM5YygHpSjOJMis
         j8KejizbkPXMKcl3022hr1JZViYLVlpHKu5YUjKQomuWGI4EEJrm4w+GTrCIUwVAaXK2
         RNV8jdPLjeAloYEdaH/K/V5vYHzQdVmzlAklq5mV+srWG7UZSVkJkW57N4TZUoDpD/WX
         HZinqIozutF+nZR919tj+cm2Iti5FLOU55aFJYEOvQm/Pnzbw/ybHhwpa3eAAfVE5aV2
         838h5OU2pZUPXWHVM10NMozlHbT8hakgIS3wNmsl3tXjbD1rUG0bke5nWzAqHh/Cehnz
         Gj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIZwaynDR8kedmi5MHOA7J5a7J547EsUi+lKhglp4uU=;
        b=PQaceOLHI7lcubzYqxVdt5YNeCLjxcAMbmT756FqYOl1ELxr5WNQVRcRl+PkjDy4WJ
         vfiX1giS/zU3LTRZKNot78zhXRVTzCj7FiPt9H+tssKwLj4sN99sa8yXNvWxa2ofiKnV
         AWo+xd4d0GvPKazor89xKjyfb27b2BfmfxYXL5LZ4q7OMKVXMzMCf0OukdHk4DgyK01T
         urjh92SlvNyZL5kcio0z/8yCZPdgYAKkbt8c26Ikq4A1NJtH0/edTwXs9oAbuQEizn6I
         dOApGOqLJV9o6u5ey+vgAwx4ePleynMefd3qfvcc0uKKIL9rpwwz5iEwwyO5Ss1Zu8Lc
         3dQA==
X-Gm-Message-State: AJIora/rXi1laBcn7oEbhtVmuKnoph4cu47j4W2/SFizgU+Jnq5JGQra
        50cbdvDqB20y5CLPvlvsp5URfg==
X-Google-Smtp-Source: AGRyM1sdidVXzaSAKogYDsRMm+DgLeCPih6RL2lLID4Dofh//fBIaI4q7SrEe25nivst70ojLfqJ3g==
X-Received: by 2002:a17:903:1cf:b0:16a:605a:d58a with SMTP id e15-20020a17090301cf00b0016a605ad58amr4708562plh.37.1656048525880;
        Thu, 23 Jun 2022 22:28:45 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id s144-20020a632c96000000b003c265b7d4f6sm602960pgs.44.2022.06.23.22.28.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jun 2022 22:28:45 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: [PATCH v2 0/2] commit-graph.c: no lazy fetch in lookup_commit_in_graph()
Date:   Fri, 24 Jun 2022 13:27:55 +0800
Message-Id: <cover.1656044659.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220618030130.36419-1-hanxin.hx@bytedance.com>
References: <20220618030130.36419-1-hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch fixes the following issue:
When we found the commit in the graph in lookup_commit_in_graph(), but
the commit is missing from the repository, we will try
promisor_remote_get_direct() and then enter another loop.

Then we will go into an endless loop:
  git fetch -> deref_without_lazy_fetch() ->
    lookup_commit_in_graph() -> repo_has_object_file() ->
      promisor_remote_get_direct() -> fetch_objects() ->
        git fetch (a new loop round)

Changes since v1:

* add run_with_limited_processses() to test-lib so that we can use it to
  limit forking subprocesses. As we didn't check the return value of
  promise_remote_get_direct(), "git fetch" would finally succeed due to:

    error: cannot fork() for -c: Resource temporarily unavailable
    fatal: promisor-remote: unable to fork off fetch subprocess

* Rename test repositories, reference name and use GIT_TRACE to observe
  the fetch process.

Han Xin (2):
  test-lib.sh: add limited processes to test-lib
  commit-graph.c: no lazy fetch in lookup_commit_in_graph()

 commit-graph.c                             |  2 +-
 t/t5329-no-lazy-fetch-with-commit-graph.sh | 47 ++++++++++++++++++++++
 t/test-lib.sh                              |  9 +++++
 3 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100755 t/t5329-no-lazy-fetch-with-commit-graph.sh

Range-diff against v1:
1:  ebc14bfd5e < -:  ---------- commit-graph.c: no lazy fetch in lookup_commit_in_graph()
-:  ---------- > 1:  442a4c351d test-lib.sh: add limited processes to test-lib
-:  ---------- > 2:  d3a99a5c5a commit-graph.c: no lazy fetch in lookup_commit_in_graph()
-- 
2.36.1

