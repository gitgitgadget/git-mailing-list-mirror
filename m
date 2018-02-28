Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EFF21F404
	for <e@80x24.org>; Wed, 28 Feb 2018 19:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeB1TIY (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 14:08:24 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40332 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbeB1TIW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 14:08:22 -0500
Received: by mail-wm0-f67.google.com with SMTP id t6so7106009wmt.5
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 11:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GyGGuU3DD1rIDr0NeXD34YgNSXWaPzsiJMY+BWinx+g=;
        b=XAl4CjpnRx7DfkVNtqajJOYV3vUp4dQ3Ef2ZsVClydhYYSWsDsOsIS+ktYFYDjGjDY
         ZxY5XuaJYmdQ3E7rpD8JUWTe8+bkBDjhETWs+bmhhbKxlcDDZQ4uk4GPQWNRHI08QzVE
         u6/gdjhWPTUlSd2eC7HEC9Yq/+odaUMNZf6rBm4t8twI5FJwy2/8DiZJv/Bl4u/qTZ48
         upEQXmvSN53tk+I1OvwAjNVLRaE4ckAjb5WCq2Lep6p01NQCIn71R6VdJxPM9O8vNARE
         bVLpOMCJqP5OSX9H2SzATXvknvH2UEwCZh9qhq2+vm/8ny90zzXkm0lzU/feY7OqoWHz
         q8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GyGGuU3DD1rIDr0NeXD34YgNSXWaPzsiJMY+BWinx+g=;
        b=ipL+ysmN/F5Z5zR3EA7VGkXX9KyPibHW2rqjQz7UZ358otLg5hVxQ2/Ke/J5sUYNMW
         S6nmaXg0kM/aOhN08T9tqTBeixWWtaWMaBaq+Xx9mnjs1ZIfsZERUzKmMFH0WIc0nqSG
         B2qdzE8Rqt5Q1JWWJEQ8OWpXiCFTk+uIffiiImcXb9TO++v+F0SABwZF6gyLulEdL7WC
         5OYAIfzfpPYnSrs8wmUyISHrQ+yLV9EFj2p4nNctza0JAF0u/8SEiUK7PCBCNJ/5/shN
         Jr3er3McUDIBc/sgWG2ZzYYHsRwlJtj7u/1GQNpzA2fr5BMAYlp9xfJtlB/m9a1n7+8R
         Oq0A==
X-Gm-Message-State: APf1xPA6GF9oI7pwtWbJfiS39QXUcJU+y2dAxX2nF3jiZ/o++toxWGJm
        wF9P/U2qOoZqzqPhhP6JMuoLxkO9
X-Google-Smtp-Source: AG47ELuBa0x21T7QtehdO0bN36rWixdjftgxfP8QQyJ/OKLht5xZnuZZQJ86AHKUVjCMIFZTXxi2ZA==
X-Received: by 10.28.84.26 with SMTP id i26mr11746135wmb.129.1519844900985;
        Wed, 28 Feb 2018 11:08:20 -0800 (PST)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p76sm2832609wmb.19.2018.02.28.11.08.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Feb 2018 11:08:20 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 3/5] merge-recursive: always roll back lock in `merge_recursive_generic()`
Date:   Wed, 28 Feb 2018 20:07:56 +0100
Message-Id: <e902855072b5beb107c9dd5a5651c25c54386d03.1519843916.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.16.2.246.ga4ee44448f
In-Reply-To: <cover.1519843916.git.martin.agren@gmail.com>
References: <CAN0heSqmWAN=rCO8busGtb0xNPiB5H_jkL664qH8xasPq1Sy0A@mail.gmail.com> <cover.1519843916.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we return early, or if `active_cache_changed` is false, we forget to
roll back the lockfile.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 merge-recursive.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cc5fa0a949..002fb82cf1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2198,12 +2198,15 @@ int merge_recursive_generic(struct merge_options *o,
 	hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
 	clean = merge_recursive(o, head_commit, next_commit, ca,
 			result);
-	if (clean < 0)
+	if (clean < 0) {
+		rollback_lock_file(&lock);
 		return clean;
+	}
 
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &lock, COMMIT_LOCK))
 		return err(o, _("Unable to write index."));
+	rollback_lock_file(&lock);
 
 	return clean ? 0 : 1;
 }
-- 
2.16.2.246.ga4ee44448f

