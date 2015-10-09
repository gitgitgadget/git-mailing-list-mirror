From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 01/13] refs: convert some internal functions to use object_id
Date: Fri,  9 Oct 2015 01:43:47 +0000
Message-ID: <1444355039-186351-2-git-send-email-sandals@crustytoothpaste.net>
References: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 03:45:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkMkP-0001VG-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 09 Oct 2015 03:45:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755882AbbJIBpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 21:45:15 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58050 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755626AbbJIBpI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2015 21:45:08 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3305028095;
	Fri,  9 Oct 2015 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1444355107;
	bh=uiRBdrZJTegkWWAuEKWpXCbmkEpIJOsXPeHZHkz/JaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=x/Ha8hChnKDyXTCNu1UlL5UM5qvfiXk0qYsdh0WGfT72jH2u1aITCNUnjQYOiv1wf
	 jaF6demmFsLSjSqVOJYKeakdreTOxPhyc/yTDTxH6F7brF2LR3v12+d5nfDEPAI4A6
	 ngU4HRNP+s4ZnKDpc6iMkViHdratjbHfHpytf4EMifV5mEHGGE/904o1MUjgy98nPv
	 UH9OZA6WINDzHs7o78DrLshR0sqqFvWmBGTLpArxPpoyS4GPw4YCtNNlY0u4waSokk
	 Xla+kTjlCwBqzGzvBkANYhHkT3HbWlV35TNah6PIXzFHY+qtx7AE7Ds5I134jnWKPq
	 6ApHMqgaYHXnrvMxZ8+fPjZqNvyODdUnPyIPWtOl37Kxaxj5O06yMwfSC3YkTLbMZ+
	 ZXWubmizaFUi2sQ423VFiRnvxhcqOzlZtPy6OsvB7X5a1Z8ERmFgl3o3WOo/cQ7NLM
	 9UNsT3ED4bCLm8UMdJlDZsED3SZ33Ya5FxL71LVyojTP8IHCo7v
X-Mailer: git-send-email 2.6.1
In-Reply-To: <1444355039-186351-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279286>

Convert several internal functions in refs.c to use struct object_id,
and use the GIT_SHA1_HEXSZ constants in parse_ref_line.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 refs.c | 104 ++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/refs.c b/refs.c
index 91c88bad..dae50c4e 100644
--- a/refs.c
+++ b/refs.c
@@ -1192,7 +1192,7 @@ static const char PACKED_REFS_HEADER[] =
  * Return a pointer to the refname within the line (null-terminated),
  * or NULL if there was a problem.
  */
-static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
+static const char *parse_ref_line(struct strbuf *line, struct object_id *oid)
 {
 	const char *ref;
 
@@ -1204,15 +1204,15 @@ static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
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
 
@@ -1257,7 +1257,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
 
 	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		const char *refname;
 		const char *traits;
 
@@ -1270,17 +1270,17 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
@@ -1291,8 +1291,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
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
@@ -1397,7 +1397,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	strbuf_add(&refname, dirname, dirnamelen);
 
 	while ((de = readdir(d)) != NULL) {
-		unsigned char sha1[20];
+		struct object_id oid;
 		struct stat st;
 		int flag;
 
@@ -1418,20 +1418,20 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 			int read_ok;
 
 			if (*refs->name) {
-				hashclr(sha1);
+				oidclr(&oid);
 				flag = 0;
 				read_ok = !resolve_gitlink_ref(refs->name,
-							       refname.buf, sha1);
+							       refname.buf, oid.hash);
 			} else {
 				read_ok = !read_ref_full(refname.buf,
 							 RESOLVE_REF_READING,
-							 sha1, &flag);
+							 oid.hash, &flag);
 			}
 
 			if (!read_ok) {
-				hashclr(sha1);
+				oidclr(&oid);
 				flag |= REF_ISBROKEN;
-			} else if (is_null_sha1(sha1)) {
+			} else if (is_null_oid(&oid)) {
 				/*
 				 * It is so astronomically unlikely
 				 * that NULL_SHA1 is the SHA-1 of an
@@ -1447,11 +1447,11 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
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
 		strbuf_setlen(&path, path_baselen);
@@ -1814,8 +1814,8 @@ int read_ref(const char *refname, unsigned char *sha1)
 
 int ref_exists(const char *refname)
 {
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+	struct object_id oid;
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, oid.hash, NULL);
 }
 
 static int filter_refs(const char *refname, const struct object_id *oid,
@@ -1919,7 +1919,7 @@ static enum peel_status peel_entry(struct ref_entry *entry, int repeel)
 int peel_ref(const char *refname, unsigned char *sha1)
 {
 	int flag;
-	unsigned char base[20];
+	struct object_id base;
 
 	if (current_ref && (current_ref->name == refname
 			    || !strcmp(current_ref->name, refname))) {
@@ -1929,7 +1929,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return 0;
 	}
 
-	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
+	if (read_ref_full(refname, RESOLVE_REF_READING, base.hash, &flag))
 		return -1;
 
 	/*
@@ -1950,7 +1950,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		}
 	}
 
-	return peel_object(base, sha1);
+	return peel_object(base.hash, sha1);
 }
 
 struct warn_if_dangling_data {
@@ -2361,11 +2361,11 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
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
@@ -2392,13 +2392,13 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 
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
@@ -2409,7 +2409,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 			continue;
 		if (!logs_found++) {
 			*log = xstrdup(it);
-			hashcpy(sha1, hash);
+			hashcpy(sha1, oid.hash);
 		}
 		if (!warn_ambiguous_refs)
 			break;
@@ -2558,12 +2558,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
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
@@ -2576,9 +2576,9 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
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
 
@@ -3145,7 +3145,7 @@ static int commit_ref_update(struct ref_lock *lock,
 
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
-	unsigned char sha1[20], orig_sha1[20];
+	struct object_id oid, orig_oid;
 	int flag = 0, logmoved = 0;
 	struct ref_lock *lock;
 	struct stat loginfo;
@@ -3157,7 +3157,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("reflog for %s is a symlink", oldrefname);
 
 	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
-				    orig_sha1, &flag);
+				    orig_oid.hash, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -3171,13 +3171,13 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
 			struct strbuf path = STRBUF_INIT;
 			int result;
@@ -3207,10 +3207,10 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		strbuf_release(&err);
 		goto rollback;
 	}
-	hashcpy(lock->old_oid.hash, orig_sha1);
+	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, logmsg, 0, &err)) {
+	if (write_ref_to_lockfile(lock, orig_oid.hash, &err) ||
+	    commit_ref_update(lock, orig_oid.hash, logmsg, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
 		goto rollback;
@@ -3228,8 +3228,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_to_lockfile(lock, orig_sha1, &err) ||
-	    commit_ref_update(lock, orig_sha1, NULL, 0, &err)) {
+	if (write_ref_to_lockfile(lock, orig_oid.hash, &err) ||
+	    commit_ref_update(lock, orig_oid.hash, NULL, 0, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
 	}
@@ -3502,11 +3502,11 @@ static int commit_ref_update(struct ref_lock *lock,
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
 		    !strcmp(head_ref, lock->ref_name)) {
 			struct strbuf log_err = STRBUF_INIT;
@@ -3534,11 +3534,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 	char ref[1000];
 	int fd, len, written;
 	char *git_HEAD = git_pathdup("%s", ref_target);
-	unsigned char old_sha1[20], new_sha1[20];
+	struct object_id old_oid, new_oid;
 	struct strbuf err = STRBUF_INIT;
 
-	if (logmsg && read_ref(ref_target, old_sha1))
-		hashclr(old_sha1);
+	if (logmsg && read_ref(ref_target, old_oid.hash))
+		oidclr(&old_oid);
 
 	if (safe_create_leading_directories(git_HEAD) < 0)
 		return error("unable to create directory for %s", git_HEAD);
@@ -3586,8 +3586,8 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 #ifndef NO_SYMLINK_HEAD
 	done:
 #endif
-	if (logmsg && !read_ref(refs_heads_master, new_sha1) &&
-		log_ref_write(ref_target, old_sha1, new_sha1, logmsg, 0, &err)) {
+	if (logmsg && !read_ref(refs_heads_master, new_oid.hash) &&
+		log_ref_write(ref_target, old_oid.hash, new_oid.hash, logmsg, 0, &err)) {
 		error("%s", err.buf);
 		strbuf_release(&err);
 	}
-- 
2.6.1
