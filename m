From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 1/4] short i/o: clean up the naming for the write_{in,or}_xxx family
Date: Mon, 08 Jan 2007 15:57:52 +0000
Message-ID: <25af6e84117845e1ca282192b77e5e67@pinky>
References: <45A2699F.5060100@shadowen.org>
X-From: git-owner@vger.kernel.org Mon Jan 08 16:58:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3wsq-0001Bt-HC
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 16:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161323AbXAHP54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 10:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbXAHP54
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 10:57:56 -0500
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:55589
	"EHLO localhost.localdomain" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1161323AbXAHP5z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jan 2007 10:57:55 -0500
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by localhost.localdomain with esmtp (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1H3wsi-0003VA-Qo
	for git@vger.kernel.org; Mon, 08 Jan 2007 15:57:52 +0000
To: git@vger.kernel.org
InReply-To: <45A2699F.5060100@shadowen.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36268>


We recently introduced a write_in_full() which would either write
the specified object or emit an error message and fail.  In order
to fix the read side we now want to introduce a read_in_full()
but without an error emit.  This patch cleans up the naming
of this family of calls:

1) convert the existing write_or_whine() to write_or_whine_pipe()
   to better indicate its pipe specific nature,
2) convert the existing write_in_full() calls to write_or_whine()
   to better indicate its nature,
3) introduce a write_in_full() providing a write or fail semantic,
   and
4) convert write_or_whine() and write_or_whine_pipe() to use
   write_in_full().

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/cache.h b/cache.h
index 36be64e..38a20a8 100644
--- a/cache.h
+++ b/cache.h
@@ -433,9 +433,10 @@ extern char *git_log_output_encoding;
 
 extern int copy_fd(int ifd, int ofd);
 extern void read_or_die(int fd, void *buf, size_t count);
-extern int write_in_full(int fd, const void *buf, size_t count, const char *);
+extern int write_in_full(int fd, const void *buf, size_t count);
 extern void write_or_die(int fd, const void *buf, size_t count);
 extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
+extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
 
 /* pager.c */
 extern void setup_pager(void);
diff --git a/send-pack.c b/send-pack.c
index c195d08..6756264 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -65,14 +65,14 @@ static int pack_objects(int fd, struct ref *refs)
 			memcpy(buf + 1, sha1_to_hex(refs->old_sha1), 40);
 			buf[0] = '^';
 			buf[41] = '\n';
-			if (!write_in_full(pipe_fd[1], buf, 42,
+			if (!write_or_whine(pipe_fd[1], buf, 42,
 						"send-pack: send refs"))
 				break;
 		}
 		if (!is_null_sha1(refs->new_sha1)) {
 			memcpy(buf, sha1_to_hex(refs->new_sha1), 40);
 			buf[40] = '\n';
-			if (!write_in_full(pipe_fd[1], buf, 41,
+			if (!write_or_whine(pipe_fd[1], buf, 41,
 						"send-pack: send refs"))
 				break;
 		}
diff --git a/trace.c b/trace.c
index 495e5ed..27fef86 100644
--- a/trace.c
+++ b/trace.c
@@ -101,7 +101,7 @@ void trace_printf(const char *format, ...)
 	nfvasprintf(&trace_str, format, rest);
 	va_end(rest);
 
-	write_or_whine(fd, trace_str, strlen(trace_str), err_msg);
+	write_or_whine_pipe(fd, trace_str, strlen(trace_str), err_msg);
 
 	free(trace_str);
 
@@ -139,7 +139,7 @@ void trace_argv_printf(const char **argv, int count, const char *format, ...)
 	strncpy(trace_str + format_len, argv_str, argv_len);
 	strcpy(trace_str + trace_len - 1, "\n");
 
-	write_or_whine(fd, trace_str, trace_len, err_msg);
+	write_or_whine_pipe(fd, trace_str, trace_len, err_msg);
 
 	free(argv_str);
 	free(format_str);
diff --git a/write_or_die.c b/write_or_die.c
index 6db1d31..613c0c3 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -35,49 +35,61 @@ void write_or_die(int fd, const void *buf, size_t count)
 	}
 }
 
-int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
+int write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
-	ssize_t written;
+	ssize_t total = 0;
+	ssize_t wcount = 0;
 
 	while (count > 0) {
-		written = xwrite(fd, p, count);
-		if (written == 0) {
-			fprintf(stderr, "%s: disk full?\n", msg);
-			return 0;
-		}
-		else if (written < 0) {
-			if (errno == EPIPE)
-				exit(0);
-			fprintf(stderr, "%s: write error (%s)\n",
-				msg, strerror(errno));
-			return 0;
+		wcount = xwrite(fd, p, count);
+		if (wcount <= 0) {
+			if (total)
+				return total;
+			else
+				return wcount;
 		}
-		count -= written;
-		p += written;
+		count -= wcount;
+		p += wcount;
+		total += wcount;
+	}
+
+	return wcount;
+}
+
+int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
+{
+	ssize_t written;
+
+	written = write_in_full(fd, buf, count);
+	if (written == 0) {
+		fprintf(stderr, "%s: disk full?\n", msg);
+		return 0;
+	}
+	else if (written < 0) {
+		if (errno == EPIPE)
+			exit(0);
+		fprintf(stderr, "%s: write error (%s)\n",
+			msg, strerror(errno));
+		return 0;
 	}
 
 	return 1;
 }
 
-int write_in_full(int fd, const void *buf, size_t count, const char *msg)
+int write_or_whine(int fd, const void *buf, size_t count, const char *msg)
 {
-	const char *p = buf;
 	ssize_t written;
 
-	while (count > 0) {
-		written = xwrite(fd, p, count);
-		if (written == 0) {
-			fprintf(stderr, "%s: disk full?\n", msg);
-			return 0;
-		}
-		else if (written < 0) {
-			fprintf(stderr, "%s: write error (%s)\n",
-				msg, strerror(errno));
-			return 0;
-		}
-		count -= written;
-		p += written;
+	written = write_in_full(fd, buf, count);
+	if (written == 0) {
+		fprintf(stderr, "%s: disk full?\n", msg);
+		return 0;
+	}
+	else if (written < 0) {
+		fprintf(stderr, "%s: write error (%s)\n",
+			msg, strerror(errno));
+		return 0;
 	}
 
 	return 1;
