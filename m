From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-update-ref: add --no-deref option for
 overwriting/detaching ref
Date: Wed, 09 May 2007 12:33:20 +0200
Message-ID: <20070509103320.GA7257MdfPADPa@greensroom.kotnet.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 12:33:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HljUI-0000RY-Rn
	for gcvg-git@gmane.org; Wed, 09 May 2007 12:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXEIKdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbXEIKdY
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 06:33:24 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:35430 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbXEIKdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 06:33:23 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JHR00MBKRZKA2@psmtp03.wxs.nl> for git@vger.kernel.org; Wed,
 09 May 2007 12:33:21 +0200 (MEST)
Received: (qmail 7302 invoked by uid 500); Wed, 09 May 2007 10:33:20 +0000
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46693>

git-checkout is also adapted to make use of this new option
instead of the handcrafted command sequence.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
All tests pass, except the recently added cvsserver tests,
but they fail without this patch too.
 Documentation/git-update-ref.txt |    5 ++++-
 builtin-branch.c                 |    2 +-
 builtin-fetch--tool.c            |    2 +-
 builtin-reflog.c                 |    2 +-
 builtin-update-ref.c             |   11 ++++++++---
 fast-import.c                    |    2 +-
 git-checkout.sh                  |   10 +---------
 receive-pack.c                   |    2 +-
 refs.c                           |   30 +++++++++++++++++++-----------
 refs.h                           |    3 ++-
 10 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index 9424fea..f222616 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,7 +7,7 @@ git-update-ref - Update the object name stored in a ref safely
 
 SYNOPSIS
 --------
-'git-update-ref' [-m <reason>] (-d <ref> <oldvalue> | <ref> <newvalue> [<oldvalue>])
+'git-update-ref' [-m <reason>] (-d <ref> <oldvalue> | [--no-deref] <ref> <newvalue> [<oldvalue>])
 
 DESCRIPTION
 -----------
@@ -36,6 +36,9 @@ them and update them as a regular file (i.e. it will allow the
 filesystem to follow them, but will overwrite such a symlink to
 somewhere else with a regular filename).
 
+If --no-deref is given, <ref> itself is overwritten, rather than
+the result of following the symbolic pointers.
+
 In general, using
 
 	git-update-ref HEAD "$head"
diff --git a/builtin-branch.c b/builtin-branch.c
index 7408285..6bd5843 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -462,7 +462,7 @@ static void create_branch(const char *name, const char *start_name,
 		die("Not a valid branch point: '%s'.", start_name);
 	hashcpy(sha1, commit->object.sha1);
 
-	lock = lock_any_ref_for_update(ref, NULL);
+	lock = lock_any_ref_for_update(ref, NULL, 0);
 	if (!lock)
 		die("Failed to lock ref for update: %s.", strerror(errno));
 
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 2065466..b14e78a 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -42,7 +42,7 @@ static int update_ref(const char *action,
 	if (!rla)
 		rla = "(reflog update)";
 	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
-	lock = lock_any_ref_for_update(refname, oldval);
+	lock = lock_any_ref_for_update(refname, oldval, 0);
 	if (!lock)
 		return 1;
 	if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 4c39f1d..ce093ca 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -249,7 +249,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	/* we take the lock for the ref itself to prevent it from
 	 * getting updated.
 	 */
-	lock = lock_any_ref_for_update(ref, sha1);
+	lock = lock_any_ref_for_update(ref, sha1, 0);
 	if (!lock)
 		return error("cannot lock ref '%s'", ref);
 	log_file = xstrdup(git_path("logs/%s", ref));
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index 5ee960b..feac2ed 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -3,16 +3,17 @@
 #include "builtin.h"
 
 static const char git_update_ref_usage[] =
-"git-update-ref [-m <reason>] (-d <refname> <value> | <refname> <value> [<oldval>])";
+"git-update-ref [-m <reason>] (-d <refname> <value> | [--no-deref] <refname> <value> [<oldval>])";
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL;
 	struct ref_lock *lock;
 	unsigned char sha1[20], oldsha1[20];
-	int i, delete;
+	int i, delete, ref_flags;
 
 	delete = 0;
+	ref_flags = 0;
 	git_config(git_default_config);
 
 	for (i = 1; i < argc; i++) {
@@ -30,6 +31,10 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 			delete = 1;
 			continue;
 		}
+		if (!strcmp("--no-deref", argv[i])) {
+			ref_flags |= REF_NODEREF;
+			continue;
+		}
 		if (!refname) {
 			refname = argv[i];
 			continue;
@@ -59,7 +64,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (oldval && *oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
 
-	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL);
+	lock = lock_any_ref_for_update(refname, oldval ? oldsha1 : NULL, ref_flags);
 	if (!lock)
 		die("%s: cannot lock the ref", refname);
 	if (write_ref_sha1(lock, sha1, msg) < 0)
diff --git a/fast-import.c b/fast-import.c
index 3a2d5ed..ffa00fd 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1271,7 +1271,7 @@ static int update_branch(struct branch *b)
 
 	if (read_ref(b->name, old_sha1))
 		hashclr(old_sha1);
-	lock = lock_any_ref_for_update(b->name, old_sha1);
+	lock = lock_any_ref_for_update(b->name, old_sha1, 0);
 	if (!lock)
 		return error("Unable to lock %s", b->name);
 	if (!force_update && !is_null_sha1(old_sha1)) {
diff --git a/git-checkout.sh b/git-checkout.sh
index ed7c2c5..6b6facf 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -270,15 +270,7 @@ if [ "$?" -eq 0 ]; then
 		fi
 	elif test -n "$detached"
 	then
-		# NEEDSWORK: we would want a command to detach the HEAD
-		# atomically, instead of this handcrafted command sequence.
-		# Perhaps:
-		#	git update-ref --detach HEAD $new
-		# or something like that...
-		#
-		git-rev-parse HEAD >"$GIT_DIR/HEAD.new" &&
-		mv "$GIT_DIR/HEAD.new" "$GIT_DIR/HEAD" &&
-		git-update-ref -m "checkout: moving to $arg" HEAD "$detached" ||
+		git-update-ref --no-deref -m "checkout: moving to $arg" HEAD "$detached" ||
 			die "Cannot detach HEAD"
 		if test -n "$detach_warn"
 		then
diff --git a/receive-pack.c b/receive-pack.c
index 26aa26b..d3c422b 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -209,7 +209,7 @@ static const char *update(struct command *cmd)
 		return NULL; /* good */
 	}
 	else {
-		lock = lock_any_ref_for_update(name, old_sha1);
+		lock = lock_any_ref_for_update(name, old_sha1, 0);
 		if (!lock) {
 			error("failed to lock %s", name);
 			return "failed to lock";
diff --git a/refs.c b/refs.c
index 89876bf..2ae3235 100644
--- a/refs.c
+++ b/refs.c
@@ -736,19 +736,20 @@ static int is_refname_available(const char *ref, const char *oldref,
 	return 1;
 }
 
-static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int *flag)
+static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char *old_sha1, int flags, int *type_p)
 {
 	char *ref_file;
 	const char *orig_ref = ref;
 	struct ref_lock *lock;
 	struct stat st;
 	int last_errno = 0;
+	int type;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	ref = resolve_ref(ref, lock->old_sha1, mustexist, flag);
+	ref = resolve_ref(ref, lock->old_sha1, mustexist, &type);
 	if (!ref && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -761,8 +762,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 			error("there are still refs under '%s'", orig_ref);
 			goto error_return;
 		}
-		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, flag);
+		ref = resolve_ref(orig_ref, lock->old_sha1, mustexist, &type);
 	}
+	if (type_p)
+	    *type_p = type;
 	if (!ref) {
 		last_errno = errno;
 		error("unable to resolve reference %s: %s",
@@ -780,10 +783,15 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
+	if (flags & REF_NODEREF)
+		ref = orig_ref;
 	lock->ref_name = xstrdup(ref);
 	lock->orig_ref_name = xstrdup(orig_ref);
 	ref_file = git_path("%s", ref);
-	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;
+	if (lstat(ref_file, &st) && errno == ENOENT)
+		lock->force_write = 1;
+	if ((flags & REF_NODEREF) && (type & REF_ISSYMREF))
+		lock->force_write = 1;
 
 	if (safe_create_leading_directories(ref_file)) {
 		last_errno = errno;
@@ -806,14 +814,14 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 	if (check_ref_format(ref))
 		return NULL;
 	strcpy(refpath, mkpath("refs/%s", ref));
-	return lock_ref_sha1_basic(refpath, old_sha1, NULL);
+	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
 }
 
-struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1)
+struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
 {
 	if (check_ref_format(ref) == -1)
 		return NULL;
-	return lock_ref_sha1_basic(ref, old_sha1, NULL);
+	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
 }
 
 static struct lock_file packlock;
@@ -858,7 +866,7 @@ int delete_ref(const char *refname, const unsigned char *sha1)
 	struct ref_lock *lock;
 	int err, i, ret = 0, flag = 0;
 
-	lock = lock_ref_sha1_basic(refname, sha1, &flag);
+	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
 	if (!lock)
 		return 1;
 	if (!(flag & REF_ISPACKED)) {
@@ -909,7 +917,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	if (!is_refname_available(newref, oldref, get_loose_refs(), 0))
 		return 1;
 
-	lock = lock_ref_sha1_basic(renamed_ref, NULL, NULL);
+	lock = lock_ref_sha1_basic(renamed_ref, NULL, 0, NULL);
 	if (!lock)
 		return error("unable to lock %s", renamed_ref);
 	lock->force_write = 1;
@@ -963,7 +971,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	}
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newref, NULL, NULL);
+	lock = lock_ref_sha1_basic(newref, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newref);
 		goto rollback;
@@ -979,7 +987,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldref, NULL, NULL);
+	lock = lock_ref_sha1_basic(oldref, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldref);
 		goto rollbacklog;
diff --git a/refs.h b/refs.h
index f61f6d9..f234eb7 100644
--- a/refs.h
+++ b/refs.h
@@ -33,7 +33,8 @@ extern int get_ref_sha1(const char *ref, unsigned char *sha1);
 extern struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1);
 
 /** Locks any ref (for 'HEAD' type refs). */
-extern struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1);
+#define REF_NODEREF	0x01
+extern struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags);
 
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
-- 
1.5.2.rc2.26.gb822e-dirty
