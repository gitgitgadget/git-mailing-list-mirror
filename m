From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 1/4] refs.c: split writing and commiting a ref into two separate functions
Date: Thu, 10 Apr 2014 11:30:22 -0700
Message-ID: <1397154625-11884-2-git-send-email-sahlberg@google.com>
References: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 10 20:30:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYJkM-0001Av-LM
	for gcvg-git-2@plane.gmane.org; Thu, 10 Apr 2014 20:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbaDJSac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 14:30:32 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:42691 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbaDJSab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 14:30:31 -0400
Received: by mail-vc0-f201.google.com with SMTP id ik5so624045vcb.2
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 11:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=960wPpVv08pzr1P96SQYuI4Qb0FjPx3BQ85RtZe3Mzo=;
        b=otLqKCyC6lRL/vqao9xYnM932PWqwBCgKKS6RtLal4m5aPc8AV9mAjv36OoEU66s5X
         wwGCDnTd9PnL//dj2bn9EkFvOJVhWcQK1wZy+SuSzhnjmcwwOsE4IdKrEc/pWrdXBdTc
         jMD4QoSozJcCnwzvr8mN6km9diijg0o+j1Os6u9CwrZ39T7sFZbfKIeJPsKPuIU2j9qO
         BFAjgrjP1nSL8GVZRzAAc1oZHZz20kIUziC/+6eD85IefdpGrb/jKIkCm1bUw/ErwJBp
         XQdlwk/JE2vkOtsKju3kE9pWFcW4lkBhL7f2st+KtIMUGiuaePBZwrq58Yl7VPi5Au5M
         3jBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=960wPpVv08pzr1P96SQYuI4Qb0FjPx3BQ85RtZe3Mzo=;
        b=mCyhmm+69utW7eJxjXcTmvqWNhd9iVRLPbHtdhm/d28CRKczzVt+tp9MLRGPADwxrz
         WhKL0RKLRZuOt4sO7N703yoMC00z8V0TUglb0n7+pxeb6CAt+cNOkuLmZXH5ZdF6ncM0
         LZ8jyQ2kkYj5b4SpInHgolBeKUGuMC8O+HwGvLHcGFLICTMRWTgPB3ghGS6fDUC5hS9F
         fOcyUw5kMM8tdl93hiHIrHaKnUfgJOtxvDV7pXUkbTBrOiaIwoveIeXajRi2r/Fp/iY0
         POuSSEfd9yIWHFhE3zG4FJWHbPfKEpuWsKxOdJ1MTHVCwuxoXKuhvmqGs+j0fgjnUKmB
         WKew==
X-Gm-Message-State: ALoCoQlrm65gzeHZTH5/3a8B8haoVCuENkB8KmsaQQp50BOEiisPj9ZDgATUY93AC+4+M3Jh4fa6cRxlDoZ6Y5HnM1Hw+4EU+bPLFi4tz+JPkneNQOnaGQ8PvzTalMvrn1UHRTmswleiJbC8Q4hlTaoMEWXwOX5az27UJO7nVitkDN7Vs+soyaw/pUrSg8Xk80uF30Nkx0y7
X-Received: by 10.236.45.41 with SMTP id o29mr8243560yhb.13.1397154629739;
        Thu, 10 Apr 2014 11:30:29 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id u45si798311yhl.4.2014.04.10.11.30.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Apr 2014 11:30:29 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 86CCF5A4082;
	Thu, 10 Apr 2014 11:30:29 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 4C271E0591; Thu, 10 Apr 2014 11:30:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1.478.ga5a8238.dirty
In-Reply-To: <1397154625-11884-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246025>

Change the function write_ref_sha1() to just write the ref but not
commit the ref or the lockfile.
Add a new function commit_ref_lock() that will commit the change done by
a previous write_ref_sha1().
Update all callers of write_ref_sha1() to call commit_ref_lock().

The new pattern for updating a ref is now :

lock = lock_ref_sha1_basic() (or varient of)
write_ref_sha1(lock)
unlock_ref(lock) | commit_ref_lock(lock)

Once write_ref_sha1() returns, the new ref has been written and the lock
file has been closed.
At that stage we can then either call unlock_ref() which will abort the
update and delete the lock file withouth applying it, or call
commit_ref_lock() which will rename the lock file onto the ref file.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 branch.c               | 10 ++++++++--
 builtin/commit.c       |  5 +++++
 builtin/fetch.c        |  7 ++++++-
 builtin/receive-pack.c |  4 ++++
 builtin/replace.c      |  6 +++++-
 builtin/tag.c          |  6 +++++-
 fast-import.c          |  7 ++++++-
 refs.c                 | 39 ++++++++++++++++++++++++++++++---------
 refs.h                 |  4 ++++
 sequencer.c            |  4 ++++
 walker.c               |  4 ++++
 11 files changed, 81 insertions(+), 15 deletions(-)

diff --git a/branch.c b/branch.c
index 660097b..903ea75 100644
--- a/branch.c
+++ b/branch.c
@@ -304,9 +304,15 @@ void create_branch(const char *head,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
-	if (!dont_change_ref)
-		if (write_ref_sha1(lock, sha1, msg) < 0)
+	if (!dont_change_ref) {
+		if (write_ref_sha1(lock, sha1, msg) < 0) {
+			unlock_ref(lock);
 			die_errno(_("Failed to write ref"));
+		}
+		if (commit_ref_lock(lock) < 0) {
+			die_errno(_("Failed to commit ref"));
+		}
+	}
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/builtin/commit.c b/builtin/commit.c
index d9550c5..3d8a3a8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1686,9 +1686,14 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("cannot lock HEAD ref"));
 	}
 	if (write_ref_sha1(ref_lock, sha1, sb.buf) < 0) {
+		unlock_ref(ref_lock);
 		rollback_index_files();
 		die(_("cannot update HEAD ref"));
 	}
+	if (commit_ref_lock(ref_lock) < 0) {
+		rollback_index_files();
+		die(_("cannot commit HEAD ref"));
+	}
 
 	unlink(git_path("CHERRY_PICK_HEAD"));
 	unlink(git_path("REVERT_HEAD"));
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 55f457c..ebfb854 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -388,7 +388,12 @@ static int s_update_ref(const char *action,
 	if (!lock)
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
-	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0) {
+		unlock_ref(lock);
+		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
+					  STORE_REF_ERROR_OTHER;
+	}
+	if (commit_ref_lock(lock) < 0)
 		return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
 					  STORE_REF_ERROR_OTHER;
 	return 0;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c323081..4760274 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -587,8 +587,12 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 			return "failed to lock";
 		}
 		if (write_ref_sha1(lock, new_sha1, "push")) {
+			unlock_ref(lock);
 			return "failed to write"; /* error() already called */
 		}
+		if (commit_ref_lock(lock))
+			return "failed to commit"; /* error() already called */
+
 		return NULL; /* good */
 	}
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index b62420a..c09ff49 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -160,8 +160,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
 	lock = lock_any_ref_for_update(ref, prev, 0, NULL);
 	if (!lock)
 		die("%s: cannot lock the ref", ref);
-	if (write_ref_sha1(lock, repl, NULL) < 0)
+	if (write_ref_sha1(lock, repl, NULL) < 0) {
+		unlock_ref(lock);
 		die("%s: cannot update the ref", ref);
+	}
+	if (commit_ref_lock(lock) < 0)
+		die("%s: cannot commit the ref", ref);
 
 	return 0;
 }
diff --git a/builtin/tag.c b/builtin/tag.c
index 40356e3..8653a64 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -644,8 +644,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
 	if (!lock)
 		die(_("%s: cannot lock the ref"), ref.buf);
-	if (write_ref_sha1(lock, object, NULL) < 0)
+	if (write_ref_sha1(lock, object, NULL) < 0) {
+		unlock_ref(lock);
 		die(_("%s: cannot update the ref"), ref.buf);
+	}
+	if (commit_ref_lock(lock) < 0)
+		die(_("%s: cannot commit the ref"), ref.buf);
 	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
 		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
 
diff --git a/fast-import.c b/fast-import.c
index fb4738d..65c41ad 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1706,8 +1706,13 @@ static int update_branch(struct branch *b)
 			return -1;
 		}
 	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
+	if (write_ref_sha1(lock, b->sha1, msg) < 0) {
+		unlock_ref(lock);
 		return error("Unable to update %s", b->name);
+	}
+	if (commit_ref_lock(lock) < 0) {
+		return error("Unable to commit %s", b->name);
+	}
 	return 0;
 }
 
diff --git a/refs.c b/refs.c
index 28d5eca..9771237 100644
--- a/refs.c
+++ b/refs.c
@@ -2633,9 +2633,14 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	lock->force_write = 1;
 	hashcpy(lock->old_sha1, orig_sha1);
 	if (write_ref_sha1(lock, orig_sha1, logmsg)) {
+		unlock_ref(lock);
 		error("unable to write current sha1 into %s", newrefname);
 		goto rollback;
 	}
+	if (commit_ref_lock(lock)) {
+		error("unable to commit current sha1 into %s", newrefname);
+		goto rollback;
+	}
 
 	return 0;
 
@@ -2649,8 +2654,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	lock->force_write = 1;
 	flag = log_all_ref_updates;
 	log_all_ref_updates = 0;
-	if (write_ref_sha1(lock, orig_sha1, NULL))
+	if (write_ref_sha1(lock, orig_sha1, NULL)) {
+		unlock_ref(lock);
 		error("unable to write current sha1 into %s", oldrefname);
+	}
+	if (commit_ref_lock(lock))
+		error("unable to commit current sha1 into %s", oldrefname);
 	log_all_ref_updates = flag;
 
  rollbacklog:
@@ -2807,34 +2816,30 @@ int write_ref_sha1(struct ref_lock *lock,
 	if (!lock)
 		return -1;
 	if (!lock->force_write && !hashcmp(lock->old_sha1, sha1)) {
-		unlock_ref(lock);
+		lock->skipped_write = 1;
 		return 0;
 	}
 	o = parse_object(sha1);
 	if (!o) {
 		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
-		unlock_ref(lock);
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		error("Trying to write non-commit object %s to branch %s",
 			sha1_to_hex(sha1), lock->ref_name);
-		unlock_ref(lock);
 		return -1;
 	}
 	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
 	    write_in_full(lock->lock_fd, &term, 1) != 1
 		|| close_ref(lock) < 0) {
 		error("Couldn't write %s", lock->lk->filename);
-		unlock_ref(lock);
 		return -1;
 	}
 	clear_loose_ref_cache(&ref_cache);
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-		unlock_ref(lock);
 		return -1;
 	}
 	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
@@ -2858,7 +2863,12 @@ int write_ref_sha1(struct ref_lock *lock,
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
 	}
-	if (commit_ref(lock)) {
+	return 0;
+}
+
+int commit_ref_lock(struct ref_lock *lock)
+{
+        if (!lock->skipped_write && commit_ref(lock)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -3272,10 +3282,17 @@ int update_ref(const char *action, const char *refname,
 	       int flags, enum action_on_err onerr)
 {
 	struct ref_lock *lock;
+	int ret;
+
 	lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
 	if (!lock)
 		return 1;
-	return update_ref_write(action, refname, sha1, lock, onerr);
+	ret = update_ref_write(action, refname, sha1, lock, onerr);
+	if (ret)
+		unlock_ref(lock);
+	else
+		ret = commit_ref_lock(lock);
+	return ret;
 }
 
 static int ref_update_compare(const void *r1, const void *r2)
@@ -3351,7 +3368,11 @@ int update_refs(const char *action, const struct ref_update **updates_orig,
 					       updates[i]->ref_name,
 					       updates[i]->new_sha1,
 					       locks[i], onerr);
-			locks[i] = NULL; /* freed by update_ref_write */
+			if (ret)
+				unlock_ref(locks[i]);
+			else
+				commit_ref_lock(locks[i]);
+			locks[i] = NULL;
 			if (ret)
 				goto cleanup;
 		}
diff --git a/refs.h b/refs.h
index 87a1a79..0382128 100644
--- a/refs.h
+++ b/refs.h
@@ -8,6 +8,7 @@ struct ref_lock {
 	unsigned char old_sha1[20];
 	int lock_fd;
 	int force_write;
+	int skipped_write;
 };
 
 /**
@@ -165,6 +166,9 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
+/** Commit any changes done to the ref specified by the lock. **/
+extern int commit_ref_lock(struct ref_lock *lock);
+
 /** Setup reflog before using. **/
 int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
 
diff --git a/sequencer.c b/sequencer.c
index bde5f04..ffadf82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -283,6 +283,10 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
 					   0, NULL);
 	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
 	ret = write_ref_sha1(ref_lock, to, sb.buf);
+	if (ret)
+		unlock_ref(ref_lock);
+	else
+		ret |= commit_ref_lock(ref_lock);
 	strbuf_release(&sb);
 	return ret;
 }
diff --git a/walker.c b/walker.c
index 1dd86b8..5ce5a1d 100644
--- a/walker.c
+++ b/walker.c
@@ -295,6 +295,10 @@ int walker_fetch(struct walker *walker, int targets, char **target,
 		if (!write_ref || !write_ref[i])
 			continue;
 		ret = write_ref_sha1(lock[i], &sha1[20 * i], msg ? msg : "fetch (unknown)");
+		if (ret)
+			unlock_ref(lock[i]);
+		else
+			ret |= commit_ref_lock(lock[i]);
 		lock[i] = NULL;
 		if (ret)
 			goto unlock_and_fail;
-- 
1.9.1.478.ga5a8238.dirty
