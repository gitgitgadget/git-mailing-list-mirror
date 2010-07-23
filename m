From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 09/13] git notes merge: Initial implementation handling
 trivial merges only
Date: Fri, 23 Jul 2010 12:15:00 +0200
Message-ID: <1279880104-29796-10-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFIa-0001FC-DW
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:16:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756216Ab0GWKPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:42 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756083Ab0GWKPX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:23 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000GA79TBM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:11 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 8A2A51EA54DC_C496BAFB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:11 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3E67D1EA3EBF_C496BAFF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:11 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:11 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151522>

This initial implementation of 'git notes merge' only handles the trivial
merge cases (i.e. where the merge is either a no-op, or a fast-forward).

The patch includes testcases for these trivial merge cases.

Future patches will extend the functionality of 'git notes merge'.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile               |    2 +
 builtin/notes.c        |   56 +++++++++
 notes-merge.c          |  103 ++++++++++++++++
 notes-merge.h          |   30 +++++
 t/t3308-notes-merge.sh |  313 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 504 insertions(+), 0 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh

diff --git a/Makefile b/Makefile
index bc3c570..8a2a767 100644
--- a/Makefile
+++ b/Makefile
@@ -503,6 +503,7 @@ LIB_H += mailmap.h
 LIB_H += merge-recursive.h
 LIB_H += notes.h
 LIB_H += notes-cache.h
+LIB_H += notes-merge.h
 LIB_H += object.h
 LIB_H += pack.h
 LIB_H += pack-refs.h
@@ -593,6 +594,7 @@ LIB_OBJS += merge-recursive.o
 LIB_OBJS += name-hash.o
 LIB_OBJS += notes.o
 LIB_OBJS += notes-cache.o
+LIB_OBJS += notes-merge.o
 LIB_OBJS += object.o
 LIB_OBJS += pack-check.o
 LIB_OBJS += pack-refs.o
diff --git a/builtin/notes.c b/builtin/notes.c
index e19042c..3a15666 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -17,6 +17,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "notes-merge.h"
 
 static const char * const git_notes_usage[] = {
 	"git notes [--ref <notes_ref>] [list [<object>]]",
@@ -25,6 +26,7 @@ static const char * const git_notes_usage[] = {
 	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]",
 	"git notes [--ref <notes_ref>] edit [<object>]",
 	"git notes [--ref <notes_ref>] show [<object>]",
+	"git notes [--ref <notes_ref>] merge [-v | -q] <notes_ref>",
 	"git notes [--ref <notes_ref>] remove [<object>]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
 	NULL
@@ -61,6 +63,11 @@ static const char * const git_notes_show_usage[] = {
 	NULL
 };
 
+static const char * const git_notes_merge_usage[] = {
+	"git notes merge [<options>] <notes_ref>",
+	NULL
+};
+
 static const char * const git_notes_remove_usage[] = {
 	"git notes remove [<object>]",
 	NULL
@@ -774,6 +781,53 @@ static int show(int argc, const char **argv, const char *prefix)
 	return retval;
 }
 
+static int merge(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf remote_ref = STRBUF_INIT, msg = STRBUF_INIT;
+	unsigned char result_sha1[20];
+	struct notes_merge_options o;
+	int verbosity = 0, result;
+	struct option options[] = {
+		OPT__VERBOSITY(&verbosity),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_notes_merge_usage, 0);
+
+	if (1 < argc) {
+		error("too many parameters");
+		usage_with_options(git_notes_merge_usage, options);
+	} else if (1 > argc) {
+		error("too few parameters");
+		usage_with_options(git_notes_merge_usage, options);
+	}
+
+	init_notes_merge_options(&o);
+	o.verbosity = verbosity + 2; // default verbosity level is 2
+	o.local_ref = default_notes_ref();
+	strbuf_addstr(&remote_ref, argv[0]);
+	expand_notes_ref(&remote_ref);
+	o.remote_ref = remote_ref.buf;
+
+	result = notes_merge(&o, result_sha1);
+
+	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
+		    remote_ref.buf, default_notes_ref());
+	if (result == 0) { /* Merge resulted (trivially) in result_sha1 */
+		/* Update default notes ref with new commit */
+		update_ref(msg.buf, default_notes_ref(), result_sha1, NULL,
+			   0, DIE_ON_ERR);
+	} else {
+		/* TODO: */
+		die("'git notes merge' cannot yet handle non-trivial merges!");
+	}
+
+	strbuf_release(&remote_ref);
+	strbuf_release(&msg);
+	return 0;
+}
+
 static int remove_cmd(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] = {
@@ -866,6 +920,8 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		result = append_edit(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		result = show(argc, argv, prefix);
+	else if (!strcmp(argv[0], "merge"))
+		result = merge(argc, argv, prefix);
 	else if (!strcmp(argv[0], "remove"))
 		result = remove_cmd(argc, argv, prefix);
 	else if (!strcmp(argv[0], "prune"))
diff --git a/notes-merge.c b/notes-merge.c
new file mode 100644
index 0000000..5461827
--- /dev/null
+++ b/notes-merge.c
@@ -0,0 +1,103 @@
+#include "cache.h"
+#include "commit.h"
+#include "notes-merge.h"
+
+void init_notes_merge_options(struct notes_merge_options *o)
+{
+	memset(o, 0, sizeof(struct notes_merge_options));
+	o->verbosity = 2;
+}
+
+static int show(struct notes_merge_options *o, int v)
+{
+	return (o->verbosity >= v) || o->verbosity >= 5;
+}
+
+#define OUTPUT(o, v, ...) \
+	do { if (show((o), (v))) { printf(__VA_ARGS__); puts(""); } } while (0)
+
+int notes_merge(struct notes_merge_options *o,
+		unsigned char *result_sha1)
+{
+	unsigned char local_sha1[20], remote_sha1[20];
+	struct commit *local, *remote;
+	struct commit_list *bases = NULL;
+	const unsigned char *base_sha1;
+	int result = 0;
+
+	hashclr(result_sha1);
+
+	OUTPUT(o, 5, "notes_merge(o->local_ref = %s, o->remote_ref = %s)",
+	       o->local_ref, o->remote_ref);
+
+	if (!o->local_ref || get_sha1(o->local_ref, local_sha1)) {
+		/* empty notes ref => assume empty notes tree */
+		hashclr(local_sha1);
+		local = NULL;
+	} else if (!(local = lookup_commit_reference(local_sha1)))
+		die("Could not parse commit '%s'.", o->local_ref);
+	OUTPUT(o, 5, "\tlocal commit: %.7s", sha1_to_hex(local_sha1));
+
+	if (!o->remote_ref || get_sha1(o->remote_ref, remote_sha1)) {
+		/* empty notes ref => assume empty notes tree */
+		hashclr(remote_sha1);
+		remote = NULL;
+	}
+	if (!(remote = lookup_commit_reference(remote_sha1)))
+		die("Could not parse commit '%s'.", o->remote_ref);
+	OUTPUT(o, 5, "\tremote commit: %.7s", sha1_to_hex(remote_sha1));
+
+	if (!local) {
+		/* result == remote commit */
+		hashcpy(result_sha1, remote_sha1);
+		goto found_result;
+	}
+	if (!remote) {
+		/* result == local commit */
+		hashcpy(result_sha1, local_sha1);
+		goto found_result;
+	}
+	assert(local && remote);
+
+	/* Find merge bases */
+	bases = get_merge_bases(local, remote, 1);
+	if (!bases) {
+		base_sha1 = null_sha1;
+		OUTPUT(o, 4, "No merge base found; doing history-less merge");
+	} else if (!bases->next) {
+		base_sha1 = bases->item->object.sha1;
+		OUTPUT(o, 4, "One merge base found (%.7s)",
+		       sha1_to_hex(base_sha1));
+	} else {
+		/* TODO: How to handle multiple merge-bases? */
+		base_sha1 = bases->item->object.sha1;
+		OUTPUT(o, 3, "Multiple merge bases found. Using the first "
+		       "(%.7s)", sha1_to_hex(base_sha1));
+	}
+
+	OUTPUT(o, 4, "Merging remote commit %.7s into local commit %.7s with "
+	       "merge-base %.7s", sha1_to_hex(remote->object.sha1),
+	       sha1_to_hex(local->object.sha1), sha1_to_hex(base_sha1));
+
+	if (!hashcmp(remote->object.sha1, base_sha1)) {
+		/* Already merged; result == local commit */
+		OUTPUT(o, 2, "Already up-to-date!");
+		hashcpy(result_sha1, local->object.sha1);
+		goto found_result;
+	}
+	if (!hashcmp(local->object.sha1, base_sha1)) {
+		/* Fast-forward; result == remote commit */
+		OUTPUT(o, 2, "Fast-forward");
+		hashcpy(result_sha1, remote->object.sha1);
+		goto found_result;
+	}
+
+	/* TODO: */
+	result = error("notes_merge() cannot yet handle real merges.");
+
+found_result:
+	free_commit_list(bases);
+	OUTPUT(o, 5, "notes_merge(): result = %i, result_sha1 = %.7s",
+	       result, sha1_to_hex(result_sha1));
+	return result;
+}
diff --git a/notes-merge.h b/notes-merge.h
new file mode 100644
index 0000000..c4416e1
--- /dev/null
+++ b/notes-merge.h
@@ -0,0 +1,30 @@
+#ifndef NOTES_MERGE_H
+#define NOTES_MERGE_H
+
+struct notes_merge_options {
+	const char *local_ref;
+	const char *remote_ref;
+	int verbosity;
+};
+
+void init_notes_merge_options(struct notes_merge_options *o);
+
+/*
+ * Merge notes from o->remote_ref into o->local_ref
+ *
+ * The commits given by the two refs are merged, producing one of the following
+ * outcomes:
+ *
+ * 1. The merge trivially results in an existing commit (e.g. fast-forward or
+ *    already-up-to-date). The SHA1 of the result is written into 'result_sha1'
+ *    and 0 is returned.
+ * 2. The merge fails. result_sha1 is set to null_sha1, and non-zero returned.
+ *
+ * Either ref (but not both) may not exist in which case the missing ref is
+ * interpreted as an empty notes tree, and the merge trivially results in
+ * what the other ref points to.
+ */
+int notes_merge(struct notes_merge_options *o,
+		unsigned char *result_sha1);
+
+#endif
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
new file mode 100755
index 0000000..a89fd11
--- /dev/null
+++ b/t/t3308-notes-merge.sh
@@ -0,0 +1,313 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Johan Herland
+#
+
+test_description='Test merging of notes trees'
+
+. ./test-lib.sh
+
+whitespace="    "
+
+test_expect_success setup '
+	git config core.notesRef refs/notes/x &&
+	: > a1 &&
+	git add a1 &&
+	test_tick &&
+	git commit -m 1st &&
+	git notes add -m "Notes on 1st commit" &&
+	: > a2 &&
+	git add a2 &&
+	test_tick &&
+	git commit -m 2nd &&
+	git notes add -m "Notes on 2nd commit" &&
+	: > a3 &&
+	git add a3 &&
+	test_tick &&
+	git commit -m 3rd &&
+	git notes add -m "Notes on 3rd commit" &&
+	: > a4 &&
+	git add a4 &&
+	test_tick &&
+	git commit -m 4th &&
+	git notes add -m "Notes on 4th commit" &&
+	: > a5 &&
+	git add a5 &&
+	test_tick &&
+	git commit -m 5th
+'
+
+cat >expect_notes_x <<EOF
+5e93d24084d32e1cb61f7070505b9d2530cca987 15023535574ded8b1a89052b32673f84cf9582b8
+8366731eeee53787d2bdf8fc1eff7d94757e8da0 1584215f1d29c65e99c6c6848626553fdd07fd75
+eede89064cd42441590d6afec6c37b321ada3389 268048bfb8a1fb38e703baceb8ab235421bf80c5
+daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 34b09d6ffa51a8a03203627f0e369f607227364f
+EOF
+
+cat >expect_log_x <<EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+
+Notes (x):
+    Notes on 4th commit
+
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes (x):
+    Notes on 3rd commit
+
+commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+Notes (x):
+    Notes on 2nd commit
+
+commit 34b09d6ffa51a8a03203627f0e369f607227364f
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    1st
+
+Notes (x):
+    Notes on 1st commit
+EOF
+
+test_expect_success 'verify initial notes (x)' '
+	git notes >output_notes_x &&
+	test_cmp expect_notes_x output_notes_x &&
+	git log >output_log_x &&
+	test_cmp expect_log_x output_log_x
+'
+
+cp expect_notes_x expect_notes_y
+
+cat >expect_log_y <<EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+
+Notes (y):
+    Notes on 4th commit
+
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes (y):
+    Notes on 3rd commit
+
+commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+Notes (y):
+    Notes on 2nd commit
+
+commit 34b09d6ffa51a8a03203627f0e369f607227364f
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    1st
+
+Notes (y):
+    Notes on 1st commit
+EOF
+
+test_expect_success 'merge notes into empty notes ref (x => y)' '
+	git config core.notesRef refs/notes/y &&
+	git notes merge x &&
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log >output_log_y &&
+	test_cmp expect_log_y output_log_y &&
+	# x and y should point to the same notes commit
+	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
+'
+
+test_expect_success 'change notes on other notes ref (y)' '
+	# Leave notes to 1st commit alone
+	# Remove notes from 2nd commit
+	git notes remove HEAD~3 &&
+	# Append to 3rd commit notes
+	git notes append -m "More notes on 3rd commit" HEAD~2 &&
+	# Replace 4th commit notes
+	git notes add -f -m "New notes on 4th commit" HEAD^ &&
+	# Add new notes to 5th commit
+	git notes add -m "Notes on 5th commit" HEAD
+'
+
+cat >expect_notes_y <<EOF
+dec2502dac3ea161543f71930044deff93fa945c 15023535574ded8b1a89052b32673f84cf9582b8
+4069cdb399fd45463ec6eef8e051a16a03592d91 1584215f1d29c65e99c6c6848626553fdd07fd75
+daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 34b09d6ffa51a8a03203627f0e369f607227364f
+0f2efbd00262f2fd41dfae33df8765618eeacd99 bd1753200303d0a0344be813e504253b3d98e74d
+EOF
+
+cat >expect_log_y <<EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+Notes (y):
+    Notes on 5th commit
+
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+
+Notes (y):
+    New notes on 4th commit
+
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes (y):
+    Notes on 3rd commit
+$whitespace
+    More notes on 3rd commit
+
+commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+commit 34b09d6ffa51a8a03203627f0e369f607227364f
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    1st
+
+Notes (y):
+    Notes on 1st commit
+EOF
+
+test_expect_success 'verify changed notes on other notes ref (y)' '
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log >output_log_y &&
+	test_cmp expect_log_y output_log_y
+'
+
+test_expect_success 'verify unchanged notes on original notes ref (x)' '
+	GIT_NOTES_REF=refs/notes/x git notes >output_notes_x &&
+	test_cmp expect_notes_x output_notes_x &&
+	GIT_NOTES_REF=refs/notes/x git log >output_log_x &&
+	test_cmp expect_log_x output_log_x
+'
+
+test_expect_success 'merge original notes (x) into changed notes (y) => No-op' '
+	git notes merge x &&
+	# Verify that nothing changed on notes ref (y)
+	git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	git log >output_log_y &&
+	test_cmp expect_log_y output_log_y &&
+	# Also verify that nothing changed on original notes ref (x)
+	GIT_NOTES_REF=refs/notes/x git notes >output_notes_x &&
+	test_cmp expect_notes_x output_notes_x &&
+	GIT_NOTES_REF=refs/notes/x git log >output_log_x &&
+	test_cmp expect_log_x output_log_x
+'
+
+cp expect_notes_y expect_notes_x
+
+cat >expect_log_x <<EOF
+commit bd1753200303d0a0344be813e504253b3d98e74d
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:17:13 2005 -0700
+
+    5th
+
+Notes (x):
+    Notes on 5th commit
+
+commit 15023535574ded8b1a89052b32673f84cf9582b8
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:16:13 2005 -0700
+
+    4th
+
+Notes (x):
+    New notes on 4th commit
+
+commit 1584215f1d29c65e99c6c6848626553fdd07fd75
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:15:13 2005 -0700
+
+    3rd
+
+Notes (x):
+    Notes on 3rd commit
+$whitespace
+    More notes on 3rd commit
+
+commit 268048bfb8a1fb38e703baceb8ab235421bf80c5
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:14:13 2005 -0700
+
+    2nd
+
+commit 34b09d6ffa51a8a03203627f0e369f607227364f
+Author: A U Thor <author@example.com>
+Date:   Thu Apr 7 15:13:13 2005 -0700
+
+    1st
+
+Notes (x):
+    Notes on 1st commit
+EOF
+
+test_expect_success 'merge changed (y) into original (x) => Fast-forward' '
+	git config core.notesRef refs/notes/x &&
+	git notes merge y &&
+	# Verify new state of notes on notes ref (x)
+	git notes >output_notes_x &&
+	test_cmp expect_notes_x output_notes_x &&
+	git log >output_log_x &&
+	test_cmp expect_log_x output_log_x &&
+	# Also verify that nothing changed on other notes ref (y)
+	GIT_NOTES_REF=refs/notes/y git notes >output_notes_y &&
+	test_cmp expect_notes_y output_notes_y &&
+	GIT_NOTES_REF=refs/notes/y git log >output_log_y &&
+	test_cmp expect_log_y output_log_y &&
+	# x and y should point to same the notes commit
+	test "$(git rev-parse refs/notes/x)" = "$(git rev-parse refs/notes/y)"
+'
+
+test_done
-- 
1.7.2.220.gea1d3
