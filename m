From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 1/4] Add a simple option parser for use by builtin-commit.c.
Date: Thu, 27 Sep 2007 00:50:29 -0400
Message-ID: <1190868632-29287-1-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Sep 27 07:08:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IalcM-0004Kg-Hw
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 07:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbXI0FIr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 01:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbXI0FIq
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 01:08:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbXI0FIq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 01:08:46 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58ikG031461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 27 Sep 2007 01:08:44 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58h7H001662;
	Thu, 27 Sep 2007 01:08:43 -0400
Received: from localhost.localdomain (sebastian-int.corp.redhat.com [172.16.52.221])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8R58gMq002271;
	Thu, 27 Sep 2007 01:08:43 -0400
X-Mailer: git-send-email 1.5.3.2.1119.gab6f-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59258>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 Makefile        |    2 +-
 parse-options.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 parse-options.h |   29 +++++++++++++++++++++
 3 files changed, 104 insertions(+), 1 deletions(-)
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
1.5.2.GIT
