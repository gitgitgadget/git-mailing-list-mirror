Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A5FE1F428
	for <e@80x24.org>; Tue, 14 Aug 2018 11:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbeHNNwa (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 09:52:30 -0400
Received: from ao2.it ([92.243.12.208]:42912 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeHNNwa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 09:52:30 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fpX7U-0007ZV-Vz; Tue, 14 Aug 2018 13:04:13 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fpX90-0004dz-En; Tue, 14 Aug 2018 13:05:46 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Daniel=20Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>, Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v3 0/7] Make submodules work if .gitmodules is not checked out
Date:   Tue, 14 Aug 2018 13:05:18 +0200
Message-Id: <20180814110525.17801-1-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this series teaches git to try and read the .gitmodules file from the
current branch (HEAD:.gitmodules) when it's not readily available in the
working tree.

This can be used, along with sparse checkouts, to enable submodule usage
with programs like vcsh[1] which manage multiple repositories with their
working trees sharing the same path.

[1] https://github.com/RichiH/vcsh


This is v3 of the series from:
https://public-inbox.org/git/20180802134634.10300-1-ao2@ao2.it/

The cover letter of the first proposal contains more background:
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

Changes since v2:

  * Removed the extern keyword from the public declaration of
    print_config_from_gitmodules() and
    config_set_in_gitmodules_file_gently()

  * Used test_when_finished in t/t7411-submodule-config.sh and remove
    the problematic commits as soon as they are not needed anymore.

  * Restructured the code in module_config to avoid an unreachable
    section, the code now dies as a fallback if the arguments are not
    supported, as suggested by Jeff.

  * Dropped patches and tests about "submodule--helper config --stage"
    as they are not strictly needed for now and there is no immediate
    benefit from them.

  * Added a check to git-submodule.sh::cdm_add to make it fail earlier
    if the .gitmodules file is not "safely writeable". This also fixes
    one of the new tests which was previously marked as
    "test_expect_failure".

  * Fixed a broken &&-chain in a subshell in one of the new tests, the
    issue was exposed by a recent change in master.

  * Dropped a note about "git rm" and "git mv", it was intended as
    a personal reminder and not for the general public.

  * Squashed t7416-submodule-sparse-gitmodules.sh in the same commit of
    the code it exercises.

  * Dropped the two unrelated patches from v2:
    
      - dir: move is_empty_file() from builtin/am.c to dir.c and make it
        public
      - submodule: remove the .gitmodules file when it is empty

    as they are orthogonal to this series. I will send them as
    a standalone series.

  * Minor wording fixes here and there.


The series looks a lot cleaner and more to the point, thanks for the
review.

Ciao,
   Antonio

Antonio Ospite (7):
  submodule: add a print_config_from_gitmodules() helper
  submodule: factor out a config_set_in_gitmodules_file_gently function
  t7411: be nicer to future tests and really clean things up
  submodule--helper: add a new 'config' subcommand
  submodule: use the 'submodule--helper config' command
  t7506: clean up .gitmodules properly before setting up new scenario
  submodule: support reading .gitmodules even when it's not checked out

 builtin/submodule--helper.c            | 29 +++++++++
 cache.h                                |  1 +
 git-submodule.sh                       | 15 +++--
 new                                    |  0
 submodule-config.c                     | 53 ++++++++++++++-
 submodule-config.h                     |  3 +
 submodule.c                            | 10 +--
 t/t7411-submodule-config.sh            | 33 +++++++++-
 t/t7416-submodule-sparse-gitmodules.sh | 90 ++++++++++++++++++++++++++
 t/t7506-status-submodule.sh            |  3 +-
 10 files changed, 221 insertions(+), 16 deletions(-)
 create mode 100644 new
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
