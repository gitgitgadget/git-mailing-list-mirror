From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] Loosening path argument check a little bit in revision.c
Date: Sat, 22 Apr 2006 03:15:05 -0700
Message-ID: <7vzmidkjbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:50:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXP4B-0005Ro-VM
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDVUuw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWDVUuw
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:50:52 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:52180 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751168AbWDVUuv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:50:51 -0400
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3MAFbJE010184
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 10:15:38 GMT
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422101506.PXBB18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 06:15:06 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19059>

The argument parser revision.c::setup_revisions() insists on
path arguments that do not follow the double-dash marker to be
paths (either files or directories) that exist in the working
tree.  As the fact that diff-files and update-index have
explicit options to ignore "missing" files reminds us,
traditionally we allowed a sparsely populated working tree, so
this check is not very user friendly.

This patch allows non-existing paths to be given without the
double-dash marker as long as they exist in the index, or they
are leading paths of blobs that exist in the index.

A misspelled tag v2.6.16 is not a very likely name to have only
in the index and not in the working tree, so this should not
break the case the original code wanted to fix ;-).

---

 * I noticed a breakage in out test scripts while libifying
   diff-files.  The two-tree fast-forward merge test stuffs an
   entry DF/DF in the index while having a working tree file DF,
   and run "diff-files DF/DF" to make sure two-way read-tree
   left the index dirty.  The libified diff-files naturally uses
   revision infrastructure to get its parameters, and the path
   argument check causes the test to fail without this patch.

   This is just an RFC.  We can easily rewrite the particular
   test to use the double-dash marker, but I suspect existing
   porcelains share the same problem, expecting to be able to do
   something like this:

   	$ names=`git diff-files --name-only`
        $ git diff-index HEAD $names

   Of course, the kosher way is to always use double-dash, like
   this:

	$ git diff-files -z --name-only |
          xargs -0 git diff-index HEAD --

   So I am not pushing this too strongly.  Comments?

 revision.c |   48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 113dd5a..9f6dd24 100644
--- a/revision.c
+++ b/revision.c
@@ -504,6 +504,43 @@ void init_revisions(struct rev_info *rev
 	diff_setup(&revs->diffopt);
 }
 
+static int check_path_arg(const char *path)
+{
+	struct stat st;
+	int tmp = lstat(path, &st);
+	if (!tmp)
+		return 0;
+	tmp = errno;
+	if (!active_cache)
+		read_cache();
+	if (active_cache) {
+		int namelen = strlen(path);
+		int pos = cache_name_pos(path, namelen);
+		if (pos < 0)
+			pos = -pos - 1;
+		if (pos < active_nr) {
+			struct cache_entry *ce = active_cache[pos];
+			if (ce_namelen(ce) == namelen &&
+			    !memcmp(ce->name, path, namelen))
+				return 0;
+		}
+		/* Try it as a directory name - "foo/" */
+		while (++pos < active_nr) {
+			struct cache_entry *ce = active_cache[pos];
+			if (namelen < ce_namelen(ce) &&
+			    !memcmp(ce->name, path, namelen)) {
+				/* prefix still matches */
+				if (ce->name[namelen] == '/')
+					return 0;
+			}
+			else
+				break; /* prefix does not match anymore */
+		}
+	}
+	errno = tmp;
+	return -1;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -752,16 +789,19 @@ int setup_revisions(int argc, const char
 			arg++;
 		}
 		if (get_sha1(arg, sha1) < 0) {
-			struct stat st;
 			int j;
 
 			if (seen_dashdash || local_flags)
 				die("bad revision '%s'", arg);
 
-			/* If we didn't have a "--", all filenames must exist */
+			/* If we didn't have a "--", all filenames must
+			 * exist, either in the working tree or in the
+			 * cache.
+			 */
 			for (j = i; j < argc; j++) {
-				if (lstat(argv[j], &st) < 0)
-					die("'%s': %s", argv[j], strerror(errno));
+				if (check_path_arg(argv[j]))
+					die("'%s': %s", argv[j],
+					    strerror(errno));
 			}
 			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
