From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: [PATCH] Add builtin dump command, to query a repository using a pipe.
Date: Fri, 25 Jan 2008 16:24:34 -0800
Message-ID: <fnduk3$d0c$1@ger.gmane.org>
Reply-To: Han-Wen Nienhuys <hanwen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 26 01:25:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIYrj-0006ob-1j
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 01:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbYAZAYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 19:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757516AbYAZAYw
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 19:24:52 -0500
Received: from main.gmane.org ([80.91.229.2]:51491 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757015AbYAZAYt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 19:24:49 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JIYqj-0007cD-Vh
	for git@vger.kernel.org; Sat, 26 Jan 2008 00:24:46 +0000
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 00:24:45 +0000
Received: from hanwen by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 00:24:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 216-239-45-4.google.com
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71759>


This command prints either contents or metadata on stdout for SHA1s or
symbolic object names supplied to its stdin, so you can extract many
pieces of data of the repository using a single subprocess.

Documentation will follow once the code is approved.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile       |    1 +
 builtin-dump.c |  100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h      |    1 +
 git.c          |    1 +
 4 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100644 builtin-dump.c

diff --git a/Makefile b/Makefile
index 21c80e6..63a26a7 100644
--- a/Makefile
+++ b/Makefile
@@ -339,6 +339,7 @@ BUILTIN_OBJS = \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
 	builtin-diff-tree.o \
+	builtin-dump.o \
 	builtin-fast-export.o \
 	builtin-fetch.o \
 	builtin-fetch-pack.o \
diff --git a/builtin-dump.c b/builtin-dump.c
new file mode 100644
index 0000000..813c7ab
--- /dev/null
+++ b/builtin-dump.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2008 Google Inc.
+ * Author: hanwen@google.com
+ * 
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include "cache.h"
+#include "exec_cmd.h"
+#include "object.h"
+#include "builtin.h"
+
+/*
+  format:
+
+  'show' SP type SP objname LF
+  =>
+  'len' number LF
+  contents LF
+    
+  'metadata' SP objname LF
+  =>
+  type SP size SP sha1 LF
+  
+  for non-existent objects, 'metadata' prints
+
+  'none' SP 0 SP null-hash LF
+  
+*/
+
+typedef unsigned char sha1_t[20];
+
+void print_metadata(struct strbuf command_buf) {
+	char *obj_name = strchr(command_buf.buf, ' ') + 1;
+	sha1_t sha1 = {0};
+	const char *type_name = "none";
+	unsigned long size = 0;
+	char header[200];
+
+	if (!get_sha1(obj_name, sha1)) {
+		enum object_type type = sha1_object_info(sha1, &size);
+		type_name = type ? typename(type) : "none";
+	}
+	sprintf(header, "%s %lu %s\n", type_name, size, sha1_to_hex(sha1));
+	write_or_die(1, header, strlen(header));  
+}
+
+
+void print_show(struct strbuf command_buf) {
+	char *type = strchr(command_buf.buf, ' ') + 1;
+	char *obj_name;
+	sha1_t sha1;
+	unsigned long size;
+	char header[200];
+	void *buf;
+	
+	if (!type)
+		die("commmand format error: %s\n", command_buf.buf);
+  
+	obj_name = strchr(type, ' ');
+	if (!obj_name)
+		die("commmand format error: %s\n", command_buf.buf);
+	*obj_name = '\0';
+	obj_name++;
+  
+	if (get_sha1(obj_name, sha1))
+		die("not a valid object name: %s", obj_name);
+  
+	buf = read_object_with_reference(sha1, type, &size, NULL);
+	sprintf(header, "len %lu\n", size);
+	write_or_die(1, header, strlen(header));
+	write_or_die(1, buf, size);
+	write_or_die(1, "\n", 1);
+}
+
+
+int cmd_dump(int argc, const char **argv, const char *prefix) {
+	struct strbuf command_buf = STRBUF_INIT;
+	while (strbuf_getline(&command_buf, stdin, '\n') != EOF) {
+		if (!prefixcmp(command_buf.buf, "metadata "))
+			print_metadata(command_buf);
+		else if (!prefixcmp(command_buf.buf, "print "))
+			print_show(command_buf);
+		else
+			die("unknown command %s", command_buf.buf);
+	}
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index cb675c4..df873f9 100644
--- a/builtin.h
+++ b/builtin.h
@@ -33,6 +33,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_dump(int argc, const char **argv, const char *prefix);
 extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 15fec89..853dbc1 100644
--- a/git.c
+++ b/git.c
@@ -303,6 +303,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+		{ "dump", cmd_dump, RUN_SETUP },
 		{ "fast-export", cmd_fast_export, RUN_SETUP },
 		{ "fetch", cmd_fetch, RUN_SETUP },
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
-- 
1.5.3.5.643.g40e25
