Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459EEC433E0
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBAC22D08
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 22:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbhASWmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 17:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730062AbhASOe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 09:34:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AAC061574
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:34:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id f1so7646546edr.12
        for <git@vger.kernel.org>; Tue, 19 Jan 2021 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJIF1LM5lKdnbMJtKFr76ZocS6PDBXr5UKCPYwdMgks=;
        b=SjGGV2uhU4s/r31YjOJXE1YxQJ8oJx1+OZZ8dTdEmmyy2UWcTV3nniQqRGs2er0T6G
         AbdjVTQlxQ9pKYevJlqBATHCdXoIzwQlW++N6nLXk0RKT39UgeEkKeBT/aVX5NLoLVuL
         UuBDri/3L3jLZUhvu5S0LhEzXs7BU9EgP6xdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJIF1LM5lKdnbMJtKFr76ZocS6PDBXr5UKCPYwdMgks=;
        b=W8NbROr8Mksnu9Uorn2XVMdBzYqeQg+5zNv4z5Gzit/+3JE3TveMhpfJhD76NhMYWy
         0VbtHWGp/iiFeRoEdzLqFckj99iBFMS7ymnhLG6edLkPhQeCARAIuMphGcD5vt8fuatL
         F/ZPxiQPWAQaSsLSRRIMSccAepS7H3Vjl0bWOPKssritjomslDAhloV8fJ2CsG0YkEae
         L0dsTV5HzSjhRXLRYDzp2cfaYQzrjUWHan4LqotHFRm7qeKFcuM5IW+H1NpBz55h+4if
         21C7XYhcy9NCqfgJgOlTKP1d/HLP6pB45va/l+b6Oavl/Lxbhh9fXfIF1TkunbdCXcBj
         yARg==
X-Gm-Message-State: AOAM5315FQkIdvSUmJkm7VfoJnxVzgYGIWR+wxMwaXpFsPG4idf/0cdF
        ii2FyVkHnKbbqnZ1dO/WdUrpeylUHI6pLk8d
X-Google-Smtp-Source: ABdhPJyhJaEtEWgUcdBlFqo76nFOmbzu0jvBqGHWJ/7+qq25FnYsHvxR6sSONhlrBcPevXtJICJX/Q==
X-Received: by 2002:a05:6402:30a7:: with SMTP id df7mr3465037edb.108.1611066855951;
        Tue, 19 Jan 2021 06:34:15 -0800 (PST)
Received: from localhost.localdomain (e93008.upc-e.chello.nl. [213.93.93.8])
        by smtp.gmail.com with ESMTPSA id p12sm10819085ejc.116.2021.01.19.06.34.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 06:34:15 -0800 (PST)
From:   Jacob Vosmaer <jacob@gitlab.com>
To:     git@vger.kernel.org
Cc:     Jacob Vosmaer <jacob@gitlab.com>
Subject: [PATCH 0/1] builtin/pack-objects.c: avoid iterating all refs
Date:   Tue, 19 Jan 2021 15:33:47 +0100
Message-Id: <20210119143348.27535-1-jacob@gitlab.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a small patch for git-pack-objects which will help server side
performance on repositories with lots of refs. I will post a related
but slightly larger patch for ls-refs.c in a separate thread.

The back story is in
https://gitlab.com/gitlab-com/gl-infra/scalability/-/issues/746 but I
will try to summarize it here.

We have a particular Gitaly (Git RPC) server at GitLab that has a very
homogenous workload, dominated by CI. While trying to reduce CPU
utilization on the server we configured CI to fetch with the
'--no-tags' option. This had an unexpectedly large impact so I started
looking closer at why that may be.

What I learned is that by default, a fetch ends up using the
'--include-tag' command line option of git-pack-objects. This causes
git-pack-objects to iterate through all the tags of the repository to
see if any should be included in the pack because they point to packed
objects. The problem is that this "iterate through all the tags" uses
for_each_ref which iterates through all references in the repository,
and in doing so loads each associated object into memory to check if
the ref is broken. But all we need for '--include-tag' is to iterate
through refs/tags/.

On the repo we were testing this on, there are about
500,000 refs but only 2,000 tags. So we had to load a lot of objects
just for the sake of '--include-tag'. It was common to see more than
half the CPU time in git-pack-objects being spent in do_for_each_ref,
and that in turn was dominated by ref_resolves_to_object.

So, I think it would be nice to just iterate over those 2,000 tags and
not load 500,000 objects outside refs/tags we already know we don't
care about.

Jacob Vosmaer (1):
  builtin/pack-objects.c: avoid iterating all refs

 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.30.0

