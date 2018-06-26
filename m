Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29EF51F516
	for <e@80x24.org>; Tue, 26 Jun 2018 10:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934634AbeFZKro (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 06:47:44 -0400
Received: from ao2.it ([92.243.12.208]:57552 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934343AbeFZKrc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 06:47:32 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fXlUm-0002X3-QN; Tue, 26 Jun 2018 12:46:49 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fXlVN-0002Zr-Ua; Tue, 26 Jun 2018 12:47:25 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH v2 0/6] Restrict the usage of config_from_gitmodules to submodule-config
Date:   Tue, 26 Jun 2018 12:47:04 +0200
Message-Id: <20180626104710.9859-1-ao2@ao2.it>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+ ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is version 2 of the series from
https://public-inbox.org/git/20180622162656.19338-1-ao2@ao2.it/

The .gitmodules file is not meant for arbitrary configuration, it should
be used only for submodules properties.

Plus, arbitrary git configuration should not be distributed with the
repository, and .gitmodules might be a possible "vector" for that.

The series tries to alleviate both these issues by moving the
'config_from_gitmodules' function from config.[ch] to submodule-config.c
and making it private.

This should discourage future code from using the function with
arbitrary config callbacks which might turn .gitmodules into a mechanism
to load arbitrary configuration stored in the repository.

Backward compatibility exceptions to the rules above are handled by
ad-hoc helpers.

Finally (in patch 6) some duplication is removed by using
'config_from_gitmodules' to load the submodules configuration in
'repo_read_gitmodules'.

Changes since v1:
  * Remove an extra space before an arrow operator in patch 2
  * Fix a typo in the commit message of patch 3: s/fetchobjs/fetchjobs
  * Add a note in the commit message of patch 6 about checking the
    worktree before loading .gitmodules
  * Drop patch 7, it was meant as a cleanup but resulted in parsing the
    .gitmodules file twice

The series has been rebased on commit ed843436d ("First batch for 2.19
cycle", 2018-06-25) , and the test suite passes after each commit.

Thanks to Brandon Williams and Stefan Beller for the input.

Ciao,
   Antonio

Antonio Ospite (6):
  config: move config_from_gitmodules to submodule-config.c
  submodule-config: add helper function to get 'fetch' config from
    .gitmodules
  submodule-config: add helper to get 'update-clone' config from
    .gitmodules
  submodule-config: make 'config_from_gitmodules' private
  submodule-config: pass repository as argument to
    config_from_gitmodules
  submodule-config: reuse config_from_gitmodules in repo_read_gitmodules

 builtin/fetch.c             | 15 +-------
 builtin/submodule--helper.c |  8 ++--
 config.c                    | 17 ---------
 config.h                    | 10 -----
 submodule-config.c          | 75 +++++++++++++++++++++++++++++++------
 submodule-config.h          | 12 ++++++
 6 files changed, 80 insertions(+), 57 deletions(-)

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
