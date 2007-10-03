From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH] Add a simple option parser.
Date: Wed,  3 Oct 2007 17:45:01 -0400
Message-ID: <1191447902-27326-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 23:46:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdC32-0007e1-U2
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbXJCVqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 17:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755242AbXJCVqV
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:46:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48628 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753676AbXJCVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:46:20 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id l93Lj986018628;
	Wed, 3 Oct 2007 17:45:09 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93Lj8t7025618;
	Wed, 3 Oct 2007 17:45:08 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l93Lj7tU000495;
	Wed, 3 Oct 2007 17:45:08 -0400
X-Mailer: git-send-email 1.5.3.4.1152.geb85a-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59896>

The option parser takes argc, argv, an array of struct option
and a usage string.  Each of the struct option elements in the array
describes a valid option, its type and a pointer to the location where =
the
value is written.  The entry point is parse_options(), which scans thro=
ugh
the given argv, and matches each option there against the list of valid
options.  During the scan, argv is rewritten to only contain the
non-option command line arguments and the number of these is returned.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile        |    2 +-
 parse-options.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 parse-options.h |   33 +++++++++++++++++
 3 files changed, 140 insertions(+), 1 deletions(-)
 create mode 100644 parse-options.c
 create mode 100644 parse-options.h

diff --git a/Makefile b/Makefile
index 62bdac6..d90e959 100644
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
diff --git a/parse-options.c b/parse-options.c
new file mode 100644
index 0000000..130b609
--- /dev/null
+++ b/parse-options.c
@@ -0,0 +1,106 @@
+#include "git-compat-util.h"
+#include "parse-options.h"
+
+static int parse_one(const char **argv,
+		     struct option *options, int count,
+		     const char *usage_string)
+{
+	const char *eq, *arg, *value;
+	int i, processed;
+
+	arg =3D argv[0];
+	value =3D NULL;
+
+	if (arg[0] !=3D '-')
+		return 0;
+
+	for (i =3D 0; i < count; i++) {
+		if (arg[1] =3D=3D '-') {
+			if (!prefixcmp(options[i].long_name, arg + 2)) {
+				if (options[i].type !=3D OPTION_BOOLEAN) {
+					value =3D argv[1];
+					processed =3D 2;
+				} else {
+					processed =3D 1;
+				}
+				break;
+			}
+
+			eq =3D strchr(arg + 2, '=3D');
+			if (eq && options[i].type !=3D OPTION_BOOLEAN &&
+			    !strncmp(arg + 2,
+				     options[i].long_name, eq - arg - 2)) {
+				value =3D eq + 1;
+				processed =3D 1;
+				break;
+			}
+		}
+
+		if (arg[1] =3D=3D options[i].short_name) {
+			if (arg[2] =3D=3D '\0') {
+				if (options[i].type !=3D OPTION_BOOLEAN) {
+					value =3D argv[1];
+					processed =3D 2;
+				} else {
+					processed =3D 1;
+				}
+				break;
+			}
+
+			if (options[i].type !=3D OPTION_BOOLEAN) {
+				value =3D arg + 2;
+				processed =3D 1;
+				break;
+			}
+		}
+	}
+
+	if (i =3D=3D count)
+		usage(usage_string);
+	else switch (options[i].type) {
+	case OPTION_BOOLEAN:
+		(*(int *)options[i].value)++;
+		break;
+	case OPTION_STRING:
+		if (value =3D=3D NULL) {
+			error("option %s requires a value.", arg);
+			usage(usage_string);
+		}
+		*(const char **)options[i].value =3D value;
+		break;
+	case OPTION_INTEGER:
+		if (value =3D=3D NULL) {
+			error("option %s requires a value.", argv);
+			usage(usage_string);
+		}
+		*(int *)options[i].value =3D atoi(value);
+		break;
+	default:
+		assert(0);
+	}
+
+	return processed;
+}
+
+int parse_options(int argc, const char **argv,
+		  struct option *options, int count,
+		  const char *usage_string)
+{
+	int i, j, processed;
+
+	for (i =3D 1, j =3D 0; i < argc; ) {
+		if (!strcmp(argv[i], "--"))
+			break;
+		processed =3D parse_one(argv + i, options, count, usage_string);
+		if (processed =3D=3D 0)
+			argv[j++] =3D argv[i++];
+		else
+			i +=3D processed;
+	}
+
+	while (i < argc)
+		argv[j++] =3D argv[i++];
+	argv[j] =3D NULL;
+
+	return j;
+}
diff --git a/parse-options.h b/parse-options.h
new file mode 100644
index 0000000..5be9c20
--- /dev/null
+++ b/parse-options.h
@@ -0,0 +1,33 @@
+#ifndef PARSE_OPTIONS_H
+#define PARSE_OPTIONS_H
+
+enum option_type {
+	OPTION_BOOLEAN,
+	OPTION_STRING,
+	OPTION_INTEGER,
+	OPTION_LAST,
+};
+
+struct option {
+	enum option_type type;
+	const char *long_name;
+	char short_name;
+	void *value;
+};
+
+/* Parse the given options against the list of known options.  The
+ * order of the option structs matters, in that ambiguous
+ * abbreviations (eg, --in could be short for --include or
+ * --interactive) are matched by the first option that share the
+ * prefix.
+ *
+ * parse_options() will filter out the processed options and leave the
+ * non-option argments in argv[].  The return value is the number of
+ * arguments left in argv[].
+ */
+
+extern int parse_options(int argc, const char **argv,
+			 struct option *options, int count,
+			 const char *usage_string);
+
+#endif
--=20
1.5.2.5
