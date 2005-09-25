From: Linus Torvalds <torvalds@osdl.org>
Subject: Add "git-update-ref" to update the HEAD (or other) ref
Date: Sun, 25 Sep 2005 11:43:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sun Sep 25 20:44:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJbTC-0006Lw-94
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 20:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbVIYSnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 14:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbVIYSnM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 14:43:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751553AbVIYSnL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 14:43:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8PIh64s013034
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 25 Sep 2005 11:43:07 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8PIh5cd024894;
	Sun, 25 Sep 2005 11:43:06 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9272>


This is a careful version of the script stuff that currently just
blindly writes HEAD with a new value.

You can use

	git-update-ref HEAD <newhead>

or

	git-update-ref HEAD <newhead> <oldhead>

where the latter version verifies that the old value of HEAD matches
oldhead.

It basically allows a "ref" file to be a symbolic pointer to another ref
file by starting with the four-byte header sequence of "ref:".

More importantly, it allows the update of a ref file to follow these 
symbolic pointers, whether they are symlinks or these "regular file 
symbolic refs".

NOTE! It follows _real_ symlinks only if they start with "refs/": 
otherwise it will just try to read them and update them as a regular file 
(ie it will allow the filesystem to follow them, but will overwrite such a 
symlink to somewhere else with a regular filename).

In general, using

	git-update-ref HEAD "$head"

should be a _lot_ safer than doing

	echo "$head" > "$GIT_DIR/HEAD"

both from a symlink following standpoint _and_ an error checking
standpoint.  The "refs/" rule for symlinks means that symlinks that point
to "outside" the tree are safe: they'll be followed for reading but not 
for writing (so we'll never write through a ref symlink to some other 
tree, if you have copied a whole archive by creating a symlink tree).

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---

This is independent of my previous patch, but in the same basic series. It 
is useful regardless of whether you use the new symbolic refs or not 
because of the much improved error checking.

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -114,6 +114,7 @@ PROGRAMS = \
 	git-ssh-upload git-tar-tree git-unpack-file \
 	git-unpack-objects git-update-index git-update-server-info \
 	git-upload-pack git-verify-pack git-write-tree \
+	git-update-ref \
 	$(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed in 0.99.8
diff --git a/update-ref.c b/update-ref.c
new file mode 100644
--- /dev/null
+++ b/update-ref.c
@@ -0,0 +1,124 @@
+#include "cache.h"
+#include "refs.h"
+
+static const char git_update_ref_usage[] = "git-update-ref <refname> <value> [<oldval>]";
+
+#define MAXDEPTH 5
+
+const char *resolve_ref(const char *path, unsigned char *sha1)
+{
+	int depth = MAXDEPTH, len;
+	char buffer[256];
+
+	for (;;) {
+		struct stat st;
+		char *buf;
+		int fd;
+
+		if (--depth < 0)
+			return NULL;
+
+		/* Special case: non-existing file */
+		if (lstat(path, &st) < 0) {
+			if (errno != ENOENT)
+				return NULL;
+			memset(sha1, 0, 20);
+			return path;
+		}
+
+		/* Follow "normalized" - ie "refs/.." symlinks by hand */
+		if (S_ISLNK(st.st_mode)) {
+			len = readlink(path, buffer, sizeof(buffer)-1);
+			if (len >= 5 && !memcmp("refs/", buffer, 5)) {
+				path = git_path("%.*s", len, buffer);
+				continue;
+			}
+		}
+
+		/*
+		 * Anything else, just open it and try to use it as
+		 * a ref
+		 */
+		fd = open(path, O_RDONLY);
+		if (fd < 0)
+			return NULL;
+		len = read(fd, buffer, sizeof(buffer)-1);
+		close(fd);
+
+		/*
+		 * Is it a symbolic ref?
+		 */
+		if (len < 4 || memcmp("ref:", buffer, 4))
+			break;
+		buf = buffer + 4;
+		len -= 4;
+		while (len && isspace(*buf))
+			buf++, len--;
+		while (len && isspace(buf[len-1]))
+			buf[--len] = 0;
+		path = git_path("%.*s", len, buf);
+	}
+	if (len < 40 || get_sha1_hex(buffer, sha1))
+		return NULL;
+	return path;
+}
+
+int main(int argc, char **argv)
+{
+	char *hex;
+	const char *refname, *value, *oldval, *path, *lockpath;
+	unsigned char sha1[20], oldsha1[20], currsha1[20];
+	int fd, written;
+
+	setup_git_directory();
+	if (argc < 3 || argc > 4)
+		usage(git_update_ref_usage);
+
+	refname = argv[1];
+	value = argv[2];
+	oldval = argv[3];
+	if (get_sha1(value, sha1) < 0)
+		die("%s: not a valid SHA1", value);
+	memset(oldsha1, 0, 20);
+	if (oldval && get_sha1(oldval, oldsha1) < 0)
+		die("%s: not a valid old SHA1", oldval);
+
+	path = resolve_ref(git_path("%s", refname), currsha1);
+	if (!path)
+		die("No such ref: %s", refname);
+
+	if (oldval) {
+		if (memcmp(currsha1, oldsha1, 20))
+			die("Ref %s changed to %s", refname, sha1_to_hex(currsha1));
+		/* Nothing to do? */
+		if (!memcmp(oldsha1, sha1, 20))
+			exit(0);
+	}
+	path = strdup(path);
+	lockpath = mkpath("%s.lock", path);
+
+	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
+	if (fd < 0)
+		die("Unable to create %s", lockpath);
+	hex = sha1_to_hex(sha1);
+	hex[40] = '\n';
+	written = write(fd, hex, 41);
+	close(fd);
+	if (written != 41) {
+		unlink(lockpath);
+		die("Unable to write to %s", lockpath);
+	}
+		
+	/*
+	 * FIXME!
+	 *
+	 * We should re-read the old ref here, and re-verify that it
+	 * matches "oldsha1". Otherwise there's a small race.
+	 */
+
+	if (rename(lockpath, path) < 0) {
+		unlink(lockpath);
+		die("Unable to create %s", path);
+	}
+	return 0;
+}
