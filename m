Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEA5C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 20:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351536AbiFMU75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351463AbiFMU5X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 16:57:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B7A9594
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 13:31:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 68so4920884qkk.9
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=M0hoU86FXC62AQy/3l71QIymShJfLZyd/+MvW7HkEw4=;
        b=fqAZC37WWiDFIF4RNPb6KF22z85GKibleJsO72YHMzjQofBA+x1z4mcGhVVZ/qjt1N
         1nQxOl3D+EkTzK1YDTWGB1Pw7EEJgM0NcMxmSuMOVltm5hfLMyTg2oO7YR2CDe3IbHu/
         kCZcUo3tOG+I5fu8YV0XgknRcN+8LXx4owVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=M0hoU86FXC62AQy/3l71QIymShJfLZyd/+MvW7HkEw4=;
        b=qtaMvPHus1w7uTZwOHp5tf/D8+vwS0aCtBHJ3JoQpCUdhEkqxDACKC/TYz547vPhFm
         ZK7pW+6qv+Rkq+2oEpoPJV+kBNHu1wQqL9RTf9yy3mWBhzQJv0SF4yGoXl9lR/fDbLmZ
         vGzmlbLXnwkjiI324bXrDZn0oFM5ACwyDzlbhvYh4utHgFRevj245LEPm2S03K//946j
         Vy9iGvmrnpo1aSD9UcI8oUdh1J2gI0oezmSWx+AlIgA3QMMZ3hk/tr/sZNg6++TSBzj5
         Ohjq0Wo+JogKux0ohOV1so+Cz5NcAMnlf3PT9bSe6zuTcI0FXH3J6Vx0GDxoN5X8Lhfr
         uTrw==
X-Gm-Message-State: AOAM533/jq0kIeluNUY1VXqnlycrDpG2ocr1emps4bYFsvdWwuz3vIDy
        TaPWP9sH41SSbsHD+jrfHgx/ila08eeaQQ==
X-Google-Smtp-Source: ABdhPJy/axvzU/pf22enb2k7tAtJmVVve59uKVqYcZxzjAMK7lYVgNArmHO4Z9dWKn0c2FSxF+53zQ==
X-Received: by 2002:a05:620a:1aa5:b0:6a6:c208:fb94 with SMTP id bl37-20020a05620a1aa500b006a6c208fb94mr1542113qkb.434.1655152308008;
        Mon, 13 Jun 2022 13:31:48 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006a6d74f8fc9sm7020704qki.127.2022.06.13.13.31.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:31:47 -0700 (PDT)
Date:   Mon, 13 Jun 2022 16:31:45 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     git@vger.kernel.org
Subject: Repository corruption if objects pushed in the middle of repack
Message-ID: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, all:

I'm trying to figure the cause of repository corruption in a very specific
case. Here's the setup:

1. the repository is several GB in size, full of automatically generated pushes
   (https://git.yoctoproject.org/poky-buildhistory/)
2. this repository has no alternates or other clever things -- just your old
   boring repository
2. the builders check out this repository with --depth 1 during the build
   stage, then add new logs to the repository, commit and push

Admittedly, this is a bad use of git, but let's use that outside the scope.

Every weekend we run a set of maintenance tasks and if we find that there are
lots of new loose objects (which there usually are), we fire off a routine repack:

1. first, repack runs with the following flags (-f if deemed necessary):

        git repack -n --window-memory=1g -a -b --unpack-unreachable=yesterday -f --pack-kept-objects -d

   Since the repository is large, this usually takes a long time (3+ hours)

2. next, we generate a fresh commit-graph:

        git commit-graph write

3. next, we run pack-refs:

        git pack-refs --all

4. after that, we run prune:

        git prune --expire=yesterday

In the case of this particular repository, we regularly run into repository
corruption, reported during the prune stage:

    fsck[10362] 2022-05-09 01:00:06,378 - INFO - /var/lib/gitolite3/repositories/poky-buildhistory.git:
    fsck[10362] 2022-05-09 01:00:06,700 - INFO -    repack: performing a full repack for optimal deltas
    fsck[10362] 2022-05-09 01:00:06,701 - INFO -    repack: repacking with "-n --window-memory=1g -a -b --unpack-unreachable=yesterday -f --pack-kept-objects -d"
    fsck[10362] 2022-05-09 03:19:15,825 - INFO -     graph: generating commit-graph
    fsck[10362] 2022-05-09 03:19:20,830 - INFO -  packrefs: repacking all refs
    fsck[10362] 2022-05-09 03:19:20,842 - INFO -     prune: pruning
    fsck[10362] 2022-05-09 03:19:21,622 - CRITICAL - /var/lib/gitolite3/repositories/poky-buildhistory.git reports errors:
    fsck[10362] 2022-05-09 03:19:21,625 - CRITICAL -        fatal: bad tree object ace77888c63e5c4e545f1bd7a3ee5934e35f56e9
    fsck[10362] 2022-05-09 03:19:21,626 - WARNING - Repacking /var/lib/gitolite3/repositories/poky-buildhistory.git was unsuccessful

The tree object in question came in during the repack stage:

    2022-05-09.02:36:33     11129   update  poky-buildhistory buildhistory    W       refs/heads/poky/master/qemuppc  5aad6c8130370bf22f5639162bbbfeaefd0fcd5e ea4e65d72a6161fece5734f7b111e31af77c7578        refs/.*

As far as I know, the maintenance steps we are running shouldn't result in any
missing objects, so I'm curious if it's something we're doing wrong (using
unsafe flags) or if git isn't properly accounting for some objects that come
in during the repack stage. We're seeing this happen fairly routinely, so it's
not just a random fluke.

Git version 2.36.1 (and earlier).

Thanks,
Konstantin
