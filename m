Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78CE31F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933442AbcHYPAU (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:00:20 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37937 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758724AbcHYPAR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:00:17 -0400
Received: by mail-wm0-f42.google.com with SMTP id o80so76485352wme.1
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IXbiukpVZJt3q54veub2fREJCT2A70RpjRHlTLxzNmk=;
        b=TGnyZhtoz7OW4VWOXQiaUX5p+F+cbNQkt6yLb4Mi6rxbxXfJpsmsg8jLQRFKn+4Eq9
         pjtMrOvTQv4CYPiKhknId4uVsvUMqq/6qoD9NTx1mMmv9q57r7VDl3w72r82GQt1J+pr
         w64Gw0CMCgoFhyu/akJE/7JhVIvUrqV/B+oDjb0o0K79Nv3WAIs0W/l7Bzrbbo8l2SVf
         1cxdUSZZAqGak+PjSPTuQ2Q537GetpEcp1pidCCgXR2MY7xeFvr162X3pkufYxXtBZQq
         XAqtfqvUYmkM23w6z4dcojAkXvIXHFqn30Yh2scUXR8740sLswlCZNqqsO0PLi7un3++
         oImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IXbiukpVZJt3q54veub2fREJCT2A70RpjRHlTLxzNmk=;
        b=B25TgNSxibyPWOqeVBaLYjkeISHPxQBNjiT3wUgMGynr4S7G1t0zTY47FDgvzfxSsQ
         Dn9Z36GJwkcOu4YE9nitbLJ+uNYNw8edfwtCsM5f4BFsdMO57xEpva6XDcDkRqVPDgEV
         oYHEnRBqvVqSNaXHCC+xkOrOKLPyix6ivBrmiAPX3FmMnTLP7lSZ/dI1wxIhL6m5ttKy
         T7dhbJpqC7k7ilx+pHRT0APpkjZwjZ/PZ0HBdyN8vXblzjzZ/lTZJ/H/AK36DaScSXcn
         uMslMDZHwNLkbuJxWu+yx51mb5UY4eDber1UGuQUKgjPVx7VGTcVLnBeMKBJLC+9gGr2
         qSRg==
X-Gm-Message-State: AEkoout83IT1SBtJgPeTPNGT12XgSI3+88ExreKyi0k7LsvoXjw60BNQzDVqgvN8D/Gx1Q==
X-Received: by 10.28.25.71 with SMTP id 68mr27855954wmz.19.1472123286365;
        Thu, 25 Aug 2016 04:08:06 -0700 (PDT)
Received: from bcnf9f9l32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id p71sm38304839wmf.9.2016.08.25.04.08.05
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 25 Aug 2016 04:08:05 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v6 07/13] pack-protocol: fix maximum pkt-line size
Date:   Thu, 25 Aug 2016 13:07:46 +0200
Message-Id: <20160825110752.31581-8-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160825110752.31581-1-larsxschneider@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

According to LARGE_PACKET_MAX in pkt-line.h the maximal length of a
pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
therefore the pkt-line data component must not exceed 65516 bytes.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/technical/protocol-common.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
index bf30167..ecedb34 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -67,9 +67,9 @@ with non-binary data the same whether or not they contain the trailing
 LF (stripping the LF if present, and not complaining when it is
 missing).
 
-The maximum length of a pkt-line's data component is 65520 bytes.
-Implementations MUST NOT send pkt-line whose length exceeds 65524
-(65520 bytes of payload + 4 bytes of length data).
+The maximum length of a pkt-line's data component is 65516 bytes.
+Implementations MUST NOT send pkt-line whose length exceeds 65520
+(65516 bytes of payload + 4 bytes of length data).
 
 Implementations SHOULD NOT send an empty pkt-line ("0004").
 
-- 
2.9.2

