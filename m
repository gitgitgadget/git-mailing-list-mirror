Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24680201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753408AbdGCSzx (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 14:55:53 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:52984 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752927AbdGCSzs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 3 Jul 2017 14:55:48 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id DD862280B3;
        Mon,  3 Jul 2017 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1499108147;
        bh=t1TliHy9njT4HPp0tyg+IHc6q+lXfFhknRQnr6ay3yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/iID6EsBkSsByqMhiaeG+HA93j18DbYZ7MKPxe2OrNe0Y0wlbi1j9zvA2nvFCmrq
         /+rigPG9a7f2/ipJvgpDKtXXoxbj0VaPSCkKHWlYitaDA+ApYykOWDqhx+vYdDHQ4B
         a6ucrwNcQxCSEtvLIQWDfxBw7XuifGmHXA0QaVT06RDMAUAjRhvvJHiKaQsqw9L2vx
         xVjwVrYA8FJkinjvjWIJE3vLyoVX7c9upW7b1IU/ONSAkbKvq0A8CTDuwT4rov6mxj
         M+eh51CeiRHC6DrjLW6pT/EYnSAqWsXKntY5Q5sScm/P/mPAIMu6+7wqhkjLHus9EN
         GH7eGRjVTI+jBrMHYg/d4yvU5tNoosPAxd5QSinVmJjt3YWupWg+poub5DEjNa1PuN
         h7UTCdDrFAmx+3aHeuNI4Jpj4IedotiuzOYQSdEjaV8/ROmI+pEshL4uO3XigeBvbn
         kXGH2xukBh7N0wEyGevF3sY0K67p8OsovX6nMR4W4LJ2Q1RD7rl
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 06/12] builtin/update_ref: convert to struct object_id
Date:   Mon,  3 Jul 2017 18:55:27 +0000
Message-Id: <20170703185533.51530-7-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.2.753.g7f5404b18
In-Reply-To: <20170703185533.51530-1-sandals@crustytoothpaste.net>
References: <20170703185533.51530-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the uses of unsigned char * to struct object_id.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/update-ref.c | 69 ++++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 35 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 40ccfc193..6b90c5dea 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -94,10 +94,10 @@ static char *parse_refname(struct strbuf *input, const char **next)
  * provided but cannot be converted to a SHA-1, die.  flags can
  * include PARSE_SHA1_OLD and/or PARSE_SHA1_ALLOW_EMPTY.
  */
-static int parse_next_sha1(struct strbuf *input, const char **next,
-			   unsigned char *sha1,
-			   const char *command, const char *refname,
-			   int flags)
+static int parse_next_oid(struct strbuf *input, const char **next,
+			  struct object_id *oid,
+			  const char *command, const char *refname,
+			  int flags)
 {
 	struct strbuf arg = STRBUF_INIT;
 	int ret = 0;
@@ -115,11 +115,11 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 		(*next)++;
 		*next = parse_arg(*next, &arg);
 		if (arg.len) {
-			if (get_sha1(arg.buf, sha1))
+			if (get_oid(arg.buf, oid))
 				goto invalid;
 		} else {
 			/* Without -z, an empty value means all zeros: */
-			hashclr(sha1);
+			oidclr(oid);
 		}
 	} else {
 		/* With -z, read the next NUL-terminated line */
@@ -133,13 +133,13 @@ static int parse_next_sha1(struct strbuf *input, const char **next,
 		*next += arg.len;
 
 		if (arg.len) {
-			if (get_sha1(arg.buf, sha1))
+			if (get_oid(arg.buf, oid))
 				goto invalid;
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
 			warning("%s %s: missing <newvalue>, treating as zero",
 				command, refname);
-			hashclr(sha1);
+			oidclr(oid);
 		} else {
 			/*
 			 * With -z, an empty non-required value means
@@ -182,26 +182,25 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
-	unsigned char new_sha1[20];
-	unsigned char old_sha1[20];
+	struct object_id new_oid, old_oid;
 	int have_old;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
 		die("update: missing <ref>");
 
-	if (parse_next_sha1(input, &next, new_sha1, "update", refname,
-			    PARSE_SHA1_ALLOW_EMPTY))
+	if (parse_next_oid(input, &next, &new_oid, "update", refname,
+			   PARSE_SHA1_ALLOW_EMPTY))
 		die("update %s: missing <newvalue>", refname);
 
-	have_old = !parse_next_sha1(input, &next, old_sha1, "update", refname,
-				    PARSE_SHA1_OLD);
+	have_old = !parse_next_oid(input, &next, &old_oid, "update", refname,
+				   PARSE_SHA1_OLD);
 
 	if (*next != line_termination)
 		die("update %s: extra input: %s", refname, next);
 
 	if (ref_transaction_update(transaction, refname,
-				   new_sha1, have_old ? old_sha1 : NULL,
+				   new_oid.hash, have_old ? old_oid.hash : NULL,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -218,22 +217,22 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
-	unsigned char new_sha1[20];
+	struct object_id new_oid;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
 		die("create: missing <ref>");
 
-	if (parse_next_sha1(input, &next, new_sha1, "create", refname, 0))
+	if (parse_next_oid(input, &next, &new_oid, "create", refname, 0))
 		die("create %s: missing <newvalue>", refname);
 
-	if (is_null_sha1(new_sha1))
+	if (is_null_oid(&new_oid))
 		die("create %s: zero <newvalue>", refname);
 
 	if (*next != line_termination)
 		die("create %s: extra input: %s", refname, next);
 
-	if (ref_transaction_create(transaction, refname, new_sha1,
+	if (ref_transaction_create(transaction, refname, new_oid.hash,
 				   update_flags | create_reflog_flag,
 				   msg, &err))
 		die("%s", err.buf);
@@ -250,18 +249,18 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 	int have_old;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
 		die("delete: missing <ref>");
 
-	if (parse_next_sha1(input, &next, old_sha1, "delete", refname,
-			    PARSE_SHA1_OLD)) {
+	if (parse_next_oid(input, &next, &old_oid, "delete", refname,
+			   PARSE_SHA1_OLD)) {
 		have_old = 0;
 	} else {
-		if (is_null_sha1(old_sha1))
+		if (is_null_oid(&old_oid))
 			die("delete %s: zero <oldvalue>", refname);
 		have_old = 1;
 	}
@@ -270,7 +269,7 @@ static const char *parse_cmd_delete(struct ref_transaction *transaction,
 		die("delete %s: extra input: %s", refname, next);
 
 	if (ref_transaction_delete(transaction, refname,
-				   have_old ? old_sha1 : NULL,
+				   have_old ? old_oid.hash : NULL,
 				   update_flags, msg, &err))
 		die("%s", err.buf);
 
@@ -286,20 +285,20 @@ static const char *parse_cmd_verify(struct ref_transaction *transaction,
 {
 	struct strbuf err = STRBUF_INIT;
 	char *refname;
-	unsigned char old_sha1[20];
+	struct object_id old_oid;
 
 	refname = parse_refname(input, &next);
 	if (!refname)
 		die("verify: missing <ref>");
 
-	if (parse_next_sha1(input, &next, old_sha1, "verify", refname,
-			    PARSE_SHA1_OLD))
-		hashclr(old_sha1);
+	if (parse_next_oid(input, &next, &old_oid, "verify", refname,
+			   PARSE_SHA1_OLD))
+		oidclr(&old_oid);
 
 	if (*next != line_termination)
 		die("verify %s: extra input: %s", refname, next);
 
-	if (ref_transaction_verify(transaction, refname, old_sha1,
+	if (ref_transaction_verify(transaction, refname, old_oid.hash,
 				   update_flags, &err))
 		die("%s", err.buf);
 
@@ -355,7 +354,7 @@ static void update_refs_stdin(struct ref_transaction *transaction)
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname, *oldval;
-	unsigned char sha1[20], oldsha1[20];
+	struct object_id oid, oldoid;
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0;
 	unsigned int flags = 0;
 	int create_reflog = 0;
@@ -412,7 +411,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		refname = argv[0];
 		value = argv[1];
 		oldval = argv[2];
-		if (get_sha1(value, sha1))
+		if (get_oid(value, &oid))
 			die("%s: not a valid SHA1", value);
 	}
 
@@ -422,8 +421,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			 * The empty string implies that the reference
 			 * must not already exist:
 			 */
-			hashclr(oldsha1);
-		else if (get_sha1(oldval, oldsha1))
+			oidclr(&oldoid);
+		else if (get_oid(oldval, &oldoid))
 			die("%s: not a valid old SHA1", oldval);
 	}
 
@@ -435,10 +434,10 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		 * NULL_SHA1 as "don't care" here:
 		 */
 		return delete_ref(msg, refname,
-				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
+				  (oldval && !is_null_oid(&oldoid)) ? oldoid.hash : NULL,
 				  flags);
 	else
-		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
+		return update_ref(msg, refname, oid.hash, oldval ? oldoid.hash : NULL,
 				  flags | create_reflog_flag,
 				  UPDATE_REFS_DIE_ON_ERR);
 }
