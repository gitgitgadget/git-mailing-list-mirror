Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8321F404
	for <e@80x24.org>; Mon, 17 Sep 2018 14:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeIQThS (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 15:37:18 -0400
Received: from ao2.it ([92.243.12.208]:50073 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728729AbeIQThR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 15:37:17 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g1uBX-0001bS-4V; Mon, 17 Sep 2018 16:07:31 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g1uDg-00010n-6P; Mon, 17 Sep 2018 16:09:44 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v5 0/9] Make submodules work if .gitmodules is not checked out
Date:   Mon, 17 Sep 2018 16:09:31 +0200
Message-Id: <20180917140940.3839-1-ao2@ao2.it>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this series teaches git to try and read the .gitmodules file from the
index (:.gitmodules) or from the current branch (HEAD:.gitmodules) when
the file is not readily available in the working tree.

This can be used, together with sparse checkouts, to enable submodule
usage with programs like vcsh[1] which manage multiple repositories with
their working trees sharing the same path.

[1] https://github.com/RichiH/vcsh


v4 of the series is here:
https://public-inbox.org/git/20180824132951.8000-1-ao2@ao2.it/

v3 of the series is here:
https://public-inbox.org/git/20180814110525.17801-1-ao2@ao2.it/

v2 of the series is here:
https://public-inbox.org/git/20180802134634.10300-1-ao2@ao2.it/

v1 of the series, with some background info, is here:
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

v5 only contains some small cosmetic fixes suggested by Ævar Arnfjörð
Bjarmason, I ignored the comment about the memory leak in patch
1 because I think there is no leak in how git_config_parse_key is used:
https://public-inbox.org/git/87wosfesxl.fsf@evledraar.gmail.com/

Changes since v4:

  * Improve names of local variables in patch 1.

  * Move new functions definitions in patches 1 and 2 before
    a pre-existing comment instead of after it, as the comment does not
    apply to the new functions.

I am repeating the previous changelog below for your convenience, as v3
is what is currently in pu/ao/submodule-wo-gitmodules-checked-out.

Changes between v3 and v4:

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

  * Remove a stale file named 'new' which erroneously slipped in
    a commit.

  * Update some comments and commit messages.


Thank you,
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
 submodule-config.h                     |   2 +
 submodule.c                            |  28 +++++--
 submodule.h                            |   1 +
 t/t7411-submodule-config.sh            | 107 +++++++++++++++++++++----
 t/t7416-submodule-sparse-gitmodules.sh |  78 ++++++++++++++++++
 t/t7506-status-submodule.sh            |   3 +-
 10 files changed, 300 insertions(+), 29 deletions(-)
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
