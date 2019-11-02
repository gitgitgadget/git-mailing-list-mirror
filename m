Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87D4E1F4C0
	for <e@80x24.org>; Sat,  2 Nov 2019 19:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfKBT0t (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 15:26:49 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59078 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbfKBT0t (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 2 Nov 2019 15:26:49 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 9EAAF61CB6;
        Sat,  2 Nov 2019 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572722807;
        bh=TYJOmqsT/cC0WSPdgMWdI+L0br0vqYbAvEz/dj3+Vj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=s7jIjqsc2zPsKm8csPE0tULFTG/SyAHyPaEWdJ4X+9Ynr7Xjrb/DVjse8Jhw9jp+d
         QZ9fX2LLpS4mKgw1xeIF3CVqUOFYML4fR9u4BIIsuYot01REZvucqiyCVnw63U4TRL
         shz4eZOr+/CvAbW/J68skzbm92SSldOcVpillM3aUwDMgfUQTI9WlGB9gk4hShA9dV
         ZP2v20D4u0MBjsQJ6/aWSMbSfBc2HGoHTEwsb7DrMccavdz7mCO2Z7Gddrx43jW6jt
         3I9ipULrhA/odpZWCg5h3BDN7j6JCc9OXCitQVQVhZaOQYbT5vqzg9eyilTdTzYdUF
         SKcT6GlVGiV4qNlu3IBQkLnK3uEBaAiIGA/aSqElHsioB7h7JFcPUFga8iTHgRr5qc
         xnRZ8zeCzLImxmtOeeGb1qfSZWVj26rd9OGGyOvG1MHmDFEFfpjUYUbuCHGtabKF5u
         OdJqTN0lk52c/23wKOeeg9bPV7da2boHZ23oPICnI++WVCOnL22
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/4] docs: mention when increasing http.postBuffer is valuable
Date:   Sat,  2 Nov 2019 19:26:15 +0000
Message-Id: <20191102192615.10013-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc2.428.g50e10028f1
In-Reply-To: <20191102192615.10013-1-sandals@crustytoothpaste.net>
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
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
 Documentation/config/http.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
index 5a32f5b0a5..08b375fe95 100644
--- a/Documentation/config/http.txt
+++ b/Documentation/config/http.txt
@@ -199,6 +199,14 @@ http.postBuffer::
 	Transfer-Encoding: chunked is used to avoid creating a
 	massive pack file locally.  Default is 1 MiB, which is
 	sufficient for most requests.
++
+Note that raising this limit is only effective for disabling chunked
+transfer encoding and therefore should be used only where the remote
+server or a proxy only supports HTTP/1.0 or is noncompliant with the
+HTTP standard.  Raising this is not, in general, an effective solution
+for most push problems, but can increase memory consumption
+significantly since the entire buffer is allocated for even small
+pushes.
 
 http.lowSpeedLimit, http.lowSpeedTime::
 	If the HTTP transfer speed is less than 'http.lowSpeedLimit'
