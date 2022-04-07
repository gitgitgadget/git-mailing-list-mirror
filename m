Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A279C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 22:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiDGWK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiDGWKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 18:10:24 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F075140F0
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 14:54:00 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id E7BC55A3EE;
        Thu,  7 Apr 2022 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649368439;
        bh=e1heZ5iu+vHK6AExECRdXfQJdgRLSg4U/ygA52vOhCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=D+upvuSCdtpduXa6njhkkYSzvrmp4r9df29mGohvMVRCdLzPihRnp97lKfGHQwd0y
         pikHaR8DB4z0rJP5ZVWkiTnDVzIPrhfahTMf++4M/J+0QZwg2owwPtL83NGzwrxCNT
         7yeGqHJEHUpwXagHBHnbAaoLjrX/o6a7hKgZR6xDYdo0uxC1lZu458ZmTIjBEFPM7n
         kaCETmhBp7aYvK7hp4QNVWH1H402ZksEGC0b/EaDhmQoav2x4NsfQ84ph36W684yFq
         gp2OTuNozLb8RtF2o/2S9GRBuDu/s/UrEFti1bwKQANCYmjauP2PO/8WExZcsBK4LB
         G3JlkK6oeb6S0kX938tcsr45yiTafn5iGxns1/HslsWMdnj1Y7mFQ4nEmwNZG0SJ9x
         1a1aOMVCVq19oDTCL3zWOd7wMC5OUXVzRztynbV6uhyFmZ/b8cccVv0ieAk60I5N84
         8KV5r4qLytft560dOBijE0miLvXNFN0RVmOd1X7MkMVsq1kdJ7O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/4] object-name: make get_oid quietly return an error
Date:   Thu,  7 Apr 2022 21:53:49 +0000
Message-Id: <20220407215352.3491567-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220407215352.3491567-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220407215352.3491567-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A reasonable person looking at the signature and usage of get_oid and
friends might conclude that in the event of an error, it always returns
-1.  However, this is not the case.  Instead, get_oid_basic dies if we
go too far back into the history of a reflog (or, when quiet, simply
exits).

This is not especially useful, since in many cases, we might want to
handle this error differently.  Let's add a flag here to make it just
return -1 like elsewhere in these code paths.

Note that we cannot make this behavior the default, since we have many
other codepaths that rely on the existing behavior, including in tests.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 cache.h       | 1 +
 object-name.c | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 825ec17198..657e3ff17f 100644
--- a/cache.h
+++ b/cache.h
@@ -1376,6 +1376,7 @@ struct object_context {
 #define GET_OID_RECORD_PATH     0200
 #define GET_OID_ONLY_TO_DIE    04000
 #define GET_OID_REQUIRE_PATH  010000
+#define GET_OID_GENTLY        020000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 92862eeb1a..46dbfe36a6 100644
--- a/object-name.c
+++ b/object-name.c
@@ -911,13 +911,17 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 						len, str,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
-			} else {
+			} else if (!(flags & GET_OID_GENTLY)) {
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
 				die(_("log for '%.*s' only has %d entries"),
 				    len, str, co_cnt);
 			}
+			if (flags & GET_OID_GENTLY) {
+				free(real_ref);
+				return -1;
+			}
 		}
 	}
 
