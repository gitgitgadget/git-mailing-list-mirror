From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Move option parsing code to parse-options.[ch].
Date: Fri, 21 Sep 2007 15:01:17 -0400
Message-ID: <1190401278-2869-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 21:01:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYnl6-0007GR-2T
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 21:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761662AbXIUTBk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Sep 2007 15:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761617AbXIUTBk
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 15:01:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761469AbXIUTBj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 15:01:39 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8LJ1WNw008224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 21 Sep 2007 15:01:33 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LJ1QNu003017;
	Fri, 21 Sep 2007 15:01:26 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8LJ1NJJ030677;
	Fri, 21 Sep 2007 15:01:23 -0400
X-Mailer: git-send-email 1.5.3.2.1057.gbde3-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58868>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile         |    2 +-
 builtin-commit.c |  117 ++++++++--------------------------------------=
--------
 parse-options.c  |   74 ++++++++++++++++++++++++++++++++++
 parse-options.h  |   29 +++++++++++++
 4 files changed, 121 insertions(+), 101 deletions(-)
 create mode 100644 parse-options.c
 create mode 100644 parse-options.h

diff --git a/Makefile b/Makefile
index 69ebc7a..2612465 100644
--- a/Makefile
+++ b/Makefile
@@ -310,7 +310,7 @@ LIB_OBJS =3D \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o remote.o =
\
-	transport.o bundle.o
+	transport.o bundle.o parse-options.o
=20
 BUILTIN_OBJS =3D \
 	builtin-add.o \
diff --git a/builtin-commit.c b/builtin-commit.c
index 3e826ca..90f23de 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -18,6 +18,7 @@
 #include "log-tree.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "parse-options.h"
=20
 static const char builtin_commit_usage[] =3D
 	"[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <log=
file> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--te=
mplate <file>] [[-i | -o] <path>...]";
@@ -27,90 +28,6 @@ static char *use_message_buffer;
 static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
 static struct lock_file lock_file;
=20
-enum option_type {
-    OPTION_NONE,
-    OPTION_STRING,
-    OPTION_INTEGER,
-    OPTION_LAST,
-};
-
-struct option {
-    enum option_type type;
-    const char *long_name;
-    char short_name;
-    void *value;
-};
-
-static int scan_options(const char ***argv, struct option *options)
-{
-	const char *value, *eq;
-	int i;
-
-	if (**argv =3D=3D NULL)
-		return 0;
-	if ((**argv)[0] !=3D '-')
-		return 0;
-	if (!strcmp(**argv, "--"))
-		return 0;
-
-	value =3D NULL;
-	for (i =3D 0; options[i].type !=3D OPTION_LAST; i++) {
-		if ((**argv)[1] =3D=3D '-') {
-			if (!prefixcmp(options[i].long_name, **argv + 2)) {
-				if (options[i].type !=3D OPTION_NONE)
-					value =3D *++(*argv);
-				goto match;
-			}
-
-			eq =3D strchr(**argv + 2, '=3D');
-			if (eq && options[i].type !=3D OPTION_NONE &&
-			    !strncmp(**argv + 2,
-				     options[i].long_name, eq - **argv - 2)) {
-				value =3D eq + 1;
-				goto match;
-			}
-		}
-
-		if ((**argv)[1] =3D=3D options[i].short_name) {
-			if ((**argv)[2] =3D=3D '\0') {
-				if (options[i].type !=3D OPTION_NONE)
-					value =3D *++(*argv);
-				goto match;
-			}
-
-			if (options[i].type !=3D OPTION_NONE) {
-				value =3D **argv + 2;
-				goto match;
-			}
-		}
-	}
-
-	usage(builtin_commit_usage);
-
- match:
-	switch (options[i].type) {
-	case OPTION_NONE:
-		*(int *)options[i].value =3D 1;
-		break;
-	case OPTION_STRING:
-		if (value =3D=3D NULL)
-			die("option %s requires a value.", (*argv)[-1]);
-		*(const char **)options[i].value =3D value;
-		break;
-	case OPTION_INTEGER:
-		if (value =3D=3D NULL)
-			die("option %s requires a value.", (*argv)[-1]);
-		*(int *)options[i].value =3D atoi(value);
-		break;
-	default:
-		assert(0);
-	}
-
-	(*argv)++;
-
-	return 1;
-}
-
 static char *logfile, *force_author, *message, *template_file;
 static char *edit_message, *use_message;
 static int all, edit_flag, also, interactive, only, no_verify, amend, =
signoff;
@@ -120,24 +37,23 @@ static int no_edit, initial_commit, in_merge;
 const char *only_include_assumed;
=20
 static struct option commit_options[] =3D {
-	{ OPTION_STRING, "file", 'F', (void *) &logfile },
-	{ OPTION_NONE, "all", 'a', &all },
-	{ OPTION_STRING, "author", 0, (void *) &force_author },
-	{ OPTION_NONE, "edit", 'e', &edit_flag },
-	{ OPTION_NONE, "include", 'i', &also },
-	{ OPTION_NONE, "interactive", 0, &interactive },
-	{ OPTION_NONE, "only", 'o', &only },
+	{ OPTION_STRING, "file", 'F', &logfile },
+	{ OPTION_BOOLEAN, "all", 'a', &all },
+	{ OPTION_STRING, "author", 0, &force_author },
+	{ OPTION_BOOLEAN, "edit", 'e', &edit_flag },
+	{ OPTION_BOOLEAN, "include", 'i', &also },
+	{ OPTION_BOOLEAN, "interactive", 0, &interactive },
+	{ OPTION_BOOLEAN, "only", 'o', &only },
 	{ OPTION_STRING, "message", 'm', &message },
-	{ OPTION_NONE, "no-verify", 'n', &no_verify },
-	{ OPTION_NONE, "amend", 0, &amend },
+	{ OPTION_BOOLEAN, "no-verify", 'n', &no_verify },
+	{ OPTION_BOOLEAN, "amend", 0, &amend },
 	{ OPTION_STRING, "reedit-message", 'c', &edit_message },
 	{ OPTION_STRING, "reuse-message", 'C', &use_message },
-	{ OPTION_NONE, "signoff", 's', &signoff },
-	{ OPTION_NONE, "quiet", 'q', &quiet },
-	{ OPTION_NONE, "verbose", 'v', &verbose },
-	{ OPTION_NONE, "untracked-files", 0, &untracked_files },
+	{ OPTION_BOOLEAN, "signoff", 's', &signoff },
+	{ OPTION_BOOLEAN, "quiet", 'q', &quiet },
+	{ OPTION_BOOLEAN, "verbose", 'v', &verbose },
+	{ OPTION_BOOLEAN, "untracked-files", 0, &untracked_files },
 	{ OPTION_STRING, "template", 't', &template_file },
-	{ OPTION_LAST },
 };
=20
 /* FIXME: Taken from builtin-add, should be shared. */
@@ -432,8 +348,9 @@ static void parse_and_validate_options(const char *=
**argv)
 	int f =3D 0;
=20
 	(*argv)++;
-	while (scan_options(argv, commit_options))
-		;
+	while (parse_options(argv, commit_options, ARRAY_SIZE(commit_options)=
,
+			     builtin_commit_usage))
+	       ;
=20
 	if (logfile || message || use_message)
 		no_edit =3D 1;
diff --git a/parse-options.c b/parse-options.c
new file mode 100644
index 0000000..2fb30cd
--- /dev/null
+++ b/parse-options.c
@@ -0,0 +1,74 @@
+#include "git-compat-util.h"
+#include "parse-options.h"
+
+int parse_options(const char ***argv,
+		  struct option *options, int count,
+		  const char *usage_string)
+{
+	const char *value, *eq;
+	int i;
+
+	if (**argv =3D=3D NULL)
+		return 0;
+	if ((**argv)[0] !=3D '-')
+		return 0;
+	if (!strcmp(**argv, "--"))
+		return 0;
+
+	value =3D NULL;
+	for (i =3D 0; i < count; i++) {
+		if ((**argv)[1] =3D=3D '-') {
+			if (!prefixcmp(options[i].long_name, **argv + 2)) {
+				if (options[i].type !=3D OPTION_BOOLEAN)
+					value =3D *++(*argv);
+				goto match;
+			}
+
+			eq =3D strchr(**argv + 2, '=3D');
+			if (eq && options[i].type !=3D OPTION_BOOLEAN &&
+			    !strncmp(**argv + 2,
+				     options[i].long_name, eq - **argv - 2)) {
+				value =3D eq + 1;
+				goto match;
+			}
+		}
+
+		if ((**argv)[1] =3D=3D options[i].short_name) {
+			if ((**argv)[2] =3D=3D '\0') {
+				if (options[i].type !=3D OPTION_BOOLEAN)
+					value =3D *++(*argv);
+				goto match;
+			}
+
+			if (options[i].type !=3D OPTION_BOOLEAN) {
+				value =3D **argv + 2;
+				goto match;
+			}
+		}
+	}
+
+	usage(usage_string);
+
+ match:
+	switch (options[i].type) {
+	case OPTION_BOOLEAN:
+		*(int *)options[i].value =3D 1;
+		break;
+	case OPTION_STRING:
+		if (value =3D=3D NULL)
+			die("option %s requires a value.", (*argv)[-1]);
+		*(const char **)options[i].value =3D value;
+		break;
+	case OPTION_INTEGER:
+		if (value =3D=3D NULL)
+			die("option %s requires a value.", (*argv)[-1]);
+		*(int *)options[i].value =3D atoi(value);
+		break;
+	default:
+		assert(0);
+	}
+
+	(*argv)++;
+
+	return 1;
+}
diff --git a/parse-options.h b/parse-options.h
new file mode 100644
index 0000000..39399c3
--- /dev/null
+++ b/parse-options.h
@@ -0,0 +1,29 @@
+#ifndef PARSE_OPTIONS_H
+#define PARSE_OPTIONS_H
+
+enum option_type {
+    OPTION_BOOLEAN,
+    OPTION_STRING,
+    OPTION_INTEGER,
+    OPTION_LAST,
+};
+
+struct option {
+    enum option_type type;
+    const char *long_name;
+    char short_name;
+    void *value;
+};
+
+/* Parse the given options against the list of known options.  The
+ * order of the option structs matters, in that ambiguous
+ * abbreviations (eg, --in could be short for --include or
+ * --interactive) are matched by the first option that share the
+ * prefix.
+ */
+
+extern int parse_options(const char ***argv,
+			 struct option *options, int count,
+			 const char *usage_string);
+
+#endif
--=20
1.5.2.5
