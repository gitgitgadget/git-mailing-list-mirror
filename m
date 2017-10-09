Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC05D1FA21
	for <e@80x24.org>; Mon,  9 Oct 2017 01:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753841AbdJIBMH (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 21:12:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54732 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753762AbdJIBMD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Oct 2017 21:12:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 11C0360DA4;
        Mon,  9 Oct 2017 01:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1507511522;
        bh=6VF3HJc1z7vM+8wpfNZdV5p77M3XkSye3B4FizA5yUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=llZI/J0LpwM0/kKghSojB3YV5S9aJQ6WM655fkhleC6khSQw+YE4NtX4LDfiMFjyt
         pZ1FK81L8NV4+6WU3Nu3ueZj7vfHjI7toIossCYsqPh4ekYflJh2aSKFivtFQfYHDk
         k8Jlu8XdbfZh3JSujBYMeY2//J2SKt9T7NpIYpOC34StdkmXIitUz95KI13ffb6WRR
         YbxG9HV2+cOR0FTXvVqnxG5oqLdTG4ZNeltbsmnTjixGt10iPGYkiN9ArWqMlulNpP
         V66R2p2Iho7PP7XBpcVO6BwD2gQrrhFnXcEtELuZFsQ45XOjQfJTXCuh2fEUIbQyHz
         18LVMopOyERAKnO42GLLq48eieVQTOJJzk3BWLjo9vLcu/MgNnOpyXIGeYq4MMSkhK
         UksHuIq4zIGuKUsoEES3o36X17qGUtVhfEBZBAcUdAqYFJq31wqtyOZSV1pc3/FeRh
         fGDKXKa/aJZ2Ylv/r63HbQTbHR3BMLpirQ4pbkmCqejMIGwEC1B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 15/24] refs: convert read_ref_at to struct object_id
Date:   Mon,  9 Oct 2017 01:11:23 +0000
Message-Id: <20171009011132.675341-16-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c
In-Reply-To: <20171009011132.675341-1-sandals@crustytoothpaste.net>
References: <20171009011132.675341-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the callers and internals, including struct read_ref_at_cb, of
read_ref_at to use struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/show-branch.c |  4 ++--
 refs.c                | 34 +++++++++++++++++-----------------
 refs.h                |  2 +-
 sha1_name.c           |  2 +-
 4 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 722a7f4bec..8bf42e529d 100644
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
@@ -743,7 +743,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			timestamp_t timestamp;
 			int tz;
 
-			if (read_ref_at(ref, flags, 0, base+i, oid.hash, &logmsg,
+			if (read_ref_at(ref, flags, 0, base + i, &oid, &logmsg,
 					&timestamp, &tz, NULL)) {
 				reflog = i;
 				break;
diff --git a/refs.c b/refs.c
index 0a3754f6da..b781acc8b1 100644
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
index 7de12743f3..9b806104a4 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -697,7 +697,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 				return -1;
 			}
 		}
-		if (read_ref_at(real_ref, flags, at_time, nth, oid->hash, NULL,
+		if (read_ref_at(real_ref, flags, at_time, nth, oid, NULL,
 				&co_time, &co_tz, &co_cnt)) {
 			if (!len) {
 				if (starts_with(real_ref, "refs/heads/")) {
-- 
2.14.2.920.gcf0c67979c

