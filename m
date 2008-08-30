From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/12] checkout -m: recreate merge when checking out of
 unmerged index
Date: Fri, 29 Aug 2008 17:42:43 -0700
Message-ID: <1220056963-2352-13-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
 <1220056963-2352-6-git-send-email-gitster@pobox.com>
 <1220056963-2352-7-git-send-email-gitster@pobox.com>
 <1220056963-2352-8-git-send-email-gitster@pobox.com>
 <1220056963-2352-9-git-send-email-gitster@pobox.com>
 <1220056963-2352-10-git-send-email-gitster@pobox.com>
 <1220056963-2352-11-git-send-email-gitster@pobox.com>
 <1220056963-2352-12-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZw-00076v-Tf
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753093AbYH3AnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753105AbYH3AnY
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:24 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42412 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080AbYH3AnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:43:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BD806DC1C
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1EC586DC1B for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:17
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-12-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: A3F4ED8E-762C-11DD-A57B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94351>

This teaches git-checkout to recreate a merge out of unmerged
index entries while resolving conflicts.

With this patch, checking out an unmerged path from the index
now have the following possibilities:

 * Without any option, an attempt to checkout an unmerged path
   will atomically fail (i.e. no other cleanly-merged paths are
   checked out either);

 * With "-f", other cleanly-merged paths are checked out, and
   unmerged paths are ignored;

 * With "--ours" or "--theirs, the contents from the specified
   stage is checked out;

 * With "-m" (we should add "--merge" as synonym), the 3-way merge
   is recreated from the staged object names and checked out.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |  115 ++++++++++++++++++++++++++++++++++++++++++++++++----
 t/t7201-co.sh      |   63 ++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index bdfdb65..8b5da7f 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -13,6 +13,9 @@
 #include "diff.h"
 #include "revision.h"
 #include "remote.h"
+#include "blob.h"
+#include "xdiff-interface.h"
+#include "ll-merge.h"
 
 static const char * const checkout_usage[] = {
 	"git checkout [options] <branch>",
@@ -109,6 +112,19 @@ static int check_stage(int stage, struct cache_entry *ce, int pos)
 		     (stage == 2) ? "our" : "their");
 }
 
+static int check_all_stage(struct cache_entry *ce, int pos)
+{
+	if (ce_stage(ce) != 1 ||
+	    active_nr <= pos + 2 ||
+	    strcmp(active_cache[pos+1]->name, ce->name) ||
+	    ce_stage(active_cache[pos+1]) != 2 ||
+	    strcmp(active_cache[pos+2]->name, ce->name) ||
+	    ce_stage(active_cache[pos+2]) != 3)
+		return error("path '%s' does not have all three versions",
+			     ce->name);
+	return 0;
+}
+
 static int checkout_stage(int stage, struct cache_entry *ce, int pos,
 			  struct checkout *state)
 {
@@ -123,6 +139,77 @@ static int checkout_stage(int stage, struct cache_entry *ce, int pos,
 		     (stage == 2) ? "our" : "their");
 }
 
+/* NEEDSWORK: share with merge-recursive */
+static void fill_mm(const unsigned char *sha1, mmfile_t *mm)
+{
+	unsigned long size;
+	enum object_type type;
+
+	if (!hashcmp(sha1, null_sha1)) {
+		mm->ptr = xstrdup("");
+		mm->size = 0;
+		return;
+	}
+
+	mm->ptr = read_sha1_file(sha1, &type, &size);
+	if (!mm->ptr || type != OBJ_BLOB)
+		die("unable to read blob object %s", sha1_to_hex(sha1));
+	mm->size = size;
+}
+
+static int checkout_merged(int pos, struct checkout *state)
+{
+	struct cache_entry *ce = active_cache[pos];
+	const char *path = ce->name;
+	mmfile_t ancestor, ours, theirs;
+	int status;
+	unsigned char sha1[20];
+	mmbuffer_t result_buf;
+
+	if (ce_stage(ce) != 1 ||
+	    active_nr <= pos + 2 ||
+	    strcmp(active_cache[pos+1]->name, path) ||
+	    ce_stage(active_cache[pos+1]) != 2 ||
+	    strcmp(active_cache[pos+2]->name, path) ||
+	    ce_stage(active_cache[pos+2]) != 3)
+		return error("path '%s' does not have all 3 versions", path);
+
+	fill_mm(active_cache[pos]->sha1, &ancestor);
+	fill_mm(active_cache[pos+1]->sha1, &ours);
+	fill_mm(active_cache[pos+2]->sha1, &theirs);
+
+	status = ll_merge(&result_buf, path, &ancestor,
+			  &ours, "ours", &theirs, "theirs", 1);
+	free(ancestor.ptr);
+	free(ours.ptr);
+	free(theirs.ptr);
+	if (status < 0 || !result_buf.ptr) {
+		free(result_buf.ptr);
+		return error("path '%s': cannot merge", path);
+	}
+
+	/*
+	 * NEEDSWORK:
+	 * There is absolutely no reason to write this as a blob object
+	 * and create a phoney cache entry just to leak.  This hack is
+	 * primarily to get to the write_entry() machinery that massages
+	 * the contents to work-tree format and writes out which only
+	 * allows it for a cache entry.  The code in write_entry() needs
+	 * to be refactored to allow us to feed a <buffer, size, mode>
+	 * instead of a cache entry.  Such a refactoring would help
+	 * merge_recursive as well (it also writes the merge result to the
+	 * object database even when it may contain conflicts).
+	 */
+	if (write_sha1_file(result_buf.ptr, result_buf.size,
+			    blob_type, sha1))
+		die("Unable to add merge result for '%s'", path);
+	ce = make_cache_entry(create_ce_mode(active_cache[pos+1]->ce_mode),
+			      sha1,
+			      path, 2, 0);
+	status = checkout_entry(ce, state, NULL);
+	return status;
+}
+
 static int checkout_paths(struct tree *source_tree, const char **pathspec,
 			  struct checkout_opts *opts)
 {
@@ -134,7 +221,7 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	struct commit *head;
 	int errs = 0;
 	int stage = opts->writeout_stage;
-
+	int merge = opts->merge;
 	int newfd;
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
@@ -166,6 +253,8 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 				errs |= check_stage(stage, ce, pos);
 			} else if (opts->force) {
 				warning("path '%s' is unmerged", ce->name);
+			} else if (opts->merge) {
+				errs |= check_all_stage(ce, pos);
 			} else {
 				errs = 1;
 				error("path '%s' is unmerged", ce->name);
@@ -184,13 +273,15 @@ static int checkout_paths(struct tree *source_tree, const char **pathspec,
 	for (pos = 0; pos < active_nr; pos++) {
 		struct cache_entry *ce = active_cache[pos];
 		if (pathspec_match(pathspec, NULL, ce->name, 0)) {
-			if (ce_stage(ce)) {
-				if (stage)
-					errs |= checkout_stage(stage, ce, pos, &state);
-				pos = skip_same_name(ce, pos) - 1;
+			if (!ce_stage(ce)) {
+				errs |= checkout_entry(ce, &state, NULL);
 				continue;
 			}
-			errs |= checkout_entry(ce, &state, NULL);
+			if (stage)
+				errs |= checkout_stage(stage, ce, pos, &state);
+			else if (merge)
+				errs |= checkout_merged(pos, &state);
+			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
 
@@ -478,6 +569,11 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	return ret || opts->writeout_error;
 }
 
+static int git_checkout_config(const char *var, const char *value, void *cb)
+{
+	return git_xmerge_config(var, value, cb);
+}
+
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
 	struct checkout_opts opts;
@@ -504,7 +600,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	memset(&opts, 0, sizeof(opts));
 	memset(&new, 0, sizeof(new));
 
-	git_config(git_default_config, NULL);
+	git_config(git_checkout_config, NULL);
 
 	opts.track = BRANCH_TRACK_UNSPECIFIED;
 
@@ -611,7 +707,7 @@ no_reference:
 			die("invalid path specification");
 
 		/* Checkout paths */
-		if (opts.new_branch || opts.merge) {
+		if (opts.new_branch) {
 			if (argc == 1) {
 				die("git checkout: updating paths is incompatible with switching branches.\nDid you intend to checkout '%s' which can not be resolved as commit?", argv[0]);
 			} else {
@@ -619,6 +715,9 @@ no_reference:
 			}
 		}
 
+		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
+			die("git checkout: --ours/--theirs, --force and --merge are incompatible when\nchecking out of the index.");
+
 		return checkout_paths(source_tree, pathspec, &opts);
 	}
 
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 85c792c..6016915 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -439,4 +439,67 @@ test_expect_success 'checkout unmerged stage' '
 	test ztheirside = "z$(cat file)"
 '
 
+test_expect_success 'checkout with --merge' '
+	rm -f .git/index &&
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	(
+		echo "100644 $A 0	fild" &&
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file" &&
+		echo "100644 $A 0	filf"
+	) | git update-index --index-info &&
+	echo "none of the above" >sample &&
+	echo ourside >expect &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	git checkout -m -- fild file filf &&
+	(
+		echo "<<<<<<< ours"
+		echo ourside
+		echo "======="
+		echo theirside
+		echo ">>>>>>> theirs"
+	) >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
+test_expect_success 'checkout with --merge, in diff3 -m style' '
+	git config merge.conflictstyle diff3 &&
+	rm -f .git/index &&
+	O=$(echo original | git hash-object -w --stdin) &&
+	A=$(echo ourside | git hash-object -w --stdin) &&
+	B=$(echo theirside | git hash-object -w --stdin) &&
+	(
+		echo "100644 $A 0	fild" &&
+		echo "100644 $O 1	file" &&
+		echo "100644 $A 2	file" &&
+		echo "100644 $B 3	file" &&
+		echo "100644 $A 0	filf"
+	) | git update-index --index-info &&
+	echo "none of the above" >sample &&
+	echo ourside >expect &&
+	cat sample >fild &&
+	cat sample >file &&
+	cat sample >filf &&
+	git checkout -m -- fild file filf &&
+	(
+		echo "<<<<<<< ours"
+		echo ourside
+		echo "|||||||"
+		echo original
+		echo "======="
+		echo theirside
+		echo ">>>>>>> theirs"
+	) >merged &&
+	test_cmp expect fild &&
+	test_cmp expect filf &&
+	test_cmp merged file
+'
+
 test_done
-- 
1.6.0.1.149.ga4c44
