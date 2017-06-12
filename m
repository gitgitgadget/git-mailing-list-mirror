Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8A5220401
	for <e@80x24.org>; Mon, 12 Jun 2017 22:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752583AbdFLWOU (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 18:14:20 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:32879 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdFLWOT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 18:14:19 -0400
Received: by mail-pg0-f50.google.com with SMTP id f185so50812415pgc.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nAgmnWo6kRC9pG9XYZTt3ZdWGfQpFOgvxdI6k3RvW+k=;
        b=pMr+tGhuFupSpNZffER2yzuVtgwSuFWc9bhZQ0qba8BRMWdjJ5MV51KB5JBg0KAwpM
         pr3o4l0No/agRbcrV4euVFh66ypd2CLRe/cZipth5EJX2kDywNMgkrisZk8mzi6LgbJt
         kxEw7JwCBgIniSH824x3+G19TPUEChCtuc1M3+B7NMlRxl32+MwYrPGBEyB+QDNlGZC6
         19RZ4t47VmsAXglhzs8kUFwq4Zym5jba+DsBmBYtuhpvO1qlpVS1U79YzIxuWzKIPu8v
         sIWz3cKG3UVTPwFqxV1n6tjurBtq6QsXsS1zMJwiCcweKNGDbXpdL2jeCK1pnfNGd2uy
         beFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nAgmnWo6kRC9pG9XYZTt3ZdWGfQpFOgvxdI6k3RvW+k=;
        b=GO8fn37I7nzEA9MdLElmm4lgezCY2zN8WENjZ9SYxDPNpmt9aLw98JOzWJLtiYSxiv
         tSp8bTcj5GuGEWnirqbjm6QEIF9pHkjYA1vhp7fE/J2lGnu8TOXId+HqO3/SIF/usEu8
         oY7nZFzElOC1cQ512QdMOFBlT/DrLYM+FxafU+D+7Un1+x/rxbEcNzTznLAGmQSOERRx
         B1VNPh71UmJJnn+VTfeqOHqlfnjPusAVjAoaUeoZJCKpkyY6ZG7gvb3U6LcUOfo20y0D
         cHzrCh9zblcXWR3rXIfPZGabAZcd/DlPYhomqqJQB5GFm6wPvaO/RZOwjS/Y12+5PXf1
         dQtQ==
X-Gm-Message-State: AODbwcC6NvJ/fElDwklMceOP6U+CTJjYdC6OIWKfA5SNM1k/PbZpAQQg
        +LhTxbAfpBbLGaMNuHPnHg==
X-Received: by 10.99.218.69 with SMTP id l5mr60970764pgj.88.1497305657903;
        Mon, 12 Jun 2017 15:14:17 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id i68sm22403884pfi.72.2017.06.12.15.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 15:14:16 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 00/17] convert ls-files internals to pass around an index
Date:   Mon, 12 Jun 2017 15:13:51 -0700
Message-Id: <20170612221408.173876-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.1.518.g3df882009-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the second chunk of patches I want to carve off of my 'repository
object' series.  As you can see its 17 patches long so by eliminating this the
repository series shrinks by a considerable amount.

The point of this series is to stop having some of the internals of ls-files
(and subsequent library routines) from implicitly referencing 'the_index'.
Instead a pointer to an 'index_state' struct is passed around and operated on.
This is a preparatory step to enabling ls-files to able to recurse submodule
in-process.  They other step being the actual introduction of a repository object.

Brandon Williams (17):
  convert: convert get_cached_convert_stats_ascii to take an index
  convert: convert crlf_to_git to take an index
  convert: convert convert_to_git_filter_fd to take an index
  convert: convert convert_to_git to take an index
  convert: convert renormalize_buffer to take an index
  tree: convert read_tree to take an index parameter
  ls-files: convert overlay_tree_on_cache to take an index
  ls-files: convert write_eolinfo to take an index
  ls-files: convert show_killed_files to take an index
  ls-files: convert show_other_files to take an index
  ls-files: convert show_ru_info to take an index
  ls-files: convert ce_excluded to take an index
  ls-files: convert prune_cache to take an index
  ls-files: convert show_ce_entry to take an index
  ls-files: convert show_files to take an index
  ls-files: factor out debug info into a function
  ls-files: factor out tag calculation

 apply.c            |   2 +-
 blame.c            |   2 +-
 builtin/commit.c   |   3 +-
 builtin/ls-files.c | 178 +++++++++++++++++++++++++++++------------------------
 cache.h            |   3 +-
 combine-diff.c     |   2 +-
 convert.c          |  31 ++++++----
 convert.h          |  19 ++++--
 diff.c             |   6 +-
 dir.c              |   2 +-
 ll-merge.c         |   2 +-
 merge-recursive.c  |   4 +-
 sha1_file.c        |   6 +-
 tree.c             |  28 ++++++---
 tree.h             |   3 +-
 15 files changed, 168 insertions(+), 123 deletions(-)

-- 
2.13.1.518.g3df882009-goog

