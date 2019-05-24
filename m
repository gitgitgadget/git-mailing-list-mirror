Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B3871F462
	for <e@80x24.org>; Fri, 24 May 2019 20:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404057AbfEXU20 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 16:28:26 -0400
Received: from avasout01.plus.net ([84.93.230.227]:56044 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403852AbfEXU20 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 16:28:26 -0400
Received: from [10.0.2.15] ([87.115.253.20])
        by smtp with ESMTPA
        id UGnchpd8VmVenUGndhAaLW; Fri, 24 May 2019 21:28:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1558729704; bh=ieMToXe8Z2A6+SP1nrlhCgOtQ6I4DvfX7M77Jc5WcV4=;
        h=From:Subject:To:Cc:Date;
        b=EHhZcE/fOvzgDeIgx4lbfPh3e/Iw4byQ8ce39uGCB1ftlYFx8D5bNGZphsRw5HDW8
         3urj2/841fibfyAea8n7ZsL1k7g+fW0iczguzHC8PMhwCt6EtaA+b6uuCvW503nu8Y
         5KjHIkrc1yHza5ruGuEvDEjFIsAu8M4jjoT08/AJTE5sehaw2hXLoXD+i0qTDMOCUe
         nTdewlKaIuKJBCEvqjsauoScaQ+0XI8de+N/3v/RUvTf1l1QV31t+t6aXhEEBMyxgj
         SlyW3PtR/A8cYBYBJQuKClcYXoizuopBKRoycwnhK7NYzHsnpGIUPsmet9PEtFFQqN
         /+/anX3pHiKuA==
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=I5Ubu+og c=1 sm=1 tr=0
 a=ceBz2RPxfYaxgFK6o8vNfQ==:117 a=ceBz2RPxfYaxgFK6o8vNfQ==:17
 a=IkcTkHD0fZMA:10 a=yfo40GYm8zQ6gm7IkY4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 00/52] fix some -Wmissing-field-initializer warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Message-ID: <cf0b720e-ad29-79e7-17d5-b69d50e7007e@ramsayjones.plus.com>
Date:   Fri, 24 May 2019 21:28:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfIrUyJcPT//2uNMKhET34OI1kG9l4IkCzJiGfUTwI41TMZkTxXS//My7qT2fM3iXVHoEEmRCxEuzqhLUa+F1zJOp3w2l7MMoPMh65Mm6IJvsysu4TNar
 zUkhrqPMuhtk4qwgx9SKqnvG3hWxjnHk5cRWU92f5uV1txHV4awZTleZthIJK9A6M20YSagG/3I0mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


[No, I won't be sending 52 patches to the list!]

This series, started last year, has been hanging around because the
time never seemed right to send it to the list. It may still not be
the right time ... :-D

I would like to be able to compile git using '-Wall -Wextra -Werror'
compiler options. In order to see how far away we are from that
possibility, you can build with DEVELOPER=1 along with the additional
settings: 'DEVOPTS=extra-all no-error pedantic'.

That leads to many warnings:

      $ git describe
      v2.22.0-rc1
      $ make >out 2>&1
      $ grep warning out | sed -e 's/.*\[-W/\[-W/' | sort | uniq -c
            9 [-Wempty-body]
         1694 [-Wmissing-field-initializers]
          159 [-Wpedantic]
          945 [-Wsign-compare]
         2821 [-Wunused-parameter]
      $

Note that at the beginning of this cycle, the numbers were quite a bit
smaller (and this series was only 37 patches, rather than 52):

      $ git describe
      v2.21.0
      $ make >out 2>&1
      $ grep warning out | sed -e 's/.*\[-W/\[-W/' | sort | uniq -c
            9 [-Wempty-body]
          759 [-Wmissing-field-initializers]
          925 [-Wsign-compare]
         2732 [-Wunused-parameter]
      $

This series removes the, newly introduced, pedantic warnings and
eliminates all 1371 'missing-field-initializers' warnings that
relate to 'struct option':

      $ cat out-warn-master.stats
            9 [-Wempty-body]
          323 [-Wmissing-field-initializers]
          945 [-Wsign-compare]
         2821 [-Wunused-parameter]
      $ 

Thus, after about six months, I am further away from my target than
when I started! ;-)

This series does not fix any problems or add any new features, so it
is not important (hence the tendency to 'slip'). I don't want to
flood the mailing list with patches that nobody wants, so: is there
any interest in these kinds of patches? If not, I will stop now!
(I have a 2-3 year old branch that addressed the '-Wsign-compare'
warnings, but that is probably beyond salvaging by now :( ).

This series is available from: git://repo.or.cz/git/raj.git with the
branch name 'warn-master'. A trial merge to current 'next' and 'pu'
branches can be found at 'warn-next' and 'warn-pu' branches. (The
merge to 'next' went without problem, and 'pu' only required a fixup
to the builtin/commit patch).

[The 'warn-v2.21' branch shows the previous version of the series.]

What do you think?

Thanks!

ATB,
Ramsay Jones

Ramsay Jones (52):
  parse-options: reformat the OPT_X() macros
  parse-options: move some one-line OPT_X() macros
  parse-options: rename callback parameter from 'f' to 'cb'
  parse-options: add missing field initializers
  list-objects-filter-options: add missing initializer
  ref-filter.h: add missing field initializers
  parse-options: add an OPT_LL_CALLBACK() macro
  parse-options.h: add 'd' parameter to OPT_INTEGER_F()
  parse-options.h: fix some -Wpedantic warnings
  builtin/update-index: fix some -Wmissing-field-initializers warnings
  builtin/log: fix some -Wmissing-field-initializers warnings
  builtin/notes: fix some -Wmissing-field-initializers warnings
  builtin/grep: fix some -Wmissing-field-initializers warnings
  builtin/commit: fix some -Wmissing-field-initializers warnings
  apply.c: fix some -Wmissing-field-initializers warnings
  builtin/rebase: fix some -Wmissing-field-initializers warnings
  builtin/config: add missing field initializers
  test-parse-options: fix some -Wmissing-field-initializers warnings
  builtin/read-tree: fix some -Wmissing-field-initializers warnings
  builtin/merge: fix some -Wmissing-field-initializers warnings
  builtin/fetch: fix some -Wmissing-field-initializers warnings
  builtin/commit-tree: fix some -Wmissing-field-initializers warnings
  builtin/tag: fix an -Wmissing-field-initializers warning
  builtin/push: fix some -Wmissing-field-initializers warnings
  builtin/pack-objects: fix some -Wmissing-field-initializers warnings
  builtin/ls-files: fix some -Wmissing-field-initializers warnings
  builtin/blame: fix some -Wmissing-field-initializers warnings
  builtin/show-ref: fix some -Wmissing-field-initializers warnings
  builtin/show-branch: fix an -Wmissing-field-initializers warning
  builtin/send-pack: fix some -Wmissing-field-initializers warnings
  builtin/pull: fix some -Wmissing-field-initializers warnings
  builtin/fmt-merge-msg: fix some -Wmissing-field-initializers warnings
  builtin/describe: fix some -Wmissing-field-initializers warnings
  builtin/cat-file: fix some -Wmissing-field-initializers warnings
  builtin/shortlog: fix an -Wmissing-field-initializers warning
  builtin/reset: fix an -Wmissing-field-initializers warning
  builtin/remote: fix an -Wmissing-field-initializers warning
  builtin/ls-remote: fix an -Wmissing-field-initializers warning
  builtin/interpret-trailers: fix an -Wmissing-field-initializers warning
  builtin/clean: fix an -Wmissing-field-initializers warning
  builtin/checkout-index: fix an -Wmissing-field-initializers warning
  builtin/checkout: fix an -Wmissing-field-initializers warning
  builtin/branch: fix an -Wmissing-field-initializers warning
  builtin/add: fix an -Wmissing-field-initializers warning
  builtin/write-tree: fix an -Wmissing-field-initializers warning
  builtin/revert: fix an -Wmissing-field-initializers warning
  builtin/name-rev: fix an -Wmissing-field-initializers warning
  builtin/init-db: fix an -Wmissing-field-initializers warning
  builtin/gc: fix an -Wmissing-field-initializers warning
  builtin/clone: fix an -Wmissing-field-initializers warning
  builtin/am: fix an -Wmissing-field-initializers warning
  diff.c: fix an -Wmissing-field-initializers warning

 apply.c                       |  28 ++---
 builtin/add.c                 |   4 +-
 builtin/am.c                  |   6 +-
 builtin/blame.c               |   6 +-
 builtin/branch.c              |   7 +-
 builtin/cat-file.c            |   8 +-
 builtin/checkout-index.c      |   4 +-
 builtin/checkout.c            |   7 +-
 builtin/clean.c               |   5 +-
 builtin/clone.c               |   2 +-
 builtin/commit-tree.c         |  24 ++--
 builtin/commit.c              |  21 ++--
 builtin/config.c              |   2 +-
 builtin/describe.c            |   8 +-
 builtin/fetch.c               |  17 +--
 builtin/fmt-merge-msg.c       |  10 +-
 builtin/gc.c                  |   3 +-
 builtin/grep.c                |  24 ++--
 builtin/init-db.c             |   4 +-
 builtin/interpret-trailers.c  |   4 +-
 builtin/log.c                 |  56 ++++-----
 builtin/ls-files.c            |  12 +-
 builtin/ls-remote.c           |   4 +-
 builtin/merge.c               |  17 +--
 builtin/name-rev.c            |   8 +-
 builtin/notes.c               |  32 ++---
 builtin/pack-objects.c        |  12 +-
 builtin/pull.c                |  16 +--
 builtin/push.c                |  22 ++--
 builtin/read-tree.c           |  19 +--
 builtin/rebase.c              |  69 ++++++-----
 builtin/remote.c              |   5 +-
 builtin/reset.c               |   5 +-
 builtin/revert.c              |   5 +-
 builtin/send-pack.c           |  11 +-
 builtin/shortlog.c            |   4 +-
 builtin/show-branch.c         |  10 +-
 builtin/show-ref.c            |  11 +-
 builtin/tag.c                 |  19 ++-
 builtin/update-index.c        |  61 +++++-----
 builtin/write-tree.c          |   6 +-
 diff.c                        |   4 +-
 list-objects-filter-options.h |   2 +-
 parse-options.h               | 216 ++++++++++++++++++++++------------
 ref-filter.h                  |   2 +-
 t/helper/test-parse-options.c |  16 +--
 46 files changed, 458 insertions(+), 380 deletions(-)

-- 
2.21.0
