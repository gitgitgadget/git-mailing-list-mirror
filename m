Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817F41F6BF
	for <e@80x24.org>; Thu,  8 Sep 2016 07:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932520AbcIHH5t (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 03:57:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:53926 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757718AbcIHH5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 03:57:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MPV69-1bdDFP0aMj-004mUI; Thu, 08 Sep 2016 09:57:42
 +0200
Date:   Thu, 8 Sep 2016 09:57:27 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <cover.1473319844.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1473321437.git.johannes.schindelin@gmx.de>
References: <cover.1473319844.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:MulzrU30pvDwXta8e4GiORfcaD+zbF16qyDpKtV/5svUIMpCVrN
 7iHSkAh7Fc8qiZ+1Pf7GOjQIslL04gY5W1Z0K4u8RmRmeKBtcYEoKiw7jkvjVO6srvBd9rI
 Bg2b9YlcacvcWYladstapBgB8688vrCQQN1kyAal++KV+FVFnpaTXbtlATRxitNk698uVb8
 xyzGcYBzdQ/N260JKLn+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/DqHR2uaSWk=:L0/ZCzzYXUNsuwNF7AXIwm
 SdEoLhmIw1MbyK629rCwfqta4UnyBqAi8HO4d6apnjjVPpHp31VAtFYSQ8u8vGM2ehQRP9Ddo
 L7RLV9vQwYQvtobOwHjZtK+46N9hvDkGuGh0rjFfQv1eEN4M8TZRG98aa9P/TVzCc8da2yvqz
 PpYUlFkFCNZOmH2+SBP+zyewBTuxRDP74yO7Bd0ZAyKFSzkLpB9Jf+o0RQlOTyIa7/0ScIRYx
 qXqepe9pV8v5P4tNMyQzXq0339ekywv/1R7YuH/wZoJfM10p/Y/pyt93YlXYnm/1q1I6DB1dN
 4qOQ7BNYATMWqJ1K3scFlYzIPCHDCQVS1udkrxeWD2SEfUipmEO/8NDeSXM5+4PJfbsbsXhom
 gPgwIXTqwyhD7rS+11YRw/tmdpQMcDtQP2VjsxQWQj+9qiC6QeoEupOFLUIOLqh2t1bnpsBUU
 7JhopopeRLfEK4NPmmXtENGcR/xDYY8qlN/WFUi/KkpqPZ2vD2Ti+fUzxEboF3uuvH/Tle39S
 lF92KUrJreyCCiCCmBUsN8xgpc2vTnuP9/nCgv7hHjcbXpNVFHknPJc5EyBYkXdFl2GtMAVXt
 GUFIsoujzcv0jjFcNXOeg1ZApnh+ZIepDV6Ls2A5IjeXDdudVFesFcbMDW9HVqz2utqEQv8xf
 q8JlbIIJSVvBGtm0H7aSpZQU/udjiFy331puzzMQSeGUNqnIKucz+JST5QvBikpM10BmMEaXF
 jAiagEG0uS1629iCWO6LHGPFOkFPdiFp6N1O5lZKgr3NYW8f1m9nL5kdljD7/XwMDoBbzQsbJ
 Sb2VQGw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series addresses a problem where `git diff` is called using
`-G` or `-S --pickaxe-regex` on new-born files that are configured
without user diff drivers, and that hence get mmap()ed into memory.

The problem with that: mmap()ed memory is *not* NUL-terminated, yet the
pickaxe code calls regexec() on it just the same.

This problem has been reported by my colleague Chris Sidi.

We solve this by introducing a helper, regexec_buf(), that takes a
pointer and a length instead of a NUL-terminated string.

This helper then uses REG_STARTEND where available, and falls back to
allocating and constructing a NUL-terminated string. Given the
wide-spread support for REG_STARTEND (Linux has it, MacOSX has it, Git
for Windows has it because it uses compat/regex/ that has it), I think
this is a fair trade-off.

Changes since v2:

- changed 3/3 to switch the test_expect_failure from 1/3 to a
  test_expect_success


Johannes Schindelin (3):
  Demonstrate a problem: our pickaxe code assumes NUL-terminated buffers
  Introduce a function to run regexec() on non-NUL-terminated buffers
  Use the newly-introduced regexec_buf() function

 diff.c                  |  3 ++-
 diffcore-pickaxe.c      | 18 ++++++++----------
 git-compat-util.h       | 21 +++++++++++++++++++++
 t/t4061-diff-pickaxe.sh | 22 ++++++++++++++++++++++
 xdiff-interface.c       | 13 ++++---------
 5 files changed, 57 insertions(+), 20 deletions(-)
 create mode 100755 t/t4061-diff-pickaxe.sh

Published-As: https://github.com/dscho/git/releases/tag/mmap-regexec-v3
Fetch-It-Via: git fetch https://github.com/dscho/git mmap-regexec-v3

Interdiff vs v2:

 diff --git a/t/t4061-diff-pickaxe.sh b/t/t4061-diff-pickaxe.sh
 index 5929f2e..f0bf50b 100755
 --- a/t/t4061-diff-pickaxe.sh
 +++ b/t/t4061-diff-pickaxe.sh
 @@ -14,7 +14,7 @@ test_expect_success setup '
  	test_tick &&
  	git commit -m "A 4k file"
  '
 -test_expect_failure '-G matches' '
 +test_expect_success '-G matches' '
  	git diff --name-only -G "^0{4096}$" HEAD^ >out &&
  	test 4096-zeroes.txt = "$(cat out)"
  '

-- 
2.10.0.windows.1.10.g803177d

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
