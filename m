From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 01/10] refs: convert some internal functions to use object_id
Date: Sat, 13 Jun 2015 22:16:34 +0000
Message-ID: <1434233803-422442-2-git-send-email-sandals@crustytoothpaste.net>
References: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 14 00:17:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3tjq-0002tS-LS
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jun 2015 00:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbbFMWQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 18:16:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:42848 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751092AbbFMWQu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2015 18:16:50 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A61B428092;
	Sat, 13 Jun 2015 22:16:49 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434233803-422442-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -1 ALL_TRUSTED
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271591>

Convert several internal functions in refs.c to use struct object_id,
and use the GIT_SHA1_HEXSZ constants in parse_ref_line.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 104 ++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs.c b/refs.c
index 26d1ac1..2087012 100644
--- a/refs.c
+++ b/refs.c
@@ -1158,7 +1158,7 @@ static const char PACKED_REFS_HEADER[] =
  * Return a pointer to the refname within the line (null-terminated),
  * or NULL if there was a problem.
  */
-static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
+static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 {
 	const char *ref;
 
@@ -1170,15 +1170,15 @@ static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
 	 *  +1 (space in between hex and name)
 	 *  +1 (newline at the end of the line)
 	 */
-	if (line->len <= 42)
+	if (line->len <= GIT_SHA1_HEXSZ + 2)
 		return NULL;
 
-	if (get_sha1_hex(line->buf, sha1) < 0)
+	if (get_oid_hex(line->buf, oid) < 0)
 		return NULL;
-	if (!isspace(line->buf[40]))
+	if (!isspace(line->buf[GIT_SHA1_HEXSZ]))
 		return NULL;
 
-	ref = line->buf + 41;
+	ref = line->buf + GIT_SHA1_HEXSZ + 1;
 	if (isspace(*ref))
 		return NULL;
 
@@ -1223,7 +1223,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *refname;
 		const char *traits;
 
@@ -1236,17 +1236,17 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
+			last = create_ref_entry(refname, oid.hash, flag, 0);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -1257,8 +1257,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
@@ -1352,7 +1352,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	strbuf_add(&refname, dirname, dirnamelen);
 
 	while ((de = readdir(d)) != NULL) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct stat st;
 		int flag;
 		const char *refdir;
@@ -1374,27 +1374,27 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 							  refname.len, 1));
 		} else {
 			if (*refs->name) {
-				hashclr(sha1);
+				oidclr(&oid);
 				flag = 0;
-				if (resolve_gitlink_ref(refs->name, refname.buf, sha1) < 0) {
-					hashclr(sha1);
+				if (resolve_gitlink_ref(refs->name, refname.buf, oid.hash) < 0) {
+					oidclr(&oid);
 					flag |= REF_ISBROKEN;
 				}
 			} else if (read_ref_full(refname.buf,
 						 RESOLVE_REF_READING,
-						 sha1, &flag)) {
-				hashclr(sha1);
+						 oid.hash, &flag)) {
+				oidclr(&oid);
 				flag |= REF_ISBROKEN;
 			}
 			if (check_refname_format(refname.buf,
 						 REFNAME_ALLOW_ONELEVEL)) {
 				if (!refname_is_safe(refname.buf))
 					die("loose refname is dangerous: %s", refname.buf);
-				hashclr(sha1);
+				oidclr(&oid);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag, 0));
+					 create_ref_entry(refname.buf, oid.hash, flag, 0));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
@@ -1752,8 +1752,8 @@ int read_ref(const char *refname, unsigned char *sha1)
 
 int ref_exists(const char *refname)
 {
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+	struct object_id oid;
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, oid.hash, NULL);
 }
 
 static int filter_refs(const char *refname, const struct object_id *oid,
@@ -1857,7 +1857,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 int peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
-	unsigned char base[20];
+	struct object_id base;
 
 	if (current_ref && (current_ref->name == refname
 			    || !strcmp(current_ref->name, refname))) {
@@ -1867,7 +1867,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return 0;
 	}
 
-	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
+	if (read_ref_full(refname, RESOLVE_REF_READING, base.hash, &flag))
 		return -1;
 
 	/*
@@ -1888,7 +1888,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		}
 	}
 
-	return peel_object(base, sha1);
+	return peel_object(base.hash, sha1);
 }
 
 struct warn_if_dangling_data {
@@ -2300,11 +2300,11 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 	*ref = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
 		char fullref[PATH_MAX];
-		unsigned char sha1_from_ref[20];
+		struct object_id oid_from_ref;
 		unsigned char *this_result;
 		int flag;
 
-		this_result = refs_found ? sha1_from_ref : sha1;
+		this_result = refs_found ? oid_from_ref.hash : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
 		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
 				       this_result, &flag);
@@ -2331,13 +2331,13 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
 	*log = NULL;
 	for (p = ref_rev_parse_rules; *p; p++) {
-		unsigned char hash[20];
+		struct object_id oid;
 		char path[PATH_MAX];
 		const char *ref, *it;
 
 		mksnpath(path, sizeof(path), *p, len, str);
 		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
-					 hash, NULL);
+					 oid.hash, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path))
@@ -2348,7 +2348,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 			continue;
 		if (!logs_found++) {
 			*log = xstrdup(it);
-			hashcpy(sha1, hash);
+			hashcpy(sha1, oid.hash);
 		}
 		if (!warn_ambiguous_refs)
 			break;
@@ -2491,12 +2491,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
  * Write an entry to the packed-refs file for the specified refname.
  * If peeled is non-NULL, write it as the entry's peeled value.
  */
-static void write_packed_entry(FILE *fh, char *refname, unsigned char *sha1,
-			       unsigned char *peeled)
+static void write_packed_entry(FILE *fh, char *refname, struct object_id *oid,
+			       struct object_id *peeled)
 {
-	fprintf_or_die(fh, "%s %s\n", sha1_to_hex(sha1), refname);
+	fprintf_or_die(fh, "%s %s\n", oid_to_hex(oid), refname);
 	if (peeled)
-		fprintf_or_die(fh, "^%s\n", sha1_to_hex(peeled));
+		fprintf_or_die(fh, "^%s\n", oid_to_hex(peeled));
 }
 
 /*
@@ -2509,9 +2509,9 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
 		error("internal error: %s is not a valid packed reference!",
 		      entry->name);
-	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
+	write_packed_entry(cb_data, entry->name, &entry->u.value.oid,
 			   peel_status == PEEL_PEELED ?
-			   entry->u.value.peeled.hash : NULL);
+			   &entry->u.value.peeled : NULL);
 	return 0;
 }
 
@@ -2901,7 +2901,7 @@ static int commit_ref_update(struct ref_lock *lock,
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20], orig_sha1[20];
+	struct object_id oid, orig_oid;
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
@@ -2913,7 +2913,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("reflog for %s is a symlink", oldrefname);
 
 	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
-				    orig_sha1, &flag);
+				    orig_oid.hash, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2927,13 +2927,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
-	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
+	if (delete_ref(oldrefname, orig_oid.hash, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
-	    delete_ref(newrefname, sha1, REF_NODEREF)) {
+	if (!read_ref_full(newrefname, RESOLVE_REF_READING, oid.hash, NULL) &&
+	    delete_ref(newrefname, oid.hash, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
 				error("Directory not empty: %s", newrefname);
@@ -2956,10 +2956,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		strbuf_release(&err);
 		goto rollback;
 	}
-	hashcpy(lock->old_oid.hash, orig_sha1);
+	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, orig_sha1) ||
-	    commit_ref_update(lock, orig_sha1, logmsg)) {
+	if (write_ref_to_lockfile(lock, orig_oid.hash) ||
+	    commit_ref_update(lock, orig_oid.hash, logmsg)) {
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
@@ -2976,8 +2976,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_to_lockfile(lock, orig_sha1) ||
-	    commit_ref_update(lock, orig_sha1, NULL))
+	if (write_ref_to_lockfile(lock, orig_oid.hash) ||
+	    commit_ref_update(lock, orig_oid.hash, NULL))
 		error("unable to write current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
 
@@ -3230,11 +3230,11 @@ static int commit_ref_update(struct ref_lock *lock,
 		 * check with HEAD only which should cover 99% of all usage
 		 * scenarios (even 100% of the default ones).
 		 */
-		unsigned char head_sha1[20];
+		struct object_id head_oid;
 		int head_flag;
 		const char *head_ref;
 		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-					      head_sha1, &head_flag);
+					      head_oid.hash, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_oid.hash, sha1, logmsg);
@@ -3255,10 +3255,10 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	char ref[1000];
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
-	unsigned char old_sha1[20], new_sha1[20];
+	struct object_id old_oid, new_oid;
 
-	if (logmsg && read_ref(ref_target, old_sha1))
-		hashclr(old_sha1);
+	if (logmsg && read_ref(ref_target, old_oid.hash))
+		oidclr(&old_oid);
 
 	if (safe_create_leading_directories(git_HEAD) < 0)
 		return error("unable to create directory for %s", git_HEAD);
@@ -3304,8 +3304,8 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 #ifndef NO_SYMLINK_HEAD
 	done:
 #endif
-	if (logmsg && !read_ref(refs_heads_master, new_sha1))
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg);
+	if (logmsg && !read_ref(refs_heads_master, new_oid.hash))
+		log_ref_write(ref_target, old_oid.hash, new_oid.hash, logmsg);
 
 	free(git_HEAD);
 	return 0;
-- 
2.4.0
