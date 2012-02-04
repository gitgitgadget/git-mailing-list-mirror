From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 02/12] column: add API to print items in columns
Date: Sat,  4 Feb 2012 22:59:06 +0700
Message-ID: <1328371156-4009-3-git-send-email-pclouds@gmail.com>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 16:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RthxP-0006Ta-Ga
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 16:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621Ab2BDPzK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Feb 2012 10:55:10 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36432 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753561Ab2BDPzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 10:55:07 -0500
Received: by mail-pz0-f46.google.com with SMTP id p15so3553938dad.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iYkpjSzIMF/qozdmesnMotncxoj4l3M3WX4pJxeJ6hk=;
        b=M2fPecZGOucwuLkP9/tztq5fhMTEjVH9Zhgf10WgHMP/tJ1A/AmQdXCFvL59haMi5I
         jKuwWKXhwXDzKjb32Kg5QsH/6dRaxmlAOVodEqiFzRB//P31pnYtr+wLcMGaKIPf5CZa
         RNPghCyZw7TdBwdCl26GUm9QcD2xbmalvpzT0=
Received: by 10.68.220.227 with SMTP id pz3mr26340022pbc.86.1328370906887;
        Sat, 04 Feb 2012 07:55:06 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id w4sm22408636pbf.4.2012.02.04.07.55.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 07:55:05 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Sat, 04 Feb 2012 22:59:33 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189874>

Simple code that print line-by-line and wants to columnize can do
this:

struct string_list list;
string_list_append(&list, ...);
string_list_append(&list, ...);
=2E..
print_columns(&list, ...);

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile |    3 ++-
 column.c |   39 +++++++++++++++++++++++++++++++++++++++
 column.h |   13 +++++++++++++
 3 files changed, 54 insertions(+), 1 deletions(-)
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
index 0000000..742ae18
--- /dev/null
+++ b/column.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "column.h"
+#include "string-list.h"
+
+#define MODE(mode) ((mode) & COL_MODE)
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
+void print_columns(const struct string_list *list, unsigned int mode,
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
index 55d8067..8e4fdaa 100644
--- a/column.h
+++ b/column.h
@@ -1,6 +1,19 @@
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
+extern void print_columns(const struct string_list *list,
+			  unsigned int mode,
+			  struct column_options *opts);
=20
 #endif
--=20
1.7.8.36.g69ee2
