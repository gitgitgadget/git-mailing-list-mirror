Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 568191F403
	for <e@80x24.org>; Wed, 13 Jun 2018 14:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935761AbeFMOWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 10:22:31 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:45062 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935560AbeFMOWa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 10:22:30 -0400
Received: by mail-ot0-f194.google.com with SMTP id a5-v6so3137122otf.12
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PTGijk/dLYkdEI2QvPxNqejatgqGLfaE/85SaJqdNhs=;
        b=IbwHOjTdXqkI8YA3lkxRbCfJtEj4H1yx0jMKseAD47vmdaZ7HVmlwaBkKiD6RcaTGk
         VVlVpUIAJDJDpJ+Yq57NyFh2pulFgemQ8zEOUNDJwYOn+60ncLyytJodQjC84VyPRvtR
         IVetBbmUBQtHULMgtr6ouV6cnfUDHG8D+EwTn1YpNd3OgDkIWuRteIzZ1wL0/RkImbIw
         ooZnQlb4u8PVSdCzr5i3ctWnprB4ufh3ESIMF8x35KkrSErAwhjUD/cihKfzRXQMpdeL
         oCnuDo7EMOn3JF0hNuSB6JrWoHfCUyFUCuWrT6UUqLvnlIW+keK91g2Lk5PkLMjtFx+V
         Xbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PTGijk/dLYkdEI2QvPxNqejatgqGLfaE/85SaJqdNhs=;
        b=CpAdWX9xl3x1g7DSvKe+PQNCmqnM1h2MtaLOSLnU3A0rq0vryfKdT0aYTJdlcPSQgi
         y1FjFBYxa1ovwDu+HUh3EYDa8/1KsEMTSM27JhY0Vvyi83epWg25G5aBneH74Ouz+572
         P3FNRVnMkkzV0jWllBztC7l7rAI8NVKrDtpR5IcZyMA1JJT5A25YYPHdOIZhR/EoVVf9
         FjUmLIlqQrs7V9hoCOuz9iGVo/n+BB9vEWq/iSBjqFhduf6BV0Qk5N08dkrM8mI/7gul
         GG60rrj4SSdB+3B/QiP/hDdkLv4wD4Wj/SyVgeKxj8sv3bHD7OV9t2hnX+2tenwhx3F4
         igFw==
X-Gm-Message-State: APt69E2Dd7UU9UQ7UAxzn7JmuGouhX6MsofswCRK7qrnmF/L9Rc1L1iz
        qbLMCE0kQG9mNKjetcU0brja7A==
X-Google-Smtp-Source: ADUXVKIq0SNSwxd6bkn5PBsIi7UaCYZ2W4yaVBi9LDCj0ScBqE7dOjreahX8FZBPp+zBGp350LytXg==
X-Received: by 2002:a9d:1531:: with SMTP id u46-v6mr3529514otf.197.1528899749744;
        Wed, 13 Jun 2018 07:22:29 -0700 (PDT)
Received: from dell-suse.jhome.net ([70.123.58.237])
        by smtp.gmail.com with ESMTPSA id r131-v6sm1138082oih.16.2018.06.13.07.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 07:22:28 -0700 (PDT)
From:   Jeremy Linton <lintonrjeremy@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com,
        Jeremy Linton <lintonrjeremy@gmail.com>
Subject: [PATCH v2] packfile: Correct zlib buffer handling
Date:   Wed, 13 Jun 2018 09:22:07 -0500
Message-Id: <20180613142207.14385-1-lintonrjeremy@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buffer being passed to zlib includes a null terminator that
git needs to keep in place. unpack_compressed_entry() attempts to
detect the case that the source buffer hasn't been fully consumed
by checking to see if the destination buffer has been over consumed.

This causes a problem, that more recent zlib patches have been
poisoning the unconsumed portions of the buffer which overwrites
the null, while correctly returning length and status.

Let's replace the null at the end of the buffer to assure that
if its been overwritten by zlib it doesn't result in problems for
git.

Signed-off-by: Jeremy Linton <lintonrjeremy@gmail.com>
---
 packfile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/packfile.c b/packfile.c
index 7c1a2519f..8db5d90ca 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1433,6 +1433,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		return NULL;
 	}
 
+	buffer[size] = 0; /* assure that the buffer is still terminated */
+
 	return buffer;
 }
 
-- 
2.13.6

