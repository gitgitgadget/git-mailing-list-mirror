From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 00/15] submodule groups (once again)
Date: Tue, 26 Apr 2016 13:50:18 -0700
Message-ID: <1461703833-10350-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com, Stefan Beller <sbeller@google.com>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 26 22:50:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av9wV-0006Og-UX
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 22:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbcDZUuo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 16:50:44 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33259 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbcDZUun (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 16:50:43 -0400
Received: by mail-pf0-f180.google.com with SMTP id 206so11458937pfu.0
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=8725pp6L8GH+s1P4ADKi2gwZFmgMHrB4j77XzsnvlNE=;
        b=hikL2l8g520t4Kg3SVwVsNlv3HshhBF8HLjnzBce9ROphN2PGGLDd1pLHhDPluY3PO
         GKcDlrpANaLknt58VgFG708rSu8YOwTQ7GMKrDTx32xyV5sYy/b6y4ZQ+fraKcNuQ7CC
         YhNbyEEkR5TQaL2rnciq3S23s74b93XLEfieoLzOuog5G5DULPxz3sdrwRsZIBiQ2zXq
         c2xCuguPmizsgFxwXyftfw30ykZyaEaXhBrJv2nAzof25Lffdtwenw3ppKBa3Cof56sX
         osQvMz2E2bVwn/n9gIx2LrxK6BqPUwXAJi3d7ftbnLL6m0smUXAi5uwYJWxNNaGdtwTK
         OXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8725pp6L8GH+s1P4ADKi2gwZFmgMHrB4j77XzsnvlNE=;
        b=Zs0m+QgSYGA0VsgZjuvx7CN2plrOx+HLcC9bg1X+er+tZcocXaOaILYaKhdP+5G6UK
         1PCDJ/BnAheJQnRTYXEj/+ZTvGxS4iC8/4XBc55zLf9ttdmJENnd9k06FNvc/x8AX5Pb
         OFXmiLIPMBDI4wCHDWA0rCmhXgFm5UQddUxS9QUTZv9HdVOcw2bQnwW3e2TOVDjGR/hI
         AEXh/GHGXYrpUivCYK2vXQpAnjOi6yyn2SqfC2L60/cEe2CZG+DUr+9RV/a50YjDqIFU
         0n04j9QcYoLJauQqMrOwrGMNqooNtF5RjVR1r/4WQxSos15QEFZ1vBMOXF4U3IMt6ehg
         Yp5Q==
X-Gm-Message-State: AOPr4FUXt0UQDoeIcQRDNdejLF/70dbkgChhgqlAupRz4kz+Z47FTc13aa3zOVSpgft6TIzi
X-Received: by 10.98.24.208 with SMTP id 199mr6506636pfy.160.1461703842954;
        Tue, 26 Apr 2016 13:50:42 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fcb4:82e7:2d29:45d6])
        by smtp.gmail.com with ESMTPSA id r191sm485403pfr.36.2016.04.26.13.50.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Apr 2016 13:50:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.41.g8d9aeb3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292666>

New in this series: git status, git diff and all remaining git submodule subcommands.

One pain point I am still aware of:
`git diff` and `git status` completely ignore submodules which are not in the
default group. I am not sure if that is a reasonable default.

A poor analogy could be the .gitignore file configuration:
If an entry exists in .gitignore, the corresponding file is ignored if
(and only if) the file is not part of the repository, i.e changes to 
a tracked (but ignored) file are still shown. Another way of saying it:
The ignore mechanism doesn't influence the diff machinery.

git diff is supposed to view the differences between "what would I
get after checkout" (i.e. what is in the index run through smudge filters)
compared to the actual worktree.
With the submodule default group set, we would expect to not see some
submodules checked out. But if such a submodule is in the worktree,
we may want to show a message instead:

    $ git status
    ... # normal git status stuff
        More than 2 submodules (123 actually) including 
            'path/foo'
            'lib/baz'
            # have a reasonable maximum for the number of submodules shown
        are checked out, but not part of the default group.
        You can add these submodules via
            git config --add submodule.defaultGroup ./path/foo
            git config --add submodule.defaultGroup ./lib/baz

Once we have such a message, we would need to train `git checkout` to checkout
and drop the right submodules for switching branches.

It has been a while since last posting this series and it is substantially
different in scope (and I have rewritten most of the patches), so I'll not
provide an intra-diff or a version number for this series.

What is this series about?
==========================

If you have lots of submodules, you probably don't need all of them at once, 
but you have functional units. Some submodules are absolutely required, 
some are optional and only for very specific purposes. 

This patch series adds labels to submodules in the .gitmodules file. 

So you could have a .gitmodules file such as: 

[submodule "gcc"] 
        path = gcc 
        url = git://... 
        label = default
        label = devel 
[submodule "linux"] 
        path = linux 
        url = git://... 
        label = default 
[submodule "nethack"] 
        path = nethack 
        url = git://... 
        label = optional
        label = games 

and by this series you can work on an arbitrary group of these submodules
composed by the labels, names or paths of the submodules.

    git clone --recurse-submodules --init-submodule=label --init-submodule=label2   git://... 
    # will clone the superproject and recursively 
    # checkout any submodule being labeled label or label2
    
    git submodule add --label <name> git://... ..
    # record a label while adding a submodule
    
    git config submodule.defaultGroups default
    git config --add submodule.defaultGroups devel
    # configure which submodules you are interested in.
    
    git submodule update
    # update only the submodules in the default group if that is configured.
    
    git status
    git diff
    git submodule summary
    # show only changes to submodules which are in the default group.

Any feedback welcome, specially on the design level! 
(Do we want to have it stored in the .gitmodules file? Do we want to have 
the groups configured in .git/config as "submodule.groups", any other way 
to make it future proof and extend the groups syntax?) 

Thanks, 
Stefan 

Stefan Beller (15):
  string_list: add string_list_duplicate
  submodule doc: write down what we want to achieve in this series
  submodule add: label submodules if asked to
  submodule-config: keep labels around
  submodule-config: check if submodule a submodule is in a group
  submodule init: redirect stdout to stderr
  submodule deinit: loose requirement for giving '.'
  submodule--helper list: respect submodule groups
  submodule--helper init: respect submodule groups
  submodule--helper update_clone: respect submodule groups
  diff: ignore submodules excluded by groups
  git submodule summary respects groups
  cmd_status: respect submodule groups
  cmd_diff: respect submodule groups
  clone: allow specification of submodules to be cloned

 Documentation/config.txt        |   4 +
 Documentation/git-clone.txt     |   6 +
 Documentation/git-submodule.txt |  13 +-
 builtin/clone.c                 |  40 +++++-
 builtin/commit.c                |   3 +
 builtin/diff.c                  |   2 +
 builtin/submodule--helper.c     |  94 ++++++++++++-
 diff.c                          |   3 +
 diff.h                          |   1 +
 git-submodule.sh                |  24 +++-
 string-list.c                   |  18 +++
 string-list.h                   |   2 +
 submodule-config.c              |  66 ++++++++++
 submodule-config.h              |   5 +
 t/t7400-submodule-basic.sh      | 129 +++++++++++++++++-
 t/t7406-submodule-update.sh     |  24 +++-
 t/t7413-submodule--helper.sh    | 285 ++++++++++++++++++++++++++++++++++++++++
 wt-status.c                     |   2 +
 wt-status.h                     |   1 +
 19 files changed, 701 insertions(+), 21 deletions(-)
 create mode 100755 t/t7413-submodule--helper.sh

-- 
2.8.0.41.g8d9aeb3
