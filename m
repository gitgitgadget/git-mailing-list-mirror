Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D207C20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdLEQ75 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:59:57 -0500
Received: from siwi.pair.com ([209.68.5.199]:45192 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752621AbdLEQ7R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:59:17 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5EDB2844E6;
        Tue,  5 Dec 2017 11:59:17 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C7FB6844DE;
        Tue,  5 Dec 2017 11:59:16 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 09/12] fixup: sha1_file: convert gotos to break/continue
Date:   Tue,  5 Dec 2017 16:58:51 +0000
Message-Id: <20171205165854.64979-10-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165854.64979-1-git@jeffhostetler.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 sha1_file.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index fc7718a..ce67f27 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1180,30 +1180,30 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		}
 	}
 
-retry:
-	if (find_pack_entry(real, &e))
-		goto found_packed;
+	while (1) {
+		if (find_pack_entry(real, &e))
+			break;
 
-	/* Most likely it's a loose object. */
-	if (!sha1_loose_object_info(real, oi, flags))
-		return 0;
+		/* Most likely it's a loose object. */
+		if (!sha1_loose_object_info(real, oi, flags))
+			return 0;
 
-	/* Not a loose object; someone else may have just packed it. */
-	reprepare_packed_git();
-	if (find_pack_entry(real, &e))
-		goto found_packed;
-
-	/* Check if it is a missing object */
-	if (fetch_if_missing && repository_format_partial_clone &&
-	    !already_retried) {
-		fetch_object(repository_format_partial_clone, real);
-		already_retried = 1;
-		goto retry;
-	}
+		/* Not a loose object; someone else may have just packed it. */
+		reprepare_packed_git();
+		if (find_pack_entry(real, &e))
+			break;
 
-	return -1;
+		/* Check if it is a missing object */
+		if (fetch_if_missing && repository_format_partial_clone &&
+		    !already_retried) {
+			fetch_object(repository_format_partial_clone, real);
+			already_retried = 1;
+			continue;
+		}
+
+		return -1;
+	}
 
-found_packed:
 	if (oi == &blank_oi)
 		/*
 		 * We know that the caller doesn't actually need the
-- 
2.9.3

