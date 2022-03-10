Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BD3C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245136AbiCJRg3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245074AbiCJRgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:25 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141E418F22A
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 992B75A12D;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=ltqJ6eVTTkdnHzkh4VXZsXx1qfTvUh7Tdrd7LZGMQKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Rc7KePfYJ+nVgVPqQ59M3cdhcs0QeqG3HT+AAquD0/nBxYEKbQVxBjOYcXxgfLrWT
         aH2uSTddEorNabp5kBi2mWNFi28r+f+2EMuSSa/mIBYm0fy1RGsD+QYTfFiUNUq1XD
         zMM8rPhCueprk+ZiGivPzU/7UFESdUb2o7jGLvzhx4w17Tm0svPh8kVgvnPA5FCh/m
         b0KBtZbcImHhIng1ubBDhSfFmCbLF2A1/udgn8770ThLT652NWs/53c4wePQzbNWak
         EE86Zi6pZw0GJ6APW2pfBDCR19m67LG2VJ/LJTafXWlOReBhwXnW+Ydjk81nxBTcgf
         GlnZQ3Soa4wfStAY6N7Ql2qC0fu0Qd0Cevp5gxPNg6Jm/YCeya7vw4dSfpqOzIZyYL
         a7G5otlxFWLc2BbiARQpPLZnmFdbVs614l1K7wm2erkKmPaLbPKs6gce51KJX+U64g
         hIBiGu94kTgvVVHBj1o6vMWtUj6Vfe3SlJDy8zKkMDx65LilBxw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 3/6] object-name: make get_oid quietly return an error
Date:   Thu, 10 Mar 2022 17:32:33 +0000
Message-Id: <20220310173236.4165310-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
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
 cache.h       | 21 +++++++++++----------
 object-name.c |  6 +++++-
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 825ec17198..416a9d9983 100644
--- a/cache.h
+++ b/cache.h
@@ -1366,16 +1366,17 @@ struct object_context {
 	char *path;
 };
 
-#define GET_OID_QUIETLY           01
-#define GET_OID_COMMIT            02
-#define GET_OID_COMMITTISH        04
-#define GET_OID_TREE             010
-#define GET_OID_TREEISH          020
-#define GET_OID_BLOB             040
-#define GET_OID_FOLLOW_SYMLINKS 0100
-#define GET_OID_RECORD_PATH     0200
-#define GET_OID_ONLY_TO_DIE    04000
-#define GET_OID_REQUIRE_PATH  010000
+#define GET_OID_QUIETLY            01
+#define GET_OID_COMMIT             02
+#define GET_OID_COMMITTISH         04
+#define GET_OID_TREE              010
+#define GET_OID_TREEISH           020
+#define GET_OID_BLOB              040
+#define GET_OID_FOLLOW_SYMLINKS  0100
+#define GET_OID_RECORD_PATH      0200
+#define GET_OID_ONLY_TO_DIE     04000
+#define GET_OID_REQUIRE_PATH   010000
+#define GET_OID_RETURN_FAILURE 020000
 
 #define GET_OID_DISAMBIGUATORS \
 	(GET_OID_COMMIT | GET_OID_COMMITTISH | \
diff --git a/object-name.c b/object-name.c
index 92862eeb1a..daa3ef77ef 100644
--- a/object-name.c
+++ b/object-name.c
@@ -911,13 +911,17 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 						len, str,
 						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
 				}
-			} else {
+			} else if (!(flags & GET_OID_RETURN_FAILURE)) {
 				if (flags & GET_OID_QUIETLY) {
 					exit(128);
 				}
 				die(_("log for '%.*s' only has %d entries"),
 				    len, str, co_cnt);
 			}
+			if (flags & GET_OID_RETURN_FAILURE) {
+				free(real_ref);
+				return -1;
+			}
 		}
 	}
 
