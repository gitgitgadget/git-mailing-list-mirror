Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 694061F597
	for <e@80x24.org>; Thu,  2 Aug 2018 14:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387599AbeHBQTQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 12:19:16 -0400
Received: from ao2.it ([92.243.12.208]:54930 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387576AbeHBQTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 12:19:16 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1flDv8-0006ht-Dl; Thu, 02 Aug 2018 15:45:38 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1flDwQ-0002h5-Il; Thu, 02 Aug 2018 15:46:58 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [RFC PATCH v2 00/12] Make submodules work if .gitmodules is not checked out
Date:   Thu,  2 Aug 2018 15:46:22 +0200
Message-Id: <20180802134634.10300-1-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is a second version of the RFC from
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

Please refer to the cover letter of the previous series for the
motivation and background of the changes.

Patches from 01 to 08 should be rather uncontroversial, as they do not
introduce any change of behavior but just prepare the ground for patches
09 and 10.

The last two patches, 11 and  12 are not strictly related to the topic,
it's just an idea I came up with while reading the code for the series;
I could send them separately if you think they are valid, or drop them.

The behavior of accessing HEAD:.gitmodules have been analyzed with the
following test matrix:

Predicates:
  G = .gitmodules exists
  H = HEAD:.gitmodules exists

Operations:
  read = git submodule--helper config name
  write = git submodule--helper config name value
  stage = git submodule--helper config --stage

!G and !H:
  - read: nop
  - write: set value to .gitmodules (we are creating a brand new
    .gitmodules)
  - stage: exit with error, staging requires .gitmodules (like git
    add/rm)

G and !H:
  - read: get value from from .gitmodules
  - write: set value to .gitmodules
  - stage: stage .gitmodules

!G and H:
  - read: get the value from HEAD:.gitmodules
  - write: exit with error, setting a value requires .gitmodules
  - stage: exit with error, staging requires .gitmodules
  
G and H:
  - read: get value from from .gitmodules
  - write: set value to .gitmodules
  - stage: stage .gitmodules


Note that "git rm" and "git mv" will keep working when !G just as
t3600-rm.sh and t7001-mv.sh mandate, I am not sure if they should fail
if "!G and H".

In my previous attempt I also tried to check for the skip-worktree bit,
but I am not sure if this is needed.

My intuition suggested the following behavior to cover the case of
a manually crafted .gitmodules which could be committed and override the
hidden one:

S = .gitmodules has the skip-worktree bit set

S:
  - read: get value from .gitmodules if G or from HEAD:.gitmodules if H
  - write: exit with error, .gitmodules is not supposed to be changed
  - stage: exit with error, .gitmodules is not supposed to be changed

However it looks like git gives the user quite some freedom to add,
stage, commit, remove files even when they have the skip-worktree bit
set (which was a little surprising to me TBH) so I am leaving this out
for now.


Changes since v1:

  * Added a helper to print config values from the gitmodules
    configuration, the code is now in submoudle-config.c instead of
    buildtin/submodule--helper.c

  * Renamed config_gitmodules_set to
    config_set_in_gitmodules_file_gently and put it in
    submodule-config.c instead of submodule.c

    The naming follows the style of git config functions, and also takes
    into account Stefan Beller's comment about the final purpose of the
    function: we only write gitmodules config to the actual .gitmodules
    file, so we may as well reflect that in the function name,

  * Started using "working tree" instead of "work tree" as the former is
    the official term for the set of checked out files.

  * Start referring to HEAD as the "current branch" instead of "the
    index", the former should be more accurate.

  * Renamed GITMODULES_BLOB to GITMODULES_HEAD because GITMODULES_BLOB
    was added in commit 59e7b080 ("fsck: detect gitmodules files",
    2018-05-02)

  * Do not check for the skip-worktree bit on .gitmodules anymore, just
    check for file existence when appropriate.

  * Renamed t7415-submodule-sparse-gitmodules.sh to
    t7416-submodule-sparse-gitmodules.sh because t7415 was taken by
    t7415-submodule-names.sh

  * Made "git mv" and "git rm" work again when .gitmodules does not
    exist.

  * Removed checks about the  skip-worktree bit.


Thanks,
   Antonio

Antonio Ospite (12):
  submodule: add a print_config_from_gitmodules() helper
  submodule: factor out a config_set_in_gitmodules_file_gently function
  t7411: be nicer to future tests and really clean things up
  submodule--helper: add a new 'config' subcommand
  submodule: use the 'submodule--helper config' command
  submodule--helper: add a '--stage' option to the 'config' sub command
  submodule: use 'submodule--helper config --stage' to stage .gitmodules
  t7506: cleanup .gitmodules properly before setting up new scenario
  submodule: support reading .gitmodules even when it's not checked out
  t7416: add new test about HEAD:.gitmodules and not existing
    .gitmodules
  dir: move is_empty_file() from builtin/am.c to dir.c and make it
    public
  submodule: remove the .gitmodules file when it is empty

 builtin/am.c                           |  15 ----
 builtin/submodule--helper.c            |  82 ++++++++++++++++++
 cache.h                                |   1 +
 dir.c                                  |  16 ++++
 dir.h                                  |   1 +
 git-submodule.sh                       |  10 +--
 submodule-config.c                     |  53 +++++++++++-
 submodule-config.h                     |   3 +
 submodule.c                            |  20 +++--
 t/t3600-rm.sh                          |  32 +++----
 t/t7400-submodule-basic.sh             |  11 +++
 t/t7411-submodule-config.sh            |  65 +++++++++++++-
 t/t7416-submodule-sparse-gitmodules.sh | 112 +++++++++++++++++++++++++
 t/t7506-status-submodule.sh            |   3 +-
 14 files changed, 375 insertions(+), 49 deletions(-)
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
