Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FB8B207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 21:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1046249AbdDWVhi (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 17:37:38 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:37322 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1046149AbdDWVf4 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 23 Apr 2017 17:35:56 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 903C2280D2;
        Sun, 23 Apr 2017 21:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1492983340;
        bh=DaYWDkpF5ABNPlKwIlgwWMx/S7tRUxahtkt04AfLL0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zVafDHzYLA1sZcBkWWlhPWIY2iy4TIp4sX+6GtjbmlqDmgn4yAdg5vEnkTVSXDKBE
         4jasPGOlYIaxkpunvc0dJ7q606nwGfwraM4+ZaLvNMMlqAFnvJyVvKGvcv4rU0eOsK
         /hhdr4mZaUvM+xAHIy+nkAuEereWOrIGAXCta9W+jrn+0faO6fYYyuEmByJxt6uURW
         gKLG6Fy3hEKSa/+LRQj1h9MKmRDjUJWGepuLoYTip5/TDVUzBtHm03mIngYdrVWvPO
         cyF01Y1Zzc9M2uq3JSrTeR5MrD6Ez1y4vXMRFUGzpJ75X01Ps9ZxIH4g4qsDKLiAbh
         33reH8In8mVfyHFRSOVVi0+3f8dNBcxM4q7nlY0OFjno0ENVEovl2c2lMRQZDBMgjf
         RQt+JGXTAJ3VBrk6ubJSJPmP5GV3ox88vwHOTDpV2HqkFftxfdhrRrmxT0Pofx7dgm
         dyz8GeIUhB1twHNDsPcMduKV7UFryQE7/km3GKNbJd6y2/rDx7l
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 39/53] refs/files-backend: convert many internals to struct object_id
Date:   Sun, 23 Apr 2017 21:34:39 +0000
Message-Id: <20170423213453.253425-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.12.2.762.g0e3151a226
In-Reply-To: <20170423213453.253425-1-sandals@crustytoothpaste.net>
References: <20170423213453.253425-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert many of the internals of the files backend to use struct
object_id.  Avoid converting public APIs to limit the scope of the
changes.

Convert one use of get_sha1_hex to parse_oid_hex, and rely on the fact
that a strbuf will be NUL-terminated and that parse_oid_hex will fail on
truncated input to avoid the need to check for an explicit length.

This is a requirement to convert parse_object later on.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs/files-backend.c | 133 ++++++++++++++++++++++++---------------------------
 1 file changed, 62 insertions(+), 71 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index ccabf761e..171a157f7 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -166,8 +166,8 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
 					  int incomplete);
 static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 static int files_log_ref_write(struct files_ref_store *refs,
-			       const char *refname, const unsigned char *old_sha1,
-			       const unsigned char *new_sha1, const char *msg,
+			       const char *refname, const struct object_id *old_oid,
+			       const struct object_id *new_oid, const char *msg,
 			       int flags, struct strbuf *err);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
@@ -201,7 +201,7 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 static struct ref_entry *create_ref_entry(const char *refname,
-					  const unsigned char *sha1, int flag,
+					  const struct object_id *oid, int flag,
 					  int check_name)
 {
 	struct ref_entry *ref;
@@ -210,7 +210,7 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 	FLEX_ALLOC_STR(ref, name, refname);
-	hashcpy(ref->u.value.oid.hash, sha1);
+	oidcpy(&ref->u.value.oid, oid);
 	oidclr(&ref->u.value.peeled);
 	ref->flag = flag;
 	return ref;
@@ -1049,27 +1049,18 @@ static const char PACKED_REFS_HEADER[] =
  * Return a pointer to the refname within the line (null-terminated),
  * or NULL if there was a problem.
  */
-static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
+static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 {
 	const char *ref;
 
-	/*
-	 * 42: the answer to everything.
-	 *
-	 * In this case, it happens to be the answer to
-	 *  40 (length of sha1 hex representation)
-	 *  +1 (space in between hex and name)
-	 *  +1 (newline at the end of the line)
-	 */
-	if (line->len <= 42)
+	if (!line->len)
 		return NULL;
 
-	if (get_sha1_hex(line->buf, sha1) < 0)
+	if (parse_oid_hex(line->buf, oid, &ref) < 0)
 		return NULL;
-	if (!isspace(line->buf[40]))
+	if (!isspace(*ref++))
 		return NULL;
 
-	ref = line->buf + 41;
 	if (isspace(*ref))
 		return NULL;
 
@@ -1114,7 +1105,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *refname;
 		const char *traits;
 
@@ -1127,17 +1118,17 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			continue;
 		}
 
-		refname = parse_ref_line(&line, sha1);
+		refname = parse_ref_line(&line, &oid);
 		if (refname) {
 			int flag = REF_ISPACKED;
 
 			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 				if (!refname_is_safe(refname))
 					die("packed refname is dangerous: %s", refname);
-				hashclr(sha1);
+				oidclr(&oid);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
-			last = create_ref_entry(refname, sha1, flag, 0);
+			last = create_ref_entry(refname, &oid, flag, 0);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -1148,8 +1139,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		    line.buf[0] == '^' &&
 		    line.len == PEELED_LINE_LENGTH &&
 		    line.buf[PEELED_LINE_LENGTH - 1] == '\n' &&
-		    !get_sha1_hex(line.buf + 1, sha1)) {
-			hashcpy(last->u.value.peeled.hash, sha1);
+		    !get_oid_hex(line.buf + 1, &oid)) {
+			oidcpy(&last->u.value.peeled, &oid);
 			/*
 			 * Regardless of what the file header said,
 			 * we definitely know the value of *this*
@@ -1257,14 +1248,14 @@ static struct ref_dir *get_packed_refs(struct files_ref_store *refs)
  * commit_packed_refs().
  */
 static void add_packed_ref(struct files_ref_store *refs,
-			   const char *refname, const unsigned char *sha1)
+			   const char *refname, const struct object_id *oid)
 {
 	struct packed_ref_cache *packed_ref_cache = get_packed_ref_cache(refs);
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
 	add_ref(get_packed_ref_dir(packed_ref_cache),
-		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+		create_ref_entry(refname, oid, REF_ISPACKED, 1));
 }
 
 /*
@@ -1295,7 +1286,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	strbuf_add(&refname, dirname, dirnamelen);
 
 	while ((de = readdir(d)) != NULL) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct stat st;
 		int flag;
 
@@ -1316,10 +1307,10 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
 						     RESOLVE_REF_READING,
-						     sha1, &flag)) {
-				hashclr(sha1);
+						     oid.hash, &flag)) {
+				oidclr(&oid);
 				flag |= REF_ISBROKEN;
-			} else if (is_null_sha1(sha1)) {
+			} else if (is_null_oid(&oid)) {
 				/*
 				 * It is so astronomically unlikely
 				 * that NULL_SHA1 is the SHA-1 of an
@@ -1335,11 +1326,11 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 						 REFNAME_ALLOW_ONELEVEL)) {
 				if (!refname_is_safe(refname.buf))
 					die("loose refname is dangerous: %s", refname.buf);
-				hashclr(sha1);
+				oidclr(&oid);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag, 0));
+					 create_ref_entry(refname.buf, &oid, flag, 0));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 		strbuf_setlen(&path, path_baselen);
@@ -2327,7 +2318,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
 		oidcpy(&packed_entry->u.value.oid, &entry->u.value.oid);
 	} else {
-		packed_entry = create_ref_entry(entry->name, entry->u.value.oid.hash,
+		packed_entry = create_ref_entry(entry->name, &entry->u.value.oid,
 						REF_ISPACKED | REF_KNOWS_PEELED, 0);
 		add_ref(cb->packed_refs, packed_entry);
 	}
@@ -2629,10 +2620,10 @@ static int files_verify_refname_available(struct ref_store *ref_store,
 }
 
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const unsigned char *sha1, struct strbuf *err);
+				 const struct object_id *oid, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
-			     const unsigned char *sha1, const char *logmsg,
+			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err);
 
 static int files_rename_ref(struct ref_store *ref_store,
@@ -2641,7 +2632,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
-	unsigned char sha1[20], orig_sha1[20];
+	struct object_id oid, orig_oid;
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
@@ -2663,7 +2654,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 
 	if (!refs_resolve_ref_unsafe(&refs->base, oldrefname,
 				     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				orig_sha1, &flag)) {
+				orig_oid.hash, &flag)) {
 		ret = error("refname %s not found", oldrefname);
 		goto out;
 	}
@@ -2685,21 +2676,21 @@ static int files_rename_ref(struct ref_store *ref_store,
 	}
 
 	if (refs_delete_ref(&refs->base, logmsg, oldrefname,
-			    orig_sha1, REF_NODEREF)) {
+			    orig_oid.hash, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
 
 	/*
-	 * Since we are doing a shallow lookup, sha1 is not the
-	 * correct value to pass to delete_ref as old_sha1. But that
-	 * doesn't matter, because an old_sha1 check wouldn't add to
+	 * Since we are doing a shallow lookup, oid is not the
+	 * correct value to pass to delete_ref as old_oid. But that
+	 * doesn't matter, because an old_oid check wouldn't add to
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
 	if (!refs_read_ref_full(&refs->base, newrefname,
 				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				sha1, NULL) &&
+				oid.hash, NULL) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
 			    NULL, REF_NODEREF)) {
 		if (errno == EISDIR) {
@@ -2732,10 +2723,10 @@ static int files_rename_ref(struct ref_store *ref_store,
 		strbuf_release(&err);
 		goto rollback;
 	}
-	hashcpy(lock->old_oid.hash, orig_sha1);
+	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(refs, lock, orig_sha1, logmsg, &err)) {
+	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -2755,8 +2746,8 @@ static int files_rename_ref(struct ref_store *ref_store,
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(refs, lock, orig_sha1, NULL, &err)) {
+	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -2906,8 +2897,8 @@ static int files_create_reflog(struct ref_store *ref_store,
 	return 0;
 }
 
-static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
-			    const unsigned char *new_sha1,
+static int log_ref_write_fd(int fd, const struct object_id *old_oid,
+			    const struct object_id *new_oid,
 			    const char *committer, const char *msg)
 {
 	int msglen, written;
@@ -2918,8 +2909,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 	maxlen = strlen(committer) + msglen + 100;
 	logrec = xmalloc(maxlen);
 	len = xsnprintf(logrec, maxlen, "%s %s %s\n",
-			sha1_to_hex(old_sha1),
-			sha1_to_hex(new_sha1),
+			oid_to_hex(old_oid),
+			oid_to_hex(new_oid),
 			committer);
 	if (msglen)
 		len += copy_reflog_msg(logrec + len - 1, msg) - 1;
@@ -2933,8 +2924,8 @@ static int log_ref_write_fd(int fd, const unsigned char *old_sha1,
 }
 
 static int files_log_ref_write(struct files_ref_store *refs,
-			       const char *refname, const unsigned char *old_sha1,
-			       const unsigned char *new_sha1, const char *msg,
+			       const char *refname, const struct object_id *old_oid,
+			       const struct object_id *new_oid, const char *msg,
 			       int flags, struct strbuf *err)
 {
 	int logfd, result;
@@ -2951,7 +2942,7 @@ static int files_log_ref_write(struct files_ref_store *refs,
 
 	if (logfd < 0)
 		return 0;
-	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
+	result = log_ref_write_fd(logfd, old_oid, new_oid,
 				  git_committer_info(0), msg);
 	if (result) {
 		struct strbuf sb = STRBUF_INIT;
@@ -2983,29 +2974,29 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * return -1.
  */
 static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const unsigned char *sha1, struct strbuf *err)
+				 const struct object_id *oid, struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 	int fd;
 
-	o = parse_object(sha1);
+	o = parse_object(oid->hash);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
-			    lock->ref_name, sha1_to_hex(sha1));
+			    lock->ref_name, oid_to_hex(oid));
 		unlock_ref(lock);
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		strbuf_addf(err,
 			    "trying to write non-commit object %s to branch '%s'",
-			    sha1_to_hex(sha1), lock->ref_name);
+			    oid_to_hex(oid), lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
 	fd = get_lock_file_fd(lock->lk);
-	if (write_in_full(fd, sha1_to_hex(sha1), 40) != 40 ||
+	if (write_in_full(fd, oid_to_hex(oid), GIT_SHA1_HEXSZ) != GIT_SHA1_HEXSZ ||
 	    write_in_full(fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		strbuf_addf(err,
@@ -3023,14 +3014,14 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
  */
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
-			     const unsigned char *sha1, const char *logmsg,
+			     const struct object_id *oid, const char *logmsg,
 			     struct strbuf *err)
 {
 	files_assert_main_repository(refs, "commit_ref_update");
 
 	clear_loose_ref_cache(refs);
 	if (files_log_ref_write(refs, lock->ref_name,
-				lock->old_oid.hash, sha1,
+				&lock->old_oid, oid,
 				logmsg, 0, err)) {
 		char *old_msg = strbuf_detach(err, NULL);
 		strbuf_addf(err, "cannot update the ref '%s': %s",
@@ -3053,18 +3044,18 @@ static int commit_ref_update(struct files_ref_store *refs,
 		 * check with HEAD only which should cover 99% of all usage
 		 * scenarios (even 100% of the default ones).
 		 */
-		unsigned char head_sha1[20];
+		struct object_id head_oid;
 		int head_flag;
 		const char *head_ref;
 
 		head_ref = refs_resolve_ref_unsafe(&refs->base, "HEAD",
 						   RESOLVE_REF_READING,
-						   head_sha1, &head_flag);
+						   head_oid.hash, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
 			if (files_log_ref_write(refs, "HEAD",
-						lock->old_oid.hash, sha1,
+						&lock->old_oid, oid,
 						logmsg, 0, &log_err)) {
 				error("%s", log_err.buf);
 				strbuf_release(&log_err);
@@ -3102,12 +3093,12 @@ static void update_symref_reflog(struct files_ref_store *refs,
 				 const char *target, const char *logmsg)
 {
 	struct strbuf err = STRBUF_INIT;
-	unsigned char new_sha1[20];
+	struct object_id new_oid;
 	if (logmsg &&
 	    !refs_read_ref_full(&refs->base, target,
-				RESOLVE_REF_READING, new_sha1, NULL) &&
-	    files_log_ref_write(refs, refname, lock->old_oid.hash,
-				new_sha1, logmsg, 0, &err)) {
+				RESOLVE_REF_READING, new_oid.hash, NULL) &&
+	    files_log_ref_write(refs, refname, &lock->old_oid,
+				&new_oid, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
@@ -3782,7 +3773,7 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, update->new_oid.hash,
+		} else if (write_ref_to_lockfile(lock, &update->new_oid,
 						 err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
@@ -3917,8 +3908,8 @@ static int files_transaction_commit(struct ref_store *ref_store,
 		    update->flags & REF_LOG_ONLY) {
 			if (files_log_ref_write(refs,
 						lock->ref_name,
-						lock->old_oid.hash,
-						update->new_oid.hash,
+						&lock->old_oid,
+						&update->new_oid,
 						update->msg, update->flags,
 						err)) {
 				char *old_msg = strbuf_detach(err, NULL);
@@ -4090,7 +4081,7 @@ static int files_initial_transaction_commit(struct ref_store *ref_store,
 		if ((update->flags & REF_HAVE_NEW) &&
 		    !is_null_oid(&update->new_oid))
 			add_packed_ref(refs, update->refname,
-				       update->new_oid.hash);
+				       &update->new_oid);
 	}
 
 	if (commit_packed_refs(refs)) {
