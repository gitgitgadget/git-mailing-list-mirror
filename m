From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/8] ls-tree: work from subdirectory.
Date: Sun, 27 Nov 2005 22:48:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511272219420.13959@g5.osdl.org>
References: <Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy83cdu7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511251953081.13959@g5.osdl.org>
 <7voe477n4i.fsf_-_@assigned-by-dhcp.cox.net> <7vpson4tqi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511260855560.13959@g5.osdl.org> <7vr792fnta.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511270949540.13959@g5.osdl.org> <20051127182244.GK22159@pasky.or.cz>
 <Pine.LNX.4.64.0511271049090.13959@g5.osdl.org> <7vveyd37ic.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511271742520.13959@g5.osdl.org> <7vpsol1ett.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 08:08:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgcoS-0003Fl-SU
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 07:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVK1GsP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 01:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbVK1GsP
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 01:48:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46285 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932106AbVK1GsP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 01:48:15 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAS6m9nO018913
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 27 Nov 2005 22:48:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAS6m8ZY018450;
	Sun, 27 Nov 2005 22:48:08 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsol1ett.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.56__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12854>



On Sun, 27 Nov 2005, Junio C Hamano wrote:
> 
> So it probably is safer to default ls_options to LS_RECURSIVE,
> and use "-d" to restrict it not to recurse.

I have a patch that solves all the problems, I think.

It modifies the selection a bit, so that a pathspec that is a superset of 
a particular tree path will always cause it to recurse into that tree.

As an example, let's say that we do

	git-ls-tree HEAD drivers/char

_without_ the "-r". What will happen is that it will start out doing all 
the base tree, and for "drivers" it will notice that it's a proper subset 
of "drivers/char", so it will always recurse into _that_ tree (but not 
into other trees).

Then, it will not match anything else than "char" in that subdirectory, 
and because that's not a proper superset (it's an exact match), it will 
_not_ recurse into it, so you get:

	[torvalds@g5 linux]$ ~/git/git-ls-tree HEAD drivers/char
	040000 tree 9568cda453aae205bb58983747fa73b9696d9d51    drivers/char

which is what you got with the old git-ls-tree too.

But interestingly, if you add the slash, it will become a proper superset 
and it will recurse into _that_ subdirectory (but no deeper: so if you 
want all subdirectories _below_ drivers/char/, you still need to give 
"-r"):

	[torvalds@g5 linux]$ ~/git/git-ls-tree HEAD drivers/char/
	100644 blob 2b6b1d772ed776fff87927fc34adc2e40500218e    drivers/char/.gitignore
	100644 blob 56b8a2e76ab10a5c21787cb7068a846075cbaffd    drivers/char/ChangeLog
	100644 blob 970f70d498f4c814e1cf3362e33d7e23ac53c299    drivers/char/Kconfig
	...

See? This is on top of the previous two diffs, holler if you want a whole 
new "everything combined" version..

It hasn't gotten lots of testing, but it should work.

BTW! It fails a few of the tests, but it does so because now, with "-r", 
it will never show the tree entries, and because of the difference between

	git-ls-tree $tree path

and

	git-ls-tree $tree path/

that it didn't use to have (oh, and if you give multiple paths, it will 
now always consider them a "union pathspec", not an "iteration of paths"). 
But I _think_ the new behaviour is pretty useful and while not the same as 
"ls", it's perhaps still intuitive enough..

		Linus

---
diff --git a/ls-tree.c b/ls-tree.c
index cf0dbbc..4df5830 100644
--- a/ls-tree.c
+++ b/ls-tree.c
@@ -11,7 +11,8 @@
 static int line_termination = '\n';
 #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
-static int ls_options = LS_RECURSIVE;
+static int ls_options = 0;
+const char **pathspec;
 
 static const char ls_tree_usage[] =
 	"git-ls-tree [-d] [-r] [-z] <tree-ish> [path...]";
@@ -21,8 +22,29 @@ static int show_tree(unsigned char *sha1
 	const char *type = "blob";
 
 	if (S_ISDIR(mode)) {
+		const char **s;
 		if (ls_options & LS_RECURSIVE)
 			return READ_TREE_RECURSIVE;
+		s = pathspec;
+		if (s) {
+			for (;;) {
+				const char *spec = *s++;
+				int len, speclen;
+
+				if (!spec)
+					break;
+				if (strncmp(base, spec, baselen))
+					continue;
+				len = strlen(pathname);
+				spec += baselen;
+				speclen = strlen(spec);
+				if (speclen <= len)
+					continue;
+				if (memcmp(pathname, spec, len))
+					continue;
+				return READ_TREE_RECURSIVE;
+			}
+		}
 		type = "tree";
 	}
 
@@ -32,7 +54,7 @@ static int show_tree(unsigned char *sha1
 
 int main(int argc, const char **argv)
 {
-	const char **path, *prefix;
+	const char *prefix;
 	unsigned char sha1[20];
 	char *buf;
 	unsigned long size;
@@ -60,11 +82,11 @@ int main(int argc, const char **argv)
 	if (get_sha1(argv[1], sha1) < 0)
 		usage(ls_tree_usage);
 
-	path = get_pathspec(prefix, argv + 2);
+	pathspec = get_pathspec(prefix, argv + 2);
 	buf = read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!buf)
 		die("not a tree object");
-	read_tree_recursive(buf, size, "", 0, 0, path, show_tree);
+	read_tree_recursive(buf, size, "", 0, 0, pathspec, show_tree);
 
 	return 0;
 }
