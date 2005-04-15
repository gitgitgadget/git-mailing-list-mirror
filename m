From: Junio C Hamano <junkio@cox.net>
Subject: [Patch] ls-tree enhancements
Date: Thu, 14 Apr 2005 19:21:30 -0700
Message-ID: <7vzmw0ok45.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050414002902.GU25711@pasky.ji.cz>
	<20050413212546.GA17236@64m.dyndns.org>
	<20050414004504.GW25711@pasky.ji.cz>
	<Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	<7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 04:19:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMGPW-0007S8-AR
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 04:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbVDOCVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 22:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbVDOCVl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 22:21:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38130 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261719AbVDOCVc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 22:21:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415022131.KUNE1282.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 22:21:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 14 Apr 2005 11:36:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This adds '-r' (recursive) option and '-z' (NUL terminated)
option to ls-tree.  I need it so that the merge-trees (formerly
known as git-merge.perl) script does not need to create any
temporary dircache while merging.  It used to use show-files on
a temporary dircache to get the list of files in the ancestor
tree, and also used the dircache to store the result of its
automerge.  I probably still need it for the latter reason, but
with this patch not for the former reason anymore.

It is relative to bb95843a5a0f397270819462812735ee29796fb4

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 ls-tree.c |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 90 insertions(+), 18 deletions(-)


--- ,,Linus/ls-tree.c	2005-04-14 19:08:17.000000000 -0700
+++ ,,Siam/ls-tree.c	2005-04-14 19:11:23.000000000 -0700
@@ -5,45 +5,117 @@
  */
 #include "cache.h"
 
-static int list(unsigned char *sha1)
+int line_termination = '\n';
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
+		putchar(line_termination);
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
+			line_termination = 0;
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

