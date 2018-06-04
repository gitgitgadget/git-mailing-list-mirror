Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBCAB1F517
	for <e@80x24.org>; Mon,  4 Jun 2018 23:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751223AbeFDXwo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 19:52:44 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33168 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751000AbeFDXwn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Jun 2018 19:52:43 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2120B60732;
        Mon,  4 Jun 2018 23:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528156361;
        bh=AiAigYXVbnramj9EQuFCMPv2M+kLR/3M7bcY7N1v9mo=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qnI+TRx+w2mOWknggEp41tRYjGpHQ41vN7Y2b1/iOjDv53QW4wZgkKccWonUwoLIa
         9TbRBhgPmZE3oSkLBchmkBv7LxRGPoqqpyymULZxK2ADLAPauolkIrNaZ26cd+NnU3
         QkmI3er2YWWsDbZ6WYvyi0yI1FdnWOXwsLJk5HT8iE87MU0irthZ66T3yonLoC3a3d
         wRS+RWeqFifiTXIc7zZ0Ql6eUK789ovX6ZqiNNNgsy/mYp0N8VWOkSMgWptsssKA5X
         3zpRqAbNOJFMcV2PJfUXJOeNE42azj0YUmgIzvru5PPeyP0P/qKcaB79ZKNVQ9vDnY
         LJwYwcNI9Ya1MCDihKIPp54d3hQi0F+TTe21h5vE4n9TTpeHmbdWOCrUGCIKbq6WUB
         ZimhQVt/LRqDIv87tdHAXikxsFhmB+BilzkFQ6P9Vkz3b2J877kx9KnEIEfrkZcxcm
         MFllqrMekNwo6IFamdh4aZJsDc8Lc1W4jlZIT4RIphPy9IeE7xO
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 00/10] Hash-independent tests (part 3)
Date:   Mon,  4 Jun 2018 23:52:19 +0000
Message-Id: <20180604235229.279814-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.17.1.1185.g55be947832
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is next in the series of improvements to make tests
hash-independent.

Introduced here is a test helper, test_translate, that allows lookups in
tests based on the hash algorithm in use.  Alternatives are either
specified inline (the former for SHA-1, the latter for NewHash), or
(more commonly) from a file based on a key.  Some basic examples of
translations are provided and used throughout the tests.

The ultimate idea is that tests can simply drop a file into the
translation directory and use their own test-specific translations if
convenient.

This series (and subsequent series) attempt to standardize slightly on
our use of invalid object IDs in tests.  Since the actual invalid IDs
aren't usually very important, the translations I've made using the
tables aren't necessarily entirely faithful: we will sometimes use
different SHA-1 object IDs than before, but we substitute only invalid
object IDs for different invalid ones.

It's likely in the future that test_translate will support additional
options depending on whether we want input, output, or internal formats.

I had mentioned in a previous comment that a given test would be
included in "the next series" (this one), but I redid the series and
decided to split it into smaller pieces, so it isn't included.  Sorry.

Comments on any aspect of the series are welcome, but thoughts on design
and naming would be especially valuable.

brian m. carlson (10):
  t: add tool to translate hash-related values
  t0000: use hash translation table
  t0002: abstract away SHA-1-specific constants
  t0027: use $ZERO_OID
  t0064: make hash size independent
  t1006: make hash size independent
  t1400: switch hard-coded object ID to variable
  t1405: make hash size independent
  t1406: make hash-size independent
  t1407: make hash size independent

 t/t0000-basic.sh               | 13 ++++-----
 t/t0002-gitfile.sh             | 26 +++++++++---------
 t/t0027-auto-crlf.sh           | 14 +++++-----
 t/t0064-sha1-array.sh          | 49 +++++++++++++++++++---------------
 t/t1006-cat-file.sh            |  4 +--
 t/t1400-update-ref.sh          |  2 +-
 t/t1405-main-ref-store.sh      |  4 +--
 t/t1406-submodule-ref-store.sh |  6 ++---
 t/t1407-worktree-ref-store.sh  |  4 +--
 t/test-lib-functions.sh        | 40 +++++++++++++++++++++++++++
 t/translate/hash-info          |  9 +++++++
 t/translate/oid                | 15 +++++++++++
 12 files changed, 129 insertions(+), 57 deletions(-)
 create mode 100644 t/translate/hash-info
 create mode 100644 t/translate/oid

