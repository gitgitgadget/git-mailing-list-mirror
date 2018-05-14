Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18DEE1F42D
	for <e@80x24.org>; Mon, 14 May 2018 10:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752577AbeENK7Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 06:59:16 -0400
Received: from ao2.it ([92.243.12.208]:53773 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeENK7D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 06:59:03 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fIBBp-000750-Be; Mon, 14 May 2018 12:58:49 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fIBC0-0002C1-9A; Mon, 14 May 2018 12:59:00 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH 00/10] Make submodules work if .gitmodules is not checked out
Date:   Mon, 14 May 2018 12:58:13 +0200
Message-Id: <20180514105823.8378-1-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

vcsh[1] uses bare git repositories and detached work-trees to manage
*distinct* sets of configuration files directly into $HOME.

In this setup multiple repositories share the same directory (namely
$HOME) as their work dir, so the sets of checked out files would also
need to be *disjoint* to avoid collisions (examples of collisions can be
README or LICENSE files, or even .gitignore and .gitattributes).

Amongst vcsh users, a popular solution to this problem is to use sparse
checkouts, representing the *intersection* of all the repositories in
a common sparse-checkout file[2].

This works well but there are still limitations about the ability to use
submodules because git expects the .gitmodules file to be checked out.

The user (or vcsh itself) might learn to fully populate one repository
at a time when working with submodules but this is unhandy and would
introduce serialization even when it's not strictly needed like in the
case of _reading_ .gitmodules.

As a side note, git submodules have worked perfectly fine with detached
work-trees for some time[3,4,5] so extending them to also play nice with
sparse checkouts seems the next logical step to cover the vcsh use case.

This series teaches git to try and read the .gitmodules file from the
index (HEAD:.gitmodules) when it's not available in the work dir.

It does so by first providing an opaque way to access the submodules
configuration, and then extends the access mechanism behind the scenes.

Writing to .gitmodules still requires it to be checked out.

This series should be in line with what Stefan and Jonathan proposed;
although it's not perfect yet:

  - naming of functions can be improved,
  - code can be moved around to better places,
  - maybe some notes should be added to Documentation/git-submodule.txt,
  - my git terminology may still be a little off: do "work tree" and
    "work directory" mean the same thing?

the functionality is there and we should have a decent baseline to work
on.

The patchset is based on the current master (ccdcbd54c447), the
test-suite passes after each commit and there are some per-patch
annotations.

If anyone wanted to pick up and finish the work feel free to do so,
otherwise please comment and I'll try to address issues as time permits.

Thanks,
   Antonio

[1] https://github.com/RichiH/vcsh
[2] https://github.com/RichiH/vcsh/issues/120#issuecomment-387335765
[3] http://git.661346.n2.nabble.com/git-submodule-vs-GIT-WORK-TREE-td7562165.html
[4] http://git.661346.n2.nabble.com/PATCH-Solve-git-submodule-issues-with-detached-work-trees-td7563377.html
[5] https://github.com/git/git/commit/be8779f7ac9a3be9aa783df008d59082f4054f67

Antonio Ospite (10):
  config: make config_from_gitmodules generally useful
  submodule: factor out a config_gitmodules_set function
  t7411: be nicer to other tests and really clean things up
  submodule--helper: add a new 'config' subcommand
  submodule: use the 'submodule--helper config' command
  submodule--helper: add a '--stage' option to the 'config' sub command
  submodule: use 'submodule--helper config --stage' to stage .gitmodules
  t7506: cleanup .gitmodules properly before setting up new scenario
  submodule: support reading .gitmodules even when it's not checked out
  t7415: add new test about using HEAD:.gitmodules from the index

 builtin/fetch.c                        |   2 +-
 builtin/mv.c                           |   2 +
 builtin/rm.c                           |   7 +-
 builtin/submodule--helper.c            | 100 +++++++++++++++++++-
 cache.h                                |   1 +
 config.c                               |  26 ++++--
 config.h                               |  10 +-
 git-submodule.sh                       |  10 +-
 submodule-config.c                     |  16 +---
 submodule.c                            |  37 ++++++--
 submodule.h                            |   2 +
 t/t7411-submodule-config.sh            |  63 ++++++++++++-
 t/t7415-submodule-sparse-gitmodules.sh | 124 +++++++++++++++++++++++++
 t/t7506-status-submodule.sh            |   3 +-
 14 files changed, 357 insertions(+), 46 deletions(-)
 create mode 100755 t/t7415-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
