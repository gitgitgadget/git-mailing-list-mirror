Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5EDCCA473
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiF3Xrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiF3Xr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:27 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B4E5A2C7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:18 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m184so291340wme.1
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjPtkfFop73D5DEg/b2GAzfjorlTTtpfG0ejyv8p+zY=;
        b=eTSw20kpDDdrnRg43yGP6NnprZPip4N5iBlBWejUa8U9OE/tN4RO197M08EOQe6ks6
         Yr2XdRn5TQ/63AHawRK356a6qgO8El5J5wBLIMmtjepU/gqgd8LQ+RfPU/5MwHAUo393
         rQRZxZGmROnJv1nn8tIkCBP5XDk8XIoz2b184K+IxRxEo9Oe5RludcJvQ9t+4599ZEhk
         PUllC88bprZafgVSYrRIpKOLjehIBBpevYY5F+1YP1nE70MtuIrqdQDzggFi1KeJd0Xv
         TTHcXUh4fVS+u3EW7bYSvlzw1U3sVc0VD4ouM73Q0z+Y7bH3ZbZurQk4ctG1AadZ27/K
         rqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xjPtkfFop73D5DEg/b2GAzfjorlTTtpfG0ejyv8p+zY=;
        b=ZcSgePOSIV8PV6cC3EdnC8kVe4nWHHMxegUh8BYB6+c8KnjIoMWLXpjSR04qGAVETh
         o7+32e7rbs3ngwEONKi7eIQQlR8qwtjb1muRAtRjV+3O8zEhfOW3EGS0kA+coVzdWgv3
         wRo1aIZ2kBGbBavObKe1qvH/lOnvw7vL6U/rFELD6RoRUiVCVfvdx8mIzNu87rb0VVDz
         roUkig7grASCgE0p7bElFPrM+EBxfvawSevpzbGzT5LLiBjFIqXDIYbwZhPU5gad+IOK
         aG6uEQuB1Y2LlSYLJ3hYa94/EfXYGSnl3piORz6zpXU0UnUb1ba9gxlqWmTV5KAhc9Pb
         AQ9g==
X-Gm-Message-State: AJIora/NLUH+28D8BFRVMhMMmV/k2s+Pk3+bEbVuO9/B+3g5zwFjYTC/
        Xj/R1h8pl5sAVRRzQA9BaqrSq6Ih+w61fw==
X-Google-Smtp-Source: AGRyM1u/nG8KmS9oWdfbw9kqlrWT+bLEhNrpzKALh7gzF0fR6Xqb8/p5Za50hlL+NY/AcP+XJpvpzg==
X-Received: by 2002:a05:600c:4e90:b0:3a0:57d6:4458 with SMTP id f16-20020a05600c4e9000b003a057d64458mr13324344wmq.198.1656632836863;
        Thu, 30 Jun 2022 16:47:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/9] test-tool: fix memory leaks
Date:   Fri,  1 Jul 2022 01:47:00 +0200
Message-Id: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a series of trivial leak-fixes which allows us to mark various
tests as entirely passing under SANITIZE=leak, the reasn they weren't
passing before was because we'd spot memory leaks in test-tool, rather
than git itself.

This is a sibling series to my just-submitted series for fixing memory
leaks in built-ins[1], but the the two do not textually or
semantically conflict.

There are still a few other test-tool memory leaks, but these are the
ones I had patches ready for, having focused on trying to get t00*.sh
passing first, and then picking some low-hanging fruit after that.

Passing CI for this series can be found at [2].

1. https://lore.kernel.org/git/cover-00.11-00000000000-20220630T175714Z-avarab@gmail.com/
2. https://github.com/avar/git/tree/avar/test-tool-memory-leaks

Ævar Arnfjörð Bjarmason (9):
  test-tool test-hash: fix a memory leak
  test-tool path-utils: fix a memory leak
  test-tool {dump,scrap}-cache-tree: fix memory leaks
  test-tool urlmatch-normalization: fix a memory leak
  test-tool regex: call regfree(), fix memory leaks
  test-tool json-writer: fix memory leaks
  test-tool bloom: fix a memory leak
  test-tool ref-store: fix a memory leak
  test-tool delta: fix a memory leak

 t/helper/test-bloom.c                  |  2 ++
 t/helper/test-delta.c                  | 21 +++++++++-----
 t/helper/test-dump-cache-tree.c        |  7 ++++-
 t/helper/test-hash.c                   |  1 +
 t/helper/test-json-writer.c            | 16 ++++++++---
 t/helper/test-path-utils.c             | 10 +++++--
 t/helper/test-ref-store.c              |  1 +
 t/helper/test-regex.c                  | 40 ++++++++++++++++----------
 t/helper/test-scrap-cache-tree.c       |  1 +
 t/helper/test-urlmatch-normalization.c | 11 +++++--
 t/t0015-hash.sh                        |  3 +-
 t/t0019-json-writer.sh                 |  2 ++
 t/t0060-path-utils.sh                  |  1 +
 t/t0090-cache-tree.sh                  |  2 ++
 t/t0095-bloom.sh                       |  2 +-
 t/t0110-urlmatch-normalization.sh      |  2 ++
 t/t5303-pack-corruption-resilience.sh  |  2 ++
 t/t5308-pack-detect-duplicates.sh      |  2 ++
 t/t5309-pack-delta-cycles.sh           |  2 ++
 t/t5321-pack-large-objects.sh          |  2 ++
 t/t7812-grep-icase-non-ascii.sh        |  1 +
 21 files changed, 97 insertions(+), 34 deletions(-)

-- 
2.37.0.874.g7d3439f13c4

