From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] builtin-add.c: optimize -A option and "git add $paths..."
Date: Wed, 23 Jul 2008 00:01:42 -0700
Message-ID: <1216796502-11227-2-git-send-email-gitster@pobox.com>
References: <1216796502-11227-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 09:03:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLYNc-00020M-Hr
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 09:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbYGWHBw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 03:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYGWHBv
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 03:01:51 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53475 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900AbYGWHBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 03:01:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B926A383FC
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 03:01:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BE47E383FB for <git@vger.kernel.org>; Wed, 23 Jul 2008 03:01:47
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.rc0.15.g0dda1
In-Reply-To: <1216796502-11227-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 3827A4DA-5885-11DD-9890-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89606>

The earlier "git add -A" change was done in a quite inefficient
way (i.e. it is as unefficient as "git add -u && git add ." modulo
one fork/exec and read/write index).

For that matter, the original "git add $paths..." could be improved.

When the user asks "git add .", we do not have to examine all paths
we encounter and perform the excluded() and dir_add_name()
processing, both of which are slower code and use slower data structure
by git standards, especially when the index is already reasonably well
populated.

Instead, we implement "git add $pathspec..." as:

 - read the index;

 - read_directory() to process untracked, unignored files the current
   way, that is, recursively doing readdir(), filtering them by pathspec
   and excluded(), queueing them via dir_add_name() and finally do
   add_files(); and

 - iterate over the index, filtering them by pathspec, and update only
   the modified/type changed paths but not deleted ones.

And "git add -A" becomes exactly the same as above, modulo:

 - missing $pathspec means "." instead of being an error; and

 - "iterate over the index" part handles deleted ones as well,
   i.e. exactly what the current update_callback() in builtin-add.c does.

In either case, because fill_directory() does not use read_directory() to
read everything in, we need to add an extra logic to iterate over the
index to catch mistyped pathspec.

In a fully populated kernel tree (without any local change), best of ten
runs:

(with this patch)
$ /usr/bin/time ~/git-test/bin/git add .
0.16user 0.17system 0:00.34elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3231minor)pagefaults 0swaps

(without this patch)
$ /usr/bin/time ~/git-master/bin/git add .
0.21user 0.21system 0:00.42elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3647minor)pagefaults 0swaps

Under the same condition, but after "rm .git/index" to force re-indexing
everything (the patch should not make any difference):

(with this patch)
$ /usr/bin/time ~/git-test/bin/git add .
3.22user 2.10system 1:35.10elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (30037major+63003minor)pagefaults 0swaps

(without this patch)
$ /usr/bin/time ~/git-master/bin/git add .
3.31user 2.28system 1:44.77elapsed 5%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (30472major+62563minor)pagefaults 0swaps

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-add.c |   43 +++++++++++++++++++++++++++++++------------
 1 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 0de516a..1834e2d 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -18,6 +18,27 @@ static const char * const builtin_add_usage[] = {
 static int patch_interactive = 0, add_interactive = 0;
 static int take_worktree_changes;
 
+static void fill_pathspec_matches(const char **pathspec, char *seen, int specs)
+{
+	int num_unmatched = 0, i;
+
+	/*
+	 * Since we are walking the index as if we are warlking the directory,
+	 * we have to mark the matched pathspec as seen; otherwise we will
+	 * mistakenly think that the user gave a pathspec that did not match
+	 * anything.
+	 */
+	for (i = 0; i < specs; i++)
+		if (!seen[i])
+			num_unmatched++;
+	if (!num_unmatched)
+		return;
+	for (i = 0; i < active_nr; i++) {
+		struct cache_entry *ce = active_cache[i];
+		match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen);
+	}
+}
+
 static void prune_directory(struct dir_struct *dir, const char **pathspec, int prefix)
 {
 	char *seen;
@@ -37,6 +58,7 @@ static void prune_directory(struct dir_struct *dir, const char **pathspec, int p
 			*dst++ = entry;
 	}
 	dir->nr = dst - dir->entries;
+	fill_pathspec_matches(pathspec, seen, specs);
 
 	for (i = 0; i < specs; i++) {
 		if (!seen[i] && !file_exists(pathspec[i]))
@@ -201,7 +223,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	if (addremove && take_worktree_changes)
 		die("-A and -u are mutually incompatible");
-	if (addremove && !argc) {
+	if ((addremove || take_worktree_changes) && !argc) {
 		static const char *here[2] = { ".", NULL };
 		argc = 1;
 		argv = here;
@@ -214,7 +236,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	flags = ((verbose ? ADD_CACHE_VERBOSE : 0) |
 		 (show_only ? ADD_CACHE_PRETEND : 0) |
-		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0));
+		 (ignore_add_errors ? ADD_CACHE_IGNORE_ERRORS : 0) |
+		 (!(addremove || take_worktree_changes)
+		  ? ADD_CACHE_IGNORE_REMOVAL : 0));
 
 	if (require_pathspec && argc == 0) {
 		fprintf(stderr, "Nothing specified, nothing added.\n");
@@ -223,24 +247,19 @@ int cmd_add(int argc, const char **argv, const char *prefix)
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
-- 
1.6.0.rc0.15.g0dda1
