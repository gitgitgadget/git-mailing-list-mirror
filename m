Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6191F461
	for <e@80x24.org>; Sat,  7 Sep 2019 17:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395108AbfIGRIE (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 13:08:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58580 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387994AbfIGRIE (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 7 Sep 2019 13:08:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:6959:e43b:5cf6:a465])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0428D6074C;
        Sat,  7 Sep 2019 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567876081;
        bh=sPJOfyaNuOaB0UQW8YFq8vd8f67i3n2JbpSgMjSTF+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=V/ZemjvMkBpFf/8ePvS+knSGQ4UnDm75EAN+2oPoOPEi0t24ZsQfY4JzxGxpK9/Kq
         3g0TRslR9AKIIFhxPyc+D+2Asu/4TXYR/VH91k/BF5BNEqI21iEh/EyNotmZfFcOeQ
         LZW9bej8aDWHuIjRbc3oWZyKyWURfiwuNRWWEZ0LZuDoPAUrPNGfzVBSicoOPLBx+H
         vLmMhtoSSozeZGZXI8us69i3zYD0at7qkIRfdyEYD3eXb5kpn8NJV+SPhOBZunpF63
         1llMzxMLWvE44O50MzY2aADLzD4meADFzCS17icPTUqhbU/w6kipSj2xgAHnjfYsp1
         hSFgT5ybApJon0hUkcfbVmZ3x4+81OysEQsTorLYqqhz9vmOFKk3IM54vz7aCp3gYN
         s4hcmRROs23ezyItn68VS9ndkcydJosFV/DOimYrRsZdE1N491MGb0Iy72gALJ6d1E
         dgPUtZYOoVSht8s66s/O0R+OnINwqg2FkqaULodC3unmhkqdfQu
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation: fix build with Asciidoctor 2
Date:   Sat,  7 Sep 2019 17:07:46 +0000
Message-Id: <20190907170746.273984-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734
In-Reply-To: <20190906232947.GJ11334@genre.crustytoothpaste.net>
References: <20190906232947.GJ11334@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our documentation toolchain has traditionally been built around DocBook
4.5.  This version of DocBook is the last DTD-based version of DocBook.
In 2009, DocBook 5 was introduced using namespaces and its syntax is
expressed in RELAX-NG, which is more expressive and allows a wider
variety of syntax forms.

Asciidoctor, one of the alternatives for building our documentation,
dropped support for DocBook 4.5 in its recent 2.0 release and now only
supports DocBook 5.  This would not be a problem but for the fact that
we use xmlto, which is still stuck in the DocBook 4.5 era.

xmlto performs DTD validation as part of the build process.  This is not
problematic for DocBook 4.5, which has a valid DTD, but it clearly
cannot work for DocBook 5, since no DTD can adequately express its full
syntax.  In addition, even if xmlto did support RELAX-NG validation,
that wouldn't be sufficient because it uses the libxml2-based xmllint to
do so, which has known problems with validating interleaves in RELAX-NG.

Fortunately, there's an easy way forward: ask Asciidoctor to use its
DocBook 5 backend and tell xmlto to skip validation.  Asciidoctor has
supported DocBook 5 since v0.1.4 in 2013 and xmlto has supported
skipping validation for probably longer than that.

xmlto will still use the non-namespaced DocBook XSL stylesheets (which
are designed for DocBook 4.5) for building the documentation instead of
the namespaced ones (which are designed for DocBook 5).  This isn't
really a problem, since both forms are built from the same source and
can handle both versions, but it does mean that an ugly message about
the stylesheets stripping the namespace will be printed to standard
error.

Overall, however, this message is a relatively minor price to pay and it
means that we can continue to use the aging xmlto to drive our build
process, while still supporting newer tooling like Asciidoctor 2.

The differences in output between AsciiDoc 8.6.10 on master and
Asciidoctor 2.0.10 with this patch are, with one exception, all due to
whitespace, wrapping, or quoting and do not affect substantive content.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 76f2ecfc1b..485f365cbf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -197,11 +197,12 @@ ifdef USE_ASCIIDOCTOR
 ASCIIDOC = asciidoctor
 ASCIIDOC_CONF =
 ASCIIDOC_HTML = xhtml5
-ASCIIDOC_DOCBOOK = docbook45
+ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
 DBLATEX_COMMON =
+XMLTO_EXTRA += --skip-validation
 endif
 
 SHELL_PATH ?= $(SHELL)
