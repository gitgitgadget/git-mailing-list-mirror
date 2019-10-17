Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9591F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 00:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391716AbfJQAxp (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 20:53:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:45398 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388082AbfJQAxp (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Oct 2019 20:53:45 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6FB3762060;
        Thu, 17 Oct 2019 00:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1571273624;
        bh=8uACwxOTNjAioSjtOo6DvauA73ALKLFLnoMsRHY/DjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Tn+7ORNAtUACUq/9U2BzwjmwQKKEMqIP22IM+OEQOvpbDY5X1yuU3ZEtLG/y3FgNj
         h1Z0IRCo0XZWfmGC3/uBV0N8adu9kWYPLbLnjah6JpMll10vPbzRmZcWfdhB8/e3in
         dlUbK4eQ2xyvokwLUtYTd4uB/DfVEciIxaGhnlSJUeMniFhmMNFk1SaQdUy97BK9+u
         9ybk0wJgMpR1z6uPL1GsgQ0lAE9cgYJ4b4UbzqmmAqseJaoCgTSfJAhQOTMHA0G6W8
         CdgjHbUMPE1BxyYTalNkCUSBzrRaJ6z9AvqcCpnPXJWYep+E80PZzAZoAJM+l8R7Uy
         j1Tu7dhR9grCfsoPAzoESVRehW9WyzY+B3q3dfjJRALZcKxbadOtNDbHqFza+wKLxz
         mVE4R2XzYZQpjnFwdR1B3DPo1Oupp4ofPBy7z45aKSVF9tKSEGYZhQQzXaQfYkqfSa
         04u/7ETG4y/Pdc3ltmvp3KO1ew5mUeHWIA3xmJLTUrnsx0l4TCU
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] docs: mention when increasing http.postBuffer is valuable
Date:   Thu, 17 Oct 2019 00:53:30 +0000
Message-Id: <20191017005330.9021-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c
In-Reply-To: <20191017005330.9021-1-sandals@crustytoothpaste.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users in a wide variety of situations find themselves with HTTP push
problems.  Oftentimes these issues are due to antivirus software,
filtering proxies, or other man-in-the-middle situations; other times,
they are due to simple unreliability of the network.

However, a common solution to HTTP push problems found online is to
increase http.postBuffer.  This works for none of the aforementioned
situations and is only useful in a small, highly restricted number of
cases: essentially, when the connection does not properly support
HTTP/1.1.

Document when raising this value is appropriate and what it actually
does, and discourage people from using it as a general solution for push
problems, since it is not effective there.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/config/http.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 5a32f5b0a5..ba7198846d 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -199,6 +199,13 @@ http.postBuffer::
 	Transfer-Encoding: chunked is used to avoid creating a
 	massive pack file locally.  Default is 1 MiB, which is
 	sufficient for most requests.
++
+Note that raising this limit is only effective for disabling chunked
+transfer encoding and therefore should be used only where the remote
+server or a proxy only supports HTTP/1.0 or is noncompliant with the
+HTTP standard.  Raising this is not, in general, an effective solution
+for most push problems, but can increase memory consumption
+significantly.
 
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
