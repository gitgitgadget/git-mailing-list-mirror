Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B005B201A0
	for <e@80x24.org>; Thu, 11 May 2017 22:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbdEKWEf (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 18:04:35 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34490 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdEKWEd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 18:04:33 -0400
Received: by mail-pg0-f43.google.com with SMTP id u28so20779979pgn.1
        for <git@vger.kernel.org>; Thu, 11 May 2017 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JpQ9TUFB/rh141fIKX17JTh0vv75ZHb4dLPDnAnYDcA=;
        b=oXO5ohGqBHtCao4vaPd0i3Qls3Dd6g9l2pffpo30umFJoBEvzgfPk9NvOWMZ1zAm6+
         rcYAD0rJniegYWNpaKgjDm9mKPR/HfG6xwwDa6e3bD16efy33ziRg6+Pi5LEhLgg8Be9
         KW9S8fK9FNQZBwXhGLZIrFkD0hOh1EmNvdasi+VQdl2Rt2VWXyqu3bdJgaC4gCyC4FSz
         mnaDNiRYoMdmNJkcgO1TDpjVs9QSuxblvSO4T00KIgK2jiyn0ZGPoN0r9rJmjyDVDw+p
         RskTrCJJo7XEhuiqA9UGUBqkxah0dI+5bs1uH/NG4zqj+pIlaYrkN2RGxoR8XNtreSX8
         oCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JpQ9TUFB/rh141fIKX17JTh0vv75ZHb4dLPDnAnYDcA=;
        b=OwXzdD127vlYwtbrCbRDutBgasewjvBKMU2y4H59sxmTLvLS+ktd7yNAbXWBo2LvsH
         XixzgvENoPgRVME/fMkCgPFYHcor7dv/Uf+sJaSfXo2/NUYucrXwOoRTeIuLxdfCYY/1
         tg+Ju/Yvp6eud0mIUtzE1sP+UWaokYtL+2wZafyc/c7KrVtZ0GNTYQx5fLVveRHtcKVx
         sdrMNammB6f6DKZip1vquc8/EjyRo9k5oo+Mj1XoWcq6UEPFENqeGg8R7s044y3Txm/8
         DspPsMN6EtuZhu2OiJ5bp+kQR6eiVIm+k/rlhkQ38E+ztUNVPyKkiF/S4goizQVg6Vdu
         Hk5w==
X-Gm-Message-State: AODbwcBBJWm1QIesVFY/OoqL66wCtx8pSkOe3zYZL277CENA77TvRjTk
        hSqJbnhpinOwdon2
X-Received: by 10.84.213.143 with SMTP id g15mr922122pli.53.1494540271926;
        Thu, 11 May 2017 15:04:31 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id s68sm1873335pgc.5.2017.05.11.15.04.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 May 2017 15:04:30 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, j6t@kdbg.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/6] convert pathspec.c to take an index parameter
Date:   Thu, 11 May 2017 15:04:21 -0700
Message-Id: <20170511220427.192627-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <20170509191805.176266-1-bmwill@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The main difference in v2 is that instead of piping through an index_state
struct into parse_pathspec, I ripped out the logic that needed to access the
index and either removed it completely if it wasn't needed anymore (stripping
submodule slash) or factored it out into its own function which can be called
after initializing a pathspec object (dying if a path descends into a
submodule).

Brandon Williams (6):
  pathspec: provide a more descriptive die message
  submodule: add die_in_unpopulated_submodule function
  pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE flag
  ls-files: prevent prune_cache from overeagerly pruning submodules
  pathspec: remove PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP
  pathspec: convert find_pathspecs_matching_against_index to take an
    index

 builtin/add.c                    | 12 ++++--
 builtin/check-ignore.c           |  6 ++-
 builtin/ls-files.c               | 31 ++++++++++++---
 builtin/reset.c                  |  1 -
 builtin/rm.c                     |  3 +-
 builtin/submodule--helper.c      |  3 +-
 pathspec.c                       | 86 ++++------------------------------------
 pathspec.h                       | 25 +++++-------
 submodule.c                      | 63 +++++++++++++++++++++++++++++
 submodule.h                      |  4 ++
 t/t6134-pathspec-in-submodule.sh |  6 +--
 11 files changed, 124 insertions(+), 116 deletions(-)

-- 
2.13.0.rc2.291.g57267f2277-goog

