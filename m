Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B712018E
	for <e@80x24.org>; Wed, 10 Aug 2016 19:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941266AbcHJTIn (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:08:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36562 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941264AbcHJTIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:08:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id i138so11367559wmf.3
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 12:08:35 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IXbiukpVZJt3q54veub2fREJCT2A70RpjRHlTLxzNmk=;
        b=Z/ET3jVyjrxoK4L6B6DAPFiRPuCftQpQ3DVZpsJ07qpSMU3kUjvFdoz+lowG16DPvK
         O66vvgOUH6ceEv/Tg7ety7trErHaDsjPJDhno0QmeNyl2+wDV9/KUD6lJ3o7lxKgkpWx
         SxSHgfiqKa9rz8e0jeQNs15a44nkHfcppLLSWsLwDdlSk3pxxTYeshKS4xUOhM5LpMo9
         PdgqiURApbNeVZduz8TTxy93Q4g4i7jFC8wrwB7/za/14JRMm9jHDzzUAuvDUTraUKVL
         szGFXMU0+RfFEXS2/7uiaCIsPkS7HPpY+Lihm3NpEHquKTh06hnStw4f3+wvzCffnCIJ
         ijsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IXbiukpVZJt3q54veub2fREJCT2A70RpjRHlTLxzNmk=;
        b=I0kT9urLyYDu4ogJUGNIsMvcv3LTXmdARX4+XkV5zgXCdTBnUaC1xWE8NwlP0I5Kz3
         ONq2g/2o9Ysl+u4vbHDBIMXkngSvU7xFkoK7og7EvEfnzo4SMYjeaYCHKqzta8tettNa
         GqTnibzxID0kBa/Myp5yRUycCRPNYAkBj4Y455wcbXFDkdXk8cQISCeE31i8nFBeu/SZ
         n0nqRsxPL9OSXqIIaBSKveUrkg1o9/Ecy2MHc+CjNmnAq1nhn+SPVyqiuDfjNrKA0mqm
         /2CI+7kWWws0f40aUxQKdBm0Na0kgYlf31PTOGLp3JxIWEuUgG67cPptJk6/Aj9qznr7
         f1DQ==
X-Gm-Message-State: AEkooutEaWPmHhLjo3YVLlLarlR3bLdjyc4R7aE3ZED56RiFHrePsTs0TfJ2X/c9xebC9w==
X-Received: by 10.194.178.193 with SMTP id da1mr4798885wjc.66.1470834262302;
        Wed, 10 Aug 2016 06:04:22 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id p83sm8319899wma.18.2016.08.10.06.04.21
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 10 Aug 2016 06:04:21 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, mlbright@gmail.com,
	e@80x24.org, peff@peff.net, Johannes.Schindelin@gmx.de,
	ben@wijen.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 09/15] pack-protocol: fix maximum pkt-line size
Date:	Wed, 10 Aug 2016 15:04:05 +0200
Message-Id: <20160810130411.12419-10-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
In-Reply-To: <20160810130411.12419-1-larsxschneider@gmail.com>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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

