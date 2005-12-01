From: Linus Torvalds <torvalds@osdl.org>
Subject: git-ls-tree: add "-t" option to always show the tree entries
Date: Thu, 1 Dec 2005 10:35:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512011022520.3099@g5.osdl.org>
References: <7vlkz5n3r1.fsf@assigned-by-dhcp.cox.net>
 <20051201085433.GA7866@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 19:39:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhtIP-0004iA-Qr
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 19:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbVLASgi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 13:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVLASgi
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 13:36:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24724 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932399AbVLASgi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 13:36:38 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB1IZrnO032434
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Dec 2005 10:35:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB1IZpTG032216;
	Thu, 1 Dec 2005 10:35:52 -0800
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051201085433.GA7866@c165.ib.student.liu.se>
X-Spam-Status: No, hits=-6 required=5 tests=PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13065>


The old (new) behaviour was that it only shows trees if the object is 
specified exactly, and recursive is not set. That makes sense, because 
there is obviously nothing else it can show for that case.

However, with the new "-t" option, it will show the tree even with "-r", 
as it traverses down into it.

NOTE! This also means that it will show all trees leading up to that tree. 

For example, if you do a

	git-ls-tree -t HEAD -- drivers/char/this/file/does/not/exist

it will show the trees that lead up to the files that do not exist:

	[torvalds@g5 linux]$ git-ls-tree -t HEAD -- drivers/char/this/file/does/not/exist
	040000 tree 9cb687b77dcd64bf82e9a73214db467c964c1266    drivers
	040000 tree 298e2fadf0ff3867d1ef49936fd2c7bf6ce1eb66    drivers/char
	[torvalds@g5 linux]$

and note how this is true even though I didn't specify "-r": the fact that 
I supplied a pathspec automatically implies "enough recursion" for that 
particular pathspec.

I think the code is cleaner and easier to understand too: the patch looks 
bigger, but it's really just splitting up the "should we recurse into this 
tree" into a function of its own.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
----

This obviously means that to fix merge-recursive, we should add that "-t" 
flag to it, but then hopefully everything should be ok? Do you have a 
test-case, and perhaps something we could add to "make test".

Talking about "make test", this doesn't break any (since it doesn't change 
behaviour without the "-t" flag), but maybe it should add some. But I'm 
lazy.

On Thu, 1 Dec 2005, Fredrik Kuivinen wrote:
> 
> It turns out that this change breaks the directory/file conflict
> handling in git-merge-recursive. Right now merge-recursive uses
> 
>    git-ls-tree -r -z <tree SHA1>
> 
> to get a listing of every blob object (which corresponds to files) and
> every tree object (which corresponds to directories) in the tree
> designated by the SHA1.

diff --git a/ls-tree.c b/ls-tree.c
index d4b6219..a2a5eb0 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -11,39 +11,53 @@
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
+#define LS_SHOW_TREES 4
 static int ls_options = 0;
 const char **pathspec;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
+	"git-ls-tree [-d] [-r] [-t] [-z] <tree-ish> [path...]";
+
+static int show_recursive(const char *base, int baselen, const char *pathname)
+{
+	const char **s;
+
+	if (ls_options & LS_RECURSIVE)
+		return 1;
+
+	s = pathspec;
+	if (!s)
+		return 0;
+
+	for (;;) {
+		const char *spec = *s++;
+		int len, speclen;
+
+		if (!spec)
+			return 0;
+		if (strncmp(base, spec, baselen))
+			continue;
+		len = strlen(pathname);
+		spec += baselen;
+		speclen = strlen(spec);
+		if (speclen <= len)
+			continue;
+		if (memcmp(pathname, spec, len))
+			continue;
+		return 1;
+	}
+}
 
 static int show_tree(unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
 {
+	int retval = 0;
 	const char *type = "blob";
 
 	if (S_ISDIR(mode)) {
-		const char **s;
-		if (ls_options & LS_RECURSIVE)
-			return READ_TREE_RECURSIVE;
-		s = pathspec;
-		if (s) {
-			for (;;) {
-				const char *spec = *s++;
-				int len, speclen;
-
-				if (!spec)
-					break;
-				if (strncmp(base, spec, baselen))
-					continue;
-				len = strlen(pathname);
-				spec += baselen;
-				speclen = strlen(spec);
-				if (speclen <= len)
-					continue;
-				if (memcmp(pathname, spec, len))
-					continue;
-				return READ_TREE_RECURSIVE;
-			}
+		if (show_recursive(base, baselen, pathname)) {
+			retval = READ_TREE_RECURSIVE;
+			if (!(ls_options & LS_SHOW_TREES))
+				return retval;
 		}
 		type = "tree";
 	}
@@ -51,7 +65,7 @@ static int show_tree(unsigned char *sha1
 	printf("%06o %s %s\t", mode, type, sha1_to_hex(sha1));
 	write_name_quoted(base, baselen, pathname, line_termination, stdout);
 	putchar(line_termination);
-	return 0;
+	return retval;
 }
 
 int main(int argc, const char **argv)
@@ -73,6 +87,9 @@ int main(int argc, const char **argv)
 		case 'd':
 			ls_options |= LS_TREE_ONLY;
 			break;
+		case 't':
+			ls_options |= LS_SHOW_TREES;
+			break;
 		default:
 			usage(ls_tree_usage);
 		}
