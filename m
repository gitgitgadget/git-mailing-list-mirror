Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DBBC433FE
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 21:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiC2Vvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiC2Vvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 17:51:37 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC3947390
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 14:49:52 -0700 (PDT)
Received: from camp.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D332E5A3DB;
        Tue, 29 Mar 2022 21:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1648590591;
        bh=e1heZ5iu+vHK6AExECRdXfQJdgRLSg4U/ygA52vOhCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=p/UP7wgFZib4XWCl+DAOT7efz19PlVMt7XTqQb7YTMMrgemIHftefeWV/e5OG/xk2
         u3HBfARkWRk77+oH8WYx4Q/aFgI84P1lzdXKm5HFa44ZB59P4Q1tZOvcylkSpLl2z5
         AmgZjs5x6ei7dLEY3P3vHHgKg1ITCDrimnzUZC66eobhAiPys6xgqEvaZM06y/dxpX
         Jt3AH0+XtteCccFM4sdaD8rWEpD3smoEvYtHpBhiiVjoCz3P+x3nI8wzn4osVOKCr8
         34PdNIp9pK4Wca3J4m6ZakWxbrPGM+G6goakP0Vz0NCmkiirTPxe71wfeTeWPh58oL
         nYyUGBJEefGbXgxxQxtfHP5BU3aV8hJlrtaYMkxIFGIF34Xw6oyzz5nfc/o2FWYGqD
         sT4PEUGmW+5lo+w0aBb6jlOw4X28FFrdsXUTC+HrHUFtGjMKFAino0PCrSZjUW6YXm
         BhllneKDfMgy8te8SYAuX6081ldOQaJ1MLQr1XcLaU3Dm0c1wB1
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/4] object-name: make get_oid quietly return an error
Date:   Tue, 29 Mar 2022 21:49:38 +0000
Message-Id: <20220329214941.2018609-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220329214941.2018609-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220329214941.2018609-1-sandals@crustytoothpaste.net>
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
 
