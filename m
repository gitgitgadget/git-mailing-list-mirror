From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 09:59:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509250941520.3308@g5.osdl.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
 <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org> <Pine.LNX.4.58.0509241526180.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 18:59:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJZqw-0004bX-FO
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 18:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbVIYQ7p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 12:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbVIYQ7p
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 12:59:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19354 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751515AbVIYQ7o (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 12:59:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8PGxc4s010034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Sep 2005 09:59:39 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8PGxbom022143;
	Sun, 25 Sep 2005 09:59:37 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0509241526180.3308@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9269>



On Sat, 24 Sep 2005, Linus Torvalds wrote:
>
> Anyway, regardless, we could certainly make HEAD be a regular file 
> containing the name of the head instead.
> 
> It probably wouldn't even require a whole lot of changes. HEAD already 
> ends up getting some special attention, since most of the things that look 
> for refs only look inside the .git/refs directory.

This patch does some of it. I decided not to special-case HEAD, but to 
just improve "read_ref()" a bit.

Changing "read_ref()" was the trivial part - the bigger part that we had 
three different implementations of it, and this patch is thus bigger just 
because it collapses them all into "read_ref()" and makes the calling 
conventions acceptable to all.

NOTE! This makes "symbolic refs" usable in general, ie you can do

	echo "ref: refs/tags/v0.99.7" > .git/refs/tags/LATEST

and that essentially makes "LATEST" a symbolic ref that points to the 
v0.99.7 tag without using a filesystem symlink. But it does NOT mean that 
you can replace the HEAD symlink with a file containing "refs/tags/master" 
yet: there are _other_ parts of git that depend on it being a symlink. 

(For the most core example, the "write new head" logic depends on just
writing to HEAD, and that symlink will automatically change that write to 
the thing the HEAD _points_ to. That's the biggest one).

I'll change those too to accept a regular file, if people agree this is 
worthwhile. In theory there are even UNIXes out there that don't support 
symlinks, so maybe it's worth it. But maybe people dislike this.

In the meantime, you can test this out with

	echo "ref: HEAD" > .git/TEST_HEAD
	git-rev-parse HEAD TEST_HEAD master

which - if your HEAD points to master - should print out the same SHA1
three times ;)

		Linus

---
Subject: Allow reading "symbolic refs" that point to other refs

This extends the ref reading to understand a "symbolic ref": a ref file 
that starts with "ref: " and points to another ref file, and thus 
introduces the notion of ref aliases.

This is in preparation of allowing HEAD to eventually not be a symlink, 
but one of these symbolic refs instead.

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -227,6 +227,7 @@ extern int has_pack_index(const unsigned
 extern int get_sha1(const char *str, unsigned char *sha1);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
+extern int read_ref(const char *filename, unsigned char *sha1);
 
 /* General helper functions */
 extern void usage(const char *err) NORETURN;
diff --git a/refs.c b/refs.c
--- a/refs.c
+++ b/refs.c
@@ -2,17 +2,38 @@
 #include "cache.h"
 
 #include <errno.h>
+#include <ctype.h>
 
-static int read_ref(const char *refname, unsigned char *sha1)
+/* We allow "recursive" symbolic refs. Only within reason, though */
+#define MAXDEPTH 5
+
+int read_ref(const char *filename, unsigned char *sha1)
 {
-	int ret = -1;
-	int fd = open(git_path("%s", refname), O_RDONLY);
+	int depth = 0;
+	int ret = -1, fd;
+
+	while ((fd = open(filename, O_RDONLY)) >= 0) {
+		char buffer[256];
+		int len = read(fd, buffer, sizeof(buffer)-1);
 
-	if (fd >= 0) {
-		char buffer[60];
-		if (read(fd, buffer, sizeof(buffer)) >= 40)
-			ret = get_sha1_hex(buffer, sha1);
 		close(fd);
+		if (len < 0)
+			break;
+
+		buffer[len] = 0;
+		while (len && isspace(buffer[len-1]))
+			buffer[--len] = 0;
+
+		if (!strncmp(buffer, "ref: ", 5)) {
+			if (depth > MAXDEPTH)
+				break;
+			depth++;
+			filename = git_path("%s", buffer+5);
+			continue;
+		}
+		if (len >= 40)
+			ret = get_sha1_hex(buffer, sha1);
+		break;
 	}
 	return ret;
 }
@@ -54,7 +75,7 @@ static int do_for_each_ref(const char *b
 					break;
 				continue;
 			}
-			if (read_ref(path, sha1) < 0)
+			if (read_ref(git_path("%s", path), sha1) < 0)
 				continue;
 			if (!has_sha1_file(sha1))
 				continue;
@@ -71,7 +92,7 @@ static int do_for_each_ref(const char *b
 int head_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
 	unsigned char sha1[20];
-	if (!read_ref("HEAD", sha1))
+	if (!read_ref(git_path("HEAD"), sha1))
 		return fn("HEAD", sha1);
 	return 0;
 }
@@ -101,33 +122,14 @@ static char *ref_lock_file_name(const ch
 	return ret;
 }
 
-static int read_ref_file(const char *filename, unsigned char *sha1) {
-	int fd = open(filename, O_RDONLY);
-	char hex[41];
-	if (fd < 0) {
-		return error("Couldn't open %s\n", filename);
-	}
-	if ((read(fd, hex, 41) < 41) ||
-	    (hex[40] != '\n') ||
-	    get_sha1_hex(hex, sha1)) {
-		error("Couldn't read a hash from %s\n", filename);
-		close(fd);
-		return -1;
-	}
-	close(fd);
-	return 0;
-}
-
 int get_ref_sha1(const char *ref, unsigned char *sha1)
 {
-	char *filename;
-	int retval;
+	const char *filename;
+
 	if (check_ref_format(ref))
 		return -1;
-	filename = ref_file_name(ref);
-	retval = read_ref_file(filename, sha1);
-	free(filename);
-	return retval;
+	filename = git_path("refs/%s", ref);
+	return read_ref(filename, sha1);
 }
 
 static int lock_ref_file(const char *filename, const char *lock_filename,
@@ -140,7 +142,7 @@ static int lock_ref_file(const char *fil
 		return error("Couldn't open lock file for %s: %s",
 			     filename, strerror(errno));
 	}
-	retval = read_ref_file(filename, current_sha1);
+	retval = read_ref(filename, current_sha1);
 	if (old_sha1) {
 		if (retval) {
 			close(fd);
diff --git a/sha1_name.c b/sha1_name.c
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -119,21 +119,6 @@ static int get_short_sha1(const char *na
 	return -1;
 }
 
-static int get_sha1_file(const char *path, unsigned char *result)
-{
-	char buffer[60];
-	int fd = open(path, O_RDONLY);
-	int len;
-
-	if (fd < 0)
-		return -1;
-	len = read(fd, buffer, sizeof(buffer));
-	close(fd);
-	if (len < 40)
-		return -1;
-	return get_sha1_hex(buffer, result);
-}
-
 static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 {
 	static const char *prefix[] = {
@@ -150,7 +135,7 @@ static int get_sha1_basic(const char *st
 
 	for (p = prefix; *p; p++) {
 		char *pathname = git_path("%s/%.*s", *p, len, str);
-		if (!get_sha1_file(pathname, sha1))
+		if (!read_ref(pathname, sha1))
 			return 0;
 	}
 
