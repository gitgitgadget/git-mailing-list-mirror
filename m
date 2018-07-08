Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B548A1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 14:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeGHOoP (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 10:44:15 -0400
Received: from s019.cyon.net ([149.126.4.28]:51624 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754014AbeGHOoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 10:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=P5sHX84IjejHamCEBMEbFQs1O37fZNSSBuOYjAjCAUE=; b=rSMQFNxgbj+Z8qwsgmdcXotvZ3
        bLhjLNSxTQGlUZ5B03926YbsJ7P0T0+0xDi952PfGD74jli1SFr81/B8OTTOSG1fuE1iO8wvqv/H9
        2fN2K7r8AB8Ta4aXjugNmiQpGjvdqPgk38t360Xj22yr8ZfVFzYeG6Uibvvk2OSXg0LtJzxcCRbjb
        QAX46XY1z/JndcTTXF+OQ7g+PzVz3z4074+/E9aHVoVxT4cqujDVsU8T60emdqQeUctmhxEoD7wn9
        ddSC0SsbO942vilQ+r3rueEQMex6rhk9hVeFmoqDMcdb+gPhS0NjK6zxQ4lGYOYjKSZ/hrUjpAIc8
        plxUE+4Q==;
Received: from [10.20.10.232] (port=55570 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <bb@drbeat.li>)
        id 1fcAv0-004hb2-O4; Sun, 08 Jul 2018 16:44:08 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id D5FB32056D; Sun,  8 Jul 2018 16:44:04 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [RFC PATCH 6/6] utf8.c: avoid char overflow
Date:   Sun,  8 Jul 2018 16:43:42 +0200
Message-Id: <20180708144342.11922-7-dev+git@drbeat.li>
X-Mailer: git-send-email 2.15.0.rc1.299.gda03b47c3
In-Reply-To: <20180708144342.11922-1-dev+git@drbeat.li>
References: <20180708144342.11922-1-dev+git@drbeat.li>
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ISO C, char constants must be in the range -128..127. Change the BOM
constants to unsigned char to avoid overflow.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 utf8.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/utf8.c b/utf8.c
index d55e20c641..833ce00617 100644
--- a/utf8.c
+++ b/utf8.c
@@ -561,15 +561,15 @@ char *reencode_string_len(const char *in, int insz,
 #endif
 
 static int has_bom_prefix(const char *data, size_t len,
-			  const char *bom, size_t bom_len)
+			  const unsigned char *bom, size_t bom_len)
 {
 	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
 }
 
-static const char utf16_be_bom[] = {0xFE, 0xFF};
-static const char utf16_le_bom[] = {0xFF, 0xFE};
-static const char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
-static const char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
+static const unsigned char utf16_be_bom[] = {0xFE, 0xFF};
+static const unsigned char utf16_le_bom[] = {0xFF, 0xFE};
+static const unsigned char utf32_be_bom[] = {0x00, 0x00, 0xFE, 0xFF};
+static const unsigned char utf32_le_bom[] = {0xFF, 0xFE, 0x00, 0x00};
 
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
-- 
2.15.0.rc1.299.gda03b47c3

