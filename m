Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90B52027B
	for <e@80x24.org>; Thu, 18 May 2017 23:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbdERXWK (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:22:10 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:36843 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751673AbdERXWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:22:08 -0400
Received: by mail-pg0-f50.google.com with SMTP id x64so29452416pgd.3
        for <git@vger.kernel.org>; Thu, 18 May 2017 16:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=c7wH2rHTpLsb6dBjeIdcV2+4zxwyfmDLanJ8x1O+Yro=;
        b=DxPt8jXrdlvbRk1F8FirYotP3+qhbeql2RbR7GM38vo6uvmPA9KeEYhVsYhjLJ1CPl
         cyJ95D2ERJ36KS6Eit/7lhg03yHWWzUNaIpN7K9l8KN02IUZMSE4C/FCN85x4okcuSCX
         JQPGN71OBOZlLJ1IzfmPe840fx2daRpdMeYKm9ECWw5qYYx6YRdJY56VUkmB3Y8kDase
         C12XqCNiKnWCkGIq+aCabQKRrvyl91ec2FE1joe9tFquixBNl6y6CgqQ5Wbme1tZK56R
         pOg/G+LWfn3+efyuHORFAA6QrwNZnIbUknr14p7BkGCCsqxXsztXwq0tQ0FIyndkiiRs
         XYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=c7wH2rHTpLsb6dBjeIdcV2+4zxwyfmDLanJ8x1O+Yro=;
        b=c3gTr8VLdt2TkJtrao6bx+1fCG3LC2qiaS3JM9cliUFXujf/3iEuGvD1BG844G1Nci
         cloE48bjbXLinMmYazmp/YU000zWVg6v8Mgx4Cvv2t6wMAVcerm1Aa9AuMJHOf3fpzVU
         S9COHUmage4G4V9H8Y6SZD3vKipfus/KggvoswQkR7o8/yQw8RE4lvVW4K0cem2fZEYG
         ytRJuKsR7Nzn6k4hcuBTWhtbnMZUQQYxWkytqIvGuU6gcf80gyYXIEeSdVeJIGi7baie
         bMQbop192awdgOSyPKiHxbvAR+x3lvKKUEmgZKYc0DK/RyRf7rns5xbT/yDo14QYnwj9
         HayQ==
X-Gm-Message-State: AODbwcBXz3R5mL2dET2xdrpZ0KmxlEQYq7WE0akaRCbpTWHTRbPrsn1k
        FTu6Kciogsig+eZF
X-Received: by 10.84.141.129 with SMTP id 1mr7837966plv.75.1495149727844;
        Thu, 18 May 2017 16:22:07 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d3sm12579575pfg.30.2017.05.18.16.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 16:22:06 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        sbeller@google.com, jrnieder@gmail.com, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [WIP/RFC 00/23] repository object
Date:   Thu, 18 May 2017 16:21:11 -0700
Message-Id: <20170518232134.163059-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.303.g4ebf302169-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I first started working on the git project I found it very difficult to
understand parts of the code base because of the inherently global nature of
our code.  It also made working on submodules very difficult.  Since we can
only open up a single repository per process, you need to launch a child
process in order to process a submodule.  But you also need to be able to
communicate other stateful information to the children processes so that the
submodules know how best to format their output or match against a
pathspec...it ends up feeling like layering on hack after hack.  What I would
really like to do, is to have the ability to have a repository object so that I
can open a submodule in-process.

Before this becomes a reality for all commands, much of the library code would
need to be refactored in order to work purely on handles instead of global
state.  As it turned out, ls-files is a pretty simple command and doesn't have
*too* many dependencies.  The biggest thing that needed to be changed was
piping through an index into a couple library routines so that they don't
inherently rely on 'the_index'.  A few of these changes I've sent out and can
be found at 'origin/bw/pathspec-sans-the-index' and
'origin/bw/dir-c-stops-relying-on-the-index' which this series is based on.

Patches 1-16 are refactorings to prepare either library code or ls-files itself
to be ready to handle passing around an index struct.  Patches 17-22 introduce
a repository struct and change a couple of things about how submodule caches
work (getting submodule information from .gitmodules).  And Patch 23 converts
ls-files to use a repository struct. 

The most interesting part of the series is from 17-23.  And 1-16 could be taken
as is without the rest of the series.

This is still very much in a WIP state, though it does pass all tests.  What
I'm hoping for here is to get a discussion started about the feasibility of a
change like this and hopefully to get the ball rolling.  Is this a direction we
want to move in?  Is it worth the pain?

Thanks for taking the time to look at this and entertain my insane ideas :)

Brandon Williams (23):
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
  ls-files: convert show_files to take an index
  ls-files: factor out debug info into a function
  ls-files: factor out tag calculation
  repo: introduce new repository object
  repo: add index_state to struct repo
  repo: add per repo config
  submodule-config: refactor to allow for multiple submodule_cache's
  repo: add repo_read_gitmodules
  submodule: add is_submodule_active
  ls-files: use repository object

 Makefile                               |   1 +
 apply.c                                |   2 +-
 builtin/blame.c                        |   2 +-
 builtin/commit.c                       |   3 +-
 builtin/ls-files.c                     | 348 ++++++++++++++++-----------------
 cache.h                                |   4 +-
 combine-diff.c                         |   2 +-
 config.c                               |   2 +-
 convert.c                              |  31 +--
 convert.h                              |  19 +-
 diff.c                                 |   6 +-
 dir.c                                  |   2 +-
 git.c                                  |   2 +-
 ll-merge.c                             |   2 +-
 merge-recursive.c                      |   4 +-
 repo.c                                 | 112 +++++++++++
 repo.h                                 |  22 +++
 sha1_file.c                            |   6 +-
 submodule-config.c                     |  40 +++-
 submodule-config.h                     |  10 +
 submodule.c                            |  51 +++++
 submodule.h                            |   2 +
 t/t3007-ls-files-recurse-submodules.sh |  39 ++++
 tree.c                                 |  28 ++-
 tree.h                                 |   3 +-
 25 files changed, 513 insertions(+), 230 deletions(-)
 create mode 100644 repo.c
 create mode 100644 repo.h

-- 
2.13.0.303.g4ebf302169-goog

