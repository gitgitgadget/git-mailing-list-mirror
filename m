Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C769CC43334
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 14:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiGLOAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 10:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiGLN7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 09:59:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E7B959C
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:59:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u13so14089523lfn.5
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=54OoiJ9WJDHaaVMSmQZANIDn++PQZ9BNPbC6GoYKX3g=;
        b=Tv/jMMUmmrPoPQ6F30WqvEyMm3pCOheOjd5h8HTlawgluD5+KXgPVYNEfAn84Xoo/D
         Vs+0ZJZIgeamzHEfdBVzxShRMZ1qUKHnaUtqdfQyONZwXogmJBihFP+GWpv1c7xNys6X
         5GQS716/aSlpi1j51BgMrOlhRSGgNx7gGkWFcqy9qHP4q3+X7+LTVpRW52/SAYsw3oZN
         CPU+iDXwpOmiyA3KV/pv1SeHt7VhFOXmEK1xGGvTFy9ABpB58oaCZPkQpY1T9BU32eE5
         ijqfK7MF9ikeAQ6p+si+6/VXOggUcjaG8NmpkisqvKmfuTO4tYruXbQbYMcz3DoMSWAh
         VDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=54OoiJ9WJDHaaVMSmQZANIDn++PQZ9BNPbC6GoYKX3g=;
        b=60UnhyReSyWDixTbEBHNQEC/d+fAz11ifdxi/0K2K4vuzaDrdEl6akBMBCZQuOtPI1
         8KCwyACmxigHdUqtznxJdfRHFKKWP7tBKE3N7p4pl89R1JHz3imJAktp6rpCIRImrHWo
         DevBFw8ZQPZvQY2VjXZXZ3gQqWaFMHGf1H4vSggtofJAcbC9ZkbiiUdpJax1HnaPzBrm
         qHYmSOV9TPK57U/DbQY+/jgcSnnIvsv+g6gE0j+NwjDjcwfBg4xZsUEsyGZzwmIc6DJP
         fiB/HJDVZyiw8n6k5HzysoaJif3zlRXtKXwHbfE8nJVch4zXbrHRpeisLMp7YoxkD9vK
         5kBQ==
X-Gm-Message-State: AJIora/4Rb0GmVXiltsH5Kfmux3Ia56ZAfUkk+gO3Pf5L1mwFEil7k7u
        9N8umY+jrvdIQKY5wzEzKDpJjp4SqfmTGnxQ3iIz9VTwQg0=
X-Google-Smtp-Source: AGRyM1uHXzH3dz2789V0DqMitEA/kRDEzycS7+q4KNDP0zainerUE4OxhVqFJHRwxlo9wJISnjNLdSYaF5NlCTtdGvM=
X-Received: by 2002:a05:6512:32c2:b0:487:ad20:e0e6 with SMTP id
 f2-20020a05651232c200b00487ad20e0e6mr15326736lfg.492.1657634342797; Tue, 12
 Jul 2022 06:59:02 -0700 (PDT)
MIME-Version: 1.0
From:   Dian Xu <dianxudev@gmail.com>
Date:   Tue, 12 Jul 2022 09:58:51 -0400
Message-ID: <CAKSRnEzYYQ1EOmbUvafQvzJUNW8kojLuD+BbakxU09JSm=niHA@mail.gmail.com>
Subject: 'git sparse-checkout add' hangs if local repo is using alternative
 objects store
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git developers,

Reporting Issue:
    'git sparse-checkout add' hangs if local repo is using alternative
objects store

Found in:
    Git 2.37.0

Reproduction steps:
    1. Local repo setup:
        git init
        git remote add origin <repo_url>
        echo <alternative_objects_store> >! .git/objects/info/alternates
        git config --unset-all remote.origin.fetch
        git config --unset-all remote.origin.tagopt
        git config --add remote.origin.tagopt --no-tags
        git config --add remote.origin.fetch
+refs/heads/main:refs/remotes/origin/main
        git config core.sparsecheckout true
        git config core.sparsecheckoutcone true
        git fetch

    2. Sparse checkout <dir1>:
        git sparse-checkout set <dir1>
        git checkout -b tmp1 origin/main

    3. Add another <dir2> via sparse-checkout, which hangs:
        git sparse-checkout add <dir2>
            09:39:11.169116 read-cache.c:2451       performance:
6.326754679 s:  read cache .git/index
            09:39:11.731989 unpack-trees.c:496      performance:
0.197235658 s:   check_updates
            09:39:11.732031 unpack-trees.c:2062     performance:
0.512473791 s:  update_sparsity
            09:39:17.162018 read-cache.c:3135       performance:
5.429975480 s:  write index, changed mask = 2
            09:39:17.637510 cache-tree.c:483        performance:
0.154317183 s:  cache_tree_update
            09:39:17.857204 cache-tree.c:483        performance:
0.019983088 s:  cache_tree_update

Repo and dir info:
    <repo_url> is a large repo, containing large number of directories
and 2 million files;
    Local repo is using <alternative_objects_store>, which is working
by verifying: git count-objects -vH;
    <dir1> used here is one level deep, <dir2> used here is 5 level deep

Observations:
    1. Even 'sparse-checkout add' hangs, scm code from <dir2> was
actually downloaded pretty fast
    2. If waited out 'sparse-checkout add', git seems start to
download large number of objects from alternative objects store into
local .git/objects

Please help us take a look at this issue and let us know if you need
more information.

Thanks,

Dian Xu
Mathworks, Inc
1 Lakeside Campus Drive, Natick, MA 01760
508-647-3583
