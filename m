Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65D2E207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046095AbdDWVf6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:35:58 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37380 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046096AbdDWVfe (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:34 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2324F280B6;
        Sun, 23 Apr 2017 21:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983330;
        bh=fV8tab+n3xVfUrYuzJJJ8STAvp8HcxWibFL7xWsPXmc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIjivB/Ds5prCIYHEkVcXR59UOD+DZJhWS7huVByYEeMiO+r70uUIKkkdnS08EMM4
         RD7NWxrV1kYmM928S0tAczPRoFHQc+dU04U7M3Dyp0/aHQRkp5c/M2XAleWVq0job6
         FEN7vODJbVnlg9d/hb4E1L/Nviy1ddwIQrN9JESqp2MtKHFEV78j6BXtXae2O/JCk+
         A5u7n63i9w65U48Dm8s6eONgyy/phDsNIlxClgx+Eia+KWUfkdh590faU5AxpU5tf5
         BGaiCLBdIXGXDKAODZkyDYVoiHDvu79DXqXOjgr+9xSbEa2rQNFHr6AhzAhgP+c4E/
         HDMM0hGLfcwBWzkg+lmc6Nb7WCbBrN/JwWyz+O5SJWAV+8JIP1SkvdYRL5qeYuUk/w
         cwh0VcKIaTXreUUYwC0gzXktg0I9R/o4jvyccYba4UQiQnsx5z1eUc/ZzoRkOaJIrD
         iemEy2vWPAGVAouaVjd8dCVwn0CQcK2c2NCMIgPnTrPgrI6Oefp
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/53] builtin/rev-parse: convert to struct object_id
Date:   Sun, 23 Apr 2017 21:34:09 +0000
Message-Id: <20170423213453.253425-10-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some of the functions converted are callers of lookup_commit_reference.
However, the changes involved in converting the entire thing are not too
large, so we might as well convert it all.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/rev-parse.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 051333091..272bb13a0 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -121,7 +121,7 @@ static void show_with_type(int type, const char *arg)
 }
 
 /* Output a revision, only if filter allows it */
-static void show_rev(int type, const unsigned char *sha1, const char *name)
+static void show_rev(int type, const struct object_id *oid, const char *name)
 {
 	if (!(filter & DO_REVS))
 		return;
@@ -129,10 +129,10 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 
 	if ((symbolic || abbrev_ref) && name) {
 		if (symbolic == SHOW_SYMBOLIC_FULL || abbrev_ref) {
-			unsigned char discard[20];
+			struct object_id discard;
 			char *full;
 
-			switch (dwim_ref(name, strlen(name), discard, &full)) {
+			switch (dwim_ref(name, strlen(name), discard.hash, &full)) {
 			case 0:
 				/*
 				 * Not found -- not a ref.  We could
@@ -158,9 +158,9 @@ static void show_rev(int type, const unsigned char *sha1, const char *name)
 		}
 	}
 	else if (abbrev)
-		show_with_type(type, find_unique_abbrev(sha1, abbrev));
+		show_with_type(type, find_unique_abbrev(oid->hash, abbrev));
 	else
-		show_with_type(type, sha1_to_hex(sha1));
+		show_with_type(type, oid_to_hex(oid));
 }
 
 /* Output a flag, only if filter allows it. */
@@ -180,11 +180,11 @@ static int show_default(void)
 	const char *s = def;
 
 	if (s) {
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		def = NULL;
-		if (!get_sha1(s, sha1)) {
-			show_rev(NORMAL, sha1, s);
+		if (!get_oid(s, &oid)) {
+			show_rev(NORMAL, &oid, s);
 			return 1;
 		}
 	}
@@ -195,19 +195,19 @@ static int show_reference(const char *refname, const struct object_id *oid, int
 {
 	if (ref_excluded(ref_excludes, refname))
 		return 0;
-	show_rev(NORMAL, oid->hash, refname);
+	show_rev(NORMAL, oid, refname);
 	return 0;
 }
 
 static int anti_reference(const char *refname, const struct object_id *oid, int flag, void *cb_data)
 {
-	show_rev(REVERSED, oid->hash, refname);
+	show_rev(REVERSED, oid, refname);
 	return 0;
 }
 
 static int show_abbrev(const struct object_id *oid, void *cb_data)
 {
-	show_rev(NORMAL, oid->hash, NULL);
+	show_rev(NORMAL, oid, NULL);
 	return 0;
 }
 
@@ -242,8 +242,8 @@ static int show_file(const char *arg, int output_prefix)
 static int try_difference(const char *arg)
 {
 	char *dotdot;
-	unsigned char sha1[20];
-	unsigned char end[20];
+	struct object_id oid;
+	struct object_id end;
 	const char *next;
 	const char *this;
 	int symmetric;
@@ -273,18 +273,18 @@ static int try_difference(const char *arg)
 		return 0;
 	}
 
-	if (!get_sha1_committish(this, sha1) && !get_sha1_committish(next, end)) {
-		show_rev(NORMAL, end, next);
-		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
+	if (!get_sha1_committish(this, oid.hash) && !get_sha1_committish(next, end.hash)) {
+		show_rev(NORMAL, &end, next);
+		show_rev(symmetric ? NORMAL : REVERSED, &oid, this);
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
-			a = lookup_commit_reference(sha1);
-			b = lookup_commit_reference(end);
+			a = lookup_commit_reference(oid.hash);
+			b = lookup_commit_reference(end.hash);
 			exclude = get_merge_bases(a, b);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
-				show_rev(REVERSED, commit->object.oid.hash, NULL);
+				show_rev(REVERSED, &commit->object.oid, NULL);
 			}
 		}
 		*dotdot = '.';
@@ -297,7 +297,7 @@ static int try_difference(const char *arg)
 static int try_parent_shorthands(const char *arg)
 {
 	char *dotdot;
-	unsigned char sha1[20];
+	struct object_id oid;
 	struct commit *commit;
 	struct commit_list *parents;
 	int parent_number;
@@ -327,12 +327,12 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	*dotdot = 0;
-	if (get_sha1_committish(arg, sha1)) {
+	if (get_sha1_committish(arg, oid.hash)) {
 		*dotdot = '^';
 		return 0;
 	}
 
-	commit = lookup_commit_reference(sha1);
+	commit = lookup_commit_reference(oid.hash);
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents)) {
 		*dotdot = '^';
@@ -340,7 +340,7 @@ static int try_parent_shorthands(const char *arg)
 	}
 
 	if (include_rev)
-		show_rev(NORMAL, sha1, arg);
+		show_rev(NORMAL, &oid, arg);
 	for (parents = commit->parents, parent_number = 1;
 	     parents;
 	     parents = parents->next, parent_number++) {
@@ -352,7 +352,7 @@ static int try_parent_shorthands(const char *arg)
 		if (symbolic)
 			name = xstrfmt("%s^%d", arg, parent_number);
 		show_rev(include_parents ? NORMAL : REVERSED,
-			 parents->item->object.oid.hash, name);
+			& parents->item->object.oid, name);
 		free(name);
 	}
 
@@ -571,7 +571,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	int did_repo_setup = 0;
 	int has_dashdash = 0;
 	int output_prefix = 0;
-	unsigned char sha1[20];
+	struct object_id oid;
 	unsigned int flags = 0;
 	const char *name = NULL;
 	struct object_context unused;
@@ -910,11 +910,11 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			name++;
 			type = REVERSED;
 		}
-		if (!get_sha1_with_context(name, flags, sha1, &unused)) {
+		if (!get_sha1_with_context(name, flags, oid.hash, &unused)) {
 			if (verify)
 				revs_count++;
 			else
-				show_rev(type, sha1, name);
+				show_rev(type, &oid, name);
 			continue;
 		}
 		if (verify)
@@ -929,7 +929,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	strbuf_release(&buf);
 	if (verify) {
 		if (revs_count == 1) {
-			show_rev(type, sha1, name);
+			show_rev(type, &oid, name);
 			return 0;
 		} else if (revs_count == 0 && show_default())
 			return 0;
