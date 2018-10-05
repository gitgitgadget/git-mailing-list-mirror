Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1633C1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeJEUEt (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:49 -0400
Received: from mail.ao2.it ([92.243.12.208]:44927 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbeJEUEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ao2.it; s=20180927;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=yoFdM4vi5tLs/48iu1kvbiexl3/XuacRSVorAdzv9PI=;
        b=qKyb68C/j1UsaV5cA41pRVDFmCnlklnwSFk93MpvFmOVp2iDlgas54+MTbr+hItwEtc80eU61x1C+aZk0Fwev5lMPnKLqtxQ+FJU06V1Be+VrRi5p3IToJ1so2Sv/9B/UPsA5YIAPYazKQxeakrv+UYiYktXMng+isdrZEPsRpF10jZ+1kg+9t64LMuyob46rtRjdAEx/1vm52uuMwJL+VSl/p/RAhtozVfL3eoO09lsn6np2L18Smg6BZFy9TKEd6dDT1Tx9LRQNeKvwC2u0P5zfph31i45rnzP+N3gS9aQ025aoG5+E4jP1g+VOkJdaeZAOj4cBWGDB3CHN1VZfA==;
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g8PlT-0003BK-Us; Fri, 05 Oct 2018 15:03:32 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1g8Pnx-000490-57; Fri, 05 Oct 2018 15:06:05 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v6 00/10] Make submodules work if .gitmodules is not checked out
Date:   Fri,  5 Oct 2018 15:05:51 +0200
Message-Id: <20181005130601.15879-1-ao2@ao2.it>
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


Thanks to SZEDER Gábor we found out that the changes in patch 9 could
allow to access the object store in an inconsistent way when using
multi-threading in "git grep --recurse-submodules", this has been dealt
with in this revision.

BTW, with Stefan Beller we also identified some unneeded code which
could have been removed to alleviate the issue, but that would not have
solved it completely; so, I am not removing the unnecessary call to
repo_read_gitmodules() builtin/grep.c in this series, possibly this can
become a stand-alone change.

The problems from above also made me investigate what implications the
current use of a global object store had on my new addition, and now
I know that there is one case which I cannot support just yet: nested
submodules without .gitmodules in their working tree.

This case has been documented with a warning and test_expect_failure
items in tests, and hitting the unsupported case does not alter the
current behavior of git.

Apart form patch 9 and 10 there are no major changes to the previous
iteration.

IMHO we are in a place where the problem has been analyzed with enough
depth, the limitations have been identified and dealt with in a way that
should not affect current users nor diminish the usefulness of the new
code.

v5 of the series is here:
https://public-inbox.org/git/20180917140940.3839-1-ao2@ao2.it/

v4 of the series is here:
https://public-inbox.org/git/20180824132951.8000-1-ao2@ao2.it/

v3 of the series is here:
https://public-inbox.org/git/20180814110525.17801-1-ao2@ao2.it/

v2 of the series is here:
https://public-inbox.org/git/20180802134634.10300-1-ao2@ao2.it/

v1 of the series, with some background info, is here:
https://public-inbox.org/git/20180514105823.8378-1-ao2@ao2.it/

Changes since v5:

  * print_config_from_gitmodules() in patch 1 now accepts a struct
    repository argument.

  * submodule--helper config in patch 5 has been adjusted to use the new
    signature of print_config_from_gitmodules().

  * In patch 9 the grep read lock in builtin/grep.c now covers all code
    paths involving config_from_gitmodules().
    
    FTR git-grep is the only place where config_from_gitmodules() is
    called from multi-threaded code.

  * Patch 9 also documents the rare case that cannot be supported just
    yet, and adds a warning to the user.

  * In patch 9, config_from_gitmodules() now does not read any config
    when the config source is not specified.(I added a catch-all "else"
    block) This match more closely the behavior of the old code using
    git_config_from_file.

  * Added a new test tool in patch 10 to exercise config_read_config()
    in a more direct way, passing an arbitrary repository.
    
    Admittedly, patch 10 performs a similar test to the one added to
    t7814 in patch 9, so I'd be OK with dropping patch 10 if it is too
    specific.

Thank you,
   Antonio

Antonio Ospite (10):
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
  t/helper: add test-submodule-nested-repo-config

 Makefile                                     |   1 +
 builtin/grep.c                               |  17 ++-
 builtin/submodule--helper.c                  |  40 ++++++
 cache.h                                      |   2 +
 git-submodule.sh                             |  13 +-
 submodule-config.c                           |  68 ++++++++-
 submodule-config.h                           |   2 +
 submodule.c                                  |  28 +++-
 submodule.h                                  |   1 +
 t/helper/test-submodule-nested-repo-config.c |  30 ++++
 t/helper/test-tool.c                         |   1 +
 t/helper/test-tool.h                         |   1 +
 t/t7411-submodule-config.sh                  | 141 +++++++++++++++++--
 t/t7416-submodule-sparse-gitmodules.sh       |  78 ++++++++++
 t/t7506-status-submodule.sh                  |   3 +-
 t/t7814-grep-recurse-submodules.sh           |  16 +++
 16 files changed, 410 insertions(+), 32 deletions(-)
 create mode 100644 t/helper/test-submodule-nested-repo-config.c
 create mode 100755 t/t7416-submodule-sparse-gitmodules.sh

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
