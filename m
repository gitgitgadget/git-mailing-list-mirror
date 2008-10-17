From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] Enhance hold_lock_file_for_{update,append}() API
Date: Fri, 17 Oct 2008 16:10:21 -0700
Message-ID: <7v7i86hl7m.fsf_-_@gitster.siamese.dyndns.org>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <20081016203916.GB9487@coredump.intra.peff.net>
 <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Draisey <matt@draisey.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:11:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqyU5-0000lT-QQ
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756511AbYJQXKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756588AbYJQXKl
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:10:41 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426AbYJQXKk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:10:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 953948B2B6;
	Fri, 17 Oct 2008 19:10:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B0D518B2B5; Fri, 17 Oct 2008 19:10:32 -0400 (EDT)
In-Reply-To: <7vfxmuhlad.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 17 Oct 2008 16:08:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D0652C18-9CA0-11DD-A391-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98497>

This changes the "die_on_error" boolean parameter to a mere "flags", and
changes the existing callers of hold_lock_file_for_update/append()
functions to pass LOCK_DIE_ON_ERROR.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-commit.c     |    3 ++-
 builtin-fetch-pack.c |    3 ++-
 builtin-revert.c     |    3 ++-
 bundle.c             |    3 ++-
 cache.h              |    1 +
 lockfile.c           |   26 +++++++++++++++-----------
 pack-refs.c          |    3 ++-
 refs.c               |    3 ++-
 rerere.c             |    3 ++-
 sha1_file.c          |    2 +-
 10 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index e2a7e48..b563a0d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -320,7 +320,8 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		die("unable to write new_index file");
 
 	fd = hold_lock_file_for_update(&false_lock,
-				       git_path("next-index-%d", getpid()), 1);
+				       git_path("next-index-%d", getpid()),
+				       LOCK_DIE_ON_ERROR);
 
 	create_base_index();
 	add_remove_files(&partial);
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 85509f5..21ce3e0 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -813,7 +813,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			  )
 			die("shallow file was changed during fetch");
 
-		fd = hold_lock_file_for_update(&lock, shallow, 1);
+		fd = hold_lock_file_for_update(&lock, shallow,
+					       LOCK_DIE_ON_ERROR);
 		if (!write_shallow_commits(fd, 0)) {
 			unlink(shallow);
 			rollback_lock_file(&lock);
diff --git a/builtin-revert.c b/builtin-revert.c
index 27881e9..e839387 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -338,7 +338,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 	 * reverse of it if we are revert.
 	 */
 
-	msg_fd = hold_lock_file_for_update(&msg_file, defmsg, 1);
+	msg_fd = hold_lock_file_for_update(&msg_file, defmsg,
+					   LOCK_DIE_ON_ERROR);
 
 	encoding = get_encoding(message);
 	if (!encoding)
diff --git a/bundle.c b/bundle.c
index 00b2aab..7d17a1f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -186,7 +186,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 	if (bundle_to_stdout)
 		bundle_fd = 1;
 	else
-		bundle_fd = hold_lock_file_for_update(&lock, path, 1);
+		bundle_fd = hold_lock_file_for_update(&lock, path,
+						      LOCK_DIE_ON_ERROR);
 
 	/* write signature */
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
diff --git a/cache.h b/cache.h
index 884fae8..941a9dc 100644
--- a/cache.h
+++ b/cache.h
@@ -411,6 +411,7 @@ struct lock_file {
 	char on_list;
 	char filename[PATH_MAX];
 };
+#define LOCK_DIE_ON_ERROR 1
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index 4023797..bc1b585 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -121,9 +121,10 @@ static char *resolve_symlink(char *p, size_t s)
 }
 
 
-static int lock_file(struct lock_file *lk, const char *path)
+static int lock_file(struct lock_file *lk, const char *path, int flags)
 {
-	if (strlen(path) >= sizeof(lk->filename)) return -1;
+	if (strlen(path) >= sizeof(lk->filename))
+		return -1;
 	strcpy(lk->filename, path);
 	/*
 	 * subtract 5 from size to make sure there's room for adding
@@ -155,21 +156,21 @@ static int lock_file(struct lock_file *lk, const char *path)
 	return lk->fd;
 }
 
-int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on_error)
+int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
 {
-	int fd = lock_file(lk, path);
-	if (fd < 0 && die_on_error)
+	int fd = lock_file(lk, path, flags);
+	if (fd < 0 && (flags & LOCK_DIE_ON_ERROR))
 		die("unable to create '%s.lock': %s", path, strerror(errno));
 	return fd;
 }
 
-int hold_lock_file_for_append(struct lock_file *lk, const char *path, int die_on_error)
+int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 {
 	int fd, orig_fd;
 
-	fd = lock_file(lk, path);
+	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
-		if (die_on_error)
+		if (flags & LOCK_DIE_ON_ERROR)
 			die("unable to create '%s.lock': %s", path, strerror(errno));
 		return fd;
 	}
@@ -177,13 +178,13 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int die_on
 	orig_fd = open(path, O_RDONLY);
 	if (orig_fd < 0) {
 		if (errno != ENOENT) {
-			if (die_on_error)
+			if (flags & LOCK_DIE_ON_ERROR)
 				die("cannot open '%s' for copying", path);
 			close(fd);
 			return error("cannot open '%s' for copying", path);
 		}
 	} else if (copy_fd(orig_fd, fd)) {
-		if (die_on_error)
+		if (flags & LOCK_DIE_ON_ERROR)
 			exit(128);
 		close(fd);
 		return -1;
@@ -215,7 +216,10 @@ int commit_lock_file(struct lock_file *lk)
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
 {
-	return hold_lock_file_for_update(lk, get_index_file(), die_on_error);
+	return hold_lock_file_for_update(lk, get_index_file(),
+					 die_on_error
+					 ? LOCK_DIE_ON_ERROR
+					 : 0);
 }
 
 void set_alternate_index_output(const char *name)
diff --git a/pack-refs.c b/pack-refs.c
index 848d311..2c76fb1 100644
--- a/pack-refs.c
+++ b/pack-refs.c
@@ -89,7 +89,8 @@ int pack_refs(unsigned int flags)
 	memset(&cbdata, 0, sizeof(cbdata));
 	cbdata.flags = flags;
 
-	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
+	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"),
+				       LOCK_DIE_ON_ERROR);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
diff --git a/refs.c b/refs.c
index 39a3b23..5467e98 100644
--- a/refs.c
+++ b/refs.c
@@ -845,7 +845,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 		error("unable to create directory for %s", ref_file);
 		goto error_return;
 	}
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, 1);
+	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file,
+						  LOCK_DIE_ON_ERROR);
 
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
diff --git a/rerere.c b/rerere.c
index 323e493..2b7a99d 100644
--- a/rerere.c
+++ b/rerere.c
@@ -346,7 +346,8 @@ int setup_rerere(struct string_list *merge_rr)
 		return -1;
 
 	merge_rr_path = xstrdup(git_path("MERGE_RR"));
-	fd = hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
+	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
+				       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
 	return fd;
 }
diff --git a/sha1_file.c b/sha1_file.c
index e2cb342..5cfae5d 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -385,7 +385,7 @@ static void read_info_alternates(const char * relative_base, int depth)
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
-	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), 1);
+	int fd = hold_lock_file_for_append(lock, git_path("objects/info/alternates"), LOCK_DIE_ON_ERROR);
 	char *alt = mkpath("%s/objects\n", reference);
 	write_or_die(fd, alt, strlen(alt));
 	if (commit_lock_file(lock))
-- 
1.6.0.2.734.gae0be
