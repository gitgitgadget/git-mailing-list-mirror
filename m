Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C431FC3E
	for <e@80x24.org>; Mon,  1 May 2017 02:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642318AbdEACaH (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 22:30:07 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:35598 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S642309AbdEACaE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 30 Apr 2017 22:30:04 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4E9C9280AE;
        Mon,  1 May 2017 02:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1493605802;
        bh=BMHazu5Q8qr02PVTQgJ4GIBHng/Qrz8E37JQif3hZTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pzGvV4fsU5xmoJM+hTEJ2Y+Rjfu6GYVIlFTO66ZzIdto2tRR28uIT3iuZd9C9Z2Vh
         4wBSQ86os/optVj+2uyMgg4hdF9s7od89OuqdNu0AK/oWm345jJAe3/FuPdk/SKZzr
         F2amVM9aoiteJc9kJpgcM1ovsGspa1/2Q+P2o7Wab5zYc0BCiSn7l8VqO8ejoCCw/a
         i1Bz/m85KMDFi7POuulAnGpBt0lvVhu4wa3YiUcwCR+1ZEVnH+cqAUc7iRgUUkDBcl
         CDjfpN/n5BUwvK17X5rdYi19mSDmZXpb0SaJ8VlJ8313g01/WqBf/4eIZeRXpc/W2x
         2N15+sNaSgaYlkfWXwrtqEmpB7FDZTLdLOpa4deErZ8FWptiCW5WbCuJ68SJCakofC
         PaMECcVnI7dHCHMnRDRh6VFNqtj6i5tC+gjFx8kO16Cks49egHi+KXlGT1GGl+GHYC
         mhYsWhtAO1bp1moKlxe3Sxzdo2YKNJcSRoPfSUm4vKCKjP3JosM
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 01/53] fetch-pack: convert to struct object_id
Date:   Mon,  1 May 2017 02:28:54 +0000
Message-Id: <20170501022946.258735-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.13.0.rc0.306.g87b477812d
In-Reply-To: <20170501022946.258735-1-sandals@crustytoothpaste.net>
References: <20170501022946.258735-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert all uses of unsigned char [20] to struct object_id.  Switch one
use of get_sha1_hex to parse_oid_hex to avoid the need for a constant.
This change is necessary in order to convert parse_object.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 fetch-pack.c | 89 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index afb8b0502..b42d01f42 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -118,9 +118,9 @@ static void rev_list_push(struct commit *commit, int mark)
 	}
 }
 
-static int rev_list_insert_ref(const char *refname, const unsigned char *sha1)
+static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 {
-	struct object *o = deref_tag(parse_object(sha1), refname, 0);
+	struct object *o = deref_tag(parse_object(oid->hash), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		rev_list_push((struct commit *)o, SEEN);
@@ -131,7 +131,7 @@ static int rev_list_insert_ref(const char *refname, const unsigned char *sha1)
 static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
 				   int flag, void *cb_data)
 {
-	return rev_list_insert_ref(refname, oid->hash);
+	return rev_list_insert_ref(refname, oid);
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
@@ -183,7 +183,7 @@ static void mark_common(struct commit *commit,
   Get the next rev to send, ignoring the common.
 */
 
-static const unsigned char *get_rev(void)
+static const struct object_id *get_rev(void)
 {
 	struct commit *commit = NULL;
 
@@ -222,7 +222,7 @@ static const unsigned char *get_rev(void)
 		}
 	}
 
-	return commit->object.oid.hash;
+	return &commit->object.oid;
 }
 
 enum ack_type {
@@ -251,7 +251,7 @@ static void consume_shallow_list(struct fetch_pack_args *args, int fd)
 	}
 }
 
-static enum ack_type get_ack(int fd, unsigned char *result_sha1)
+static enum ack_type get_ack(int fd, struct object_id *result_oid)
 {
 	int len;
 	char *line = packet_read_line(fd, &len);
@@ -262,7 +262,7 @@ static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 	if (!strcmp(line, "NAK"))
 		return NAK;
 	if (skip_prefix(line, "ACK ", &arg)) {
-		if (!get_sha1_hex(arg, result_sha1)) {
+		if (!get_oid_hex(arg, result_oid)) {
 			arg += 40;
 			len -= arg - line;
 			if (len < 1)
@@ -293,7 +293,7 @@ static void send_request(struct fetch_pack_args *args,
 
 static void insert_one_alternate_object(struct object *obj)
 {
-	rev_list_insert_ref(NULL, obj->oid.hash);
+	rev_list_insert_ref(NULL, &obj->oid);
 }
 
 #define INITIAL_FLUSH 16
@@ -317,12 +317,12 @@ static int next_flush(struct fetch_pack_args *args, int count)
 }
 
 static int find_common(struct fetch_pack_args *args,
-		       int fd[2], unsigned char *result_sha1,
+		       int fd[2], struct object_id *result_oid,
 		       struct ref *refs)
 {
 	int fetching;
 	int count = 0, flushes = 0, flush_at = INITIAL_FLUSH, retval;
-	const unsigned char *sha1;
+	const struct object_id *oid;
 	unsigned in_vain = 0;
 	int got_continue = 0;
 	int got_ready = 0;
@@ -340,7 +340,7 @@ static int find_common(struct fetch_pack_args *args,
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
-		unsigned char *remote = refs->old_oid.hash;
+		struct object_id *remote = &refs->old_oid;
 		const char *remote_hex;
 		struct object *o;
 
@@ -354,12 +354,12 @@ static int find_common(struct fetch_pack_args *args,
 		 * interested in the case we *know* the object is
 		 * reachable and we have already scanned it.
 		 */
-		if (((o = lookup_object(remote)) != NULL) &&
+		if (((o = lookup_object(remote->hash)) != NULL) &&
 				(o->flags & COMPLETE)) {
 			continue;
 		}
 
-		remote_hex = sha1_to_hex(remote);
+		remote_hex = oid_to_hex(remote);
 		if (!fetching) {
 			struct strbuf c = STRBUF_INIT;
 			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
@@ -410,25 +410,25 @@ static int find_common(struct fetch_pack_args *args,
 	if (args->deepen) {
 		char *line;
 		const char *arg;
-		unsigned char sha1[20];
+		struct object_id oid;
 
 		send_request(args, fd[1], &req_buf);
 		while ((line = packet_read_line(fd[0], NULL))) {
 			if (skip_prefix(line, "shallow ", &arg)) {
-				if (get_sha1_hex(arg, sha1))
+				if (get_oid_hex(arg, &oid))
 					die(_("invalid shallow line: %s"), line);
-				register_shallow(sha1);
+				register_shallow(oid.hash);
 				continue;
 			}
 			if (skip_prefix(line, "unshallow ", &arg)) {
-				if (get_sha1_hex(arg, sha1))
+				if (get_oid_hex(arg, &oid))
 					die(_("invalid unshallow line: %s"), line);
-				if (!lookup_object(sha1))
+				if (!lookup_object(oid.hash))
 					die(_("object not found: %s"), line);
 				/* make sure that it is parsed as shallow */
-				if (!parse_object(sha1))
+				if (!parse_object(oid.hash))
 					die(_("error in object: %s"), line);
-				if (unregister_shallow(sha1))
+				if (unregister_shallow(oid.hash))
 					die(_("no shallow found: %s"), line);
 				continue;
 			}
@@ -447,9 +447,9 @@ static int find_common(struct fetch_pack_args *args,
 
 	flushes = 0;
 	retval = -1;
-	while ((sha1 = get_rev())) {
-		packet_buf_write(&req_buf, "have %s\n", sha1_to_hex(sha1));
-		print_verbose(args, "have %s", sha1_to_hex(sha1));
+	while ((oid = get_rev())) {
+		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
+		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
 		if (flush_at <= ++count) {
 			int ack;
@@ -469,10 +469,10 @@ static int find_common(struct fetch_pack_args *args,
 
 			consume_shallow_list(args, fd[0]);
 			do {
-				ack = get_ack(fd[0], result_sha1);
+				ack = get_ack(fd[0], result_oid);
 				if (ack)
 					print_verbose(args, _("got %s %d %s"), "ack",
-						      ack, sha1_to_hex(result_sha1));
+						      ack, oid_to_hex(result_oid));
 				switch (ack) {
 				case ACK:
 					flushes = 0;
@@ -483,9 +483,9 @@ static int find_common(struct fetch_pack_args *args,
 				case ACK_ready:
 				case ACK_continue: {
 					struct commit *commit =
-						lookup_commit(result_sha1);
+						lookup_commit(result_oid->hash);
 					if (!commit)
-						die(_("invalid commit %s"), sha1_to_hex(result_sha1));
+						die(_("invalid commit %s"), oid_to_hex(result_oid));
 					if (args->stateless_rpc
 					 && ack == ACK_common
 					 && !(commit->object.flags & COMMON)) {
@@ -493,7 +493,7 @@ static int find_common(struct fetch_pack_args *args,
 						 * on the next RPC request so the peer knows
 						 * it is in common with us.
 						 */
-						const char *hex = sha1_to_hex(result_sha1);
+						const char *hex = oid_to_hex(result_oid);
 						packet_buf_write(&req_buf, "have %s\n", hex);
 						state_len = req_buf.len;
 						/*
@@ -538,10 +538,10 @@ static int find_common(struct fetch_pack_args *args,
 	if (!got_ready || !no_done)
 		consume_shallow_list(args, fd[0]);
 	while (flushes || multi_ack) {
-		int ack = get_ack(fd[0], result_sha1);
+		int ack = get_ack(fd[0], result_oid);
 		if (ack) {
 			print_verbose(args, _("got %s (%d) %s"), "ack",
-				      ack, sha1_to_hex(result_sha1));
+				      ack, oid_to_hex(result_oid));
 			if (ack == ACK)
 				return 0;
 			multi_ack = 1;
@@ -555,9 +555,9 @@ static int find_common(struct fetch_pack_args *args,
 
 static struct commit_list *complete;
 
-static int mark_complete(const unsigned char *sha1)
+static int mark_complete(const struct object_id *oid)
 {
-	struct object *o = parse_object(sha1);
+	struct object *o = parse_object(oid->hash);
 
 	while (o && o->type == OBJ_TAG) {
 		struct tag *t = (struct tag *) o;
@@ -579,7 +579,7 @@ static int mark_complete(const unsigned char *sha1)
 static int mark_complete_oid(const char *refname, const struct object_id *oid,
 			     int flag, void *cb_data)
 {
-	return mark_complete(oid->hash);
+	return mark_complete(oid);
 }
 
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
@@ -637,14 +637,15 @@ static void filter_refs(struct fetch_pack_args *args,
 
 	/* Append unmatched requests to the list */
 	for (i = 0; i < nr_sought; i++) {
-		unsigned char sha1[20];
+		struct object_id oid;
+		const char *p;
 
 		ref = sought[i];
 		if (ref->match_status != REF_NOT_MATCHED)
 			continue;
-		if (get_sha1_hex(ref->name, sha1) ||
-		    ref->name[40] != '\0' ||
-		    hashcmp(sha1, ref->old_oid.hash))
+		if (parse_oid_hex(ref->name, &oid, &p) ||
+		    *p != '\0' ||
+		    oidcmp(&oid, &ref->old_oid))
 			continue;
 
 		if ((allow_unadvertised_object_request &
@@ -661,7 +662,7 @@ static void filter_refs(struct fetch_pack_args *args,
 
 static void mark_alternate_complete(struct object *obj)
 {
-	mark_complete(obj->oid.hash);
+	mark_complete(&obj->oid);
 }
 
 static int everything_local(struct fetch_pack_args *args,
@@ -724,17 +725,17 @@ static int everything_local(struct fetch_pack_args *args,
 	filter_refs(args, refs, sought, nr_sought);
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
-		const unsigned char *remote = ref->old_oid.hash;
+		const struct object_id *remote = &ref->old_oid;
 		struct object *o;
 
-		o = lookup_object(remote);
+		o = lookup_object(remote->hash);
 		if (!o || !(o->flags & COMPLETE)) {
 			retval = 0;
-			print_verbose(args, "want %s (%s)", sha1_to_hex(remote),
+			print_verbose(args, "want %s (%s)", oid_to_hex(remote),
 				      ref->name);
 			continue;
 		}
-		print_verbose(args, _("already have %s (%s)"), sha1_to_hex(remote),
+		print_verbose(args, _("already have %s (%s)"), oid_to_hex(remote),
 			      ref->name);
 	}
 	return retval;
@@ -873,7 +874,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
-	unsigned char sha1[20];
+	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
 
@@ -945,7 +946,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(args, fd, sha1, ref) < 0)
+	if (find_common(args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
