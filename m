From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/4] Add new "git replace" command
Date: Mon, 2 Feb 2009 06:12:44 +0100
Message-ID: <20090202061244.a621db43.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 06:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTr8r-0005cZ-JL
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 06:14:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbZBBFNG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2009 00:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbZBBFNF
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 00:13:05 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:36739 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbZBBFNC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 00:13:02 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id BD086940053;
	Mon,  2 Feb 2009 06:12:54 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with SMTP id 81A22940024;
	Mon,  2 Feb 2009 06:12:51 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.11; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108049>

This command can only be used now to list replace refs in
"refs/replace/" and to delete them.

The option to list replace refs is "-l".
The option to delete replace refs is "-d".

The behavior should be consistent with how "git tag" and "git branch"
are working.

The code has been copied from "builtin-tag.c" by Kristian H=F8gsberg
<krh@redhat.com> and Carlos Rica <jasampler@gmail.com> that was itself
based on git-tag.sh and mktag.c by Linus Torvalds.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile           |    1 +
 builtin-replace.c  |  105 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 builtin.h          |    1 +
 git.c              |    1 +
 t/t6050-replace.sh |   12 ++++++
 5 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 builtin-replace.c

	This patch series comes on top of my previous "replace" series in pu.
	It should make it easier to test and use the previous code.
	But there is no documentation yet for the new "git replace" command
	introduced in this series.

diff --git a/Makefile b/Makefile
index 9f91013..ee28569 100644
--- a/Makefile
+++ b/Makefile
@@ -570,6 +570,7 @@ BUILTIN_OBJS +=3D builtin-read-tree.o
 BUILTIN_OBJS +=3D builtin-receive-pack.o
 BUILTIN_OBJS +=3D builtin-reflog.o
 BUILTIN_OBJS +=3D builtin-remote.o
+BUILTIN_OBJS +=3D builtin-replace.o
 BUILTIN_OBJS +=3D builtin-rerere.o
 BUILTIN_OBJS +=3D builtin-reset.o
 BUILTIN_OBJS +=3D builtin-rev-list.o
diff --git a/builtin-replace.c b/builtin-replace.c
new file mode 100644
index 0000000..b5c40aa
--- /dev/null
+++ b/builtin-replace.c
@@ -0,0 +1,105 @@
+/*
+ * Builtin "git replace"
+ *
+ * Copyright (c) 2008 Christian Couder <chriscool@tuxfamily.org>
+ *
+ * Based on builtin-tag.c by Kristian H=C3=B8gsberg <krh@redhat.com>
+ * and Carlos Rica <jasampler@gmail.com> that was itself based on
+ * git-tag.sh and mktag.c by Linus Torvalds.
+ */
+
+#include "cache.h"
+#include "builtin.h"
+#include "refs.h"
+#include "parse-options.h"
+
+static const char * const git_replace_usage[] =3D {
+	"git replace -d <object>...",
+	"git replace -l [<pattern>]",
+	NULL
+};
+
+static int show_reference(const char *refname, const unsigned char *sh=
a1,
+			  int flag, void *cb_data)
+{
+	const char *pattern =3D cb_data;
+
+	if (!fnmatch(pattern, refname, 0))
+		printf("%s\n", refname);
+
+	return 0;
+}
+
+static int list_replace_refs(const char *pattern)
+{
+	if (pattern =3D=3D NULL)
+		pattern =3D "*";
+
+	for_each_replace_ref(show_reference, (void *) pattern);
+
+	return 0;
+}
+
+typedef int (*each_replace_name_fn)(const char *name, const char *ref,
+				    const unsigned char *sha1);
+
+static int for_each_replace_name(const char **argv, each_replace_name_=
fn fn)
+{
+	const char **p;
+	char ref[PATH_MAX];
+	int had_error =3D 0;
+	unsigned char sha1[20];
+
+	for (p =3D argv; *p; p++) {
+		if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
+					>=3D sizeof(ref)) {
+			error("replace ref name too long: %.*s...", 50, *p);
+			had_error =3D 1;
+			continue;
+		}
+		if (!resolve_ref(ref, sha1, 1, NULL)) {
+			error("replace ref '%s' not found.", *p);
+			had_error =3D 1;
+			continue;
+		}
+		if (fn(*p, ref, sha1))
+			had_error =3D 1;
+	}
+	return had_error;
+}
+
+static int delete_replace_ref(const char *name, const char *ref,
+			      const unsigned char *sha1)
+{
+	if (delete_ref(ref, sha1, 0))
+		return 1;
+	printf("Deleted replace ref '%s'\n", name);
+	return 0;
+}
+
+int cmd_replace(int argc, const char **argv, const char *prefix)
+{
+	int list =3D 0, delete =3D 0;
+	struct option options[] =3D {
+		OPT_BOOLEAN('l', NULL, &list, "list replace refs"),
+		OPT_BOOLEAN('d', NULL, &delete, "delete replace refs"),
+		OPT_END()
+	};
+
+	argc =3D parse_options(argc, argv, options, git_replace_usage, 0);
+
+	if (list && delete)
+		usage_with_options(git_replace_usage, options);
+
+	if (delete) {
+		if (argc < 1)
+			usage_with_options(git_replace_usage, options);
+		return for_each_replace_name(argv, delete_replace_ref);
+	}
+
+	/* List refs, even if "list" is not set */
+	if (argc > 1)
+		usage_with_options(git_replace_usage, options);
+
+	return list_replace_refs(argv[0]);
+}
diff --git a/builtin.h b/builtin.h
index 1495cf6..70c5daf 100644
--- a/builtin.h
+++ b/builtin.h
@@ -110,5 +110,6 @@ extern int cmd_write_tree(int argc, const char **ar=
gv, const char *prefix);
 extern int cmd_verify_pack(int argc, const char **argv, const char *pr=
efix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefi=
x);
 extern int cmd_pack_refs(int argc, const char **argv, const char *pref=
ix);
+extern int cmd_replace(int argc, const char **argv, const char *prefix=
);
=20
 #endif
diff --git a/git.c b/git.c
index c2b181e..92d47b0 100644
--- a/git.c
+++ b/git.c
@@ -335,6 +335,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "receive-pack", cmd_receive_pack },
 		{ "reflog", cmd_reflog, RUN_SETUP },
 		{ "remote", cmd_remote, RUN_SETUP },
+		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 17f6063..bf4c93f 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -105,6 +105,18 @@ test_expect_success 'repack, clone and fetch work'=
 '
      cd ..
 '
=20
+test_expect_success '"git replace" listing and deleting' '
+     test "$HASH2" =3D "$(git replace -l)" &&
+     test "$HASH2" =3D "$(git replace)" &&
+     aa=3D${HASH2%??????????????????????????????????????} &&
+     test "$HASH2" =3D "$(git replace -l "$aa*")" &&
+     test_must_fail git replace -d $R &&
+     test_must_fail git replace -d &&
+     test_must_fail git replace -l -d $HASH2 &&
+     git replace -d $HASH2 &&
+     test -z "$(git replace -l)"
+'
+
 #
 #
 test_done
--=20
1.6.1.2.353.g99fdd.dirty
