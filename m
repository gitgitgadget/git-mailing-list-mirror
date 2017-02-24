Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66BC2201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 23:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdBXXvK (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 18:51:10 -0500
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36485 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdBXXvI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 18:51:08 -0500
Received: by mail-pg0-f41.google.com with SMTP id s67so17195179pgb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 15:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VGyu16iMqxEiS1i+YhSVdFN1V6KAKddr1/gU8Yz7fFE=;
        b=t3uZGZzKzs7VEMjvPOjmIz9g9/4d1V9NAcoqnzenxzYOU34bNn6tlbELga5z4Q1OXN
         KS5ljGP1hEZH1FdonXZiLevYXJzhFBtF0/RRckw3IRe5xth09AEcuamnECBIdde/w2a0
         NJmutTo92DkkGtHHdHADzHwPDvVudV3moN9uVCto0qi/y+cxI2Nwk/KfTKydRqCWbMez
         t4DWzV6ODHTAMlzMR54EYxaiQTqlbbv8OQwLiptKmBh7MVMSGXNh7hvcPrckys3WX5v5
         5fYvW51T36ewol6bYPEfcAC03LUl5qHCJT4u9tFJtK6Ty4T2q8eqrMsUuofky6+3+oE5
         gPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VGyu16iMqxEiS1i+YhSVdFN1V6KAKddr1/gU8Yz7fFE=;
        b=U2Rj11GFcZejYMKnCx7nnX2IHm90FqRayCvdYi7eQajcsn1gZ+UDRq2kdDGXTYfjUG
         UMMTjYihEdV43NzfJjaK04919uTuTHLOXlXR3fekU/af16jgcolGcAmaaM1KIOkGEAvj
         AB15d5daEyvMlVO42DLTr5Z0rS8/jOBnKxI2FrfohjypvHtHxJij0uOas/Uwo610EqOx
         k2pWpR/ZQaoeQHPrT0HuZj9R33KNnsesAiUht/rI/TChQIgvyIsr/MIwIZ9faOgMdc4X
         A3fMBeq3uey1a7qa49Ba5K2oQUkgWc2LxZRvcqlxtM9vEGH89hZ74hRhDC0YlCceBRG6
         VBwg==
X-Gm-Message-State: AMke39nWyL5fVWCUnEOVE51A1DsrHnMz2iIrHHAMN6VqtKUC/k1RIj0/qsQFFyAvzeVRcV5j
X-Received: by 10.99.217.17 with SMTP id r17mr6826770pgg.140.1487980267424;
        Fri, 24 Feb 2017 15:51:07 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id v69sm17048236pgd.18.2017.02.24.15.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Feb 2017 15:51:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, sbeller@google.com,
        pclouds@gmail.com
Subject: [PATCH 0/5] recursing submodules with relative pathspec (grep and ls-files)
Date:   Fri, 24 Feb 2017 15:50:55 -0800
Message-Id: <20170224235100.52627-1-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It was discovered that when using the --recurse-submodules flag with `git grep`
and `git ls-files` and specifying a relative path when not at the root causes
the child processes spawned to error out with an error like:

fatal: ..: '..' is outside repository

While true that ".." is outside the scope of the submodule repository, it
probably doesn't make much sense to the user who gave that pathspec with
respect to the superproject.  Since the child processes that are spawned to
handle the submodules have some context that they are executing underneath a
superproject (via the 'super_prefix'), they should be able to prevent dying
under this circumstance.

This series fixes this bug in both git grep and git ls-files as well as
correctly formatting the output from submodules to handle the relative paths
with "..".

One of the changes made to fix this was to add an additional flag for the
parse_pathspec() function in order to treat all paths provided as being from
the root of the repository.  I hesitantly selected the name 'PATHSPEC_FROMROOT'
but I'm not fond of it since its too similar to the pathspec magic define
'PATHSPEC_FROMTOP'.  So I'm open for naming suggestions.

Brandon Williams (5):
  grep: illustrate bug when recursing with relative pathspec
  pathspec: add PATHSPEC_FROMROOT flag
  grep: fix bug when recuring with relative pathspec
  ls-files: illustrate bug when recursing with relative pathspec
  ls-files: fix bug when recuring with relative pathspec

 builtin/grep.c                         |  8 ++++--
 builtin/ls-files.c                     |  8 ++++--
 pathspec.c                             |  2 +-
 pathspec.h                             |  2 ++
 t/t3007-ls-files-recurse-submodules.sh | 50 ++++++++++++++++++++++++++++++++++
 t/t7814-grep-recurse-submodules.sh     | 42 ++++++++++++++++++++++++++++
 6 files changed, 107 insertions(+), 5 deletions(-)

-- 
2.11.0.483.g087da7b7c-goog

