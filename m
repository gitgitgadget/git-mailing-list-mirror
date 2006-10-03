From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] pack-refs: use lockfile as everybody else does.
Date: Tue, 03 Oct 2006 02:19:20 -0700
Message-ID: <7v7izhrc2v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 11:19:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUgQu-0000BU-WE
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 11:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030271AbWJCJTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 05:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWJCJTV
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 05:19:21 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:64146 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030271AbWJCJTV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 05:19:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003091920.CEBI26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 05:19:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VlKN1V00T1kojtg0000000
	Tue, 03 Oct 2006 05:19:23 -0400
To: torvalds@osdl.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28259>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 I failed to spot a difference from the result/lock-path thing in
 builtin-pack-ref and what lockfile interface does for refs and
 index file.  They seem to do the essentially same thing.  Did I
 miss something?

 Also I am not sure about the "fsync(fd); fclose(refs_file)"
 sequence I did not touch with this patch.  Doesn't stdio still
 have stuff buffered when you run fsync()?  Would adding fflush()
 in between help?

 builtin-pack-refs.c |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index 4093973..ede4743 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "refs.h"
 
-static const char *result_path, *lock_path;
 static const char builtin_pack_refs_usage[] =
 "git-pack-refs [--prune]";
 
@@ -17,12 +16,6 @@ struct pack_refs_cb_data {
 	FILE *refs_file;
 };
 
-static void remove_lock_file(void)
-{
-	if (lock_path)
-		unlink(lock_path);
-}
-
 static int do_not_prune(int flags)
 {
 	/* If it is already packed or if it is a symref,
@@ -69,6 +62,8 @@ static void prune_refs(struct ref_to_pru
 	}
 }
 
+static struct lock_file packed;
+
 int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	int fd, i;
@@ -88,14 +83,7 @@ int cmd_pack_refs(int argc, const char *
 	if (i != argc)
 		usage(builtin_pack_refs_usage);
 
-	result_path = xstrdup(git_path("packed-refs"));
-	lock_path = xstrdup(mkpath("%s.lock", result_path));
-
-	fd = open(lock_path, O_CREAT | O_EXCL | O_WRONLY, 0666);
-	if (fd < 0)
-		die("unable to create new ref-pack file (%s)", strerror(errno));
-	atexit(remove_lock_file);
-
+	fd = hold_lock_file_for_update(&packed, git_path("packed-refs"), 1);
 	cbdata.refs_file = fdopen(fd, "w");
 	if (!cbdata.refs_file)
 		die("unable to create ref-pack file structure (%s)",
@@ -103,9 +91,8 @@ int cmd_pack_refs(int argc, const char *
 	for_each_ref(handle_one_ref, &cbdata);
 	fsync(fd);
 	fclose(cbdata.refs_file);
-	if (rename(lock_path, result_path) < 0)
+	if (commit_lock_file(&packed) < 0)
 		die("unable to overwrite old ref-pack file (%s)", strerror(errno));
-	lock_path = NULL;
 	if (cbdata.prune)
 		prune_refs(cbdata.ref_to_prune);
 	return 0;
-- 
1.4.2.3.gd1e9e
