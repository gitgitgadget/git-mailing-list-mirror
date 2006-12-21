From: Junio C Hamano <junkio@cox.net>
Subject: [RFH/RFT] git-rm: update to saner semantics
Date: Thu, 21 Dec 2006 01:18:13 -0800
Message-ID: <7vwt4lboa2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 21 10:20:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxK6H-0004GV-LX
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 10:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422916AbWLUJTX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 04:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbWLUJSe
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 04:18:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:40841 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422916AbWLUJSP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 04:18:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221091814.LCEE9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 04:18:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1MHY1W0041kojtg0000000; Thu, 21 Dec 2006 04:17:32 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35037>

This updates the "git rm" command with saner semantics suggested
on the list earlier with:

	Message-ID: <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
	Message-ID: <Pine.LNX.4.64.0612040737120.3476@woody.osdl.org>

The command still validates that the given paths all talk about
sensible paths to avoid mistakes (e.g. "git rm fiel" when the
user meant to remove "file" would error out), and it has further
safety checks described next.  The biggest difference is that
the paths are removed from both index and from the working tree
(if you have an exotic need to remove paths only from the index,
you can use the --cached option).

The command refuses to remove if the copy on the working tree
does not match the index, or if the index and the HEAD does not
match.  You can defeat this check with -f option.

This safety check has two exceptions: if the working tree file
does not exist to begin with, that technically does not match
the index but it is allowed.  This is to allow this CVS style
command sequence:

	rm <path> && git rm <path>

Also if the index is unmerged at the <path>, you can use "git rm
<path>" to declare that the result of the merge loses that path,
and the above safety check does not trigger; requiring the file
to match the index in this case forces the user to do "git
update-index file && git rm file", which is just crazy.

---

 * This has seen only very limited test, so testing, adjusting the
   test case t/t3600-rm.sh (possibly others) to the updated
   semantics and documentation updates are still needed.

   Also it lacks the "require -r for recursive behaviour" safety
   valve.  I think that is a sane thing to add.

   Volunteers?

 builtin-rm.c |  103 +++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 33d04bd..3927d93 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -9,7 +9,7 @@
 #include "cache-tree.h"
 
 static const char builtin_rm_usage[] =
-"git-rm [-n] [-v] [-f] <filepattern>...";
+"git-rm [-n] [-f] [--cached] <filepattern>...";
 
 static struct {
 	int nr, alloc;
@@ -41,12 +41,66 @@ static int remove_file(const char *name)
 	return ret;
 }
 
+static int check_local_mod(unsigned char *head)
+{
+	/* items in list are already sorted in the cache order,
+	 * so we could do this a lot more efficiently by using
+	 * tree_desc based traversal if we wanted to, but I am
+	 * lazy, and who cares if removal of files is a tad slower
+	 * than theoretical maximum speed?
+	 */
+	int i, no_head;
+	int errs = 0;
+
+	no_head = is_null_sha1(head);
+	for (i = 0; i < list.nr; i++) {
+		struct stat st;
+		int pos;
+		struct cache_entry *ce;
+		const char *name = list.name[i];
+		unsigned char sha1[20];
+		unsigned mode;
+
+		pos = cache_name_pos(name, strlen(name));
+		if (pos < 0)
+			continue; /* removing unmerged entry */
+		ce = active_cache[pos];
+
+		if (lstat(ce->name, &st) < 0) {
+			if (errno != ENOENT)
+				fprintf(stderr, "warning: '%s': %s",
+					ce->name, strerror(errno));
+			/* It already vanished from the working tree */
+			continue;
+		}
+		else if (S_ISDIR(st.st_mode)) {
+			/* if a file was removed and it is now a
+			 * directory, that is the same as ENOENT as
+			 * far as git is concerned; we do not track
+			 * directories.
+			 */
+			continue;
+		}
+		if (ce_match_stat(ce, &st, 0))
+			errs = error("'%s' has local modifications "
+				     "(hint: try -f)", ce->name);
+		if (no_head)
+			continue;
+		get_tree_entry(head, name, sha1, &mode);
+		if (ce->ce_mode != create_ce_mode(mode) ||
+		    hashcmp(ce->sha1, sha1))
+			errs = error("'%s' has changes staged in the index "
+				     "(hint: try -f)", name);
+	}
+	return errs;
+}
+
 static struct lock_file lock_file;
 
 int cmd_rm(int argc, const char **argv, const char *prefix)
 {
 	int i, newfd;
-	int verbose = 0, show_only = 0, force = 0;
+	int show_only = 0, force = 0, index_only = 0;
 	const char **pathspec;
 	char *seen;
 
@@ -62,23 +116,18 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 
 		if (*arg != '-')
 			break;
-		if (!strcmp(arg, "--")) {
+		else if (!strcmp(arg, "--")) {
 			i++;
 			break;
 		}
-		if (!strcmp(arg, "-n")) {
+		else if (!strcmp(arg, "-n"))
 			show_only = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-v")) {
-			verbose = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-f")) {
+		else if (!strcmp(arg, "--cached"))
+			index_only = 1;
+		else if (!strcmp(arg, "-f"))
 			force = 1;
-			continue;
-		}
-		usage(builtin_rm_usage);
+		else
+			usage(builtin_rm_usage);
 	}
 	if (argc <= i)
 		usage(builtin_rm_usage);
@@ -105,8 +154,26 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	}
 
 	/*
+	 * If not forced, the file, the index and the HEAD (if exists)
+	 * must match; but the file can already been removed, since
+	 * this sequence is a natural "novice" way:
+	 *
+	 *	rm F; git fm F
+	 *
+	 * Further, if HEAD commit exists, "diff-index --cached" must
+	 * report no changes unless forced.
+	 */
+	if (!force) {
+		unsigned char sha1[20];
+		if (get_sha1("HEAD", sha1))
+			hashclr(sha1);
+		if (check_local_mod(sha1))
+			exit(1);
+	}
+
+	/*
 	 * First remove the names from the index: we won't commit
-	 * the index unless all of them succeed
+	 * the index unless all of them succeed.
 	 */
 	for (i = 0; i < list.nr; i++) {
 		const char *path = list.name[i];
@@ -121,14 +188,14 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		return 0;
 
 	/*
-	 * Then, if we used "-f", remove the filenames from the
-	 * workspace. If we fail to remove the first one, we
+	 * Then, unless we used "--cache", remove the filenames from
+	 * the workspace. If we fail to remove the first one, we
 	 * abort the "git rm" (but once we've successfully removed
 	 * any file at all, we'll go ahead and commit to it all:
 	 * by then we've already committed ourselves and can't fail
 	 * in the middle)
 	 */
-	if (force) {
+	if (!index_only) {
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.name[i];
