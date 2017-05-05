Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E05D2207B3
	for <e@80x24.org>; Fri,  5 May 2017 19:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755987AbdEETzG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 15:55:06 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34709 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755302AbdEETxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 15:53:46 -0400
Received: by mail-pf0-f171.google.com with SMTP id e64so7111919pfd.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 12:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=51o0hSnPC5r6to6oIRc6iQ9daD4QseqvV/4TZ/IgcNo=;
        b=jNlvCxrAhnQYSTj/qd2vYREM+QotOuL5bOKhcIKqf7TALtXN6Ac7c3Y6QSwd/Xr0Ad
         2Bq1Pe3yHMBb3Fp14nO6/YQAu0aHZa9oWhQouFYu/RvbjRFmVjPIze/eJuYc4hgRF4Rv
         f3D0SmD3fgxMUwFvj4BrTPEvuyA22Zl7G34Tl6CPuDwdb/WOqipe6RBwBYPsy4Z4XrQC
         GGjMjYy14w4bEhXyFEtoYToqAmvW3qGmt6mX6Q+K/Ogmppn3UYBhteDv/ezFW5HFBe+B
         bFd920W3/yVGFsFNwb9bZBOVHvaYSzEF7kgPkHOBzLdKKgiOxbnrgJxgvFFHhOOmOZj0
         npIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=51o0hSnPC5r6to6oIRc6iQ9daD4QseqvV/4TZ/IgcNo=;
        b=D2pNwGMrU9cRHx2m+4pYEVNuoSeNwUVwFuahiQ8aRyVTdRTSO69TPEJIF2IWx6UV66
         onomT91hDb03rS1wuQIS6f4dENqCEcLqrfmnvLpqMNJv+31Vhovc+b6b+xlGhT6iw/9v
         BV1mq8pXiKM66PRVMill2NWpl5x+uKNk7KuZpr65bGizBLUJhjg/bRbJuPZR55qv9Ehx
         0iarLj2bjTl11ntYoc100ZQHJfu7i0/lhhA0/+DlStKC+Kk4+wRXscd0O/yqHGa7Y7UQ
         3j68I4pox/s16Ey1cjNP5qtuTE0FUouZccKdDdkbnD8n2p2EBMnoV+DCqESlRt5WXm2W
         L1bQ==
X-Gm-Message-State: AN3rC/4uRSuV/ySARpkIP/j3FQMVkMaZHj16hQ6OhFRje6vPjVN0Ul/y
        9D63XDCrZtOuf69X
X-Received: by 10.98.137.5 with SMTP id v5mr18841545pfd.183.1494014025088;
        Fri, 05 May 2017 12:53:45 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id r86sm12395967pfb.24.2017.05.05.12.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 12:53:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 00/14] convert dir.c to take an index parameter
Date:   Fri,  5 May 2017 12:53:20 -0700
Message-Id: <20170505195334.121856-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.rc1.294.g07d810a77f-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the things brought up on the list in the past few days has been
migrating away from using the index compatibility macros.  One of the issues
brought up in that thread was how simply doing that conversion doesn't
eliminate the reliance on global state (specifically the_index).  If one day we
want to have a 'repository object' passed around then we first need to convert
different subsystems to be prepared to handle that.  This series provides a
first step, converting the code in dir.c to take a 'struct index_state' and
using that instead of implicitly using 'the_index'.

Brandon Williams (14):
  dir: stop using the index compatibility macros
  dir: convert read_skip_worktree_file_from_index to take an index
  dir: convert directory_exists_in_index to take index
  dir: convert get_dtype to take index
  dir: convert dir_add* to take an index
  dir: convert last_exclude_matching_from_list to take an index
  dir: convert is_excluded_from_list to take an index
  dir: convert add_excludes to take an index
  dir: convert prep_exclude to take an index
  dir: convert is_excluded to take an index
  dir: convert open_cached_dir to take an index
  dir: convert read_directory_recursive to take an index
  dir: convert read_directory to take an index
  dir: convert fill_directory to take an index

 builtin/add.c          |   7 +-
 builtin/check-ignore.c |   3 +-
 builtin/clean.c        |   4 +-
 builtin/grep.c         |   2 +-
 builtin/ls-files.c     |   4 +-
 dir.c                  | 200 ++++++++++++++++++++++++++++---------------------
 dir.h                  |  27 +++++--
 unpack-trees.c         |  10 +--
 wt-status.c            |   2 +-
 9 files changed, 151 insertions(+), 108 deletions(-)

-- 
2.13.0.rc1.294.g07d810a77f-goog

