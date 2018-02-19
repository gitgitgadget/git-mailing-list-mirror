Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 455071F404
	for <e@80x24.org>; Mon, 19 Feb 2018 23:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeBSW7r (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 17:59:47 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33328 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932254AbeBSW7m (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Feb 2018 17:59:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:e6b3:18ff:fe98:41a3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E52E0609E0;
        Mon, 19 Feb 2018 22:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1519081181;
        bh=Y0VEJu/pD/oy7fDSeOUmIMcd09y711YpYH0ieu2EGww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=DGQSsctVjIjnYjsP1+ZFzGZzf5K4Errt8dtxQKSuTYd4g2r61/Tw530Znh+S02Evs
         y52ofkibbaXevlFXdDIgvvGJia4QPdGFrTx3K5ZMzZ6vd+MWw02g3fWCTgTDcBBYYA
         xpsaPAJx71jnaSsuL+Vxffc9PQs8cENLbrVOo6zCdZMo/QGzj+RlQeO961G8NbBW5+
         s6cRYazvhs2dHAPa1BJPC7oZNZR1C3Pqyx7SBiBEnSKsH4VD5XKwJdsHfC6v1VZLLC
         +Eto9jofhumNU4diIIggk4hr9/F/+gBUucbaYpXWCkNR+cLNRcIDTfdF6t+gKdQok6
         By5DmjWZmNqzwDE6JlRHzNEfp1X62ry1p8xaHs11K/goxLnZ9eQTQadRy3QF22Mugr
         pzC/5JFD9BkVFDTKY6CSUfkVzkmFkJyVSOikgKfYwbs5kGLFYAQkJixDHuz8EnHH37
         YZ7BIjpHEx0o7HH0fnQDojAYnBz8Prkt/LHzAp62gJEigdj+LFS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 08/36] strbuf: convert strbuf_add_unique_abbrev to use struct object_id
Date:   Mon, 19 Feb 2018 22:58:59 +0000
Message-Id: <20180219225927.386065-9-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132
In-Reply-To: <20180219225927.386065-1-sandals@crustytoothpaste.net>
References: <20180219225927.386065-1-sandals@crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration and definition of strbuf_add_unique_abbrev to
make it take a pointer to struct object_id.  Predeclare the struct in
strbuf.h, as cache.h includes strbuf.h before it declares the struct,
and otherwise the struct declaration would have the wrong scope.

Apply the following semantic patch, along with the standard object_id
transforms, to adjust the callers:

@@
expression E1, E2, E3;
@@
- strbuf_add_unique_abbrev(E1, E2.hash, E3);
+ strbuf_add_unique_abbrev(E1, &E2, E3);

@@
expression E1, E2, E3;
@@
- strbuf_add_unique_abbrev(E1, E2->hash, E3);
+ strbuf_add_unique_abbrev(E1, E2, E3);

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c | 2 +-
 builtin/fetch.c    | 8 ++++----
 builtin/tag.c      | 2 +-
 merge-recursive.c  | 2 +-
 pretty.c           | 8 ++++----
 strbuf.c           | 4 ++--
 strbuf.h           | 8 +++++++-
 submodule.c        | 4 ++--
 transport.c        | 4 ++--
 wt-status.c        | 6 +++---
 10 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 87182aa018..bc68d423e5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -720,7 +720,7 @@ static int add_pending_uninteresting_ref(const char *refname,
 static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 {
 	strbuf_addstr(sb, "  ");
-	strbuf_add_unique_abbrev(sb, commit->object.oid.hash, DEFAULT_ABBREV);
+	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
 	if (!parse_commit(commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8ee998ea2e..3b8988e51d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -697,9 +697,9 @@ static int update_local_ref(struct ref *ref,
 	if (in_merge_bases(current, updated)) {
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
-		strbuf_add_unique_abbrev(&quickref, current->object.oid.hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "..");
-		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(&ref->new_oid);
@@ -712,9 +712,9 @@ static int update_local_ref(struct ref *ref,
 	} else if (force || ref->force) {
 		struct strbuf quickref = STRBUF_INIT;
 		int r;
-		strbuf_add_unique_abbrev(&quickref, current->object.oid.hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV);
 		strbuf_addstr(&quickref, "...");
-		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
 		if ((recurse_submodules != RECURSE_SUBMODULES_OFF) &&
 		    (recurse_submodules != RECURSE_SUBMODULES_ON))
 			check_for_new_submodule_commits(&ref->new_oid);
diff --git a/builtin/tag.c b/builtin/tag.c
index 8885e21ddc..99dba2d907 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -289,7 +289,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		strbuf_addstr(sb, rla);
 	} else {
 		strbuf_addstr(sb, "tag: tagging ");
-		strbuf_add_unique_abbrev(sb, oid->hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(sb, oid, DEFAULT_ABBREV);
 	}
 
 	strbuf_addstr(sb, " (");
diff --git a/merge-recursive.c b/merge-recursive.c
index c886f2e9cd..f58f13957e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -228,7 +228,7 @@ static void output_commit_title(struct merge_options *o, struct commit *commit)
 		strbuf_addf(&o->obuf, "virtual %s\n",
 			merge_remote_util(commit)->name);
 	else {
-		strbuf_add_unique_abbrev(&o->obuf, commit->object.oid.hash,
+		strbuf_add_unique_abbrev(&o->obuf, &commit->object.oid,
 					 DEFAULT_ABBREV);
 		strbuf_addch(&o->obuf, ' ');
 		if (parse_commit(commit) != 0)
diff --git a/pretty.c b/pretty.c
index f7ce490230..34fe891fc0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -549,7 +549,7 @@ static void add_merge_info(const struct pretty_print_context *pp,
 		struct object_id *oidp = &parent->item->object.oid;
 		strbuf_addch(sb, ' ');
 		if (pp->abbrev)
-			strbuf_add_unique_abbrev(sb, oidp->hash, pp->abbrev);
+			strbuf_add_unique_abbrev(sb, oidp, pp->abbrev);
 		else
 			strbuf_addstr(sb, oid_to_hex(oidp));
 		parent = parent->next;
@@ -1156,7 +1156,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		return 1;
 	case 'h':		/* abbreviated commit hash */
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_COMMIT));
-		strbuf_add_unique_abbrev(sb, commit->object.oid.hash,
+		strbuf_add_unique_abbrev(sb, &commit->object.oid,
 					 c->pretty_ctx->abbrev);
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		return 1;
@@ -1164,7 +1164,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
 		return 1;
 	case 't':		/* abbreviated tree hash */
-		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
+		strbuf_add_unique_abbrev(sb, &commit->tree->object.oid,
 					 c->pretty_ctx->abbrev);
 		return 1;
 	case 'P':		/* parent hashes */
@@ -1178,7 +1178,7 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
-			strbuf_add_unique_abbrev(sb, p->item->object.oid.hash,
+			strbuf_add_unique_abbrev(sb, &p->item->object.oid,
 						 c->pretty_ctx->abbrev);
 		}
 		return 1;
diff --git a/strbuf.c b/strbuf.c
index 1df674e919..128fbec503 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -869,12 +869,12 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_add_unique_abbrev(struct strbuf *sb, const unsigned char *sha1,
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
 			      int abbrev_len)
 {
 	int r;
 	strbuf_grow(sb, GIT_SHA1_HEXSZ + 1);
-	r = find_unique_abbrev_r(sb->buf + sb->len, sha1, abbrev_len);
+	r = find_unique_abbrev_r(sb->buf + sb->len, oid->hash, abbrev_len);
 	strbuf_setlen(sb, sb->len + r);
 }
 
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..cd7ad898eb 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -70,6 +70,12 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
 
+/*
+ * Predeclare this here, since cache.h includes this file before it defines the
+ * struct.
+ */
+struct object_id;
+
 /**
  * Life Cycle Functions
  * --------------------
@@ -539,7 +545,7 @@ extern void strbuf_list_free(struct strbuf **);
  * the strbuf `sb`.
  */
 extern void strbuf_add_unique_abbrev(struct strbuf *sb,
-				     const unsigned char *sha1,
+				     const struct object_id *oid,
 				     int abbrev_len);
 
 /**
diff --git a/submodule.c b/submodule.c
index 47ddc9b273..d4a482e647 100644
--- a/submodule.c
+++ b/submodule.c
@@ -540,9 +540,9 @@ static void show_submodule_header(struct diff_options *o, const char *path,
 
 output_header:
 	strbuf_addf(&sb, "Submodule %s ", path);
-	strbuf_add_unique_abbrev(&sb, one->hash, DEFAULT_ABBREV);
+	strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
 	strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "...");
-	strbuf_add_unique_abbrev(&sb, two->hash, DEFAULT_ABBREV);
+	strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
 	if (message)
 		strbuf_addf(&sb, " %s\n", message);
 	else
diff --git a/transport.c b/transport.c
index 00d48b5b56..87de35dd5e 100644
--- a/transport.c
+++ b/transport.c
@@ -367,7 +367,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 		char type;
 		const char *msg;
 
-		strbuf_add_unique_abbrev(&quickref, ref->old_oid.hash,
+		strbuf_add_unique_abbrev(&quickref, &ref->old_oid,
 					 DEFAULT_ABBREV);
 		if (ref->forced_update) {
 			strbuf_addstr(&quickref, "...");
@@ -378,7 +378,7 @@ static void print_ok_ref_status(struct ref *ref, int porcelain, int summary_widt
 			type = ' ';
 			msg = NULL;
 		}
-		strbuf_add_unique_abbrev(&quickref, ref->new_oid.hash,
+		strbuf_add_unique_abbrev(&quickref, &ref->new_oid,
 					 DEFAULT_ABBREV);
 
 		print_ref_status(type, quickref.buf, ref, ref->peer_ref, msg,
diff --git a/wt-status.c b/wt-status.c
index f5debcd2b4..98e558a70b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1187,7 +1187,7 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 		strbuf_trim(split[1]);
 		if (!get_oid(split[1]->buf, &oid)) {
 			strbuf_reset(split[1]);
-			strbuf_add_unique_abbrev(split[1], oid.hash,
+			strbuf_add_unique_abbrev(split[1], &oid,
 						 DEFAULT_ABBREV);
 			strbuf_addch(split[1], ' ');
 			strbuf_reset(line);
@@ -1421,7 +1421,7 @@ static char *get_branch(const struct worktree *wt, const char *path)
 		;
 	else if (!get_oid_hex(sb.buf, &oid)) {
 		strbuf_reset(&sb);
-		strbuf_add_unique_abbrev(&sb, oid.hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&sb, &oid, DEFAULT_ABBREV);
 	} else if (!strcmp(sb.buf, "detached HEAD")) /* rebase */
 		goto got_nothing;
 	else			/* bisect */
@@ -1458,7 +1458,7 @@ static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
 	if (!strcmp(cb->buf.buf, "HEAD")) {
 		/* HEAD is relative. Resolve it to the right reflog entry. */
 		strbuf_reset(&cb->buf);
-		strbuf_add_unique_abbrev(&cb->buf, noid->hash, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&cb->buf, noid, DEFAULT_ABBREV);
 	}
 	return 1;
 }
