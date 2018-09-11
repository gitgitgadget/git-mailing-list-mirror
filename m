Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B805D1F404
	for <e@80x24.org>; Tue, 11 Sep 2018 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeILEvg (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 00:51:36 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:52566 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeILEvg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 00:51:36 -0400
Received: by mail-vk0-f73.google.com with SMTP id t7-v6so6444vke.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 16:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UK9LJm65UuxeHDZIEhIkEOCaWR5+7+6jjW/ebEO4cFk=;
        b=XIt6/CNKpTZ3vTO/lu8+CJYX0ohsszUnYWTrfZzLPFK4tbMBVw4ygYqL4TUGe+dKRb
         P0KG0RHQoZRJS1hvHvzbUNgJ1lHzeqsVZfYwRqCV53Co2flzsJ/QSTE99SWTVxSC13gi
         rlkhF61eeS2ESuAwLEfvgkTLIFx4XXF5kMiTB8Irul97CuLS8oQJIQy85R3UYWMUJWBV
         GKsVaJPf9oF8J/TS6DBNWKpdUG9TWzdBEN0szFWId6kzAKJ35CT2JbnGGZRiYz9aDvbs
         6ZvikH39ciPaGoZHFdwwiOBgXNUg1JdosTSVY3aVUz8UsJ39TVE1PLz09Sn2GDeqaOSp
         PxHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UK9LJm65UuxeHDZIEhIkEOCaWR5+7+6jjW/ebEO4cFk=;
        b=gLy+f/nI6tfr5HOUkKmFrWKb63xonUFhURSpEt53FDFnP4Xiv+mkeXkjZqDD4DBwAz
         oOdogE4UU5XhulBYMdh+ge4rFTtzLZZ0hw97QJ0sq0TMfFXbC9pjbaclSU67tNWLFfyo
         yGWGQhSEegQJEnfIsB6ZsktmmBzepgvbkeq/re/MA7mCkMdRO0upAxQ024hSfwqYGdPX
         4TnvUg4/9nZsWyOM+9eZ4m7yMmKEMKMpFXUrICkXjyOx2lQ4SplcXgYJX96g/4+PNBza
         4T+7Z1Ea6JyyKYI1kbWXNyQe3/i0tU/X8BtbuqA0eCkXmgB363PIteQwwCLNsroAILYZ
         UPNA==
X-Gm-Message-State: APzg51CGWH4BM7lOXTxNyFO6aTOSLtaayzkzohqp0UVuJoFbIdUTrsAi
        3kLKpddPfDxaiPUOCxpp4xW39AqzL9zvSoInELaI8x88ueJBQew6ordMcvcSEuSul1wdfX9mInO
        qrsSFbDjMpFSrEOVdNIvBayU/BqzN7mkIZ9FkCTN5nDUO+7iIBuxmSkUvR8KW
X-Google-Smtp-Source: ANB0VdYvnlAf2yAhbbO1idiPSF2dYVGkZs9ikZzbSKEmsWDj1qDVJ3OR+SJdI5xgDBMmzC97e7mD6Yk8lIRv
X-Received: by 2002:ab0:1045:: with SMTP id g5-v6mr5538599uab.69.1536709797299;
 Tue, 11 Sep 2018 16:49:57 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:49:42 -0700
Message-Id: <20180911234951.14129-1-sbeller@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 0/9] fetch: make sure submodule oids are fetched
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently when git-fetch is asked to recurse into submodules, it dispatches
a plain "git-fetch -C <submodule-dir>" (and some submodule related options
such as prefix and recusing strategy, but) without any information of the
remote or the tip that should be fetched.

This works surprisingly well in some workflows, not so well in others,
which this series aims to fix.

The first patches provide new basic functionality and do some refactoring;
the interesting part is in the two last patches.

This was discussed in
https://public-inbox.org/git/20180808221752.195419-1-sbeller@google.com/
and I think I addressed all feedback so far.

Thanks,
Stefan

Stefan Beller (9):
  string-list: add string_list_{pop, last} functions
  sha1-array: provide oid_array_filter
  submodule.c: fix indentation
  submodule.c: sort changed_submodule_names before searching it
  submodule: move global changed_submodule_names into fetch submodule
    struct
  submodule.c: do not copy around submodule list
  submodule: fetch in submodules git directory instead of in worktree
  fetch: retry fetching submodules if sha1 were not fetched
  builtin/fetch: check for submodule updates for non branch fetches

 builtin/fetch.c             |  14 +--
 sha1-array.c                |  18 ++++
 sha1-array.h                |   5 +
 string-list.c               |  14 +++
 string-list.h               |  11 +++
 submodule.c                 | 189 ++++++++++++++++++++++++++++--------
 t/t5526-fetch-submodules.sh |  23 ++++-
 7 files changed, 227 insertions(+), 47 deletions(-)

-- 
2.19.0.397.gdd90340f6a-goog

