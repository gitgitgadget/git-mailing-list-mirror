Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C2C1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeFVQ1x (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:27:53 -0400
Received: from ao2.it ([92.243.12.208]:53092 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934349AbeFVQ1h (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:37 -0400
Received: from localhost ([::1] helo=jcn)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fWOtm-0007WS-KI; Fri, 22 Jun 2018 18:26:58 +0200
Received: from ao2 by jcn with local (Exim 4.91)
        (envelope-from <ao2@ao2.it>)
        id 1fWOuJ-00053B-LU; Fri, 22 Jun 2018 18:27:31 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 0/7] Restrict the usage of config_from_gitmodules()
Date:   Fri, 22 Jun 2018 18:26:49 +0200
Message-Id: <20180622162656.19338-1-ao2@ao2.it>
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

when I tried to reuse and extend 'config_from_gitmodules' in
https://public-inbox.org/git/20180514105823.8378-2-ao2@ao2.it/ it was
pointed out to me that special care is needed to make sure that this
function does not get abused to bring in arbitrary configuration stored
in the .gitmodules file, as the latter is meant only for submodule
specific configuration.

So I thought that the function could be made private to better
communicate that.

This is what this series is about.

Patch 1 moves 'config_from_gitmodules' to submodule-config.c

Patches 2 and 3 add helpers to handle special cases and avoid calling
'config_from_gitmodules' directly, which might set a bad example for
future code.

Patch 4 makes the symbol private to discourage its use in code not
related to submodules.

Patches 5 and 6 enable reusing 'config_from_gitmodules' when it's safe
to do so.

Patches 7 is just a cleanup and I am not even sure it is worth it, so we
might as well just drop it.

The series can be seen as a continuation of the changes from
https://public-inbox.org/git/20170802194923.88239-1-bmwill@google.com/

Even though the helper functions may be less elegant than what was done
back then, they should better protect from misuse of
config_from_gitmodules.

A further change could be to print warning messages when the backward
compatibility helpers find configuration in .gitmodules that should not
belong there, but I'll leave that to someone else.

Thanks,
   Antonio

P.S. I added Jeff King to CC as he has done some work related to
.gitmodules recently, and I removed the vcsh poeple on this one.

Antonio Ospite (7):
  config: move config_from_gitmodules to submodule-config.c
  submodule-config: add helper function to get 'fetch' config from
    .gitmodules
  submodule-config: add helper to get 'update-clone' config from
    .gitmodules
  submodule-config: make 'config_from_gitmodules' private
  submodule-config: pass repository as argument to
    config_from_gitmodules
  submodule-config: reuse config_from_gitmodules in repo_read_gitmodules
  submodule-config: cleanup backward compatibility helpers

 builtin/fetch.c             | 15 +--------
 builtin/submodule--helper.c |  8 ++---
 config.c                    | 17 ----------
 config.h                    | 10 ------
 submodule-config.c          | 66 ++++++++++++++++++++++++++++++-------
 submodule-config.h          | 12 +++++++
 6 files changed, 71 insertions(+), 57 deletions(-)

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
