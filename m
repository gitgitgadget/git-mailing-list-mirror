Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEABD1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134AbcHCQnu (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 12:43:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36524 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757348AbcHCQnE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 12:43:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so37153144wma.3
        for <git@vger.kernel.org>; Wed, 03 Aug 2016 09:42:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hdbHVPEh0Oz6ddSs8BaBqfc12kUbhSZE000Ke00Lzgc=;
        b=rm/5WIUNAkq96VreOlD7axY/AIqaJ0vlIlPzxMOOx37tP06nc15wV1gCzJQqIXh+K9
         kuzFW0BMQW6Oq1uhA1k/KFnFb5+jCmg/TjIMNU+oL4cjRbpFUxzLK0Y56oE1zB3Ianyg
         RwgrSSyng1BeJ4Xs8ySt1176KMeZsn7v8d4+ig4iNS/7dV7yiEXNBAyN9P+uqN0cuY5m
         YSwr29F/0vTz9SHv7nP+5IfXnRUnkaC9YxZn5yT0wYP2Xa8jfjzFoCknr4WgU/ugs28C
         FmLfGLe3MYn8hPhbkq88JIhIcCxNWIQWmupfmox4zw+/I9y8mZxxg9dvss9+DjzMS6Dq
         IiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hdbHVPEh0Oz6ddSs8BaBqfc12kUbhSZE000Ke00Lzgc=;
        b=kpQqZAqQkbFIWjVX2MXV9popesBBhn2d92RcfltUl6pPxYyBFEIakST4dsRLbhldsW
         QrpPhBruSARtgSLatF2BXvCLEGlgU/s3mIW9Vseixp1qi8KwfG+dR4t2FWgjA9EMypSw
         Mo+jc5IZbk4JeO7u8YyUnrkFd8rCb71ZqHkMTh9dUPaOmZdFFK/kiBgBHbsn7pNID/DU
         KBuOqkfvyUkyjA4PModTGUXR+kVqgfpmK5GSO+CfpoxzeIUT0bwgORQSwxzk3YKemIGc
         lL16onwJYlkD3yAZz+/FnwsveXeD8La56aSrANOn2+nXmg76oVFiPnB4jcBHgokaFmuq
         uQrQ==
X-Gm-Message-State: AEkoouutE8t3dTyqz4ah9ogMMFEeiq/nJdhNf4XvUx/w+js4+QwZWvODXBnErg8QJRDP/Q==
X-Received: by 10.28.152.66 with SMTP id a63mr26351784wme.66.1470242554112;
        Wed, 03 Aug 2016 09:42:34 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 3sm8959736wms.1.2016.08.03.09.42.33
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 03 Aug 2016 09:42:33 -0700 (PDT)
From:	larsxschneider@gmail.com
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, jnareb@gmail.com, tboegi@web.de,
	mlbright@gmail.com, e@80x24.org, peff@peff.net,
	Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 06/12] pack-protocol: fix maximum pkt-line size
Date:	Wed,  3 Aug 2016 18:42:19 +0200
Message-Id: <20160803164225.46355-7-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160803164225.46355-1-larsxschneider@gmail.com>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
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
2.9.0

