Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F47C1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 13:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeHXRFA (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 13:05:00 -0400
Received: from ao2.it ([92.243.12.208]:59514 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbeHXRFA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 13:05:00 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1ftC8c-0000hT-Dd; Fri, 24 Aug 2018 15:28:30 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1ftCAJ-00025w-IO; Fri, 24 Aug 2018 15:30:15 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v4 0/9] Make submodules work if .gitmodules is not checked out
Date:   Fri, 24 Aug 2018 15:29:42 +0200
Message-Id: <20180824132951.8000-1-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this series teaches git to try and read the .gitmodules file from the
index (:.gitmodules) and the current branch (HEAD:.gitmodules) when it
is not readily available in the working tree.

This can be used, together with sparse checkouts, to enable submodule
usage with programs like vcsh[1] which manage multiple repositories with
their working trees sharing the same path.

[1] https://github.com/RichiH/vcsh

In v4 patches 1, 2, 5, 6, and 7 are basically the same as in the
previous series; the review can concentrate on patches 3, 4, 8, and 9.

v3 of the series is here:
https://public-inbox.org/git/20180814110525.17801-1-ao2@ao2.it/

v2 of the series is here:
https://public-inbox.org/git/20180802134634.10300-1-ao2@ao2.it/

v1 of the series, with some background info, is here:
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

Changes since v3:

  * Improve robustness of current tests in t7411-submodule-config.sh:
      - merge two tests that check for effects of the same commit.
      - reset to a well defined point in history when exiting the tests.

  * Fix style issues in new tests added to t7411-submodule-config.sh:
      - use test_when_finished in new tests.
      - name the output file 'expect' instead of 'expected'.

  * Add a new "submodule--helper config --check-writeable" command.

  * Use "s--h config --check-wrteable" in git-submodule.sh to share the
    code with the C implementation instead of duplicating the safety
    check in shell script.

  * Add the ability to read .gitmodules from the index and then
    fall-back to the current branch if the file is not in the index.
    Add also more tests to validate all the possible scenarios.

  * Fix style issues in t7416-submodule-sparse-gitmodules.sh:
      - name the output file 'expect' instead of 'expected'.
      - remove white space after the redirection operator.
      - indent the HEREDOC block.
      - use "git -C super" instead of a subshell when there is only one
        command in the test.

  * Remove a stale file named 'new' which erroneusly slipped in
    a commit.

  * Update some comments and commit messages.


Thanks,
   Antonio

Antonio Ospite (9):
  submodule: add a print_config_from_gitmodules() helper
  submodule: factor out a config_set_in_gitmodules_file_gently function
  t7411: merge tests 5 and 6
  t7411: be nicer to future tests and really clean things up
  submodule--helper: add a new 'config' subcommand
  submodule: use the 'submodule--helper config' command
  t7506: clean up .gitmodules properly before setting up new scenario
  submodule: add a helper to check if it is safe to write to .gitmodules
  submodule: support reading .gitmodules when it's not in the working
    tree

 builtin/submodule--helper.c            |  40 +++++++++
 cache.h                                |   2 +
 git-submodule.sh                       |  13 ++-
 submodule-config.c                     |  55 ++++++++++++-
 submodule-config.h                     |   3 +
 submodule.c                            |  28 +++++--
 submodule.h                            |   1 +
 t/t7411-submodule-config.sh            | 107 +++++++++++++++++++++----
 t/t7416-submodule-sparse-gitmodules.sh |  78 ++++++++++++++++++
 t/t7506-status-submodule.sh            |   3 +-
 10 files changed, 301 insertions(+), 29 deletions(-)
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
