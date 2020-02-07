Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B92C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 22:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C245821741
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 22:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgBGWQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Feb 2020 17:16:48 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56230 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgBGWQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 17:16:48 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j0Bva-009STp-Nt
        for git@vger.kernel.org; Fri, 07 Feb 2020 23:16:46 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     git@vger.kernel.org
Subject: [PATCH] pack-format: correct multi-pack-index description
Date:   Fri,  7 Feb 2020 23:16:40 +0100
Message-Id: <20200207221640.46876-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The description of the multi-pack-index contains a small bug,
if all offsets are < 2^32 then there will be no LOFF chunk,
not only if they're all < 2^31 (since the highest bit is only
needed as the "LOFF-escape" when that's actually needed.)

Correct this, and clarify that in that case only offsets up
to 2^31-1 can be stored in the OOFF chunk.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 Documentation/technical/pack-format.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/pack-format.txt b/Documentation/technical/pack-format.txt
index cab5bdd2ff0f..d3a142c65202 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/technical/pack-format.txt
@@ -315,10 +315,11 @@ CHUNK DATA:
 	    Stores two 4-byte values for every object.
 	    1: The pack-int-id for the pack storing this object.
 	    2: The offset within the pack.
-		If all offsets are less than 2^31, then the large offset chunk
+		If all offsets are less than 2^32, then the large offset chunk
 		will not exist and offsets are stored as in IDX v1.
 		If there is at least one offset value larger than 2^32-1, then
-		the large offset chunk must exist. If the large offset chunk
+		the large offset chunk must exist, and offsets larger than
+		2^31-1 must be stored in it instead. If the large offset chunk
 		exists and the 31st bit is on, then removing that bit reveals
 		the row in the large offsets containing the 8-byte offset of
 		this object.
-- 
2.24.1

