Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6C7207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdEEP2j (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:28:39 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35061 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752410AbdEEP2i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:28:38 -0400
Received: by mail-qt0-f194.google.com with SMTP id r58so1229107qtb.2
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ipr0NEDwYrqesf7x8jnh1EhyloSKqKDbEu2l+jZa0h0=;
        b=mU/uUMbAD3H/kqgVJfv+wGozH1B5UwaZ6+BnbUQILHBTlGKXpER5ZA3DgbKLkoA/Xm
         0ZeNnWyT2Rv3PZQkvQ+y8H8RTIEv1HDYAxAXvtqzkHW2DTpS0mUAGy1yDRZvFmsLNTsD
         IZWPhzVazEz9Ab5PWiej/6QQZzME+GpgREIdI9H6apt3vkH2CYJWAT5GNlJipKwJM9hC
         TY0OdAkoWSzjG4Zclf1zYMgQuop7sOvyNX+Synq6FYCKqm+tHXdm0/MgE6vYb2g3qtHd
         rtiP/9VLqk7C7Vf9IgLj23SNMQ3qfJFDHNLMUpsORJz5iars+reraf1uhiCnVfToYxBg
         X2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ipr0NEDwYrqesf7x8jnh1EhyloSKqKDbEu2l+jZa0h0=;
        b=Jj+CFieEpzyZh5vxsGxyu0o5aUWcW8jbfdk1hcyALPyF8d2bncv/lTEAsgRAddOJBp
         17wgm+gD7qNnGXnHJ0Rgbyj38NYDEAAQ2QYzqqOJ6sIiA4TiRlAWbC9p9u7DebduRIh2
         sQTNRPDI9OBeDMJeAa0ByT7VeLPRHs2wHvwjWA9ulOMHLxjC045T8KrdbCD8wdiozkGO
         h2dX/MCI122g8+vJRLlKRX9n13kq51+4dVQSlRWFWY0wALiq2VbQPh5qIOdX6Y2m+6+0
         URBxpNrVxL5ihyehM78GUECTHx9JUN3mzjAbpMqRQDKFfOBew64PYegPy7yBT7sVuvaX
         TOnQ==
X-Gm-Message-State: AN3rC/5yTx1u9TYJqonWEchz7OjVs0kZLBK82LX4f2lXQFnnW51bNtsQ
        GHV0d5M+TPxQGQ==
X-Received: by 10.200.36.44 with SMTP id c41mr40666882qtc.223.1493998117425;
        Fri, 05 May 2017 08:28:37 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id t68sm3392792qkc.44.2017.05.05.08.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:28:36 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com, larsxschneider@gmail.com, peff@peff.net
Subject: [PATCH v7 02/10] pkt-line: fix packet_read_line() to handle len < 0 errors
Date:   Fri,  5 May 2017 11:27:54 -0400
Message-Id: <20170505152802.6724-3-benpeart@microsoft.com>
X-Mailer: git-send-email 2.12.2.gvfs.2.20.g3624a68d62.dirty
In-Reply-To: <20170505152802.6724-1-benpeart@microsoft.com>
References: <20170505152802.6724-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update packet_read_line() to test for len > 0 to avoid potential bug
if read functions return lengths less than zero to indicate errors.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Found/Fixed-by: Lars Schneider <larsxschneider@gmail.com>
---
 pkt-line.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index d4b6bfe076..6f05b1a4a8 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -315,7 +315,7 @@ static char *packet_read_line_generic(int fd,
 			      PACKET_READ_CHOMP_NEWLINE);
 	if (dst_len)
 		*dst_len = len;
-	return len ? packet_buffer : NULL;
+	return (len > 0) ? packet_buffer : NULL;
 }
 
 char *packet_read_line(int fd, int *len_p)
-- 
2.12.2.gvfs.2.20.g3624a68d62.dirty

