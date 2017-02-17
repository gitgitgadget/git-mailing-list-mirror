Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7E620136
	for <e@80x24.org>; Fri, 17 Feb 2017 15:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934274AbdBQPjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 10:39:47 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:35954 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934065AbdBQPjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 10:39:46 -0500
Received: by mail-qt0-f177.google.com with SMTP id k15so43281503qtg.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 07:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=E4ws3mOX+wK/7cZyi4XuMV/3UkiOUH83YmyIZpy3u4Q=;
        b=un5qjmIbdqwYaOtgKrgUK2LvzcvqXkhYTSZOV5QSL4FbUagJl39vkKJGmDT6x1WW7o
         nIMdxt+O4VMbl2cX76SRyMO6yb4dqCKzew5HqHHk+sfOURWUlp1/khyrd2UAazR4tJzi
         GUBWnuwYgp1GHNGQ4h7e19638WGmemSFdmRHoLxsJjwm3XsqruBDDXxAoWkDVBWKOIdc
         U/GSml6Nq8ZyuFldCsgQAjbl+DGIuqOTeJzeusPo/tbemdQ78uv8wfegkAdU5XNWiNNb
         G22J8Uwq5q4X+S//rWnmfmd697tHNDmXOEQB9BBt8bCQBs67S1uJyqzk6iKUn1ThWgS1
         dxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E4ws3mOX+wK/7cZyi4XuMV/3UkiOUH83YmyIZpy3u4Q=;
        b=FAUpMe8XTQgVpS3U97TCNV0/1iAlGnA4Gq9mWGHAV6KXUML3n+ZIt53WXZOPc0Eyn/
         QG2f4lq22rBZZNPRYbFQ8kS7bwXJ93R49/XAH2Jdo+WD3LP5X5uDTg3Eh7oA0xCFOIRR
         Dl71aYJSN2uCTvWxyAovwcrXimchPdrCh7cg9KGjpmxe2h3ozeFv7jbXSS7SlPTFqLdb
         g9dQbawRv32skrWNGd3SUzp4U4sHDX8f378++dab/JfncvRFBT6eK3NZV5i0EkH8qgQr
         R3Nxzo5AI/iGYuvTOKHShJY/zIaHti1HdIDUf/tXMOjXbLj/nrabVRQKdTkvtViBCRV1
         Voag==
X-Gm-Message-State: AMke39n9H3j7IN5WZFPF73aqOq6syvxZeXxxxdFK0F9RB59R3+2XXwfTLIJVfpUNwAs54qN1ubx0BNAJ3cqvOA==
X-Received: by 10.237.55.196 with SMTP id j62mr7550639qtb.36.1487345985197;
 Fri, 17 Feb 2017 07:39:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.38.163 with HTTP; Fri, 17 Feb 2017 07:39:24 -0800 (PST)
From:   Lukas Lueg <lukas.lueg@gmail.com>
Date:   Fri, 17 Feb 2017 16:39:24 +0100
Message-ID: <CAJF-kYmrqgTtj=TMdzAaru-XKVUyQqXLTDY6Cytc-3VQEz0LTw@mail.gmail.com>
Subject: libgit2::git_describe_workdir() fails with depth-cloned + detached head
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I have a build on Travis failing with a weird error that happens while
trying to get a description from a repo. One of the integration tests
that are executed on Travis executes libgit2::git_describe_workdir()
on it's own repo and fails with code: -3, klass: 9, message: "object
not found - no match for id
(77f95f14776deb7e120a2a26f7b56abf2903bc62)".

The id 77f95f1 from the error message refers to a commit that is of no
particular interest and actually weeks behind; I never asked for it.

I was finally able to reproduce the problem by very carefully
following how Travis clones the repo:

git clone --depth=50 https://... repo_root
cd repo_root
git fetch origin +refs/pull/414/merge:
git checkout -qf FETCH_HEAD

If and only if the repo is cloned recursively, the call to
libgit2::git_describe_workdir() results in this error, always
referring to 77f95f1. If the repo is cloned without '--depth 50', no
error occurs. The repo does not even have submodules.

My local git client does the right thing and get's the latest commit
oid without problems.

Any idea what's going on here?

Best regards
Lukas
