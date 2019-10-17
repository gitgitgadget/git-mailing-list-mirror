Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C341F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 00:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391708AbfJQAxp (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 20:53:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45392 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391498AbfJQAxp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Oct 2019 20:53:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0666761C70;
        Thu, 17 Oct 2019 00:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571273624;
        bh=XvxHqqXYF2VCra9Gh2vBVGrCRmeaXe0OsjwMcS+RWcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=iZ9CdI+wadsTvt4BD5jnkSACqsmVOD6yJbMxxOo1kFg3iS9M75a57fcvjDAP2F4yn
         yhme6dVMMb9xZmKnV2kL0ggZzsaU/C1aXW9esSdbhdrakPx+Eopuob+UtFPdQrxG4g
         7Cry1MKj/rK903cIuy5z4uqp/niISonAYB54eOLJk4YYFPXxTJp0OZDKfYovkDjwUA
         mlIozR1ztd/fHrPaHAVl3zDYv1o00evzJp2B0xmAFaSNnmKDYppJb/1W11ME9YrkVP
         iZcTdm1839iRvPKEBouHsWhE8/YTAkNiM0UuPNK+ur2pxZHf4kBVVYippkPFye3PK6
         bt9Bm+wtEblzP9PbI6FxzdLJMiCyorpoNn6MbVCO2cL8kkvRslyG4/r2aQeY7kVHIF
         hdPPnKRH1WdWYwD1D1AbrroywJ+/LLo+AIx9IMTDIsrLfV13H7qrFjl6Xn8ylH4MDC
         fMQ9Wnk+7n97RCU5UpAUwoVX2kz5q8L47ZjmVjGPjgmxInDS/7S
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] doc: dissuade users from trying to ignore tracked files
Date:   Thu, 17 Oct 2019 00:53:29 +0000
Message-Id: <20191017005330.9021-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c
In-Reply-To: <20191017005330.9021-1-sandals@crustytoothpaste.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is quite common for users to want to ignore the changes to a file
that Git tracks.  Common scenarios for this case are IDE settings and
configuration files, which should generally not be tracked and possibly
generated from tracked files using a templating mechanism.

However, users learn about the assume-unchanged and skip-worktree bits
and try to use them to do this anyway.  This is problematic, because
when these bits are set, many operations behave as the user expects, but
they usually do not help when git checkout needs to replace a file.

There is no sensible behavior in this case, because sometimes the data
is precious, such as certain configuration files, and sometimes it is
irrelevant data that the user would be happy to discard.

Since this is not a supported configuration and users are prone to
misuse the existing features for unintended purposes, causing general
sadness and confusion, let's document the existing behavior and the
pitfalls in the documentation for git update-index so that users know
they should explore alternate solutions.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-update-index.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a41..502e06abc0 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -543,6 +543,16 @@ The untracked cache extension can be enabled by the
 `core.untrackedCache` configuration variable (see
 linkgit:git-config[1]).
 
+NOTES
+-----
+
+Users often try to use the ``assume unchanged'' and skip-worktree bits
+to tell Git to ignore changes to files that are tracked.  This does not
+work as expected, since Git may still check working tree files against
+the index when performing certain operations.  In general, Git does not
+provide a way to ignore changes to tracked files, so alternate solutions
+are recommended.
+
 SEE ALSO
 --------
 linkgit:git-config[1],
