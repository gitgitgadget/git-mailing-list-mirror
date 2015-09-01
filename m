From: Jeff King <peff@peff.net>
Subject: [PATCH] rerere: release lockfile in non-writing functions
Date: Tue, 1 Sep 2015 18:14:09 -0400
Message-ID: <20150901221409.GA23274@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 00:14:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWtom-0000gI-IR
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 00:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059AbbIAWON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 18:14:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:53356 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751180AbbIAWOM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 18:14:12 -0400
Received: (qmail 29899 invoked by uid 102); 1 Sep 2015 22:14:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 17:14:12 -0500
Received: (qmail 6345 invoked by uid 107); 1 Sep 2015 22:14:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 18:14:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 18:14:09 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277052>

There's a bug in builtin/am.c in which we take a lock on
MERGE_RR recursively. But rather than fix am.c, this patch
fixes the confusing interface from rerere.c that caused the
bug. Read on for the gory details.

The setup_rerere() function both reads the existing MERGE_RR
file, and takes MERGE_RR.lock. In the rerere() and
rerere_forget() functions, we end up in write_rr(), which
will then commit the lock file.

But for functions like rerere_clear() that do not write to
MERGE_RR, we expect the caller to have handled
setup_rerere(). That caller would then need to release the
lockfile, but it can't; the lock struct is local to
rerere.c.

For builtin/rerere.c, this is OK. We run a single rerere
operation and then exit immediately, which has the side
effect of rolling back the lockfile.

But in builtin/am.c, this is actively wrong. If we run "git
am -3 --skip", we call setup-rerere twice without releasing
the lock:

  1. The "--skip" causes us to call am_rerere_clear(), which
     calls setup_rerere(), but never drops the lock.

  2. We then proceed to the next patch.

  3. The "--3way" may cause us to call rerere() to handle
     conflicts in that patch, but we are already holding the
     lock. The lockfile code dies with:

     BUG: prepare_tempfile_object called for active object

We could fix this by having rerere_clear() call
rollback_lock_file(). But it feels a bit odd for it to roll
back a lockfile that it did not itself take. So let's
simplify the interface further, and handle setup_rerere in
the function itself, taking away the question from the
caller over whether they need to do so.

We can give rerere_gc() the same treatment, as well (even
though it doesn't have any callers besides builtin/rerere.c
at this point). Note that these functions don't take flags
from their callers to pass along to setup_rerere; that's OK,
because the flags would not be meaningful for what they are
doing.

Both of those functions need to hold the lock because even
though they do not write to MERGE_RR, they are still writing
and should be protected from a simultaneous "rerere" run.
But rerere_remaining(), "rerere diff", and "rerere status"
are all read-only operations. They want to setup_rerere(),
but do not care about taking the lock in the first place.
Since our update of MERGE_RR is the usual atomic rename done
by commit_lock_file, they can just do a lockless read. For
that, we teach setup_rerere a READONLY flag to avoid the
lock.

As a bonus, this pushes builtin/rerere.c's setup_rerere call
closer to the functions that use it. Which means that "git
rerere totally-bogus-command" will no longer silently
exit(0) in a repository without rerere enabled.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c     |  5 -----
 builtin/rerere.c | 18 +++++++++---------
 rerere.c         | 17 +++++++++++++++--
 rerere.h         |  1 +
 t/t4150-am.sh    | 36 ++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+), 16 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 27165a6..83b3d86 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2057,11 +2057,6 @@ static int clean_index(const unsigned char *head, const unsigned char *remote)
 static void am_rerere_clear(void)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int fd = setup_rerere(&merge_rr, 0);
-
-	if (fd < 0)
-		return;
-
 	rerere_clear(&merge_rr);
 	string_list_clear(&merge_rr, 1);
 }
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 7afadd2..12535c9 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -50,7 +50,7 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	int i, fd, autoupdate = -1, flags = 0;
+	int i, autoupdate = -1, flags = 0;
 
 	struct option options[] = {
 		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
@@ -79,18 +79,16 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		return rerere_forget(&pathspec);
 	}
 
-	fd = setup_rerere(&merge_rr, flags);
-	if (fd < 0)
-		return 0;
-
 	if (!strcmp(argv[0], "clear")) {
 		rerere_clear(&merge_rr);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(&merge_rr);
-	else if (!strcmp(argv[0], "status"))
+	else if (!strcmp(argv[0], "status")) {
+		if (setup_rerere(&merge_rr, flags | RERERE_READONLY) < 0)
+			return 0;
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
-	else if (!strcmp(argv[0], "remaining")) {
+	} else if (!strcmp(argv[0], "remaining")) {
 		rerere_remaining(&merge_rr);
 		for (i = 0; i < merge_rr.nr; i++) {
 			if (merge_rr.items[i].util != RERERE_RESOLVED)
@@ -100,13 +98,15 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 				 * string_list_clear() */
 				merge_rr.items[i].util = NULL;
 		}
-	} else if (!strcmp(argv[0], "diff"))
+	} else if (!strcmp(argv[0], "diff")) {
+		if (setup_rerere(&merge_rr, flags | RERERE_READONLY) < 0)
+			return 0;
 		for (i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const char *name = (const char *)merge_rr.items[i].util;
 			diff_two(rerere_path(name, "preimage"), path, path, path);
 		}
-	else
+	} else
 		usage_with_options(rerere_usage, options);
 
 	string_list_clear(&merge_rr, 1);
diff --git a/rerere.c b/rerere.c
index 6a517aa..d90057b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -409,6 +409,8 @@ static int find_conflict(struct string_list *conflict)
 int rerere_remaining(struct string_list *merge_rr)
 {
 	int i;
+	if (setup_rerere(merge_rr, RERERE_READONLY))
+		return 0;
 	if (read_cache() < 0)
 		return error("Could not read index");
 
@@ -603,8 +605,11 @@ int setup_rerere(struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	fd = hold_lock_file_for_update(&write_lock, git_path_merge_rr(),
-				       LOCK_DIE_ON_ERROR);
+	if (flags & RERERE_READONLY)
+		fd = 0;
+	else
+		fd = hold_lock_file_for_update(&write_lock, git_path_merge_rr(),
+					       LOCK_DIE_ON_ERROR);
 	read_rr(merge_rr);
 	return fd;
 }
@@ -701,6 +706,9 @@ void rerere_gc(struct string_list *rr)
 	int cutoff_noresolve = 15;
 	int cutoff_resolve = 60;
 
+	if (setup_rerere(rr, 0) < 0)
+		return;
+
 	git_config_get_int("gc.rerereresolved", &cutoff_resolve);
 	git_config_get_int("gc.rerereunresolved", &cutoff_noresolve);
 	git_config(git_default_config, NULL);
@@ -727,16 +735,21 @@ void rerere_gc(struct string_list *rr)
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
+	rollback_lock_file(&write_lock);
 }
 
 void rerere_clear(struct string_list *merge_rr)
 {
 	int i;
 
+	if (setup_rerere(merge_rr, 0) < 0)
+		return;
+
 	for (i = 0; i < merge_rr->nr; i++) {
 		const char *name = (const char *)merge_rr->items[i].util;
 		if (!has_rerere_resolution(name))
 			unlink_rr_item(name);
 	}
 	unlink_or_warn(git_path_merge_rr());
+	rollback_lock_file(&write_lock);
 }
diff --git a/rerere.h b/rerere.h
index 2956c2e..407d599 100644
--- a/rerere.h
+++ b/rerere.h
@@ -7,6 +7,7 @@ struct pathspec;
 
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
+#define RERERE_READONLY     04
 
 /*
  * Marks paths that have been hand-resolved and added to the
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index dd627c4..af6053a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -873,4 +873,40 @@ test_expect_success 'am --message-id -s signs off after the message id' '
 	test_cmp expected actual
 '
 
+test_expect_success 'am -3 works with rerere' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+
+	# make patches one->two and two->three...
+	test_commit one file &&
+	test_commit two file &&
+	test_commit three file &&
+	git format-patch -2 --stdout >seq.patch &&
+
+	# and create a situation that conflicts...
+	git reset --hard one &&
+	test_commit other file &&
+
+	# enable rerere...
+	test_config rerere.enabled true &&
+	test_when_finished "rm -rf .git/rr-cache" &&
+
+	# ...and apply. Our resolution is to skip the first
+	# patch, and the rerere the second one.
+	test_must_fail git am -3 seq.patch &&
+	test_must_fail git am --skip &&
+	echo resolved >file &&
+	git add file &&
+	git am --resolved &&
+
+	# now apply again, and confirm that rerere engaged (we still
+	# expect failure from am because rerere does not auto-commit
+	# for us).
+	git reset --hard other &&
+	test_must_fail git am -3 seq.patch &&
+	test_must_fail git am --skip &&
+	echo resolved >expect &&
+	test_cmp expect file
+'
+
 test_done
-- 
2.5.1.739.g7891f6b
