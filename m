Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57DD211B9
	for <e@80x24.org>; Thu, 27 Dec 2018 02:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeL0CRq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 21:17:46 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57996 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbeL0CRq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 21:17:46 -0500
Received: from genre.crustytoothpaste.net (S0106ac1f6b61f856.vc.shawcable.net [50.64.113.123])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 770A56042F;
        Thu, 27 Dec 2018 02:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545877063;
        bh=PwKTSui76jKjaog7nhbHiLQBvtMtlQccWumvxZNnUg8=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=B09WmMRWhq1lBTUVN88xVqABaFH0zsIIdlHxRmr/8CjKwzJQUVLtpw3aCYqlc6TVU
         bZi2LzTAf2F7yuSNpYzTSSr4DmMAf5kdKhyECZwI241+3puJYsy1cLFMpAnKaC25jQ
         SfCbu8VmDFkYpPL9sclBh9AgeBSLuELJd1GgELvhkCnWU/NnDc9UXIc9zXN+jsCN/M
         B53JahOYRYqdCjtsCBWfIRXN30SOhVPoHsBTmJkSeHk3ZcrarwL3hQmlfZGdPPn1UE
         YjKBWS9DFMnnk8ZmWpYkGA0KdWaSw2l9UW3dgzhMha7K+HKAc4Scfhiu8PZNbpr/yv
         pvwFqDLFovZ4bnwGCSxMnFgpB3TWY5+KssUoyQbQIvFv5tpn/NqWxmOC0cXU3nDlGx
         KNE4QY2NEv7thst9MsEnTQPCmaTVaI9QCcA8GQsMwA/hV3TxtJUe8v8sTgTchNFtat
         8mOP7We20kij6WPDY5WJ5v1zjMqWaiyzfVCdLtgUuNrCWkMQvaQ
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 0/2] Improve documentation on UTF-16
Date:   Thu, 27 Dec 2018 02:17:32 +0000
Message-Id: <20181227021734.528629-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.415.g653613c723
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We've recently fielded several reports from unhappy Windows users about
our handling of UTF-16, UTF-16LE, and UTF-16BE, none of which seem to be
suitable for certain Windows programs.

In an effort to communicate the reasons for our behavior more
effectively, explain in the documentation that the UTF-16 variant that
people have been asking for hasn't been standardized, and therefore
hasn't been implemented in iconv(3). Mention what each of the variants
do, so that people can make a decision which one meets their needs the
best.

In addition, add a comment in the code about why we must, for
correctness reasons, reject a UTF-16LE or UTF-16BE sequence that begins
with U+FEFF, namely that such a codepoint semantically represents a
ZWNBSP, not a BOM, but that that codepoint at the beginning of a UTF-8
sequence (as encoded in the object store) would be misinterpreted as a
BOM instead.

This comment is in the code because I think it needs to be somewhere,
but I'm not sure the documentation is the right place for it. If
desired, I can add it to the documentation, although I feel the lurid
details are not interesting to most users. If the wording is confusing,
I'm very open to hearing suggestions for how to improve it.

I don't use Windows, so I don't know what MSVCRT does. If it requires a
BOM but doesn't accept big-endian encoding, then perhaps we should
report that as a bug to Microsoft so it can be fixed in a future
version. That would probably make a lot more programs work right out of
the box and dramatically improve the user experience.

As a note, I'm currently on vacation through the 2nd, so my responses
may be slightly delayed.

brian m. carlson (2):
  Documentation: document UTF-16-related behavior
  utf8: add comment explaining why BOMs are rejected

 Documentation/gitattributes.txt | 5 +++++
 utf8.c                          | 7 +++++++
 2 files changed, 12 insertions(+)

