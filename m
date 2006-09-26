From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] update-ref: -d flag and ref creation safety.
Date: Mon, 25 Sep 2006 21:13:36 -0700
Message-ID: <7vfyefuuxb.fsf_-_@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609231322.30214.chriscool@tuxfamily.org>
	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>
	<200609240645.54467.chriscool@tuxfamily.org>
	<7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 26 06:13:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4KD-0006OW-QQ
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWIZENj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWIZENj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:13:39 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6078 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750718AbWIZENi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:13:38 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041337.BWFU6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:13:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsDa1V00e1kojtg0000000
	Tue, 26 Sep 2006 00:13:35 -0400
To: git@vger.kernel.org
In-Reply-To: <7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 25 Sep 2006 02:26:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27769>

This adds -d flag to update-ref to allow safe deletion of ref.
Before deleting it, the command checks if the given <oldvalue>
still matches the value the caller thought the ref contained.

Similarly, it also accepts 0{40} as <oldvalue> to allow safe
creation of a new ref.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-update-ref.txt |    9 ++++++--
 builtin-update-ref.c             |   16 +++++++++++++--
 cache.h                          |    1 +
 refs.c                           |   41 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index e062030..723906d 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -7,7 +7,7 @@ git-update-ref - update the object name 
 
 SYNOPSIS
 --------
-'git-update-ref' [-m <reason>] <ref> <newvalue> [<oldvalue>]
+'git-update-ref' [-m <reason>] (-d <ref> <oldvalue> | <ref> <newvalue> [<oldvalue>])
 
 DESCRIPTION
 -----------
@@ -20,7 +20,8 @@ possibly dereferencing the symbolic refs
 the current value of the <ref> matches <oldvalue>.
 E.g. `git-update-ref refs/heads/master <newvalue> <oldvalue>`
 updates the master branch head to <newvalue> only if its current
-value is <oldvalue>.
+value is <oldvalue>.  You can specify 40 "0" as <oldvalue> to
+make sure that the ref you are creating does not exist.
 
 It also allows a "ref" file to be a symbolic pointer to another
 ref file by starting with the four-byte header sequence of
@@ -49,6 +50,10 @@ for reading but not for writing (so we'l
 ref symlink to some other tree, if you have copied a whole
 archive by creating a symlink tree).
 
+With `-d` flag, it deletes the named <ref> after verifying it
+still contains <oldvalue>.
+
+
 Logging Updates
 ---------------
 If config parameter "core.logAllRefUpdates" is true or the file
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index ab52833..486b8f2 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -3,15 +3,16 @@ #include "refs.h"
 #include "builtin.h"
 
 static const char git_update_ref_usage[] =
-"git-update-ref <refname> <value> [<oldval>] [-m <reason>]";
+"git-update-ref [-m <reason>] (-d <refname> <value> | <refname> <value> [<oldval>])";
 
 int cmd_update_ref(int argc, const char **argv, const char *prefix)
 {
 	const char *refname=NULL, *value=NULL, *oldval=NULL, *msg=NULL;
 	struct ref_lock *lock;
 	unsigned char sha1[20], oldsha1[20];
-	int i;
+	int i, delete;
 
+	delete = 0;
 	setup_ident();
 	git_config(git_default_config);
 
@@ -26,6 +27,10 @@ int cmd_update_ref(int argc, const char 
 				die("Refusing to perform update with \\n in message.");
 			continue;
 		}
+		if (!strcmp("-d", argv[i])) {
+			delete = 1;
+			continue;
+		}
 		if (!refname) {
 			refname = argv[i];
 			continue;
@@ -44,6 +49,13 @@ int cmd_update_ref(int argc, const char 
 
 	if (get_sha1(value, sha1))
 		die("%s: not a valid SHA1", value);
+
+	if (delete) {
+		if (oldval)
+			usage(git_update_ref_usage);
+		return delete_ref(refname, sha1);
+	}
+
 	hashclr(oldsha1);
 	if (oldval && get_sha1(oldval, oldsha1))
 		die("%s: not a valid old SHA1", oldval);
diff --git a/cache.h b/cache.h
index 97debd0..851f4c0 100644
--- a/cache.h
+++ b/cache.h
@@ -179,6 +179,7 @@ struct lock_file {
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
 extern void rollback_lock_file(struct lock_file *);
+extern int delete_ref(const char *, unsigned char *sha1);
 
 /* Environment bits from configuration mechanism */
 extern int use_legacy_headers;
diff --git a/refs.c b/refs.c
index b4f6d4f..4d499b0 100644
--- a/refs.c
+++ b/refs.c
@@ -212,6 +212,32 @@ int get_ref_sha1(const char *ref, unsign
 	return read_ref(git_path("refs/%s", ref), sha1);
 }
 
+int delete_ref(const char *refname, unsigned char *sha1)
+{
+	struct ref_lock *lock;
+	int err, i, ret = 0;
+
+	lock = lock_any_ref_for_update(refname, sha1);
+	if (!lock)
+		return 1;
+	i = strlen(lock->lk->filename) - 5; /* .lock */
+	lock->lk->filename[i] = 0;
+	err = unlink(lock->lk->filename);
+	if (err) {
+		ret = 1;
+		error("unlink(%s) failed: %s",
+		      lock->lk->filename, strerror(errno));
+	}
+	lock->lk->filename[i] = '.';
+
+	err = unlink(lock->log_file);
+	if (err && errno != ENOENT)
+		fprintf(stderr, "warning: unlink(%s) failed: %s",
+			lock->log_file, strerror(errno));
+
+	return ret;
+}
+
 /*
  * Make sure "ref" is something reasonable to have under ".git/refs/";
  * We do not like it if:
@@ -268,6 +294,19 @@ static struct ref_lock *verify_lock(stru
 {
 	char buf[40];
 	int nr, fd = open(lock->ref_file, O_RDONLY);
+
+	if (is_null_sha1(old_sha1)) {
+		/* we wanted to make sure it did not exist */
+		if (fd < 0 && errno == ENOENT)
+			return lock;
+		if (0 <= fd) {
+			close(fd);
+			error("ref %s should be absent but it exists",
+			      lock->ref_file);
+			unlock_ref(lock);
+			return NULL;
+		}
+	}
 	if (fd < 0 && errno != ENOENT) {
 		error("Can't verify ref %s", lock->ref_file);
 		unlock_ref(lock);
@@ -296,7 +335,7 @@ static struct ref_lock *lock_ref_sha1_ba
 	const char *orig_path = path;
 	struct ref_lock *lock;
 	struct stat st;
-	int mustexist = 0;
+	int mustexist = old_sha1 && !is_null_sha1(old_sha1);
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
-- 
1.4.2.1.g7a39b
