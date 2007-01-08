From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 3/4] short i/o: fix calls to write to use xwrite or write_in_full
Date: Mon, 08 Jan 2007 15:58:23 +0000
Message-ID: <9120c8418678fa5fe59f86abc7fb86b0@pinky>
References: <45A2699F.5060100@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 16:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3wtL-0001K0-T5
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 16:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbXAHP62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 10:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbXAHP62
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 10:58:28 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:55594
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750872AbXAHP61 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jan 2007 10:58:27 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1H3wtD-0003Zc-CF
	for git@vger.kernel.org; Mon, 08 Jan 2007 15:58:23 +0000
To: git@vger.kernel.org
InReply-To: <45A2699F.5060100@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36270>


We have a number of badly checked write() calls.  Often we are
expecting write() to write exactly the size we requested or fail,
this fails to handle interrupts or short writes.  Switch to using
the new write_in_full().  Otherwise we at a minimum need to check
for EINTR and EAGAIN, where this is appropriate use xwrite().

Note, the changes to config handling are much larger and handled
in the next patch in the sequence.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 079c0bd..318d959 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -51,9 +51,11 @@ static int write_rr(struct path_list *rr, int out_fd)
 	int i;
 	for (i = 0; i < rr->nr; i++) {
 		const char *path = rr->items[i].path;
-		write(out_fd, rr->items[i].util, 40);
-		write(out_fd, "\t", 1);
-		write(out_fd, path, strlen(path) + 1);
+		int length = strlen(path) + 1;
+		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
+		    write_in_full(out_fd, "\t", 1) != 1 ||
+		    write_in_full(out_fd, path, length) != length)
+			die("unable to write rerere record");
 	}
 	close(out_fd);
 	return commit_lock_file(&write_lock);
@@ -244,7 +246,8 @@ static int outf(void *dummy, mmbuffer_t *ptr, int nbuf)
 {
 	int i;
 	for (i = 0; i < nbuf; i++)
-		write(1, ptr[i].ptr, ptr[i].size);
+		if (write_in_full(1, ptr[i].ptr, ptr[i].size) != ptr[i].size)
+			return -1;
 	return 0;
 }
 
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index ad802fc..8055dda 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -82,7 +82,7 @@ int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix)
 	if (memcmp(content, "52 comment=", 11))
 		return 1;
 
-	n = xwrite(1, content + 11, 41);
+	n = write_in_full(1, content + 11, 41);
 	if (n < 41)
 		die("git-get-tar-commit-id: write error");
 
diff --git a/commit.c b/commit.c
index 2a58175..9ce45ce 100644
--- a/commit.c
+++ b/commit.c
@@ -249,8 +249,10 @@ int write_shallow_commits(int fd, int use_pack_protocol)
 			if (use_pack_protocol)
 				packet_write(fd, "shallow %s", hex);
 			else {
-				write(fd, hex,  40);
-				write(fd, "\n", 1);
+				if (write_in_full(fd, hex,  40) != 40)
+					break;
+				if (write_in_full(fd, "\n", 1) != 1)
+					break;
 			}
 		}
 	return count;
diff --git a/daemon.c b/daemon.c
index b129b83..f039534 100644
--- a/daemon.c
+++ b/daemon.c
@@ -102,7 +102,7 @@ static void logreport(int priority, const char *err, va_list params)
 	buf[buflen++] = '\n';
 	buf[buflen] = '\0';
 
-	write(2, buf, buflen);
+	write_in_full(2, buf, buflen);
 }
 
 static void logerror(const char *err, ...)
diff --git a/diff.c b/diff.c
index 1fee15a..f11a633 100644
--- a/diff.c
+++ b/diff.c
@@ -1403,7 +1403,7 @@ static void prep_temp_blob(struct diff_tempfile *temp,
 	fd = git_mkstemp(temp->tmp_path, TEMPFILE_PATH_LEN, ".diff_XXXXXX");
 	if (fd < 0)
 		die("unable to create temp-file");
-	if (write(fd, blob, size) != size)
+	if (write_in_full(fd, blob, size) != size)
 		die("unable to write temp-file");
 	close(fd);
 	temp->name = temp->tmp_path;
diff --git a/entry.c b/entry.c
index 88df713..0ebf0f0 100644
--- a/entry.c
+++ b/entry.c
@@ -89,7 +89,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 			return error("git-checkout-index: unable to create file %s (%s)",
 				path, strerror(errno));
 		}
-		wrote = write(fd, new, size);
+		wrote = write_in_full(fd, new, size);
 		close(fd);
 		free(new);
 		if (wrote != size)
@@ -104,7 +104,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 				return error("git-checkout-index: unable to create "
 						 "file %s (%s)", path, strerror(errno));
 			}
-			wrote = write(fd, new, size);
+			wrote = write_in_full(fd, new, size);
 			close(fd);
 			free(new);
 			if (wrote != size)
diff --git a/http-fetch.c b/http-fetch.c
index 50a3b00..fe8cd7b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -71,7 +71,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	int posn = 0;
 	struct object_request *obj_req = (struct object_request *)data;
 	do {
-		ssize_t retval = write(obj_req->local,
+		ssize_t retval = xwrite(obj_req->local,
 				       (char *) ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
diff --git a/http-push.c b/http-push.c
index acb5c27..7e73eac 100644
--- a/http-push.c
+++ b/http-push.c
@@ -195,7 +195,7 @@ static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 	int posn = 0;
 	struct transfer_request *request = (struct transfer_request *)data;
 	do {
-		ssize_t retval = write(request->local_fileno,
+		ssize_t retval = xwrite(request->local_fileno,
 				       (char *) ptr + posn, size - posn);
 		if (retval < 0)
 			return posn;
diff --git a/imap-send.c b/imap-send.c
index 8de19e3..3eaf025 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -236,7 +236,7 @@ socket_read( Socket_t *sock, char *buf, int len )
 static int
 socket_write( Socket_t *sock, const char *buf, int len )
 {
-	int n = write( sock->fd, buf, len );
+	int n = write_in_full( sock->fd, buf, len );
 	if (n != len) {
 		socket_perror( "write", sock, n );
 		close( sock->fd );
diff --git a/index-pack.c b/index-pack.c
index e9a5303..8d10d6b 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -814,7 +814,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		char buf[48];
 		int len = snprintf(buf, sizeof(buf), "%s\t%s\n",
 				   report, sha1_to_hex(sha1));
-		xwrite(1, buf, len);
+		write_in_full(1, buf, len);
 
 		/*
 		 * Let's just mimic git-unpack-objects here and write
diff --git a/merge-recursive.c b/merge-recursive.c
index bac16f5..87a27e0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -517,7 +517,7 @@ static int mkdir_p(const char *path, unsigned long mode)
 static void flush_buffer(int fd, const char *buf, unsigned long size)
 {
 	while (size > 0) {
-		long ret = xwrite(fd, buf, size);
+		long ret = write_in_full(fd, buf, size);
 		if (ret < 0) {
 			/* Ignore epipe */
 			if (errno == EPIPE)
diff --git a/read-cache.c b/read-cache.c
index 29cf9ab..8ecd826 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -870,7 +870,7 @@ static int ce_write_flush(SHA_CTX *context, int fd)
 	unsigned int buffered = write_buffer_len;
 	if (buffered) {
 		SHA1_Update(context, write_buffer, buffered);
-		if (write(fd, write_buffer, buffered) != buffered)
+		if (write_in_full(fd, write_buffer, buffered) != buffered)
 			return -1;
 		write_buffer_len = 0;
 	}
@@ -919,7 +919,7 @@ static int ce_flush(SHA_CTX *context, int fd)
 
 	/* Flush first if not enough space for SHA1 signature */
 	if (left + 20 > WRITE_BUFFER_SIZE) {
-		if (write(fd, write_buffer, left) != left)
+		if (write_in_full(fd, write_buffer, left) != left)
 			return -1;
 		left = 0;
 	}
@@ -927,7 +927,7 @@ static int ce_flush(SHA_CTX *context, int fd)
 	/* Append the SHA1 signature at the end */
 	SHA1_Final(write_buffer + left, context);
 	left += 20;
-	return (write(fd, write_buffer, left) != left) ? -1 : 0;
+	return (write_in_full(fd, write_buffer, left) != left) ? -1 : 0;
 }
 
 static void ce_smudge_racily_clean_entry(struct cache_entry *ce)
diff --git a/refs.c b/refs.c
index 2b69e1e..4d6fad8 100644
--- a/refs.c
+++ b/refs.c
@@ -332,7 +332,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master)
 	}
 	lockpath = mkpath("%s.lock", git_HEAD);
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);	
-	written = write(fd, ref, len);
+	written = write_in_full(fd, ref, len);
 	close(fd);
 	if (written != len) {
 		unlink(lockpath);
@@ -968,7 +968,7 @@ static int log_ref_write(struct ref_lock *lock,
 			sha1_to_hex(sha1),
 			committer);
 	}
-	written = len <= maxlen ? write(logfd, logrec, len) : -1;
+	written = len <= maxlen ? write_in_full(logfd, logrec, len) : -1;
 	free(logrec);
 	close(logfd);
 	if (written != len)
@@ -987,8 +987,8 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return 0;
 	}
-	if (write(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
-	    write(lock->lock_fd, &term, 1) != 1
+	if (write_in_full(lock->lock_fd, sha1_to_hex(sha1), 40) != 40 ||
+	    write_in_full(lock->lock_fd, &term, 1) != 1
 		|| close(lock->lock_fd) < 0) {
 		error("Couldn't write %s", lock->lk->filename);
 		unlock_ref(lock);
diff --git a/sha1_file.c b/sha1_file.c
index 0c9483c..095a7e1 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1611,20 +1611,13 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 
 static int write_buffer(int fd, const void *buf, size_t len)
 {
-	while (len) {
-		ssize_t size;
+	ssize_t size;
 
-		size = write(fd, buf, len);
-		if (!size)
-			return error("file write: disk full");
-		if (size < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
-			return error("file write error (%s)", strerror(errno));
-		}
-		len -= size;
-		buf = (char *) buf + size;
-	}
+	size = write_in_full(fd, buf, len);
+	if (!size)
+		return error("file write: disk full");
+	if (size < 0)
+		return error("file write error (%s)", strerror(errno));
 	return 0;
 }
 
diff --git a/ssh-fetch.c b/ssh-fetch.c
index 72965d6..4c172b6 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -20,22 +20,6 @@ static int fd_out;
 static unsigned char remote_version;
 static unsigned char local_version = 1;
 
-static ssize_t force_write(int fd, void *buffer, size_t length)
-{
-	ssize_t ret = 0;
-	while (ret < length) {
-		ssize_t size = write(fd, (char *) buffer + ret, length - ret);
-		if (size < 0) {
-			return size;
-		}
-		if (size == 0) {
-			return ret;
-		}
-		ret += size;
-	}
-	return ret;
-}
-
 static int prefetches;
 
 static struct object_list *in_transit;
@@ -53,8 +37,9 @@ void prefetch(unsigned char *sha1)
 	node->item = lookup_unknown_object(sha1);
 	*end_of_transit = node;
 	end_of_transit = &node->next;
-	force_write(fd_out, &type, 1);
-	force_write(fd_out, sha1, 20);
+	/* XXX: what if these writes fail? */
+	write_in_full(fd_out, &type, 1);
+	write_in_full(fd_out, sha1, 20);
 	prefetches++;
 }
 
@@ -97,8 +82,10 @@ int fetch(unsigned char *sha1)
 static int get_version(void)
 {
 	char type = 'v';
-	write(fd_out, &type, 1);
-	write(fd_out, &local_version, 1);
+	if (write_in_full(fd_out, &type, 1) != 1 ||
+	    write_in_full(fd_out, &local_version, 1)) {
+		return error("Couldn't request version from remote end");
+	}
 	if (xread(fd_in, &remote_version, 1) < 1) {
 		return error("Couldn't read version from remote end");
 	}
@@ -109,8 +96,10 @@ int fetch_ref(char *ref, unsigned char *sha1)
 {
 	signed char remote;
 	char type = 'r';
-	write(fd_out, &type, 1);
-	write(fd_out, ref, strlen(ref) + 1);
+	int length = strlen(ref) + 1;
+	if (write_in_full(fd_out, &type, 1) != 1 ||
+	    write_in_full(fd_out, ref, length) != length)
+		return -1;
 
 	if (read_in_full(fd_in, &remote, 1) != 1)
 		return -1;
diff --git a/ssh-upload.c b/ssh-upload.c
index 2747f96..07e61e5 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -41,7 +41,8 @@ static int serve_object(int fd_in, int fd_out) {
 		remote = -1;
 	}
 	
-	write(fd_out, &remote, 1);
+	if (write_in_full(fd_out, &remote, 1) != 1)
+		return 0;
 	
 	if (remote < 0)
 		return 0;
@@ -53,7 +54,7 @@ static int serve_version(int fd_in, int fd_out)
 {
 	if (xread(fd_in, &remote_version, 1) < 1)
 		return -1;
-	write(fd_out, &local_version, 1);
+	write_in_full(fd_out, &local_version, 1);
 	return 0;
 }
 
@@ -74,10 +75,11 @@ static int serve_ref(int fd_in, int fd_out)
 
 	if (get_ref_sha1(ref, sha1))
 		remote = -1;
-	write(fd_out, &remote, 1);
+	if (write_in_full(fd_out, &remote, 1) != 1)
+		return 0;
 	if (remote)
 		return 0;
-	write(fd_out, sha1, 20);
+	write_in_full(fd_out, sha1, 20);
         return 0;
 }
 
diff --git a/test-delta.c b/test-delta.c
index 795aa08..16595ef 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -68,7 +68,7 @@ int main(int argc, char *argv[])
 	}
 
 	fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
-	if (fd < 0 || write(fd, out_buf, out_size) != out_size) {
+	if (fd < 0 || write_in_full(fd, out_buf, out_size) != out_size) {
 		perror(argv[4]);
 		return 1;
 	}
diff --git a/unpack-file.c b/unpack-file.c
index ccddf1d..d24acc2 100644
--- a/unpack-file.c
+++ b/unpack-file.c
@@ -17,7 +17,7 @@ static char *create_temp_file(unsigned char *sha1)
 	fd = mkstemp(path);
 	if (fd < 0)
 		die("unable to create temp-file");
-	if (write(fd, buf, size) != size)
+	if (write_in_full(fd, buf, size) != size)
 		die("unable to write temp-file");
 	close(fd);
 	return path;
diff --git a/upload-pack.c b/upload-pack.c
index 03a4156..3a466c6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,6 +55,7 @@ static ssize_t send_client_data(int fd, const char *data, ssize_t sz)
 		/* emergency quit */
 		fd = 2;
 	if (fd == 2) {
+		/* XXX: are we happy to lose stuff here? */
 		xwrite(fd, data, sz);
 		return sz;
 	}
diff --git a/write_or_die.c b/write_or_die.c
index e7f8263..a119e1d 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -33,45 +33,40 @@ void read_or_die(int fd, void *buf, size_t count)
 		die("read error (%s)", strerror(errno));
 }
 
-void write_or_die(int fd, const void *buf, size_t count)
+int write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
-	ssize_t written;
+	ssize_t total = 0;
+	ssize_t written = 0;
 
 	while (count > 0) {
 		written = xwrite(fd, p, count);
-		if (written == 0)
-			die("disk full?");
-		else if (written < 0) {
-			if (errno == EPIPE)
-				exit(0);
-			die("write error (%s)", strerror(errno));
+		if (written <= 0) {
+			if (total)
+				return total;
+			else
+				return written;
 		}
 		count -= written;
 		p += written;
+		total += written;
 	}
+
+	return total;
 }
 
-int write_in_full(int fd, const void *buf, size_t count)
+void write_or_die(int fd, const void *buf, size_t count)
 {
-	const char *p = buf;
-	ssize_t total = 0;
-	ssize_t wcount = 0;
+	ssize_t written;
 
-	while (count > 0) {
-		wcount = xwrite(fd, p, count);
-		if (wcount <= 0) {
-			if (total)
-				return total;
-			else
-				return wcount;
-		}
-		count -= wcount;
-		p += wcount;
-		total += wcount;
+	written = write_in_full(fd, buf, count);
+	if (written == 0)
+		die("disk full?");
+	else if (written < 0) {
+		if (errno == EPIPE)
+			exit(0);
+		die("write error (%s)", strerror(errno));
 	}
-
-	return wcount;
 }
 
 int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
