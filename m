From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/6] builtin-reset.c: use reset_index_and_worktree()
Date: Fri,  5 Dec 2008 17:54:15 -0800
Message-ID: <1228528455-3089-7-git-send-email-gitster@pobox.com>
References: <1228528455-3089-1-git-send-email-gitster@pobox.com>
 <1228528455-3089-2-git-send-email-gitster@pobox.com>
 <1228528455-3089-3-git-send-email-gitster@pobox.com>
 <1228528455-3089-4-git-send-email-gitster@pobox.com>
 <1228528455-3089-5-git-send-email-gitster@pobox.com>
 <1228528455-3089-6-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 06 02:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8mP6-0005m7-03
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 02:56:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756036AbYLFByn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2008 20:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755935AbYLFBym
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Dec 2008 20:54:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61905 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015AbYLFByf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2008 20:54:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 05B4218321
	for <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2B0BB1830E for
 <git@vger.kernel.org>; Fri,  5 Dec 2008 20:54:33 -0500 (EST)
X-Mailer: git-send-email 1.6.1.rc1.72.ga5ce6
In-Reply-To: <1228528455-3089-6-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D4FFEF42-C338-11DD-981D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102438>

This makes "git reset --merge" to use the same underlying mechanism "git
checkout" uses to update the index and the work tree.

It is possible to make it use the 3-way merge fallback "git checkout -m"
allows, but this commit does not go there yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-checkout.c |    1 +
 builtin-reset.c    |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 reset.h            |   11 ++++++++
 3 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 reset.h

diff --git a/builtin-checkout.c b/builtin-checkout.c
index a08941a..d196521 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -16,6 +16,7 @@
 #include "blob.h"
 #include "xdiff-interface.h"
 #include "ll-merge.h"
+#include "reset.h"
 
 static const char * const checkout_usage[] = {
 	"git checkout [options] <branch>",
diff --git a/builtin-reset.c b/builtin-reset.c
index c0cb915..481a1cc 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -18,6 +18,7 @@
 #include "tree.h"
 #include "branch.h"
 #include "parse-options.h"
+#include "reset.h"
 
 static const char * const git_reset_usage[] = {
 	"git reset [--mixed | --soft | --hard | --merge] [-q] [<commit>]",
@@ -52,7 +53,7 @@ static inline int is_merge(void)
 	return !access(git_path("MERGE_HEAD"), F_OK);
 }
 
-static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet)
+static int reset_index_file_via_read_tree(const unsigned char *sha1, int reset_type, int quiet)
 {
 	int i = 0;
 	const char *args[6];
@@ -77,6 +78,67 @@ static int reset_index_file(const unsigned char *sha1, int reset_type, int quiet
 	return run_command_v_opt(args, RUN_GIT_CMD);
 }
 
+static int reset_index_file(struct commit *new, int reset_type, int quiet)
+{
+	/*
+	 * SOFT reset won't even touch index nor work tree so
+	 * this function is not called.
+	 * MIXED updates the index only (should have been called
+	 * --cached), and we let "git read-tree" to do so.
+	 * HARD and MERGE corresponds to "checkout -f" and "checkout [-m]"
+	 */
+	int merge, wt_error, ret;
+	struct commit *old;
+	unsigned char head_sha1[20];
+	unsigned char *new_sha1 = new->object.sha1;
+	struct lock_file *lock_file;
+	int newfd;
+
+	/*
+	 * We play lazy and let read-tree complain if HEAD is not
+	 * readable.  Also on hard reset, HEAD does not have to be
+	 * readable.
+	 */
+	if (reset_type == MIXED ||
+	    reset_type == HARD ||
+	    get_sha1("HEAD", head_sha1) ||
+	    !(old = lookup_commit_reference_gently(head_sha1, 1)))
+		return reset_index_file_via_read_tree(new_sha1, reset_type,
+						      quiet);
+
+	lock_file = xcalloc(1, sizeof(struct lock_file));
+	newfd = hold_locked_index(lock_file, 1);
+	if (read_cache() < 0) {
+		rollback_lock_file(lock_file);
+		return reset_index_file_via_read_tree(new_sha1, reset_type,
+						      quiet);
+	}
+
+	/*
+	 * If we want "checkout -m" behaviour of falling back to
+	 * the 3-way content level merges, we could use
+	 *
+	 *	 merge = (reset_type == MERGE);
+	 *
+	 * here.
+	 */
+	merge = 0;
+
+	wt_error = 0;
+	ret = reset_index_and_worktree(0, merge, quiet, &wt_error,
+				       old, "local",
+				       new, "reset");
+	if (ret || wt_error) {
+		rollback_lock_file(lock_file);
+		return -1;
+	}
+
+	if (write_cache(newfd, active_cache, active_nr) ||
+	    commit_locked_index(lock_file))
+		return error("unable to write new index file");
+	return 0;
+}
+
 static void print_new_head_line(struct commit *commit)
 {
 	const char *hex, *body;
@@ -276,7 +338,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		if (is_merge() || read_cache() < 0 || unmerged_cache())
 			die("Cannot do a soft reset in the middle of a merge.");
 	}
-	else if (reset_index_file(sha1, reset_type, quiet))
+	else if (reset_index_file(commit, reset_type, quiet))
 		die("Could not reset index file to revision '%s'.", rev);
 
 	/* Any resets update HEAD to the head being switched to,
diff --git a/reset.h b/reset.h
new file mode 100644
index 0000000..9c42838
--- /dev/null
+++ b/reset.h
@@ -0,0 +1,11 @@
+#ifndef RESET_H
+#define RESET_H
+
+extern int reset_index_and_worktree(int force, int merge, int quiet,
+				    int *wt_error,
+				    struct commit *old_commit,
+				    const char *old_label,
+				    struct commit *new_commit,
+				    const char *new_label);
+
+#endif
-- 
1.6.1.rc1.72.ga5ce6
