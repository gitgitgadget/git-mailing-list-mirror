Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AAE21F667
	for <e@80x24.org>; Sat, 12 Aug 2017 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbdHLIrZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 04:47:25 -0400
Received: from vie01a-dmta-pe01-1.mx.upcmail.net ([62.179.121.154]:32684 "EHLO
        vie01a-dmta-pe01-1.mx.upcmail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750904AbdHLIrY (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Aug 2017 04:47:24 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe01.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1dgS4o-000298-HD
        for git@vger.kernel.org; Sat, 12 Aug 2017 10:47:22 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id w8nF1v01o5BuuEg018nHtZ; Sat, 12 Aug 2017 10:47:17 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id A895145D4512; Sat, 12 Aug 2017 10:47:15 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [PATCH] Add overflow check to get_delta_hdr_size
Date:   Sat, 12 Aug 2017 09:27:18 +0200
Message-Id: <1502522838-12581-1-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
Applies on top of my size_t series

I'm not sure, if die or error is better.

 delta.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/delta.h b/delta.h
index 2df0f55..18a4983 100644
--- a/delta.h
+++ b/delta.h
@@ -96,6 +96,11 @@ static inline size_t get_delta_hdr_size(const unsigned char **datap,
 		cmd = *data++;
 		size |= (cmd & 0x7f) << i;
 		i += 7;
+		if (bitsizeof(size_t) <= i) {
+			error("too large object size");
+			size = 0;
+			break;
+		}
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
 	return size;
-- 
2.1.4

