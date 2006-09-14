From: Linus Torvalds <torvalds@osdl.org>
Subject: Enable the packed refs file format
Date: Thu, 14 Sep 2006 10:14:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609141005440.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 14 19:15:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNunh-0006aE-Uz
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 19:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWINROy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 13:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWINROy
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 13:14:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55168 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750810AbWINROx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Sep 2006 13:14:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8EHEmnW023186
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 14 Sep 2006 10:14:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8EHElPj026301;
	Thu, 14 Sep 2006 10:14:47 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=-0.512 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.148 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27017>


This actually "turns on" the packed ref file format, now that the 
infrastructure to do so sanely exists (ie notably the change to make the 
reference reading logic take refnames rather than pathnames to the loose 
objects that no longer necessarily even exist).

In particular, when the ref lookup hits a refname that has no loose file 
associated with it, it falls back on the packed-ref information. Also, the 
ref-locking code, while still using a loose file for the locking itself 
(and _creating_ a loose file for the new ref) no longer requires that the 
old ref be in such an unpacked state.

Finally, this does a minimal hack to git-checkout.sh to rather than check 
the ref-file directly, do a "git-rev-parse" on the "heads/$refname". 
That's not really wonderful - we should rather really have a special 
routine to verify the names as proper branch head names, but it is a 
workable solution for now.

With this, I can literally do something like

	git pack-refs
	find .git/refs -type f -print0 | xargs -0 rm -f --

and the end result is a largely working repository (ie I've done two 
commits - which creates _one_ unpacked ref file - done things like run 
"gitk" and "git log" etc, and it all looks ok).

There are probably things missing, but I'm hoping that the missing things 
are now of the "small and obvious" kind, and that somebody else might want 
to start looking at this too. Hint hint ;)

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This obviously depends on the lt/refs branch in Junio's tree, that is 
currently only in -pu.

diff --git a/git-checkout.sh b/git-checkout.sh
index 580a9e8..c60e029 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -22,7 +22,7 @@ while [ "$#" != "0" ]; do
 		shift
 		[ -z "$newbranch" ] &&
 			die "git checkout: -b needs a branch name"
-		[ -e "$GIT_DIR/refs/heads/$newbranch" ] &&
+		git-rev-parse --symbolic "heads/$newbranch" >&/dev/null &&
 			die "git checkout: branch $newbranch already exists"
 		git-check-ref-format "heads/$newbranch" ||
 			die "git checkout: we do not like '$newbranch' as a branch name."
@@ -51,7 +51,7 @@ while [ "$#" != "0" ]; do
 			fi
 			new="$rev"
 			new_name="$arg^0"
-			if [ -f "$GIT_DIR/refs/heads/$arg" ]; then
+			if git-rev-parse "heads/$arg^0" >&/dev/null; then
 				branch="$arg"
 			fi
 		elif rev=$(git-rev-parse --verify "$arg^{tree}" 2>/dev/null)
diff --git a/refs.c b/refs.c
index 50c25d3..134c0fc 100644
--- a/refs.c
+++ b/refs.c
@@ -28,6 +28,8 @@ static const char *parse_ref_line(char *
 	if (!isspace(line[40]))
 		return NULL;
 	line += 41;
+	if (isspace(*line))
+		return NULL;
 	if (line[len] != '\n')
 		return NULL;
 	line[len] = 0;
@@ -168,6 +170,14 @@ const char *resolve_ref(const char *ref,
 		 * reading.
 		 */
 		if (lstat(path, &st) < 0) {
+			struct ref_list *list = get_packed_refs();
+			while (list) {
+				if (!strcmp(ref, list->name)) {
+					hashcpy(sha1, list->sha1);
+					return ref;
+				}
+				list = list->next;
+			}
 			if (reading || errno != ENOENT)
 				return NULL;
 			hashclr(sha1);
@@ -400,22 +410,13 @@ int check_ref_format(const char *ref)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	char buf[40];
-	int nr, fd = open(lock->ref_file, O_RDONLY);
-	if (fd < 0 && (mustexist || errno != ENOENT)) {
-		error("Can't verify ref %s", lock->ref_file);
-		unlock_ref(lock);
-		return NULL;
-	}
-	nr = read(fd, buf, 40);
-	close(fd);
-	if (nr != 40 || get_sha1_hex(buf, lock->old_sha1) < 0) {
-		error("Can't verify ref %s", lock->ref_file);
+	if (!resolve_ref(lock->ref_name, lock->old_sha1, mustexist)) {
+		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
 		return NULL;
 	}
 	if (hashcmp(lock->old_sha1, old_sha1)) {
-		error("Ref %s is at %s but expected %s", lock->ref_file,
+		error("Ref %s is at %s but expected %s", lock->ref_name,
 			sha1_to_hex(lock->old_sha1), sha1_to_hex(old_sha1));
 		unlock_ref(lock);
 		return NULL;
@@ -427,6 +428,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	int plen,
 	const unsigned char *old_sha1, int mustexist)
 {
+	char *ref_file;
 	const char *orig_ref = ref;
 	struct ref_lock *lock;
 	struct stat st;
@@ -445,13 +447,14 @@ static struct ref_lock *lock_ref_sha1_ba
 	}
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	lock->ref_file = xstrdup(git_path("%s", ref));
+	lock->ref_name = xstrdup(ref);
 	lock->log_file = xstrdup(git_path("logs/%s", ref));
-	lock->force_write = lstat(lock->ref_file, &st) && errno == ENOENT;
+	ref_file = git_path(ref);
+	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;
 
-	if (safe_create_leading_directories(lock->ref_file))
-		die("unable to create directory for %s", lock->ref_file);
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file, 1);
+	if (safe_create_leading_directories(ref_file))
+		die("unable to create directory for %s", ref_file);
+	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, 1);
 
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 }
@@ -479,7 +482,7 @@ void unlock_ref(struct ref_lock *lock)
 		if (lock->lk)
 			rollback_lock_file(lock->lk);
 	}
-	free(lock->ref_file);
+	free(lock->ref_name);
 	free(lock->log_file);
 	free(lock);
 }
@@ -556,7 +559,7 @@ int write_ref_sha1(struct ref_lock *lock
 		return -1;
 	}
 	if (commit_lock_file(lock->lk)) {
-		error("Couldn't set %s", lock->ref_file);
+		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
diff --git a/refs.h b/refs.h
index 553155c..af347e6 100644
--- a/refs.h
+++ b/refs.h
@@ -2,7 +2,7 @@ #ifndef REFS_H
 #define REFS_H
 
 struct ref_lock {
-	char *ref_file;
+	char *ref_name;
 	char *log_file;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
