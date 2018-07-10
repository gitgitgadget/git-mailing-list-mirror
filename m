Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE2791F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 08:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeGJIxK (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 04:53:10 -0400
Received: from thoth.sbs.de ([192.35.17.2]:42053 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbeGJIxI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 04:53:08 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id w6A8qh7n026158
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 10:52:43 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6A8qgGN024364;
        Tue, 10 Jul 2018 10:52:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 0/9] X509 (gpgsm) commit signing support
Date:   Tue, 10 Jul 2018 10:52:22 +0200
Message-Id: <cover.1531208187.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
 - removed trailing commas in array initializers and add leading space
 - replaced assert(0) with BUG in p5
 - consolidated 2 format lookups reusing get_format_data p5
 - changed from format "PGP" to "openpgp", later X509 to "x509"
 - use strcasecmp instead of strcmp for format matching
 - introduce gpg.<format>.program in p8, no gpg.programX509 anymore
 - moved t/7510 patch inbetween the two patches changing validation code
 - changed t/7510 patch to use test_config and test_must_fail

This series adds support for signing commits with gpgsm.

The first two patches are cleanups of gpg-interface, they are already
close to being merged. But since they have not been pulled to next i am
resending them.
The following 5 patches (p3-p7) prepare for the introduction of the
actual feature in patch 8.
Finally patch 9 extends the testsuite to cover the new feature.

This series can be seen as a follow up of a series that appeared under
the name "gpg-interface: Multiple signing tools" in april 2018 [1]. After
that series was not merged i decided to get my patches ready. The
original series aimed at being generic for any sort of signing tool, while
this series just introduced the X509 variant of gpg. (gpgsm)
I collected authors and reviewers of that first series and already put them
on cc.

[1] https://public-inbox.org/git/20180409204129.43537-1-mastahyeti@gmail.com/

Henning Schild (9):
  builtin/receive-pack: use check_signature from gpg-interface
  gpg-interface: make parse_gpg_output static and remove from interface
    header
  gpg-interface: add new config to select how to sign a commit
  t/t7510: check the validation of the new config gpg.format
  gpg-interface: introduce an abstraction for multiple gpg formats
  gpg-interface: do not hardcode the key string len anymore
  gpg-interface: introduce new config to select per gpg format program
  gpg-interface: introduce new signature format "x509" using gpgsm
  gpg-interface t: extend the existing GPG tests with GPGSM

 Documentation/config.txt   |  9 +++++
 builtin/receive-pack.c     | 17 ++-------
 gpg-interface.c            | 88 ++++++++++++++++++++++++++++++++++++++--------
 gpg-interface.h            |  2 --
 t/lib-gpg.sh               |  9 ++++-
 t/lib-gpg/gpgsm-gen-key.in |  6 ++++
 t/t4202-log.sh             | 66 ++++++++++++++++++++++++++++++++++
 t/t5534-push-signed.sh     | 52 +++++++++++++++++++++++++++
 t/t7003-filter-branch.sh   | 15 ++++++++
 t/t7030-verify-tag.sh      | 47 +++++++++++++++++++++++--
 t/t7510-signed-commit.sh   | 10 ++++++
 t/t7600-merge.sh           | 31 ++++++++++++++++
 12 files changed, 317 insertions(+), 35 deletions(-)
 create mode 100644 t/lib-gpg/gpgsm-gen-key.in

-- 
2.16.4

