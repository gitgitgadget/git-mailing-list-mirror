Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7EE01F597
	for <e@80x24.org>; Tue, 17 Jul 2018 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGQNXH (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 09:23:07 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:55286 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731186AbeGQNXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 09:23:05 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6HCoEHa029112
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 14:50:14 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id w6HCoEZU005172;
        Tue, 17 Jul 2018 14:50:14 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v4 0/7] X509 (gpgsm) commit signing support
Date:   Tue, 17 Jul 2018 14:50:06 +0200
Message-Id: <cover.1531831244.git.henning.schild@siemens.com>
X-Mailer: git-send-email 2.16.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v4:
 - make gpg.format matching case sensitive
 - (final?) coding style and wording changes

Changes in v3:
 - drop patches 1 and 2 known from < v3, see pu hs/push-cert-check-cleanup
 - dropped some testcases from p6, added two t7004 bad key/sig
 - ship a binary x509 certificate for tests, no generation anymore
 - silence gpgsm in tests
 - switch all tests to use test_config instead of "git config"
 - p4 deal with invalid input
 - p3 several refactorings, see "PATCH v2 5/9" discussion

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

The first 5 patches prepare for the introduction of the actual feature in
patch 6.
Finally patch 7 extends the testsuite to cover the new feature.

This series can be seen as a follow up of a series that appeared under
the name "gpg-interface: Multiple signing tools" in april 2018 [1]. After
that series was not merged i decided to get my patches ready. The
original series aimed at being generic for any sort of signing tool, while
this series just introduced the X509 variant of gpg. (gpgsm)
I collected authors and reviewers of that first series and already put them
on cc.

[1] https://public-inbox.org/git/20180409204129.43537-1-mastahyeti@gmail.com/

Henning Schild (7):
  gpg-interface: add new config to select how to sign a commit
  t/t7510: check the validation of the new config gpg.format
  gpg-interface: introduce an abstraction for multiple gpg formats
  gpg-interface: do not hardcode the key string len anymore
  gpg-interface: introduce new config to select per gpg format program
  gpg-interface: introduce new signature format "x509" using gpgsm
  gpg-interface t: extend the existing GPG tests with GPGSM

 Documentation/config.txt   |  10 +++++
 gpg-interface.c            | 108 +++++++++++++++++++++++++++++++++++++--------
 t/lib-gpg.sh               |  28 +++++++++++-
 t/lib-gpg/gpgsm-gen-key.in |   8 ++++
 t/lib-gpg/gpgsm_cert.p12   | Bin 0 -> 2652 bytes
 t/t4202-log.sh             |  39 ++++++++++++++++
 t/t5534-push-signed.sh     |  52 ++++++++++++++++++++++
 t/t7004-tag.sh             |  13 ++++++
 t/t7030-verify-tag.sh      |  33 ++++++++++++++
 t/t7510-signed-commit.sh   |   9 ++++
 10 files changed, 281 insertions(+), 19 deletions(-)
 create mode 100644 t/lib-gpg/gpgsm-gen-key.in
 create mode 100644 t/lib-gpg/gpgsm_cert.p12

-- 
2.16.4

