Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919D8C433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7316A600D3
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhJTBJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:09:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37028 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhJTBJQ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 Oct 2021 21:09:16 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 459D260786;
        Wed, 20 Oct 2021 01:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1634691992;
        bh=0glHI5VDiJIwIWZYs/4kKFoRVfdx+35K9YtLrLK/mdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IW4z8BkPBUNnuubKkgqvGUUQ0qqgcKJlJE+0+0HSxGk8k80RDR85SJ+epgnNInXAp
         hzXgi9nklanfZis/pp3GMBJ+o82eArTmggk+hlF8z1s1xf3FXmtqZDnU8dpJSliAMk
         VUg/BaNZ0JyJjYpFQ14JQkF4nTsns3vIorUbJ6znVbaQulQkQge6POngqLktT5XY5R
         poLGhTvHMIdOiaI5uVPZuwD7DTIVAXXdh/Gf2ka70UhWo7CnqQ7CF7jok26BJ7/LZW
         xtWl9No05FIQwpeVnfIoFlIyqFYQ+oUg3at0zEF/yzrRKPJLT7jKgvGFyCY5fbye14
         /mr7i/pLO/0H2FuUS0Yh8L8aS7mVQ6PdvKeo2dQxFSrdOTRkfhQShmLLZmQiwtgOHD
         O0pIsr72nVGFKD+lrRZ7oWc86sumvMugppACNCu9rZuFN2KN3fR/sPz1K0FK1k+UcK
         H0yiUW8kH2w8TojZBV3amUF8+Fmf/netiHdr9gB3wqO0QXWEgIS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 2/4] gitfaq: add documentation on proxies
Date:   Wed, 20 Oct 2021 01:06:21 +0000
Message-Id: <20211020010624.675562-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2
In-Reply-To: <20211020010624.675562-1-sandals@crustytoothpaste.net>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many corporate environments and local systems have proxies in use.  Note
the situations in which proxies can be used and how to configure them.
At the same time, note what standards a proxy must follow to work with
Git.  Explicitly call out certain classes that are known to routinely
have problems reported various places online, including in the Git for
Windows issue tracker and on Stack Overflow, and recommend against the
use of such software.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 946691c153..abc0f62e6c 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -241,6 +241,24 @@ How do I know if I want to do a fetch or a pull?::
 	ignore the upstream changes.  A pull consists of a fetch followed
 	immediately by either a merge or rebase.  See linkgit:git-pull[1].
 
+[[proxy]]
+Can I use a proxy with Git?::
+	Yes, Git supports the use of proxies.  Git honors the standard `http_proxy`,
+	`https_proxy`, and `no_proxy` environment variables commonly used on Unix, and
+	it also can be configured with `http.proxy` and similar options for HTTPS (see
+	linkgit:git-config[1]).  The `http.proxy` and related options can be
+	customized on a per-URL pattern basis.  In addition, Git can in theory
+	function normally with transparent proxies that exist on the network.
++
+However, note that for Git to work properly, the proxy must be completely
+transparent.  The proxy cannot modify, tamper with, change, or buffer the
+connection in any way, or Git will almost certainly fail to work.  Note that
+many proxies, including many TLS middleboxes, Windows antivirus and firewall
+programs other than Windows Defender and Windows Firewall, and filtering proxies
+fail to meet this standard, and as a result end up breaking Git.  Because of the
+many reports of problems, we recommend against the use of these classes of
+software and devices.
+
 Design
 ------
 
