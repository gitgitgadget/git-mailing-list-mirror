From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 02/13] column: add API to print items in columns
Date: Fri,  3 Feb 2012 20:34:27 +0700
Message-ID: <1328276078-27955-3-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 14:31:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtJEV-0007xT-7A
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 14:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360Ab2BCNbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 08:31:05 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37976 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756332Ab2BCNaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 08:30:55 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so2736866dad.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lyaP/cEk4nyaOsRmcXtrZ6Sy0vP5pfItsDCNcy+YDx0=;
        b=chw5ITxGG/Zbf9yLITH5juS1ztAUJcEScUtPiNX5dJb5YsrNu149ah1UwweejA0GZB
         W/ixmgA0IR6xF46RQ2SX7rZv3PfcPsUkQZr0WpaSmp+p65vLkQtLhw+VFR+Ar5WcHNyI
         kmmDsbHpdi8nb69Lgbm+MCEOS8rtx/lXeHx4I=
Received: by 10.68.225.4 with SMTP id rg4mr17522845pbc.111.1328275855322;
        Fri, 03 Feb 2012 05:30:55 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id kx17sm13107180pbb.19.2012.02.03.05.30.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 05:30:54 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Fri, 03 Feb 2012 20:35:04 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189760>

Simple code that print line-by-line and wants to columnize can do
this:

print_cell(...);
print_cell(...);
=2E..
print_columns(...);

if column layout is disabled, print_cell() prints directly and
print_columns() becomes no-op. Otherwise print_cell() saves all items
in a string list for print_columns() to process later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    3 ++-
 column.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 column.h |   17 +++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletions(-)
 create mode 100644 column.c

diff --git a/Makefile b/Makefile
index cbbc699..5f0531b 100644
--- a/Makefile
+++ b/Makefile
@@ -637,6 +637,7 @@ LIB_OBJS +=3D bulk-checkin.o
 LIB_OBJS +=3D bundle.o
 LIB_OBJS +=3D cache-tree.o
 LIB_OBJS +=3D color.o
+LIB_OBJS +=3D column.o
 LIB_OBJS +=3D combine-diff.o
 LIB_OBJS +=3D commit.o
 LIB_OBJS +=3D compat/obstack.o
@@ -2114,7 +2115,7 @@ builtin/prune.o builtin/reflog.o reachable.o: rea=
chable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
-help.o pager.o: column.h
+column.o help.o pager.o: column.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
=20
diff --git a/column.c b/column.c
new file mode 100644
index 0000000..4ae98f3
--- /dev/null
+++ b/column.c
@@ -0,0 +1,54 @@
+#include "cache.h"
+#include "column.h"
+#include "string-list.h"
+
+#define MODE(mode) ((mode) & COL_MODE)
+
+struct string_list_item *add_cell_to_list(struct string_list *list,
+					  int mode,
+					  const char *string)
+{
+	if (mode & COL_ENABLED)
+		return string_list_append(list, string);
+	return NULL;
+}
+
+void print_cell(struct string_list *list, int mode, const char *string=
)
+{
+	if (!add_cell_to_list(list, mode, string))
+		printf("%s\n", string);
+}
+
+/* Display without layout when COL_ENABLED is not set */
+static void display_plain(const struct string_list *list,
+			  const char *indent, const char *nl)
+{
+	int i;
+
+	for (i =3D 0; i < list->nr; i++)
+		printf("%s%s%s", indent, list->items[i].string, nl);
+}
+
+void print_columns(const struct string_list *list, int mode,
+		   struct column_options *opts)
+{
+	const char *indent =3D "", *nl =3D "\n";
+	int padding =3D 1, width =3D term_columns();
+
+	if (!list->nr)
+		return;
+	if (opts) {
+		if (opts->indent)
+			indent =3D opts->indent;
+		if (opts->nl)
+			nl =3D opts->nl;
+		if (opts->width)
+			width =3D opts->width;
+		padding =3D opts->padding;
+	}
+	if (width <=3D 1 || !(mode & COL_ENABLED)) {
+		display_plain(list, indent, nl);
+		return;
+	}
+	die("BUG: invalid mode %d", MODE(mode));
+}
diff --git a/column.h b/column.h
index 55d8067..e0f8c26 100644
--- a/column.h
+++ b/column.h
@@ -1,6 +1,23 @@
 #ifndef COLUMN_H
 #define COLUMN_H
=20
+#define COL_MODE          0x000F
+#define COL_ENABLED      (1 << 4)
+
+struct column_options {
+	int width;
+	int padding;
+	const char *indent;
+	const char *nl;
+};
+
 extern int term_columns(void);
+extern struct string_list_item *add_cell_to_list(struct string_list *l=
ist,
+						 int mode,
+						 const char *string);
+/* add cell to list, or print it out if column mode is disabled */
+extern void print_cell(struct string_list *list, int mode, const char =
*string);
+extern void print_columns(const struct string_list *list,
+			  int mode, struct column_options *opts);
=20
 #endif
--=20
1.7.8.36.g69ee2
