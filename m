From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] Add -r and -z options to ls-tree
Date: Thu, 14 Apr 2005 23:05:16 -0700
Message-ID: <7vekdco9r7.fsf@assigned-by-dhcp.cox.net>
References: <7vr7hco9z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 08:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMJuF-00052c-UF
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 08:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbVDOGFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 02:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVDOGFo
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 02:05:44 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54004 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S261741AbVDOGFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 02:05:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415060517.FHIN7956.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 02:05:17 -0400
To: Petr Baudis <pasky@ucw.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Recursive behaviour (-r) and NUL-terminated output (-z) are added to
ls-tree with this patch.  They are necessary for merge-trees script to
deal with filenames with embedded newlines.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 ls-tree.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 90 insertions(+), 18 deletions(-)

Index: ls-tree.c
===================================================================
--- 6767883b330882bc0e9a7c1e4fd999c0ee97ba3a/ls-tree.c  (mode:100644 sha1:3e2a6c7d183a42e41f1073dfec6794e8f8a5e75c)
+++ 21e5e9f7d7dfa81c6519f0204d5a467236c7fdd5/ls-tree.c  (mode:100664 sha1:cf1279b2c032aeffa72013ddee9dcb8742a7b069)
@@ -5,45 +5,117 @@
  */
 #include "cache.h"
 
-static int list(unsigned char *sha1)
+int line_terminator = '\n';
+int recursive = 0;
+
+struct path_prefix {
+	struct path_prefix *prev;
+	const char *name;
+};
+
+static void print_path_prefix(struct path_prefix *prefix)
 {
-	void *buffer;
-	unsigned long size;
-	char type[20];
+	if (prefix) {
+		if (prefix->prev)
+			print_path_prefix(prefix->prev);
+		fputs(prefix->name, stdout);
+		putchar('/');
+	}
+}
+
+static void list_recursive(void *buffer,
+			  unsigned char *type,
+			  unsigned long size,
+			  struct path_prefix *prefix)
+{
+	struct path_prefix this_prefix;
+	this_prefix.prev = prefix;
 
-	buffer = read_sha1_file(sha1, type, &size);
-	if (!buffer)
-		die("unable to read sha1 file");
 	if (strcmp(type, "tree"))
 		die("expected a 'tree' node");
+
 	while (size) {
-		int len = strlen(buffer)+1;
-		unsigned char *sha1 = buffer + len;
-		char *path = strchr(buffer, ' ')+1;
+		int namelen = strlen(buffer)+1;
+		void *eltbuf;
+		char elttype[20];
+		unsigned long eltsize;
+		unsigned char *sha1 = buffer + namelen;
+		char *path = strchr(buffer, ' ') + 1;
 		unsigned int mode;
-		unsigned char *type;
 
-		if (size < len + 20 || sscanf(buffer, "%o", &mode) != 1)
+		if (size < namelen + 20 || sscanf(buffer, "%o", &mode) != 1)
 			die("corrupt 'tree' file");
 		buffer = sha1 + 20;
-		size -= len + 20;
+		size -= namelen + 20;
+
 		/* XXX: We do some ugly mode heuristics here.
 		 * It seems not worth it to read each file just to get this
-		 * and the file size. -- pasky@ucw.cz */
-		type = S_ISDIR(mode) ? "tree" : "blob";
-		printf("%03o\t%s\t%s\t%s\n", mode, type, sha1_to_hex(sha1), path);
+		 * and the file size. -- pasky@ucw.cz
+		 * ... that is, when we are not recursive -- junkio@cox.net
+		 */
+		eltbuf = (recursive ? read_sha1_file(sha1, elttype, &eltsize) :
+			  NULL);
+		if (! eltbuf) {
+			if (recursive)
+				error("cannot read %s", sha1_to_hex(sha1));
+			type = S_ISDIR(mode) ? "tree" : "blob";
+		}
+		else
+			type = elttype;
+
+		printf("%03o\t%s\t%s\t", mode, type, sha1_to_hex(sha1));
+		print_path_prefix(prefix);
+		fputs(path, stdout);
+		putchar(line_terminator);
+
+		if (eltbuf && !strcmp(type, "tree")) {
+			this_prefix.name = path;
+			list_recursive(eltbuf, elttype, eltsize, &this_prefix);
+		}
+		free(eltbuf);
 	}
+}
+
+static int list(unsigned char *sha1)
+{
+	void *buffer;
+	unsigned long size;
+	char type[20];
+
+	buffer = read_sha1_file(sha1, type, &size);
+	if (!buffer)
+		die("unable to read sha1 file");
+	list_recursive(buffer, type, size, NULL);
 	return 0;
 }
 
+static void _usage(void)
+{
+	usage("ls-tree [-r] [-z] <key>");
+}
+
 int main(int argc, char **argv)
 {
 	unsigned char sha1[20];
 
+	while (1 < argc && argv[1][0] == '-') {
+		switch (argv[1][1]) {
+		case 'z':
+			line_terminator = 0;
+			break;
+		case 'r':
+			recursive = 1;
+			break;
+		default:
+			_usage();
+		}
+		argc--; argv++;
+	}
+
 	if (argc != 2)
-		usage("ls-tree <key>");
+		_usage();
 	if (get_sha1_hex(argv[1], sha1) < 0)
-		usage("ls-tree <key>");
+		_usage();
 	sha1_file_directory = getenv(DB_ENVIRONMENT);
 	if (!sha1_file_directory)
 		sha1_file_directory = DEFAULT_DB_ENVIRONMENT;






