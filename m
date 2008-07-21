From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] builtin-add.c: restructure the code for
 maintainability
Date: Mon, 21 Jul 2008 01:24:17 -0700
Message-ID: <7vr69ntzke.fsf@gitster.siamese.dyndns.org>
References: <1216534144-23826-1-git-send-email-gitster@pobox.com>
 <alpine.DEB.1.00.0807201529150.3305@eeepc-johanness>
 <7v3am3yfph.fsf@gitster.siamese.dyndns.org>
 <7v7ibfvfmh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 10:25:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqhy-0007wf-Lz
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYGUIY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 04:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754123AbYGUIY0
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:24:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753820AbYGUIYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 04:24:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98358394A7;
	Mon, 21 Jul 2008 04:24:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5A578394A4; Mon, 21 Jul 2008 04:24:20 -0400 (EDT)
In-Reply-To: <7v7ibfvfmh.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Jul 2008 00:52:06 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6CAFA050-56FE-11DD-99F1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89321>

Junio C Hamano <gitster@pobox.com> writes:

> Thinking about this issue a bit more, I realize that the earlier "git add -A"
> change was done in a quite inefficient way (i.e. it is as unefficient as
> "git add -u && git add ." modulo one fork/exec and read/write index).  For
> that matter, the original "git add ." could probably be more efficient
> than it currently is.
> ...
> It is likely that I am too tired to do this right tonight, so I'll go to
> bed and expect to find a nicely done patch in my mailbox by somebody else
> ;-).

Well, I lied.  I couldn't sleep, so here is a preview that seems to pass
all the test at least.  It needs to be split into two, but I am too tired
to do that properly tonight.

The main part of the change is third hunk (preimage ll.258-) to the bottom
of builtin-add.c and follows the idea outlined in the message this is a
response to.

A private function add_files_to_cache() in builtin-add.c was borrowed by
checkout and commit re-implementors without getting properly refactored to
more library-ish place.  This does the refactoring, and most of the
changes you see in the diffstat are this; it should come before the main
part of the change.

---

 builtin-add.c |   78 ++++++--------------------------------------------------
 cache.h       |    1 +
 read-cache.c  |   61 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 69 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index fc3f96e..f9b25f2 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -8,10 +8,6 @@
 #include "dir.h"
 #include "exec_cmd.h"
 #include "cache-tree.h"
-#include "diff.h"
-#include "diffcore.h"
-#include "commit.h"
-#include "revision.h"
 #include "run-command.h"
 #include "parse-options.h"
 
@@ -79,59 +75,6 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 		prune_directory(dir, pathspec, baselen);
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
-		case DIFF_STATUS_MODIFIED:
-		case DIFF_STATUS_TYPE_CHANGED:
-			if (add_file_to_cache(path, data->flags)) {
-				if (!(data->flags & ADD_CACHE_IGNORE_ERRORS))
-					die("updating files failed");
-				data->add_errors++;
-			}
-			break;
-		case DIFF_STATUS_DELETED:
-			if (!(data->flags & ADD_CACHE_PRETEND))
-				remove_file_from_cache(path);
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
 static void refresh(int verbose, const char **pathspec)
 {
 	char *seen;
@@ -258,7 +201,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die("-A and -u are mutually incompatible");
-	if (addremove && !argc) {
+	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] = { ".", NULL };
 		argc = 1;
 		argv = here;
@@ -271,7 +214,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
-		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0));
+		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
+		 (!(addremove || take_worktree_changes)
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
@@ -280,24 +225,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	}
 	pathspec = get_pathspec(prefix, argv);
 
-	/*
-	 * If we are adding new files, we need to scan the working
-	 * tree to find the ones that match pathspecs; this needs
-	 * to be done before we read the index.
-	 */
-	if (add_new_files)
-		fill_directory(&dir, pathspec, ignored_too);
-
 	if (read_cache() < 0)
 		die("index file corrupt");
 
+	if (add_new_files)
+		/* This picks up the paths that are not tracked */
+		fill_directory(&dir, pathspec, ignored_too);
+
 	if (refresh_only) {
 		refresh(verbose, pathspec);
 		goto finish;
 	}
 
-	if (take_worktree_changes || addremove)
-		exit_status |= add_files_to_cache(prefix, pathspec, flags);
+	exit_status |= add_files_to_cache(prefix, pathspec, flags);
 
 	if (add_new_files)
 		exit_status |= add_files(&dir, flags);
diff --git a/cache.h b/cache.h
index 38985aa..6f374ad 100644
--- a/cache.h
+++ b/cache.h
@@ -375,6 +375,7 @@ extern int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
+#define ADD_CACHE_IGNORE_REMOVAL 8
 extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
 extern int add_file_to_index(struct index_state *, const char *path, int flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const unsigned char *sha1, const char *path, int stage, int refresh);
diff --git a/read-cache.c b/read-cache.c
index a50a851..6833af6 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -8,6 +8,11 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
+#include "tree.h"
+#include "commit.h"
+#include "diff.h"
+#include "diffcore.h"
+#include "revision.h"
 
 /* Index extensions.
  *
@@ -1444,3 +1449,59 @@ int read_index_unmerged(struct index_state *istate)
 	istate->cache_nr = dst - istate->cache;
 	return !!last;
 }
+
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
