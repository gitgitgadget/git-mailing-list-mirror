From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] use xread where we are not checking for EAGAIN/EINTR
Date: Fri, 05 Jan 2007 10:54:33 +0000
Message-ID: <1cb8699724ff000fbf0c14ba3e15031e@pinky>
X-From: git-owner@vger.kernel.org Fri Jan 05 11:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2mie-0004hP-7X
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 11:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161054AbXAEKyh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 05:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbXAEKyh
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 05:54:37 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:38537
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161054AbXAEKyf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 05:54:35 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1H2miX-0004bJ-47
	for git@vger.kernel.org; Fri, 05 Jan 2007 10:54:33 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35992>


We have xread() to handle those OS's which will return EAGAIN or
EINTR when the read is interrupted.  We should use this where we
are not otherwise handling such errors.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---

    We have an xread() wrapper to help us with those nasty
    interrupt returns and yet we fail to use it consistently.
    This patch updates those plain read()'s which do not
    have any handling for errors, or which treat those errors
    as user visible fatal errors.

    This feels right to me, but perhaps there is some good
    reason that things are done this way ... if so could
    someone elighten me.

    If this is a sensible change, then I'll have a look at
    the write side.
---
diff --git a/dir.c b/dir.c
index 0338d6c..8fe0865 100644
--- a/dir.c
+++ b/dir.c
@@ -142,7 +142,7 @@ static int add_excludes_from_file_1(const char *fname,
 		return 0;
 	}
 	buf = xmalloc(size+1);
-	if (read(fd, buf, size) != size)
+	if (xread(fd, buf, size) != size)
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
index ad91858..3f1e542 100644
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
+	if (xread( fd, dat, 128 ) != 128) {
 		fprintf( stderr, "Fatal: cannot read random number source.\n" );
 		exit( 3 );
 	}
diff --git a/local-fetch.c b/local-fetch.c
index 7b6875c..21bcf75 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -184,7 +184,7 @@ int fetch_ref(char *ref, unsigned char *sha1)
 		fprintf(stderr, "cannot open %s\n", filename);
 		return -1;
 	}
-	if (read(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
+	if (xread(ifd, hex, 40) != 40 || get_sha1_hex(hex, sha1)) {
 		close(ifd);
 		fprintf(stderr, "cannot read from %s\n", filename);
 		return -1;
diff --git a/path.c b/path.c
index 066f621..f6f9cfd 100644
--- a/path.c
+++ b/path.c
@@ -113,7 +113,7 @@ int validate_symref(const char *path)
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
-	len = read(fd, buffer, sizeof(buffer)-1);
+	len = xread(fd, buffer, sizeof(buffer)-1);
 	close(fd);
 
 	/*
diff --git a/refs.c b/refs.c
index 121774c..f6afd61 100644
--- a/refs.c
+++ b/refs.c
@@ -284,7 +284,7 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return NULL;
-		len = read(fd, buffer, sizeof(buffer)-1);
+		len = xread(fd, buffer, sizeof(buffer)-1);
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
index b006c5c..6ec9488 100644
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
@@ -111,10 +111,10 @@ int fetch_ref(char *ref, unsigned char *sha1)
 	char type = 'r';
 	write(fd_out, &type, 1);
 	write(fd_out, ref, strlen(ref) + 1);
-	read(fd_in, &remote, 1);
+	xread(fd_in, &remote, 1);
 	if (remote < 0)
 		return remote;
-	read(fd_in, sha1, 20);
+	xread(fd_in, sha1, 20);
 	return 0;
 }
 
diff --git a/ssh-upload.c b/ssh-upload.c
index 0b52ae1..3f2794c 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -23,7 +23,7 @@ static int serve_object(int fd_in, int fd_out) {
 	signed char remote;
 	int posn = 0;
 	do {
-		size = read(fd_in, sha1 + posn, 20 - posn);
+		size = xread(fd_in, sha1 + posn, 20 - posn);
 		if (size < 0) {
 			perror("git-ssh-upload: read ");
 			return -1;
@@ -54,7 +54,7 @@ static int serve_object(int fd_in, int fd_out) {
 
 static int serve_version(int fd_in, int fd_out)
 {
-	if (read(fd_in, &remote_version, 1) < 1)
+	if (xread(fd_in, &remote_version, 1) < 1)
 		return -1;
 	write(fd_out, &local_version, 1);
 	return 0;
@@ -67,7 +67,7 @@ static int serve_ref(int fd_in, int fd_out)
 	int posn = 0;
 	signed char remote = 0;
 	do {
-		if (read(fd_in, ref + posn, 1) < 1)
+		if (xread(fd_in, ref + posn, 1) < 1)
 			return -1;
 		posn++;
 	} while (ref[posn - 1]);
@@ -89,7 +89,7 @@ static void service(int fd_in, int fd_out) {
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
