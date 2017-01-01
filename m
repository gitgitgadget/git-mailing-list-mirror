Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B24F1FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 19:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932417AbdAATTw (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 14:19:52 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:53874 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932406AbdAATTq (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 14:19:46 -0500
Received: from genre.crustytoothpaste.net (unknown [173.243.43.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C60D4280AF;
        Sun,  1 Jan 2017 19:19:44 +0000 (UTC)
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 13/17] refs: convert each_reflog_ent_fn to struct object_id
Date:   Sun,  1 Jan 2017 19:18:43 +0000
Message-Id: <20170101191847.564741-14-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170101191847.564741-1-sandals@crustytoothpaste.net>
References: <20170101191847.564741-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make each_reflog_ent_fn take two struct object_id pointers instead of
two pointers to unsigned char.  Convert the various callbacks to use
struct object_id as well.  Also, rename fsck_handle_reflog_sha1 to
fsck_handle_reflog_oid.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/fsck.c       | 16 ++++++++--------
 builtin/merge-base.c |  6 +++---
 builtin/reflog.c     |  2 +-
 reflog-walk.c        |  6 +++---
 refs.c               | 24 ++++++++++++------------
 refs.h               |  2 +-
 refs/files-backend.c | 24 ++++++++++++------------
 revision.c           | 12 ++++++------
 sha1_name.c          |  2 +-
 wt-status.c          |  6 +++---
 10 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f01b81eeb..8d6e98399 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -393,13 +393,13 @@ static int fsck_obj_buffer(const unsigned char *sha1, enum object_type type,
 
 static int default_refs;
 
-static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
+static void fsck_handle_reflog_oid(const char *refname, struct object_id *oid,
 	unsigned long timestamp)
 {
 	struct object *obj;
 
-	if (!is_null_sha1(sha1)) {
-		obj = lookup_object(sha1);
+	if (!is_null_oid(oid)) {
+		obj = lookup_object(oid->hash);
 		if (obj) {
 			if (timestamp && name_objects)
 				add_decoration(fsck_walk_options.object_names,
@@ -408,13 +408,13 @@ static void fsck_handle_reflog_sha1(const char *refname, unsigned char *sha1,
 			obj->used = 1;
 			mark_object_reachable(obj);
 		} else {
-			error("%s: invalid reflog entry %s", refname, sha1_to_hex(sha1));
+			error("%s: invalid reflog entry %s", refname, oid_to_hex(oid));
 			errors_found |= ERROR_REACHABLE;
 		}
 	}
 }
 
-static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
@@ -422,10 +422,10 @@ static int fsck_handle_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	if (verbose)
 		fprintf(stderr, "Checking reflog %s->%s\n",
-			sha1_to_hex(osha1), sha1_to_hex(nsha1));
+			oid_to_hex(ooid), oid_to_hex(noid));
 
-	fsck_handle_reflog_sha1(refname, osha1, 0);
-	fsck_handle_reflog_sha1(refname, nsha1, timestamp);
+	fsck_handle_reflog_oid(refname, ooid, 0);
+	fsck_handle_reflog_oid(refname, noid, timestamp);
 	return 0;
 }
 
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index b572a37c2..db95bc29c 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -131,7 +131,7 @@ static void add_one_commit(unsigned char *sha1, struct rev_collect *revs)
 	commit->object.flags |= TMP_MARK;
 }
 
-static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+static int collect_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 				  const char *ident, unsigned long timestamp,
 				  int tz, const char *message, void *cbdata)
 {
@@ -139,9 +139,9 @@ static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 
 	if (revs->initial) {
 		revs->initial = 0;
-		add_one_commit(osha1, revs);
+		add_one_commit(ooid->hash, revs);
 	}
-	add_one_commit(nsha1, revs);
+	add_one_commit(noid->hash, revs);
 	return 0;
 }
 
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7a7136e53..747277577 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -615,7 +615,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
-static int count_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+static int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
diff --git a/reflog-walk.c b/reflog-walk.c
index fe5be4147..99679f582 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -19,7 +19,7 @@ struct complete_reflogs {
 	int nr, alloc;
 };
 
-static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
+static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
@@ -28,8 +28,8 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
 
 	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
 	item = array->items + array->nr;
-	hashcpy(item->ooid.hash, osha1);
-	hashcpy(item->noid.hash, nsha1);
+	oidcpy(&item->ooid, ooid);
+	oidcpy(&item->noid, noid);
 	item->email = xstrdup(email);
 	item->timestamp = timestamp;
 	item->tz = tz;
diff --git a/refs.c b/refs.c
index 9bd0bc177..4bc924790 100644
--- a/refs.c
+++ b/refs.c
@@ -669,7 +669,7 @@ struct read_ref_at_cb {
 	int *cutoff_cnt;
 };
 
-static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
+static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
@@ -693,30 +693,30 @@ static int read_ref_at_ent(unsigned char *osha1, unsigned char *nsha1,
 		 * hold the values for the previous record.
 		 */
 		if (!is_null_sha1(cb->osha1)) {
-			hashcpy(cb->sha1, nsha1);
-			if (hashcmp(cb->osha1, nsha1))
+			hashcpy(cb->sha1, noid->hash);
+			if (hashcmp(cb->osha1, noid->hash))
 				warning("Log for ref %s has gap after %s.",
 					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
-			hashcpy(cb->sha1, nsha1);
-		else if (hashcmp(nsha1, cb->sha1))
+			hashcpy(cb->sha1, noid->hash);
+		else if (hashcmp(noid->hash, cb->sha1))
 			warning("Log for ref %s unexpectedly ended on %s.",
 				cb->refname, show_date(cb->date, cb->tz,
 						       DATE_MODE(RFC2822)));
-		hashcpy(cb->osha1, osha1);
-		hashcpy(cb->nsha1, nsha1);
+		hashcpy(cb->osha1, ooid->hash);
+		hashcpy(cb->nsha1, noid->hash);
 		cb->found_it = 1;
 		return 1;
 	}
-	hashcpy(cb->osha1, osha1);
-	hashcpy(cb->nsha1, nsha1);
+	hashcpy(cb->osha1, ooid->hash);
+	hashcpy(cb->nsha1, noid->hash);
 	if (cb->cnt > 0)
 		cb->cnt--;
 	return 0;
 }
 
-static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
+static int read_ref_at_ent_oldest(struct object_id *ooid, struct object_id *noid,
 				  const char *email, unsigned long timestamp,
 				  int tz, const char *message, void *cb_data)
 {
@@ -730,9 +730,9 @@ static int read_ref_at_ent_oldest(unsigned char *osha1, unsigned char *nsha1,
 		*cb->cutoff_tz = tz;
 	if (cb->cutoff_cnt)
 		*cb->cutoff_cnt = cb->reccnt;
-	hashcpy(cb->sha1, osha1);
+	hashcpy(cb->sha1, ooid->hash);
 	if (is_null_sha1(cb->sha1))
-		hashcpy(cb->sha1, nsha1);
+		hashcpy(cb->sha1, noid->hash);
 	/* We just want the first entry */
 	return 1;
 }
diff --git a/refs.h b/refs.h
index 694784391..ce35c4019 100644
--- a/refs.h
+++ b/refs.h
@@ -290,7 +290,7 @@ int delete_reflog(const char *refname);
 
 /* iterate over reflog entries */
 typedef int each_reflog_ent_fn(
-		unsigned char *old_sha1, unsigned char *new_sha1,
+		struct object_id *old_oid, struct object_id *new_oid,
 		const char *committer, unsigned long timestamp,
 		int tz, const char *msg, void *cb_data);
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f9023939d..3da3141ee 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3113,15 +3113,15 @@ static int files_delete_reflog(struct ref_store *ref_store,
 
 static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
 {
-	unsigned char osha1[20], nsha1[20];
+	struct object_id ooid, noid;
 	char *email_end, *message;
 	unsigned long timestamp;
 	int tz;
 
 	/* old SP new SP name <email> SP time TAB msg LF */
 	if (sb->len < 83 || sb->buf[sb->len - 1] != '\n' ||
-	    get_sha1_hex(sb->buf, osha1) || sb->buf[40] != ' ' ||
-	    get_sha1_hex(sb->buf + 41, nsha1) || sb->buf[81] != ' ' ||
+	    get_oid_hex(sb->buf, &ooid) || sb->buf[40] != ' ' ||
+	    get_oid_hex(sb->buf + 41, &noid) || sb->buf[81] != ' ' ||
 	    !(email_end = strchr(sb->buf + 82, '>')) ||
 	    email_end[1] != ' ' ||
 	    !(timestamp = strtoul(email_end + 2, &message, 10)) ||
@@ -3136,7 +3136,7 @@ static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *c
 		message += 6;
 	else
 		message += 7;
-	return fn(osha1, nsha1, sb->buf + 82, timestamp, tz, message, cb_data);
+	return fn(&ooid, &noid, sb->buf + 82, timestamp, tz, message, cb_data);
 }
 
 static char *find_beginning_of_line(char *bob, char *scan)
@@ -3936,10 +3936,10 @@ struct expire_reflog_cb {
 	reflog_expiry_should_prune_fn *should_prune_fn;
 	void *policy_cb;
 	FILE *newlog;
-	unsigned char last_kept_sha1[20];
+	struct object_id last_kept_oid;
 };
 
-static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 			     const char *email, unsigned long timestamp, int tz,
 			     const char *message, void *cb_data)
 {
@@ -3947,9 +3947,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	struct expire_reflog_policy_cb *policy_cb = cb->policy_cb;
 
 	if (cb->flags & EXPIRE_REFLOGS_REWRITE)
-		osha1 = cb->last_kept_sha1;
+		ooid = &cb->last_kept_oid;
 
-	if ((*cb->should_prune_fn)(osha1, nsha1, email, timestamp, tz,
+	if ((*cb->should_prune_fn)(ooid->hash, noid->hash, email, timestamp, tz,
 				   message, policy_cb)) {
 		if (!cb->newlog)
 			printf("would prune %s", message);
@@ -3958,9 +3958,9 @@ static int expire_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 	} else {
 		if (cb->newlog) {
 			fprintf(cb->newlog, "%s %s %s %lu %+05d\t%s",
-				sha1_to_hex(osha1), sha1_to_hex(nsha1),
+				oid_to_hex(ooid), oid_to_hex(noid),
 				email, timestamp, tz, message);
-			hashcpy(cb->last_kept_sha1, nsha1);
+			oidcpy(&cb->last_kept_oid, noid);
 		}
 		if (cb->flags & EXPIRE_REFLOGS_VERBOSE)
 			printf("keep %s", message);
@@ -4047,14 +4047,14 @@ static int files_reflog_expire(struct ref_store *ref_store,
 		 */
 		int update = (flags & EXPIRE_REFLOGS_UPDATE_REF) &&
 			!(type & REF_ISSYMREF) &&
-			!is_null_sha1(cb.last_kept_sha1);
+			!is_null_oid(&cb.last_kept_oid);
 
 		if (close_lock_file(&reflog_lock)) {
 			status |= error("couldn't write %s: %s", log_file,
 					strerror(errno));
 		} else if (update &&
 			   (write_in_full(get_lock_file_fd(lock->lk),
-				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
+				oid_to_hex(&cb.last_kept_oid), 40) != 40 ||
 			    write_str_in_full(get_lock_file_fd(lock->lk), "\n") != 1 ||
 			    close_ref(lock) < 0)) {
 			status |= error("couldn't write %s",
diff --git a/revision.c b/revision.c
index b37dbec37..d9fe73318 100644
--- a/revision.c
+++ b/revision.c
@@ -1196,11 +1196,11 @@ static void handle_refs(const char *submodule, struct rev_info *revs, unsigned f
 	for_each(submodule, handle_one_ref, &cb);
 }
 
-static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
+static void handle_one_reflog_commit(struct object_id *oid, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
-	if (!is_null_sha1(sha1)) {
-		struct object *o = parse_object(sha1);
+	if (!is_null_oid(oid)) {
+		struct object *o = parse_object(oid->hash);
 		if (o) {
 			o->flags |= cb->all_flags;
 			/* ??? CMDLINEFLAGS ??? */
@@ -1214,12 +1214,12 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 	}
 }
 
-static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+static int handle_one_reflog_ent(struct object_id *ooid, struct object_id *noid,
 		const char *email, unsigned long timestamp, int tz,
 		const char *message, void *cb_data)
 {
-	handle_one_reflog_commit(osha1, cb_data);
-	handle_one_reflog_commit(nsha1, cb_data);
+	handle_one_reflog_commit(ooid, cb_data);
+	handle_one_reflog_commit(noid, cb_data);
 	return 0;
 }
 
diff --git a/sha1_name.c b/sha1_name.c
index 73a915ff1..744e9f884 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1051,7 +1051,7 @@ struct grab_nth_branch_switch_cbdata {
 	struct strbuf buf;
 };
 
-static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
+static int grab_nth_branch_switch(struct object_id *ooid, struct object_id *noid,
 				  const char *email, unsigned long timestamp, int tz,
 				  const char *message, void *cb_data)
 {
diff --git a/wt-status.c b/wt-status.c
index f0d750880..08a4d0bd3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1367,7 +1367,7 @@ struct grab_1st_switch_cbdata {
 	unsigned char nsha1[20];
 };
 
-static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
+static int grab_1st_switch(struct object_id *ooid, struct object_id *noid,
 			   const char *email, unsigned long timestamp, int tz,
 			   const char *message, void *cb_data)
 {
@@ -1381,13 +1381,13 @@ static int grab_1st_switch(unsigned char *osha1, unsigned char *nsha1,
 		return 0;
 	target += strlen(" to ");
 	strbuf_reset(&cb->buf);
-	hashcpy(cb->nsha1, nsha1);
+	hashcpy(cb->nsha1, noid->hash);
 	end = strchrnul(target, '\n');
 	strbuf_add(&cb->buf, target, end - target);
 	if (!strcmp(cb->buf.buf, "HEAD")) {
 		/* HEAD is relative. Resolve it to the right reflog entry. */
 		strbuf_reset(&cb->buf);
-		strbuf_add_unique_abbrev(&cb->buf, nsha1, DEFAULT_ABBREV);
+		strbuf_add_unique_abbrev(&cb->buf, noid->hash, DEFAULT_ABBREV);
 	}
 	return 1;
 }
-- 
2.11.0

