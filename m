Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6704A1FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 12:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbcHQMlA (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 08:41:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:60508 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbcHQMk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 08:40:59 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MJjvw-1bYuDg2Kqi-0017Pk; Wed, 17 Aug 2016 14:40:52
 +0200
Date:	Wed, 17 Aug 2016 14:40:51 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH 0/2] Do not lock temporary files via child processes on
 Windows
Message-ID: <cover.1471437637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9xrKK/ONVEtD/wOvpgaCB/3OvI8SK3lO6L64farXpB9dE8M9Wih
 QlYuiPabGm6Usc9t6gnEN5ABXUAszY3YydJeRLJ3eaqq3MCjTEKpBfDlBmVBdNw3phRmVCj
 IZqyDkIsMmnm++DHcb95JLqJmivztPMWB04H4xytfQZkA/xKVPiQNFkid2A54ZFy8hEMG7G
 BLMY44nM2nWeFXJ1sIagQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ZBtfPBCYsYw=:XlZ/QmeLFodZsVNbcEXbWQ
 8RYWqJLkoKDJm1o2v0LVGe9TFcNjL8idRLgWXCguXEV4bbJwP967EdVnL0bdh2Dq6oHuFaGwr
 NANKwaEN7MHgCaVxa0M5Tc+e61Klgut5KexUJvlT+/YUnl4QXPflN//PbYqM1k7B/qIccs+eY
 dljDu2fFZ/k1PCz7ZcOHLh6qAmc5rulIk/Hu8DVJh1r7/Bt4S5j/EhljBKGBdvNVJjCpjP8rT
 ozm99mx9OUhqSaFBMwV5H+Yn5R8/M1q1uwBeWGRGrsRmBqRDWHd8mVzT5gnxIemZIeVV5u3Xz
 bA5sc4BrpaDFh5HHHgolBlYX673prNfA5hl8pEiTmKNF0zYmo4Y2U+iIxQaM2kwkt7J9USm9X
 2D4NVjxefWwvyyK3RFQykv1Y547VNlyfZRgf/GK2Dhzkp2uv2vIIGmG4fsIpQMevHg5WeWxdf
 9TTWvls8Bh/SR3K/EzLbj30kEhAdnhAY556S0yoA0wBPz7y1Sek81XZmwOyulRUr3LRsFejOY
 NndhgC3flqmR+5+v5+mSrwHdmC4j0Et2wdOErTn00JOfKguIWEmKUcw3VJIW0uYLP5d8vfoYz
 M5UrPBP8uI2WFBC5CE6Wf5Tqd2RjuO9VDBZC1F5NSInuMiIQNxPtWW1XMTlzIP+aTO/46Tauj
 hWbreD9sfxutFUdL0kAlLVk7fP9OQsHbS2rD8ssL+MI+CdTM6xlhuR/oi9vT2DiIJQerLmrgC
 lSQSk/YKJoBUsU0wwra2qukONp3gO/orMCk/vEJX9uTgKuHo83fMRGolRvF6joil0iXRhxwGb
 CzjtSwG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This issue was originally reported and fixed in
https://github.com/git-for-windows/git/pull/755

The problem is that file handles to temporary files (such as
index.lock) were inherited by spawned processes. If those spawned
processes do not exit before the parent process wants to delete or
rename them, we are in big trouble.

The original use case triggering the bug is a merge driver that does
not quit, but listen to subsequent merge requests.

However, the same issue turned up in Lars Schneider's work on making
clean/smudge filters batchable (i.e. more efficient by avoiding
possibly thousands of child processes, one per file).


Ben Wijen (2):
  t6026-merge-attr: child processes must not inherit index.lock handles
  mingw: ensure temporary file handles are not inherited by child
    processes

 compat/mingw.h        |  4 ++++
 t/t6026-merge-attr.sh | 13 +++++++++++++
 tempfile.c            |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

Published-As: https://github.com/dscho/git/releases/tag/mingw-index-lock-v1
Fetch-It-Via: git fetch https://github.com/dscho/git mingw-index-lock-v1

-- 
2.9.2.691.g78954f3

base-commit: 07c92928f2b782330df6e78dd9d019e984d820a7
