From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Create object subdirectories on demand
Date: Fri, 7 Oct 2005 07:56:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510070745370.31407@g5.osdl.org>
References: <Pine.LNX.4.64.0510061612080.31407@g5.osdl.org>
 <7vfyrd7jll.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 17:00:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENteM-0004bE-WD
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 16:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030259AbVJGO4g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 10:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030265AbVJGO4g
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 10:56:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030259AbVJGO4g (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 10:56:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j97EuU4s015868
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 7 Oct 2005 07:56:30 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j97EuT3s026058;
	Fri, 7 Oct 2005 07:56:30 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyrd7jll.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9802>



On Fri, 7 Oct 2005, Junio C Hamano wrote:
> 
> But then once everybody else updates, the repository their git
> creates cannot be read by my git -- an interesting chicken and
> egg problem.

Well, you can do it in two (or three) phases:

 (a) remove the tests for "GIT_DIR/objects/00" from the "is this a 
     git dir" tests and allow git-fsck-objects to skip missing 
     directories.

This makes read-only operations work fine in sparse directories

 (b) apply my sha1_file.c part of the patch that knows how to do the mkdir 
     and also fixes (untested!) the write_sha1_from_fd() problem.

This makes all operations work fine in sparse object directories

 (c) remove the "for(i = 0; i < 256; i++) mkdir(i)" thing from git-init-db 
     and add the "rmdir()" to git-prune-packed.

This is the part that actually generates the sparse object directories.

So if you apply (a+b) to mainline, and wait with (c) until a later date, 
at least we can then do (c) at any point. No hurry.

Appended is a suggested split, if you want it explicitly. I haven't 
actually tested this split and did it by hand, but it looks correct.

			Linus

---- stage (a) ----

Phase 1: don't require the object subdirectories to be there if empty

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -142,7 +142,7 @@ static int upload(char *dir, int dirlen)
 	 * is ok with us doing this.
 	 */
 	if ((!export_all_trees && access("git-daemon-export-ok", F_OK)) ||
-	    access("objects/00", X_OK) ||
+	    access("objects/", X_OK) ||
 	    access("HEAD", R_OK)) {
 		logerror("Not a valid git-daemon-enabled repository: '%s'", dir);
 		return -1;
diff --git a/fsck-objects.c b/fsck-objects.c
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -329,9 +329,8 @@ static int fsck_dir(int i, char *path)
 	DIR *dir = opendir(path);
 	struct dirent *de;
 
-	if (!dir) {
-		return error("missing sha1 directory '%s'", path);
-	}
+	if (!dir)
+		return 0;
 
 	while ((de = readdir(dir)) != NULL) {
 		char name[100];
diff --git a/git-rename.perl b/git-rename.perl
--- a/git-rename.perl
+++ b/git-rename.perl
@@ -15,7 +15,7 @@ sub usage($);
 my $GIT_DIR = $ENV{'GIT_DIR'} || ".git";
 
 unless ( -d $GIT_DIR && -d $GIT_DIR . "/objects" && 
-	-d $GIT_DIR . "/objects/00" && -d $GIT_DIR . "/refs") {
+	-d $GIT_DIR . "/objects/" && -d $GIT_DIR . "/refs") {
 	usage("Git repository not found.");
 }
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -22,4 +22,4 @@ refs/*)	: ;;
 *)	false ;;
 esac &&
 [ -d "$GIT_DIR/refs" ] &&
-[ -d "$GIT_OBJECT_DIRECTORY/00" ]
+[ -d "$GIT_OBJECT_DIRECTORY/" ]
diff --git a/prune-packed.c b/prune-packed.c
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -46,7 +48,7 @@ static void prune_packed_objects(void)
 		sprintf(pathname + len, "%02x/", i);
 		d = opendir(pathname);
 		if (!d)
-			die("unable to open %s", pathname);
+			continue;
 		prune_dir(i, d, pathname, len + 3);
 		closedir(d);
 	}

---- stage (b) ----

Phase 2: create object subdirectories on demand

diff --git a/sha1_file.c b/sha1_file.c
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1248,6 +1248,73 @@ char *write_sha1_file_prepare(void *buf,
 	return sha1_file_name(sha1);
 }
 
+/*
+ * Link the tempfile to the final place, possibly creating the
+ * last directory level as you do so.
+ *
+ * Returns the errno on failure, 0 on success.
+ */
+static int link_temp_to_file(const char *tmpfile, char *filename)
+{
+	int ret;
+
+	if (!link(tmpfile, filename))
+		return 0;
+
+	/*
+	 * Try to mkdir the last path component if that failed
+	 * with an ENOENT.
+	 *
+	 * Re-try the "link()" regardless of whether the mkdir
+	 * succeeds, since a race might mean that somebody
+	 * else succeeded.
+	 */
+	ret = errno;
+	if (ret == ENOENT) {
+		char *dir = strrchr(filename, '/');
+		if (dir) {
+			*dir = 0;
+			mkdir(filename, 0777);
+			*dir = '/';
+			if (!link(tmpfile, filename))
+				return 0;
+			ret = errno;
+		}
+	}
+	return ret;
+}
+
+/*
+ * Move the just written object into its final resting place
+ */
+static int move_temp_to_file(const char *tmpfile, char *filename)
+{
+	int ret = link_temp_to_file(tmpfile, filename);
+	if (ret) {
+		/*
+		 * Coda hack - coda doesn't like cross-directory links,
+		 * so we fall back to a rename, which will mean that it
+		 * won't be able to check collisions, but that's not a
+		 * big deal.
+		 *
+		 * When this succeeds, we just return 0. We have nothing
+		 * left to unlink.
+		 */
+		if (ret == EXDEV && !rename(tmpfile, filename))
+			return 0;
+	}
+	unlink(tmpfile);
+	if (ret) {
+		if (ret != EEXIST) {
+			fprintf(stderr, "unable to write sha1 filename %s: %s", filename, strerror(ret));
+			return -1;
+		}
+		/* FIXME!!! Collision check here ? */
+	}
+
+	return 0;
+}
+
 int write_sha1_file(void *buf, unsigned long len, const char *type, unsigned char *returnsha1)
 {
 	int size;
@@ -1257,7 +1324,7 @@ int write_sha1_file(void *buf, unsigned 
 	char *filename;
 	static char tmpfile[PATH_MAX];
 	unsigned char hdr[50];
-	int fd, hdrlen, ret;
+	int fd, hdrlen;
 
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
@@ -1320,32 +1387,7 @@ int write_sha1_file(void *buf, unsigned 
 	close(fd);
 	free(compressed);
 
-	ret = link(tmpfile, filename);
-	if (ret < 0) {
-		ret = errno;
-
-		/*
-		 * Coda hack - coda doesn't like cross-directory links,
-		 * so we fall back to a rename, which will mean that it
-		 * won't be able to check collisions, but that's not a
-		 * big deal.
-		 *
-		 * When this succeeds, we just return 0. We have nothing
-		 * left to unlink.
-		 */
-		if (ret == EXDEV && !rename(tmpfile, filename))
-			return 0;
-	}
-	unlink(tmpfile);
-	if (ret) {
-		if (ret != EEXIST) {
-			fprintf(stderr, "unable to write sha1 filename %s: %s", filename, strerror(ret));
-			return -1;
-		}
-		/* FIXME!!! Collision check here ? */
-	}
-
-	return 0;
+	return move_temp_to_file(tmpfile, filename);
 }
 
 int write_sha1_to_fd(int fd, const unsigned char *sha1)
@@ -1420,8 +1462,7 @@ int write_sha1_to_fd(int fd, const unsig
 int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 		       size_t bufsize, size_t *bufposn)
 {
-	char *filename = sha1_file_name(sha1);
-
+	char tmpfile[PATH_MAX];
 	int local;
 	z_stream stream;
 	unsigned char real_sha1[20];
@@ -1429,10 +1470,11 @@ int write_sha1_from_fd(const unsigned ch
 	int ret;
 	SHA_CTX c;
 
-	local = open(filename, O_WRONLY | O_CREAT | O_EXCL, 0666);
+	snprintf(tmpfile, sizeof(tmpfile), "%s/obj_XXXXXX", get_object_directory());
 
+	local = mkstemp(tmpfile);
 	if (local < 0)
-		return error("Couldn't open %s\n", filename);
+		return error("Couldn't open %s for %s\n", tmpfile, sha1_to_hex(sha1));
 
 	memset(&stream, 0, sizeof(stream));
 
@@ -1462,7 +1504,7 @@ int write_sha1_from_fd(const unsigned ch
 		size = read(fd, buffer + *bufposn, bufsize - *bufposn);
 		if (size <= 0) {
 			close(local);
-			unlink(filename);
+			unlink(tmpfile);
 			if (!size)
 				return error("Connection closed?");
 			perror("Reading from connection");
@@ -1475,15 +1517,15 @@ int write_sha1_from_fd(const unsigned ch
 	close(local);
 	SHA1_Final(real_sha1, &c);
 	if (ret != Z_STREAM_END) {
-		unlink(filename);
+		unlink(tmpfile);
 		return error("File %s corrupted", sha1_to_hex(sha1));
 	}
 	if (memcmp(sha1, real_sha1, 20)) {
-		unlink(filename);
+		unlink(tmpfile);
 		return error("File %s has bad hash\n", sha1_to_hex(sha1));
 	}
-	
-	return 0;
+
+	return move_temp_to_file(tmpfile, sha1_file_name(sha1));
 }
 
 int has_pack_index(const unsigned char *sha1)

---- stage (c) ----

Phase 3: actually remove object subdirectories

diff --git a/init-db.c b/init-db.c
--- a/init-db.c
+++ b/init-db.c
@@ -244,10 +244,6 @@ int main(int argc, char **argv)
 	memcpy(path, sha1_dir, len);
 
 	safe_create_dir(sha1_dir);
-	for (i = 0; i < 256; i++) {
-		sprintf(path+len, "/%02x", i);
-		safe_create_dir(path);
-	}
 	strcpy(path+len, "/pack");
 	safe_create_dir(path);
 	strcpy(path+len, "/info");
diff --git a/prune-packed.c b/prune-packed.c
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -26,6 +26,8 @@ static void prune_dir(int i, DIR *dir, c
 		else if (unlink(pathname) < 0)
 			error("unable to unlink %s", pathname);
 	}
+	pathname[len] = 0;
+	rmdir(pathname);
 }
 
 static void prune_packed_objects(void)
