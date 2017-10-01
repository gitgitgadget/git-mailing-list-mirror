Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C301B20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 22:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbdJAWJK (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 18:09:10 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54178 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752065AbdJAWJE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Oct 2017 18:09:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DB8AB60DB0;
        Sun,  1 Oct 2017 22:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1506895743;
        bh=7/A2WLszwaT3oafNd09871N/lCzlmgktaUydJOOc5wY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6ISJQGSytXLBB/n09BuiNf6zrxo1o97g2FDao8hRYb1QQnJVQZSaEFDi6WP4q0xg
         Bt6nLXi2hjbDZyVHxxZlY8PxCX7NdmJ7p4pqMeV6j5XctqQojDGft9QFZAkI9YTW81
         CbKJQDxlXv8i5hl21GdH5rbcYBYwWfdE7lLu1UxWNqVQI/ZPNDLOZFIEznjQSP7XtP
         RNviHd6GJ7u7ONRxyA1OIu5uzNZDymNdQqL99jyfk5JYBp0NCflFsjvZXy4SAWV604
         bCoJ2Qz33s9M7W52wlDkYxnUTUpHxQfij2bhGIT6LrDGsRN8+GOt6axqIk5JKQ6q+l
         Mn+cU5dbZxuUTPEq3NjppeMeXlh50ojB4S2T0EuRzu1jEs/OlSt1ZFmTxUjylwLHsl
         4e6Lvp7K72BFQ1nThAr1TMn+Irtdf5s9+wmOUeGsmEUQNZ9F4zOZElF71+rQDgPK2r
         bEchp43xprDqndS5p6QcQYZ9ceR2H5tLGxTwq5ZxHDVpP2iD3ti
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 15/24] refs: convert read_ref_at to struct object_id
Date:   Sun,  1 Oct 2017 22:08:22 +0000
Message-Id: <20171001220831.214705-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.822.g60be5d43e6
In-Reply-To: <20171001220831.214705-1-sandals@crustytoothpaste.net>
References: <20171001220831.214705-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the callers and internals, including struct read_ref_at_cb, of
read_ref_at to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c |  5 ++---
 refs.c                | 34 +++++++++++++++++-----------------
 refs.h                |  2 +-
 sha1_name.c           |  3 +--
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 722a7f4bec..8ef8ad10c5 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -731,7 +731,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 				/* Ah, that is a date spec... */
 				timestamp_t at;
 				at = approxidate(reflog_base);
-				read_ref_at(ref, flags, at, -1, oid.hash, NULL,
+				read_ref_at(ref, flags, at, -1, &oid, NULL,
 					    NULL, NULL, &base);
 			}
 		}
@@ -743,8 +743,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			timestamp_t timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
-					&timestamp, &tz, NULL)) {
+			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg, &timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
 			}
diff --git a/refs.c b/refs.c
index 6cbe2c1c6b..684dd75deb 100644
--- a/refs.c
+++ b/refs.c
@@ -734,11 +734,11 @@ struct read_ref_at_cb {
 	timestamp_t at_time;
 	int cnt;
 	int reccnt;
-	unsigned char *sha1;
+	struct object_id *oid;
 	int found_it;
 
-	unsigned char osha1[20];
-	unsigned char nsha1[20];
+	struct object_id ooid;
+	struct object_id noid;
 	int tz;
 	timestamp_t date;
 	char **msg;
@@ -770,25 +770,25 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		 * we have not yet updated cb->[n|o]sha1 so they still
 		 * hold the values for the previous record.
 		 */
-		if (!is_null_sha1(cb->osha1)) {
-			hashcpy(cb->sha1, noid->hash);
-			if (hashcmp(cb->osha1, noid->hash))
+		if (!is_null_oid(&cb->ooid)) {
+			oidcpy(cb->oid, noid);
+			if (oidcmp(&cb->ooid, noid))
 				warning("Log for ref %s has gap after %s.",
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
-			hashcpy(cb->sha1, noid->hash);
-		else if (hashcmp(noid->hash, cb->sha1))
+			oidcpy(cb->oid, noid);
+		else if (oidcmp(noid, cb->oid))
 			warning("Log for ref %s unexpectedly ended on %s.",
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
-		hashcpy(cb->osha1, ooid->hash);
-		hashcpy(cb->nsha1, noid->hash);
+		oidcpy(&cb->ooid, ooid);
+		oidcpy(&cb->noid, noid);
 		cb->found_it = 1;
 		return 1;
 	}
-	hashcpy(cb->osha1, ooid->hash);
-	hashcpy(cb->nsha1, noid->hash);
+	oidcpy(&cb->ooid, ooid);
+	oidcpy(&cb->noid, noid);
 	if (cb->cnt > 0)
 		cb->cnt--;
 	return 0;
@@ -808,15 +808,15 @@ static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid
 		*cb->cutoff_tz = tz;
 	if (cb->cutoff_cnt)
 		*cb->cutoff_cnt = cb->reccnt;
-	hashcpy(cb->sha1, ooid->hash);
-	if (is_null_sha1(cb->sha1))
-		hashcpy(cb->sha1, noid->hash);
+	oidcpy(cb->oid, ooid);
+	if (is_null_oid(cb->oid))
+		oidcpy(cb->oid, noid);
 	/* We just want the first entry */
 	return 1;
 }
 
 int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, int cnt,
-		unsigned char *sha1, char **msg,
+		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
 {
 	struct read_ref_at_cb cb;
@@ -829,7 +829,7 @@ int read_ref_at(const char *refname, unsigned int flags, timestamp_t at_time, in
 	cb.cutoff_time = cutoff_time;
 	cb.cutoff_tz = cutoff_tz;
 	cb.cutoff_cnt = cutoff_cnt;
-	cb.sha1 = sha1;
+	cb.oid = oid;
 
 	for_each_reflog_ent_reverse(refname, read_ref_at_ent, &cb);
 
diff --git a/refs.h b/refs.h
index 832ade2b13..3afecd2e8a 100644
--- a/refs.h
+++ b/refs.h
@@ -363,7 +363,7 @@ int safe_create_reflog(const char *refname, int force_create, struct strbuf *err
 /** Reads log for the value of ref during at_time. **/
 int read_ref_at(const char *refname, unsigned int flags,
 		timestamp_t at_time, int cnt,
-		unsigned char *sha1, char **msg,
+		struct object_id *oid, char **msg,
 		timestamp_t *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
 
 /** Check if a particular reflog exists */
diff --git a/sha1_name.c b/sha1_name.c
index 7de12743f3..f0ec3f0454 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -697,8 +697,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid->hash, NULL,
-				&co_time, &co_tz, &co_cnt)) {
+		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL, &co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
 					str = real_ref + 11;
-- 
2.14.2.822.g60be5d43e6

