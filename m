Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33A4820372
	for <e@80x24.org>; Sun, 15 Oct 2017 22:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbdJOWIj (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 18:08:39 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55088 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751587AbdJOWHt (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 15 Oct 2017 18:07:49 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 54BF06045B;
        Sun, 15 Oct 2017 22:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1508105268;
        bh=iVKmioAxcCnCdgziRN4BHodbQlm89OXa9D8k6f6NBAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=t8LwrZe84StuoUY+3tA9oYt7AZAiH/09WJhMceLStB7Uf/858USX1HJHhmo2koIeR
         833QFpydhlSRhs5PYBJsSmFlISH86K/HVir2jZ+gk5VYH2TkCYXcX4rkR8NtNOAIG/
         z6QrB7NeFLtc+Io4UQjNcWter+X8aK5Tv1KnJzQO6HXYby/C2tQoAs6MWRSgiryunu
         XFvwsYpMKynhqFiO6kmPvN7l0qlr6DoTBJ+LOWTg2Jm+Uxd484z43efsYbi+Ln2Z9E
         hLvCSnmPQB2LBLBDuX/98s4MrxvdE5XJb0BEdcFi9mU7BbQfHf4e1YjEMbyfUmGHmu
         sZUs+VFinxeeCOENiDf4lSeqeTxb29RanwTi3NgGl/3OziaZPS/YYu+zzKN00i7xx5
         Wu03Ew/LZALtX0beoL8I4B+oigiMQuVEckTHREfnDLKENXdw6e3RON5UfUn0wL8kMb
         TJgFu/1Lp+YnrPWvEUnM2+Nd2v7pllxkBNLieAWEjIdssBOzQi7
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v3 12/25] refs: convert dwim_log to struct object_id
Date:   Sun, 15 Oct 2017 22:06:59 +0000
Message-Id: <20171015220712.97308-13-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.15.0.rc0.271.g36b669edcc
In-Reply-To: <20171015220712.97308-1-sandals@crustytoothpaste.net>
References: <20171015220712.97308-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/reflog.c | 4 ++--
 reflog-walk.c    | 2 +-
 refs.c           | 8 ++++----
 refs.h           | 2 +-
 sha1_name.c      | 2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 302fafbeef..cd4c4847b7 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -602,7 +602,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	for (; i < argc; i++) {
 		char *ref;
 		struct object_id oid;
-		if (!dwim_log(argv[i], strlen(argv[i]), oid.hash, &ref)) {
+		if (!dwim_log(argv[i], strlen(argv[i]), &oid, &ref)) {
 			status |= error("%s points nowhere!", argv[i]);
 			continue;
 		}
@@ -668,7 +668,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!dwim_log(argv[i], spec - argv[i], oid.hash, &ref)) {
+		if (!dwim_log(argv[i], spec - argv[i], &oid, &ref)) {
 			status |= error("no reflog for '%s'", argv[i]);
 			continue;
 		}
diff --git a/reflog-walk.c b/reflog-walk.c
index 842b2f77dc..5008bbf6ad 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -161,7 +161,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 			struct object_id oid;
 			char *b;
 			int ret = dwim_log(branch, strlen(branch),
-					   oid.hash, &b);
+					   &oid, &b);
 			if (ret > 1)
 				free(b);
 			else if (ret == 1) {
diff --git a/refs.c b/refs.c
index 9bb555e7ff..ecb43a113e 100644
--- a/refs.c
+++ b/refs.c
@@ -497,7 +497,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
 	return refs_found;
 }
 
-int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
+int dwim_log(const char *str, int len, struct object_id *oid, char **log)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
 	const char **p;
@@ -506,13 +506,13 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 	*log = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char hash[20];
+		struct object_id hash;
 		const char *ref, *it;
 
 		strbuf_reset(&path);
 		strbuf_addf(&path, *p, len, str);
 		ref = resolve_ref_unsafe(path.buf, RESOLVE_REF_READING,
-					 hash, NULL);
+					 hash.hash, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path.buf))
@@ -523,7 +523,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 			continue;
 		if (!logs_found++) {
 			*log = xstrdup(it);
-			hashcpy(sha1, hash);
+			oidcpy(oid, &hash);
 		}
 		if (!warn_ambiguous_refs)
 			break;
diff --git a/refs.h b/refs.h
index 0d864b0ab1..9d59c414aa 100644
--- a/refs.h
+++ b/refs.h
@@ -141,7 +141,7 @@ int refname_match(const char *abbrev_name, const char *full_name);
 
 int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
-int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
+int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
 /*
  * A ref_transaction represents a collection of reference updates that
diff --git a/sha1_name.c b/sha1_name.c
index d8ff831759..514915460f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -656,7 +656,7 @@ static int get_oid_basic(const char *str, int len, struct object_id *oid,
 		/* allow "@{...}" to mean the current branch reflog */
 		refs_found = dwim_ref("HEAD", 4, oid, &real_ref);
 	else if (reflog_len)
-		refs_found = dwim_log(str, len, oid->hash, &real_ref);
+		refs_found = dwim_log(str, len, oid, &real_ref);
 	else
 		refs_found = dwim_ref(str, len, oid, &real_ref);
 
-- 
2.15.0.rc0.271.g36b669edcc

