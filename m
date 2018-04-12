Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B94D81F404
	for <e@80x24.org>; Thu, 12 Apr 2018 22:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeDLW5M (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 18:57:12 -0400
Received: from ao2.it ([92.243.12.208]:51117 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753064AbeDLW5J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 18:57:09 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f6kZd-0008Ut-15; Fri, 13 Apr 2018 00:20:09 +0200
Received: from ao2 by jcn with local (Exim 4.90_1)
        (envelope-from <ao2@ao2.it>)
        id 1f6kac-0001V8-Pv; Fri, 13 Apr 2018 00:21:10 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Richard Hartmann <richih.mailinglist@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [RFC 00/10] Make .the gitmodules file path configurable
Date:   Fri, 13 Apr 2018 00:20:37 +0200
Message-Id: <20180412222047.5716-1-ao2@ao2.it>
X-Mailer: git-send-email 2.17.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

vcsh[1] uses bare git repositories and detached work-trees to manage
*distinct* sets of configuration files directly into $HOME.

In general, submodules have worked perfectly fine with detached
work-trees for some time[2,3,4].

However when multiple repositories take turns using the same directory
as their work-tree, and more than one of them want to use submodules,
there could still be conflicts about the '.gitmodules' file because git
hardcodes this path.

For comparison, in case of '.gitignore' a similar conflict might arise,
but git has alternative ways to specify exclude files, so vcsh solves
this by setting core.excludesFile for each repository and track ignored
files somewhere else (in ~/.gitignore.d/$VCSH_REPO_NAME).

This is currently not possible with submodules configuration.

So this series proposes a mechanism to set an alternative path for the
submodules configuration file (from now on "gitmodules file").

Patches are based on fe0a9eaf31dd0c349ae4308498c33a5c3794b293.

In commit 4c0eeafe4755 (cache.h: add GITMODULES_FILE macro)[5] the
gitmodules file path definition was centralized, AFAIU this was done
mainly to prevent typos, as checking a symbolic constant is something
the compiler will do for us.

Expanding on that change the first patch in the series makes the path
customizable exposing a 'core.submodulesFile' configuration setting.

The new configuration setting can be used to set an *alternative*
location for the gitmodules file; IMHO there is no need to provide
*additional* locations like in the case of exclude files.

For instance vcsh could set the location to
'~/.gitmodules.d/$VCSH_REPO_NAME' to avoid conflicts.

Since the gitmodules file is meant to be checked in into the repository,
the overridden file path should be relative to the work-tree; is there
a way to enforce this constraint at run time (i.e. validate the config
value), or is it enough to have it documented?

The last patch adds a hacky 'test-custom-gitmodules-file.sh' script
which patches the test suite to fix all the hardcoded occurrences of
'.gitmodules' and runs it twice: once with the default value and once
with a custom path, passed via an environmental variable.

I guess in the final version just testing for a custom path (e.g.
'.gitmodules_custom') could be enough, as the default value can be seen
as a particular case.

The last thing I noticed is that git does not create config files
automatically if they are under a subdirectory which does not exist
already; for instance the following command would fail:

  git config -f newsubdir/test-config user.name Antonio

This means that if the user wanted to use something like:

  git -c core.submodulesFile=.gitmodules.d/repo_submodules ...

the subdirectory would have to be created beforehand. This is not a big
deal of course, but I was wondering if this is mentioned anywhere.
Fixing the current behavior to create the leading directories does not
seem hard, but I am not sure it is worth it.

Thanks,
   Antonio

[1] https://github.com/RichiH/vcsh
[2] http://git.661346.n2.nabble.com/git-submodule-vs-GIT-WORK-TREE-td7562165.html
[3] http://git.661346.n2.nabble.com/PATCH-Solve-git-submodule-issues-with-detached-work-trees-td7563377.html
[4] https://github.com/git/git/commit/be8779f7ac9a3be9aa783df008d59082f4054f67
[5] https://github.com/git/git/commit/4c0eeafe4755345b0f4636bf09904cf689703e11

Antonio Ospite (10):
  submodule: add 'core.submodulesFile' to override the '.gitmodules'
    path
  submodule: fix getting custom gitmodule file in fetch command
  submodule: use the 'submodules_file' variable in output messages
  submodule: document 'core.submodulesFile' and fix references to
    '.gitmodules'
  submodule: adjust references to '.gitmodules' in comments
  completion: add 'core.submodulesfile' to the git-completion.bash file
  XXX: wrap-for-bin.sh: set 'core.submodulesFile' for each git
    invocation
  XXX: submodule: fix t1300-repo-config.sh to take into account the new
    config
  XXX: submodule: pass custom gitmodules file to 'test-tool
    submodule-config'
  XXX: add a hacky script to test the changes with a patched test suite

 Documentation/config.txt                      | 18 +++--
 Documentation/git-add.txt                     |  4 +-
 Documentation/git-submodule.txt               | 45 +++++------
 Documentation/gitmodules.txt                  | 15 ++--
 Documentation/gitsubmodules.txt               | 18 ++---
 .../technical/api-submodule-config.txt        |  6 +-
 Makefile                                      |  3 +-
 builtin/fetch.c                               |  2 +-
 builtin/mv.c                                  |  3 +-
 builtin/rm.c                                  |  3 +-
 builtin/submodule--helper.c                   | 20 ++---
 cache.h                                       |  1 +
 config.c                                      | 13 ++--
 config.h                                      |  7 +-
 contrib/completion/git-completion.bash        |  1 +
 contrib/subtree/git-subtree.txt               |  2 +-
 environment.c                                 |  1 +
 git-submodule.sh                              | 24 +++---
 repository.h                                  |  2 +-
 submodule-config.c                            | 16 ++--
 submodule-config.h                            |  2 +-
 submodule.c                                   | 54 ++++++-------
 t/helper/test-submodule-config.c              |  7 ++
 t/t0001-init.sh                               |  1 +
 t/t1300-repo-config.sh                        | 26 ++++++-
 test-custom-gitmodules-file.sh                | 75 +++++++++++++++++++
 unpack-trees.c                                |  2 +-
 wrap-for-bin.sh                               |  2 +
 28 files changed, 250 insertions(+), 123 deletions(-)
 create mode 100755 test-custom-gitmodules-file.sh
 mode change 100644 => 100755 wrap-for-bin.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
