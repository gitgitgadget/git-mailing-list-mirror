From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Remove diff machinery dependency from read-cache
Date: Thu, 21 Jan 2010 11:37:38 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY2xz-00087e-Hu
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 20:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581Ab0AUTpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 14:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570Ab0AUTpL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 14:45:11 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37198 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502Ab0AUTpJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jan 2010 14:45:09 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LJbcpJ021088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Jan 2010 11:37:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o0LJbcdW025220;
	Thu, 21 Jan 2010 11:37:38 -0800
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137686>


Exal Sibeaz pointed out that some git files are way too big, and that 
add_files_to_cache() brings in all the diff machinery to any git binary 
that needs the basic git SHA1 object operations from read-cache.c. Which 
is pretty much all of them.

It's doubly silly, since add_files_to_cache() is only used by builtin 
programs (add, checkout and commit), so it's fairly easily fixed by just 
moving the thing to builtin-add.c, and avoiding the dependency entirely.

I initially argued to Exal that it would probably be best to try to depend 
on smart compilers and linkers, but after spending some time trying to 
make -ffunction-sections work and giving up, I think Exal was right, and 
the fix is to just do some trivial cleanups like this.

This trivial cleanup results in pretty stunning file size differences. 
The diff machinery really is mostly used by just the builtin programs, and 
you have things like these trivial before-and-after numbers:

  -rwxr-xr-x 1 torvalds torvalds 1727420 2010-01-21 10:53 git-hash-object
  -rwxrwxr-x 1 torvalds torvalds  940265 2010-01-21 11:16 git-hash-object

Now, I'm not saying that 940kB is good either, but that's mostly all the 
debug information - you can see the real code with 'size':

   text	   data	    bss	    dec	    hex	filename
 418675	   3920	 127408	 550003	  86473	git-hash-object (before)
 230650	   2288	 111728	 344666	  5425a	git-hash-object (after)

ie we have a nice 24% size reduction from this trivial cleanup.

It's not just that one file either. I get:

	[torvalds@nehalem git]$ du -s /home/torvalds/libexec/git-core
	45640	/home/torvalds/libexec/git-core (before)
	33508	/home/torvalds/libexec/git-core (after)

so we're talking 12MB of diskspace here. 

(Of course, stripping all the binaries brings the 33MB down to 9MB, so the 
whole debug information thing is still the bulk of it all, but that's a 
separate issue entirely)

Now, I'm sure there are other things we should do, and changing our 
compiler flags from -O2 to -Os would bring the text size down by an 
additional almost 20%, but this thing Exal pointed out seems to be some 
good low-hanging fruit.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 builtin-add.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 read-cache.c  |   78 ---------------------------------------------------------
 2 files changed, 76 insertions(+), 78 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index cb6e590..2705f8d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -11,6 +11,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "diff.h"
+#include "diffcore.h"
 #include "revision.h"
 
 static const char * const builtin_add_usage[] = {
@@ -20,6 +21,81 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive, add_interactive, edit_interactive;
 static int take_worktree_changes;
 
+struct update_callback_data
+{
+	int flags;
+	int add_errors;
+};
+
+static void update_callback(struct diff_queue_struct *q,
+			    struct diff_options *opt, void *cbdata)
+{
+	int i;
+	struct update_callback_data *data = cbdata;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p = q->queue[i];
+		const char *path = p->one->path;
+		switch (p->status) {
+		default:
+			die("unexpected diff status %c", p->status);
+		case DIFF_STATUS_UNMERGED:
+			/*
+			 * ADD_CACHE_IGNORE_REMOVAL is unset if "git
+			 * add -u" is calling us, In such a case, a
+			 * missing work tree file needs to be removed
+			 * if there is an unmerged entry at stage #2,
+			 * but such a diff record is followed by
+			 * another with DIFF_STATUS_DELETED (and if
+			 * there is no stage #2, we won't see DELETED
+			 * nor MODIFIED).  We can simply continue
+			 * either way.
+			 */
+			if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL))
+				continue;
+			/*
+			 * Otherwise, it is "git add path" is asking
+			 * to explicitly add it; we fall through.  A
+			 * missing work tree file is an error and is
+			 * caught by add_file_to_index() in such a
+			 * case.
+			 */
+		case DIFF_STATUS_MODIFIED:
+		case DIFF_STATUS_TYPE_CHANGED:
+			if (add_file_to_index(&the_index, path, data->flags)) {
+				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
+					die("updating files failed");
+				data->add_errors++;
+			}
+			break;
+		case DIFF_STATUS_DELETED:
+			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
+				break;
+			if (!(data->flags & ADD_CACHE_PRETEND))
+				remove_file_from_index(&the_index, path);
+			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
+				printf("remove '%s'\n", path);
+			break;
+		}
+	}
+}
+
+int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
+{
+	struct update_callback_data data;
+	struct rev_info rev;
+	init_revisions(&rev, prefix);
+	setup_revisions(0, NULL, &rev, NULL);
+	rev.prune_data = pathspec;
+	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = update_callback;
+	data.flags = flags;
+	data.add_errors = 0;
+	rev.diffopt.format_callback_data = &data;
+	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
+	return !!data.add_errors;
+}
+
 static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
 {
 	int num_unmatched = 0, i;
diff --git a/read-cache.c b/read-cache.c
index edd9959..79938bf 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -10,9 +10,6 @@
 #include "dir.h"
 #include "tree.h"
 #include "commit.h"
-#include "diff.h"
-#include "diffcore.h"
-#include "revision.h"
 #include "blob.h"
 #include "resolve-undo.h"
 
@@ -1648,81 +1645,6 @@ int read_index_unmerged(struct index_state *istate)
 	return unmerged;
 }
 
-struct update_callback_data
-{
-	int flags;
-	int add_errors;
-};
-
-static void update_callback(struct diff_queue_struct *q,
-			    struct diff_options *opt, void *cbdata)
-{
-	int i;
-	struct update_callback_data *data = cbdata;
-
-	for (i = 0; i < q->nr; i++) {
-		struct diff_filepair *p = q->queue[i];
-		const char *path = p->one->path;
-		switch (p->status) {
-		default:
-			die("unexpected diff status %c", p->status);
-		case DIFF_STATUS_UNMERGED:
-			/*
-			 * ADD_CACHE_IGNORE_REMOVAL is unset if "git
-			 * add -u" is calling us, In such a case, a
-			 * missing work tree file needs to be removed
-			 * if there is an unmerged entry at stage #2,
-			 * but such a diff record is followed by
-			 * another with DIFF_STATUS_DELETED (and if
-			 * there is no stage #2, we won't see DELETED
-			 * nor MODIFIED).  We can simply continue
-			 * either way.
-			 */
-			if (!(data->flags & ADD_CACHE_IGNORE_REMOVAL))
-				continue;
-			/*
-			 * Otherwise, it is "git add path" is asking
-			 * to explicitly add it; we fall through.  A
-			 * missing work tree file is an error and is
-			 * caught by add_file_to_index() in such a
-			 * case.
-			 */
-		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_index(&the_index, path, data->flags)) {
-				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
-					die("updating files failed");
-				data->add_errors++;
-			}
-			break;
-		case DIFF_STATUS_DELETED:
-			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
-				break;
-			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_index(&the_index, path);
-			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf("remove '%s'\n", path);
-			break;
-		}
-	}
-}
-
-int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
-{
-	struct update_callback_data data;
-	struct rev_info rev;
-	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
-	rev.prune_data = pathspec;
-	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
-	rev.diffopt.format_callback = update_callback;
-	data.flags = flags;
-	data.add_errors = 0;
-	rev.diffopt.format_callback_data = &data;
-	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	return !!data.add_errors;
-}
-
 /*
  * Returns 1 if the path is an "other" path with respect to
  * the index; that is, the path is not mentioned in the index at all,
