From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 10/21] git notes merge: Initial implementation handling trivial merges only
Date: Sat,  9 Oct 2010 03:13:28 +0200
Message-ID: <1286586819-3636-11-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:14:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4O16-0003GS-3A
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:14:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281Ab0JIBOX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Oct 2010 21:14:23 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:49295 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759930Ab0JIBOX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:14:23 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4O0y-0001lM-C1; Sat, 09 Oct 2010 03:14:20 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158560>

This initial implementation of 'git notes merge' only handles the trivi=
al
merge cases (i.e. where the merge is either a no-op, or a fast-forward)=
=2E

The patch includes testcases for these trivial merge cases.

=46uture patches will extend the functionality of 'git notes merge'.

This patch has been improved by the following contributions:
- Stephen Boyd: Simplify argc logic
- Stephen Boyd: Use test_commit
- =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: Don't use C99 comments.
- Jonathan Nieder: Add constants for common verbosity values
- Jonathan Nieder: Use trace_printf(...) instead of OUTPUT(o, 5, ...)

Cc: Stephen Boyd <bebarino@gmail.com>
Cc: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile               |    2 +
 builtin/notes.c        |   54 +++++++++++++++++++
 notes-merge.c          |  103 +++++++++++++++++++++++++++++++++++
 notes-merge.h          |   35 ++++++++++++
 t/t3308-notes-merge.sh |  139 ++++++++++++++++++++++++++++++++++++++++=
++++++++
 5 files changed, 333 insertions(+), 0 deletions(-)
 create mode 100644 notes-merge.c
 create mode 100644 notes-merge.h
 create mode 100755 t/t3308-notes-merge.sh

diff --git a/Makefile b/Makefile
index f33648d..14c0ff1 100644
--- a/Makefile
+++ b/Makefile
@@ -503,6 +503,7 @@ LIB_H +=3D mailmap.h
 LIB_H +=3D merge-recursive.h
 LIB_H +=3D notes.h
 LIB_H +=3D notes-cache.h
+LIB_H +=3D notes-merge.h
 LIB_H +=3D object.h
 LIB_H +=3D pack.h
 LIB_H +=3D pack-refs.h
@@ -593,6 +594,7 @@ LIB_OBJS +=3D merge-recursive.o
 LIB_OBJS +=3D name-hash.o
 LIB_OBJS +=3D notes.o
 LIB_OBJS +=3D notes-cache.o
+LIB_OBJS +=3D notes-merge.o
 LIB_OBJS +=3D object.o
 LIB_OBJS +=3D pack-check.o
 LIB_OBJS +=3D pack-refs.o
diff --git a/builtin/notes.c b/builtin/notes.c
index 9c91c59..fbabdc7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -17,6 +17,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "string-list.h"
+#include "notes-merge.h"
=20
 static const char * const git_notes_usage[] =3D {
 	"git notes [--ref <notes_ref>] [list [<object>]]",
@@ -25,6 +26,7 @@ static const char * const git_notes_usage[] =3D {
 	"git notes [--ref <notes_ref>] append [-m <msg> | -F <file> | (-c | -=
C) <object>] [<object>]",
 	"git notes [--ref <notes_ref>] edit [<object>]",
 	"git notes [--ref <notes_ref>] show [<object>]",
+	"git notes [--ref <notes_ref>] merge [-v | -q] <notes_ref>",
 	"git notes [--ref <notes_ref>] remove [<object>]",
 	"git notes [--ref <notes_ref>] prune [-n | -v]",
 	NULL
@@ -61,6 +63,11 @@ static const char * const git_notes_show_usage[] =3D=
 {
 	NULL
 };
=20
+static const char * const git_notes_merge_usage[] =3D {
+	"git notes merge [<options>] <notes_ref>",
+	NULL
+};
+
 static const char * const git_notes_remove_usage[] =3D {
 	"git notes remove [<object>]",
 	NULL
@@ -772,6 +779,51 @@ static int show(int argc, const char **argv, const=
 char *prefix)
 	return retval;
 }
=20
+static int merge(int argc, const char **argv, const char *prefix)
+{
+	struct strbuf remote_ref =3D STRBUF_INIT, msg =3D STRBUF_INIT;
+	unsigned char result_sha1[20];
+	struct notes_merge_options o;
+	int verbosity =3D 0, result;
+	struct option options[] =3D {
+		OPT__VERBOSITY(&verbosity),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, prefix, options,
+			     git_notes_merge_usage, 0);
+
+	if (argc !=3D 1) {
+		error("Must specify a notes ref to merge");
+		usage_with_options(git_notes_merge_usage, options);
+	}
+
+	init_notes_merge_options(&o);
+	o.verbosity =3D verbosity + NOTES_MERGE_VERBOSITY_DEFAULT;
+
+	o.local_ref =3D default_notes_ref();
+	strbuf_addstr(&remote_ref, argv[0]);
+	expand_notes_ref(&remote_ref);
+	o.remote_ref =3D remote_ref.buf;
+
+	result =3D notes_merge(&o, result_sha1);
+
+	strbuf_addf(&msg, "notes: Merged notes from %s into %s",
+		    remote_ref.buf, default_notes_ref());
+	if (result =3D=3D 0) { /* Merge resulted (trivially) in result_sha1 *=
/
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
 	struct option options[] =3D {
@@ -865,6 +917,8 @@ int cmd_notes(int argc, const char **argv, const ch=
ar *prefix)
 		result =3D append_edit(argc, argv, prefix);
 	else if (!strcmp(argv[0], "show"))
 		result =3D show(argc, argv, prefix);
+	else if (!strcmp(argv[0], "merge"))
+		result =3D merge(argc, argv, prefix);
 	else if (!strcmp(argv[0], "remove"))
 		result =3D remove_cmd(argc, argv, prefix);
 	else if (!strcmp(argv[0], "prune"))
diff --git a/notes-merge.c b/notes-merge.c
new file mode 100644
index 0000000..293848a
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
+	o->verbosity =3D NOTES_MERGE_VERBOSITY_DEFAULT;
+}
+
+static int show(struct notes_merge_options *o, int v)
+{
+	return (o->verbosity >=3D v) || o->verbosity >=3D NOTES_MERGE_VERBOSI=
TY_MAX;
+}
+
+#define OUTPUT(o, v, ...) \
+	do { if (show((o), (v))) { printf(__VA_ARGS__); puts(""); } } while (=
0)
+
+int notes_merge(struct notes_merge_options *o,
+		unsigned char *result_sha1)
+{
+	unsigned char local_sha1[20], remote_sha1[20];
+	struct commit *local, *remote;
+	struct commit_list *bases =3D NULL;
+	const unsigned char *base_sha1;
+	int result =3D 0;
+
+	hashclr(result_sha1);
+
+	trace_printf("notes_merge(o->local_ref =3D %s, o->remote_ref =3D %s)"=
,
+	       o->local_ref, o->remote_ref);
+
+	if (!o->local_ref || get_sha1(o->local_ref, local_sha1)) {
+		/* empty notes ref =3D> assume empty notes tree */
+		hashclr(local_sha1);
+		local =3D NULL;
+	} else if (!(local =3D lookup_commit_reference(local_sha1)))
+		die("Could not parse commit '%s'.", o->local_ref);
+	trace_printf("\tlocal commit: %.7s", sha1_to_hex(local_sha1));
+
+	if (!o->remote_ref || get_sha1(o->remote_ref, remote_sha1)) {
+		/* empty notes ref =3D> assume empty notes tree */
+		hashclr(remote_sha1);
+		remote =3D NULL;
+	}
+	if (!(remote =3D lookup_commit_reference(remote_sha1)))
+		die("Could not parse commit '%s'.", o->remote_ref);
+	trace_printf("\tremote commit: %.7s", sha1_to_hex(remote_sha1));
+
+	if (!local) {
+		/* result =3D=3D remote commit */
+		hashcpy(result_sha1, remote_sha1);
+		goto found_result;
+	}
+	if (!remote) {
+		/* result =3D=3D local commit */
+		hashcpy(result_sha1, local_sha1);
+		goto found_result;
+	}
+	assert(local && remote);
+
+	/* Find merge bases */
+	bases =3D get_merge_bases(local, remote, 1);
+	if (!bases) {
+		base_sha1 =3D null_sha1;
+		OUTPUT(o, 4, "No merge base found; doing history-less merge");
+	} else if (!bases->next) {
+		base_sha1 =3D bases->item->object.sha1;
+		OUTPUT(o, 4, "One merge base found (%.7s)",
+		       sha1_to_hex(base_sha1));
+	} else {
+		/* TODO: How to handle multiple merge-bases? */
+		base_sha1 =3D bases->item->object.sha1;
+		OUTPUT(o, 3, "Multiple merge bases found. Using the first "
+		       "(%.7s)", sha1_to_hex(base_sha1));
+	}
+
+	OUTPUT(o, 4, "Merging remote commit %.7s into local commit %.7s with =
"
+	       "merge-base %.7s", sha1_to_hex(remote->object.sha1),
+	       sha1_to_hex(local->object.sha1), sha1_to_hex(base_sha1));
+
+	if (!hashcmp(remote->object.sha1, base_sha1)) {
+		/* Already merged; result =3D=3D local commit */
+		OUTPUT(o, 2, "Already up-to-date!");
+		hashcpy(result_sha1, local->object.sha1);
+		goto found_result;
+	}
+	if (!hashcmp(local->object.sha1, base_sha1)) {
+		/* Fast-forward; result =3D=3D remote commit */
+		OUTPUT(o, 2, "Fast-forward");
+		hashcpy(result_sha1, remote->object.sha1);
+		goto found_result;
+	}
+
+	/* TODO: */
+	result =3D error("notes_merge() cannot yet handle real merges.");
+
+found_result:
+	free_commit_list(bases);
+	trace_printf("notes_merge(): result =3D %i, result_sha1 =3D %.7s",
+	       result, sha1_to_hex(result_sha1));
+	return result;
+}
diff --git a/notes-merge.h b/notes-merge.h
new file mode 100644
index 0000000..bd1e530
--- /dev/null
+++ b/notes-merge.h
@@ -0,0 +1,35 @@
+#ifndef NOTES_MERGE_H
+#define NOTES_MERGE_H
+
+enum notes_merge_verbosity {
+	NOTES_MERGE_VERBOSITY_DEFAULT =3D 2,
+	NOTES_MERGE_VERBOSITY_MAX =3D 5
+};
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
+ * The commits given by the two refs are merged, producing one of the =
following
+ * outcomes:
+ *
+ * 1. The merge trivially results in an existing commit (e.g. fast-for=
ward or
+ *    already-up-to-date). The SHA1 of the result is written into 'res=
ult_sha1'
+ *    and 0 is returned.
+ * 2. The merge fails. result_sha1 is set to null_sha1, and non-zero r=
eturned.
+ *
+ * Either ref (but not both) may not exist in which case the missing r=
ef is
+ * interpreted as an empty notes tree, and the merge trivially results=
 in
+ * what the other ref points to.
+ */
+int notes_merge(struct notes_merge_options *o,
+		unsigned char *result_sha1);
+
+#endif
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
new file mode 100755
index 0000000..0342e37
--- /dev/null
+++ b/t/t3308-notes-merge.sh
@@ -0,0 +1,139 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Johan Herland
+#
+
+test_description=3D'Test merging of notes trees'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	test_commit 1st &&
+	test_commit 2nd &&
+	test_commit 3rd &&
+	test_commit 4th &&
+	test_commit 5th &&
+	# Create notes on 4 first commits
+	git config core.notesRef refs/notes/x &&
+	git notes add -m "Notes on 1st commit" 1st &&
+	git notes add -m "Notes on 2nd commit" 2nd &&
+	git notes add -m "Notes on 3rd commit" 3rd &&
+	git notes add -m "Notes on 4th commit" 4th
+'
+
+commit_sha1=3D$(git rev-parse 1st^{commit})
+commit_sha2=3D$(git rev-parse 2nd^{commit})
+commit_sha3=3D$(git rev-parse 3rd^{commit})
+commit_sha4=3D$(git rev-parse 4th^{commit})
+commit_sha5=3D$(git rev-parse 5th^{commit})
+
+verify_notes () {
+	notes_ref=3D"$1"
+	git -c core.notesRef=3D"refs/notes/$notes_ref" notes |
+		sort >"output_notes_$notes_ref" &&
+	test_cmp "expect_notes_$notes_ref" "output_notes_$notes_ref" &&
+	git -c core.notesRef=3D"refs/notes/$notes_ref" log --format=3D"%H %s%=
n%N" \
+		>"output_log_$notes_ref" &&
+	test_cmp "expect_log_$notes_ref" "output_log_$notes_ref"
+}
+
+cat <<EOF | sort >expect_notes_x
+5e93d24084d32e1cb61f7070505b9d2530cca987 $commit_sha4
+8366731eeee53787d2bdf8fc1eff7d94757e8da0 $commit_sha3
+eede89064cd42441590d6afec6c37b321ada3389 $commit_sha2
+daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 $commit_sha1
+EOF
+
+cat >expect_log_x <<EOF
+$commit_sha5 5th
+
+$commit_sha4 4th
+Notes on 4th commit
+
+$commit_sha3 3rd
+Notes on 3rd commit
+
+$commit_sha2 2nd
+Notes on 2nd commit
+
+$commit_sha1 1st
+Notes on 1st commit
+
+EOF
+
+test_expect_success 'verify initial notes (x)' '
+	verify_notes x
+'
+
+cp expect_notes_x expect_notes_y
+cp expect_log_x expect_log_y
+
+test_expect_success 'merge notes into empty notes ref (x =3D> y)' '
+	git config core.notesRef refs/notes/y &&
+	git notes merge x &&
+	verify_notes y &&
+	# x and y should point to the same notes commit
+	test "$(git rev-parse refs/notes/x)" =3D "$(git rev-parse refs/notes/=
y)"
+'
+
+test_expect_success 'change notes on other notes ref (y)' '
+	# Not touching notes to 1st commit
+	git notes remove 2nd &&
+	git notes append -m "More notes on 3rd commit" 3rd &&
+	git notes add -f -m "New notes on 4th commit" 4th &&
+	git notes add -m "Notes on 5th commit" 5th
+'
+
+cat <<EOF | sort >expect_notes_y
+0f2efbd00262f2fd41dfae33df8765618eeacd99 $commit_sha5
+dec2502dac3ea161543f71930044deff93fa945c $commit_sha4
+4069cdb399fd45463ec6eef8e051a16a03592d91 $commit_sha3
+daa55ffad6cb99bf64226532147ffcaf5ce8bdd1 $commit_sha1
+EOF
+
+cat >expect_log_y <<EOF
+$commit_sha5 5th
+Notes on 5th commit
+
+$commit_sha4 4th
+New notes on 4th commit
+
+$commit_sha3 3rd
+Notes on 3rd commit
+
+More notes on 3rd commit
+
+$commit_sha2 2nd
+
+$commit_sha1 1st
+Notes on 1st commit
+
+EOF
+
+test_expect_success 'verify changed notes on other notes ref (y)' '
+	verify_notes y
+'
+
+test_expect_success 'verify unchanged notes on original notes ref (x)'=
 '
+	verify_notes x
+'
+
+test_expect_success 'merge original notes (x) into changed notes (y) =3D=
> No-op' '
+	git notes merge -vvv x &&
+	verify_notes y &&
+	verify_notes x
+'
+
+cp expect_notes_y expect_notes_x
+cp expect_log_y expect_log_x
+
+test_expect_success 'merge changed (y) into original (x) =3D> Fast-for=
ward' '
+	git config core.notesRef refs/notes/x &&
+	git notes merge y &&
+	verify_notes x &&
+	verify_notes y &&
+	# x and y should point to same the notes commit
+	test "$(git rev-parse refs/notes/x)" =3D "$(git rev-parse refs/notes/=
y)"
+'
+
+test_done
--=20
1.7.3.1.104.g92b87a
