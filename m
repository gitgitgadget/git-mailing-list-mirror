From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] Fix checkout not to clobber the branch when using
 symlinked HEAD upon detaching
Date: Fri, 17 Oct 2008 16:11:45 -0700
Message-ID: <7v3aiuhl5a.fsf_-_@gitster.siamese.dyndns.org>
References: <1224095087.5366.19.camel@localhost>
 <20081016191751.GB14707@coredump.intra.peff.net>
 <1224187863.2796.15.camel@localhost>
 <20081016203916.GB9487@coredump.intra.peff.net>
 <7vfxmuhlad.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt Draisey <matt@draisey.ca>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:13:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqyVR-000144-1V
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757907AbYJQXMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757894AbYJQXMG
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:12:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757872AbYJQXME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:12:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3432670DBE;
	Fri, 17 Oct 2008 19:12:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8DDB270DBC; Fri, 17 Oct 2008 19:11:57 -0400 (EDT)
In-Reply-To: <7vfxmuhlad.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 17 Oct 2008 16:08:42 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0239B646-9CA1-11DD-9153-1E1F86D30F62-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98498>

When you are using core.prefersymlinkrefs (i.e. your ".git/HEAD" is a
symlink to "refs/heads/$current_branch"), attempt to detach HEAD resulted
in clobbering the tip of the current branch.

The offending callchain is:

  update_ref(..., "HEAD", REF_NODEREF, ...);
  -> lock_any_ref_for_update("HEAD", ..., REF_NODEREF);
   -> lock_ref_sha1_basic("HEAD", ..., REF_NODEREF, ...);
      . calls resolve_ref() to read HEAD to arrive at
        refs/heads/master
      . however, it notices REF_NODEREF and adjusts the ref to be updated
        back to "HEAD";
    -> hold_lock_file_for_update(..., "HEAD", 1);
     -> lock_file(..., "HEAD");
        . resolves symlink "HEAD" to "refs/heads/master", and
          locks it!  This creates "refs/heads/master.lock", that is
          then renamed to "refs/heads/master" when unlocked.

The behaviour of lock_file() to resolve symlink at this point in the code
comes from d58e8d3 (When locking in a symlinked repository, try to lock
the original, 2007-07-25), and as explained in the log message of that
commit, we cannot unconditionally remove it.

This patch fixes this.  It teaches lock_file() not to dereference the
symbolic link when LOCK_NODEREF is given, and uses this new flag in
lock_ref_sha1_basic() when it is operating directly on HEAD (iow when
REF_NODEREF was given to it).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I haven't tested it beyond running the full testsuite, which it does pass,
 but I can't give any more guarantee than that.  Testing is for wimps ;-)

 cache.h       |    1 +
 lockfile.c    |    3 ++-
 refs.c        |   10 ++++++----
 t/t7201-co.sh |    2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 941a9dc..8ab2fd8 100644
--- a/cache.h
+++ b/cache.h
@@ -412,6 +412,7 @@ struct lock_file {
 	char filename[PATH_MAX];
 };
 #define LOCK_DIE_ON_ERROR 1
+#define LOCK_NODEREF 2
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index bc1b585..6d75608 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -130,7 +130,8 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	 * subtract 5 from size to make sure there's room for adding
 	 * ".lock" for the lock file name
 	 */
-	resolve_symlink(lk->filename, sizeof(lk->filename)-5);
+	if (!(flags & LOCK_NODEREF))
+		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
 	strcat(lk->filename, ".lock");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
diff --git a/refs.c b/refs.c
index 5467e98..9e422dc 100644
--- a/refs.c
+++ b/refs.c
@@ -790,7 +790,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	struct ref_lock *lock;
 	struct stat st;
 	int last_errno = 0;
-	int type;
+	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
@@ -830,8 +830,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
-	if (flags & REF_NODEREF)
+	lflags = LOCK_DIE_ON_ERROR;
+	if (flags & REF_NODEREF) {
 		ref = orig_ref;
+		lflags |= LOCK_NODEREF;
+	}
 	lock->ref_name = xstrdup(ref);
 	lock->orig_ref_name = xstrdup(orig_ref);
 	ref_file = git_path("%s", ref);
@@ -845,9 +848,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 		error("unable to create directory for %s", ref_file);
 		goto error_return;
 	}
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file,
-						  LOCK_DIE_ON_ERROR);
 
+	lock->lock_fd = hold_lock_file_for_update(lock->lk, ref_file, lflags);
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
  error_return:
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 01304d7..d9a80aa 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -339,7 +339,7 @@ test_expect_success 'checkout w/--track from non-branch HEAD fails' '
     test "z$(git rev-parse master^0)" = "z$(git rev-parse HEAD)"
 '
 
-test_expect_failure 'detch a symbolic link HEAD' '
+test_expect_success 'detch a symbolic link HEAD' '
     git checkout master &&
     git config --bool core.prefersymlinkrefs yes &&
     git checkout side &&
-- 
1.6.0.2.734.gae0be
