From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 2/4] short i/o: fix calls to read to use xread or read_in_full
Date: Mon, 08 Jan 2007 15:58:08 +0000
Message-ID: <9bcbbe42c4508e6648004084698fca7a@pinky>
References: <45A2699F.5060100@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 16:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3wt5-0001GP-Jw
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 16:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161320AbXAHP6L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 10:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbXAHP6L
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 10:58:11 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:55591
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161324AbXAHP6J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jan 2007 10:58:09 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1H3wsy-0003XV-5F
	for git@vger.kernel.org; Mon, 08 Jan 2007 15:58:08 +0000
To: git@vger.kernel.org
InReply-To: <45A2699F.5060100@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36269>


We have a number of badly checked read() calls.  Often we are
expecting read() to read exactly the size we requested or fail, this
fails to handle interrupts or short reads.  Add a read_in_full()
providing those semantics.  Otherwise we at a minimum need to check
for EINTR and EAGAIN, where this is appropriate use xread().

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/builtin-grep.c b/builtin-grep.c
index 3b1b1cb..2bfbdb7 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -136,7 +136,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	if (i < 0)
 		goto err_ret;
 	data = xmalloc(st.st_size + 1);
-	if (st.st_size != xread(i, data, st.st_size)) {
+	if (st.st_size != read_in_full(i, data, st.st_size)) {
 		error("'%s': short read %s", filename, strerror(errno));
 		close(i);
 		free(data);
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 11e62fc..ad802fc 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -74,7 +74,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	char *content = buffer + RECORDSIZE;
 	ssize_t n;
 
-	n = xread(0, buffer, HEADERSIZE);
+	n = read_in_full(0, buffer, HEADERSIZE);
 	if (n < HEADERSIZE)
 		die("git-get-tar-commit-id: read error");
 	if (header->typeflag[0] != 'g')
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index e4156f8..48ae09e 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -91,7 +91,7 @@ static void process_input(int child_fd, int band)
 	char buf[16384];
 	ssize_t sz = read(child_fd, buf, sizeof(buf));
 	if (sz < 0) {
-		if (errno != EINTR)
+		if (errno != EAGAIN && errno != EINTR)
 			error_clnt("read error: %s\n", strerror(errno));
 		return;
 	}
diff --git a/cache.h b/cache.h
index 38a20a8..a9583ff 100644
--- a/cache.h
+++ b/cache.h
@@ -432,6 +432,7 @@ extern char *git_commit_encoding;
 extern char *git_log_output_encoding;
 
 extern int copy_fd(int ifd, int ofd);
+extern int read_in_full(int fd, void *buf, size_t count);
 extern void read_or_die(int fd, void *buf, size_t count);
 extern int write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
diff --git a/dir.c b/dir.c
index 0338d6c..32b57f0 100644
--- a/dir.c
+++ b/dir.c
@@ -142,7 +142,7 @@ static int add_excludes_from_file_1(const char *fname,
 		return 0;
 	}
 	buf = xmalloc(size+1);
-	if (read(fd, buf, size) != size)
+	if (read_in_full(fd, buf, size) != size)
 		goto err;
 	close(fd);
 
diff --git a/http-fetch.c b/http-fetch.c
index 396552d..50a3b00 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -175,7 +175,7 @@ static void start_object_request(struct object_request *obj_req)
 	prevlocal = open(prevfile, O_RDONLY);
 	if (prevlocal != -1) {
 		do {
-			prev_read = read(prevlocal, prev_buf, PREV_BUF_SIZE);
+			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
 			if (prev_read>0) {
 				if (fwrite_sha1_file(prev_buf,
 						     1,
diff --git a/http-push.c b/http-push.c
index ecefdfd..acb5c27 100644
--- a/http-push.c
+++ b/http-push.c
@@ -288,7 +288,7 @@ static void start_fetch_loose(struct transfer_request *request)
 	prevlocal = open(prevfile, O_RDONLY);
 	if (prevlocal != -1) {
 		do {
-			prev_read = read(prevlocal, prev_buf, PREV_BUF_SIZE);
+			prev_read = xread(prevlocal, prev_buf, PREV_BUF_SIZE);
 			if (prev_read>0) {
 				if (fwrite_sha1_file(prev_buf,
 						     1,
diff --git a/imap-send.c b/imap-send.c
index ad91858..8de19e3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -224,7 +224,7 @@ socket_perror( const char *func, Socket_t *sock, int ret )
 static int
 socket_read( Socket_t *sock, char *buf, int len )
 {
-	int n = read( sock->fd, buf, len );
+	int n = xread( sock->fd, buf, len );
 	if (n <= 0) {
 		socket_perror( "read", sock, n );
 		close( sock->fd );
@@ -390,7 +390,7 @@ arc4_init( void )
 		fprintf( stderr, "Fatal: no random number source available.\n" );
 		exit( 3 );
 	}
-	if (read( fd, dat, 128 ) != 128) {
+	if (read_in_full( fd, dat, 128 ) != 128) {
 		fprintf( stderr, "Fatal: cannot read random number source.\n" );
 		exit( 3 );
 	}
diff --git a/index-pack.c b/index-pack.c
index 5f6d128..e9a5303 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -638,7 +638,7 @@ static void readjust_pack_header_and_sha1(unsigned char *sha1)
 	/* Rewrite pack header with updated object number */
 	if (lseek(output_fd, 0, SEEK_SET) != 0)
 		die("cannot seek back: %s", strerror(errno));
-	if (xread(output_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
+	if (read_in_full(output_fd, &hdr, sizeof(hdr)) != sizeof(hdr))
 		die("cannot read pack header back: %s", strerror(errno));
 	hdr.hdr_entries = htonl(nr_objects);
 	if (lseek(output_fd, 0, SEEK_SET) != 0)
diff --git a/local-fetch.c b/local-fetch.c
index 7b6875c..cf99cb7 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -184,7 +184,7 @@ int fetch_ref(char *ref, unsigned char *sha1)
 		fprintf(stderr, "cannot open %s\n", filename);
 		return -1;
 	}
-	if (read(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
+	if (read_in_full(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
 		close(ifd);
 		fprintf(stderr, "cannot read from %s\n", filename);
 		return -1;
diff --git a/path.c b/path.c
index 066f621..bb5ee7b 100644
--- a/path.c
+++ b/path.c
@@ -113,7 +113,7 @@ int validate_symref(const char *path)
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
-	len = read(fd, buffer, sizeof(buffer)-1);
+	len = read_in_full(fd, buffer, sizeof(buffer)-1);
 	close(fd);
 
 	/*
diff --git a/refs.c b/refs.c
index 5205745..2b69e1e 100644
--- a/refs.c
+++ b/refs.c
@@ -284,7 +284,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return NULL;
-		len = read(fd, buffer, sizeof(buffer)-1);
+		len = read_in_full(fd, buffer, sizeof(buffer)-1);
 		close(fd);
 
 		/*
diff --git a/sha1_file.c b/sha1_file.c
index d9622d9..0c9483c 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1869,7 +1869,7 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
 			if (ret != Z_OK)
 				break;
 		}
-		size = read(fd, buffer + *bufposn, bufsize - *bufposn);
+		size = xread(fd, buffer + *bufposn, bufsize - *bufposn);
 		if (size <= 0) {
 			close(local);
 			unlink(tmpfile);
diff --git a/ssh-fetch.c b/ssh-fetch.c
index b006c5c..72965d6 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -82,7 +82,7 @@ int fetch(unsigned char *sha1)
 		remote = conn_buf[0];
 		memmove(conn_buf, conn_buf + 1, --conn_buf_posn);
 	} else {
-		if (read(fd_in, &remote, 1) < 1)
+		if (xread(fd_in, &remote, 1) < 1)
 			return -1;
 	}
 	/* fprintf(stderr, "Got %d\n", remote); */
@@ -99,7 +99,7 @@ static int get_version(void)
 	char type = 'v';
 	write(fd_out, &type, 1);
 	write(fd_out, &local_version, 1);
-	if (read(fd_in, &remote_version, 1) < 1) {
+	if (xread(fd_in, &remote_version, 1) < 1) {
 		return error("Couldn't read version from remote end");
 	}
 	return 0;
@@ -111,10 +111,13 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	char type = 'r';
 	write(fd_out, &type, 1);
 	write(fd_out, ref, strlen(ref) + 1);
-	read(fd_in, &remote, 1);
+
+	if (read_in_full(fd_in, &remote, 1) != 1)
+		return -1;
 	if (remote < 0)
 		return remote;
-	read(fd_in, sha1, 20);
+	if (read_in_full(fd_in, sha1, 20) != 20)
+		return -1;
 	return 0;
 }
 
diff --git a/ssh-upload.c b/ssh-upload.c
index 0b52ae1..2747f96 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -21,17 +21,14 @@ static int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
 	unsigned char sha1[20];
 	signed char remote;
-	int posn = 0;
-	do {
-		size = read(fd_in, sha1 + posn, 20 - posn);
-		if (size < 0) {
-			perror("git-ssh-upload: read ");
-			return -1;
-		}
-		if (!size)
-			return -1;
-		posn += size;
-	} while (posn < 20);
+
+	size = read_in_full(fd_in, sha1, 20);
+	if (size < 0) {
+		perror("git-ssh-upload: read ");
+		return -1;
+	}
+	if (!size)
+		return -1;
 	
 	if (verbose)
 		fprintf(stderr, "Serving %s\n", sha1_to_hex(sha1));
@@ -54,7 +51,7 @@ static int serve_object(int fd_in, int fd_out) {
 
 static int serve_version(int fd_in, int fd_out)
 {
-	if (read(fd_in, &remote_version, 1) < 1)
+	if (xread(fd_in, &remote_version, 1) < 1)
 		return -1;
 	write(fd_out, &local_version, 1);
 	return 0;
@@ -67,7 +64,7 @@ static int serve_ref(int fd_in, int fd_out)
 	int posn = 0;
 	signed char remote = 0;
 	do {
-		if (read(fd_in, ref + posn, 1) < 1)
+		if (xread(fd_in, ref + posn, 1) < 1)
 			return -1;
 		posn++;
 	} while (ref[posn - 1]);
@@ -89,7 +86,7 @@ static void service(int fd_in, int fd_out) {
 	char type;
 	int retval;
 	do {
-		retval = read(fd_in, &type, 1);
+		retval = xread(fd_in, &type, 1);
 		if (retval < 1) {
 			if (retval < 0)
 				perror("git-ssh-upload: read ");
diff --git a/upload-pack.c b/upload-pack.c
index c568ef0..03a4156 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -242,7 +242,7 @@ static void create_pack_file(void)
 					*cp++ = buffered;
 					outsz++;
 				}
-				sz = read(pu_pipe[0], cp,
+				sz = xread(pu_pipe[0], cp,
 					  sizeof(data) - outsz);
 				if (0 < sz)
 						;
@@ -267,7 +267,7 @@ static void create_pack_file(void)
 				/* Status ready; we ship that in the side-band
 				 * or dump to the standard error.
 				 */
-				sz = read(pe_pipe[0], progress,
+				sz = xread(pe_pipe[0], progress,
 					  sizeof(progress));
 				if (0 < sz)
 					send_client_data(2, progress, sz);
diff --git a/write_or_die.c b/write_or_die.c
index 613c0c3..e7f8263 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,19 +1,36 @@
 #include "cache.h"
 
-void read_or_die(int fd, void *buf, size_t count)
+int read_in_full(int fd, void *buf, size_t count)
 {
 	char *p = buf;
-	ssize_t loaded;
+	ssize_t total = 0;
+	ssize_t loaded = 0;
 
 	while (count > 0) {
 		loaded = xread(fd, p, count);
-		if (loaded == 0)
-			die("unexpected end of file");
-		else if (loaded < 0)
-			die("read error (%s)", strerror(errno));
+		if (loaded <= 0) {
+			if (total)
+				return total;
+			else
+				return loaded;
+		}
 		count -= loaded;
 		p += loaded;
+		total += loaded;
 	}
+
+	return total;
+}
+
+void read_or_die(int fd, void *buf, size_t count)
+{
+	ssize_t loaded;
+
+	loaded = read_in_full(fd, buf, count);
+	if (loaded == 0)
+		die("unexpected end of file");
+	else if (loaded < 0)
+		die("read error (%s)", strerror(errno));
 }
 
 void write_or_die(int fd, const void *buf, size_t count)
