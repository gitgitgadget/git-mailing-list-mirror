From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [WIP PATCH] vcs-svn: Add an svndiff0 parser
Date: Sat,  4 Sep 2010 13:13:34 +0530
Message-ID: <1283586214-31204-2-git-send-email-artagnon@gmail.com>
References: <1283586214-31204-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 09:46:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrnRp-0005hV-MC
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 09:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab0IDHps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 03:45:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37398 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0IDHpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 03:45:47 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so451436pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 00:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=heQNJPJS3Rfo24HJOUtb9J/iMqq9bBYymjJdV0xLCQQ=;
        b=GLYlbPQC9soqcjZkBBKG0+GxyeU6QBoRq2bXi9ZzdV1Kg0KTmAy+IYD3IYXkVTVbd/
         fKEDnEPa9ueWfLBd7FYv9ztou1cYB/IGmIs08p9BNUyYxLddy7MGxzZL9jnrfEC5CnZz
         eGE8f+YZowj8SZdYNnc/EB5P9tyLgQ6avIU84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZOTKcEz8YK65/smFO6uCU3caqTsorBZzprm5o1/P47RJzags8jRislj1h9O+FxKRxB
         99g0/8MiOKq2IOxEcmTXpZ+v/kNkrJ4oK0neyfe7M/hfwhSCI2JK2mssGsSSVby+ssZ3
         vdveE1JgoJtaS0j6XKhpDcpDJmGytrJ+9y5qo=
Received: by 10.115.109.6 with SMTP id l6mr422323wam.164.1283586346830;
        Sat, 04 Sep 2010 00:45:46 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id d38sm5551613wam.20.2010.09.04.00.45.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 00:45:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1283586214-31204-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155311>

Add a parser to apply one window from an svndiff version 0 stream to a
given source. svndiff version 0 is used by dumpfile version 3; this is
one step towards getting svn-fe to parse the output produced by
svnrdump. The svndiff format is described in $SVN_TRUNK/notes/svndiff.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 vcs-svn/Makefile      |    2 +
 vcs-svn/line_buffer.c |    7 +-
 vcs-svn/line_buffer.h |    2 +-
 vcs-svn/svndiff.c     |  240 +++++++++++++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.h     |   41 +++++++++
 5 files changed, 288 insertions(+), 4 deletions(-)
 create mode 100644 vcs-svn/Makefile
 create mode 100644 vcs-svn/svndiff.c
 create mode 100644 vcs-svn/svndiff.h

diff --git a/vcs-svn/Makefile b/vcs-svn/Makefile
new file mode 100644
index 0000000..62cf093
--- /dev/null
+++ b/vcs-svn/Makefile
@@ -0,0 +1,2 @@
+default: svndiff.c line_buffer.c
+	$(CC) -I../ -g3 -O0 -o svndiff svndiff.c line_buffer.c
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 1543567..17618c0 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -66,15 +66,16 @@ char *buffer_read_string(uint32_t len)
 	return ferror(infile) ? NULL : s;
 }
 
-void buffer_copy_bytes(uint32_t len)
+void buffer_copy_bytes(uint32_t len, FILE *dst)
 {
 	uint32_t in;
+	dst = dst ? dst : stdout;
 	while (len > 0 && !feof(infile) && !ferror(infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		in = fread(byte_buffer, 1, in, infile);
 		len -= in;
-		fwrite(byte_buffer, 1, in, stdout);
-		if (ferror(stdout)) {
+		fwrite(byte_buffer, 1, in, dst);
+		if (ferror(dst)) {
 			buffer_skip_bytes(len);
 			return;
 		}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 9c78ae1..fe67a22 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -5,7 +5,7 @@ int buffer_init(const char *filename);
 int buffer_deinit(void);
 char *buffer_read_line(void);
 char *buffer_read_string(uint32_t len);
-void buffer_copy_bytes(uint32_t len);
+void buffer_copy_bytes(uint32_t len, FILE *dst);
 void buffer_skip_bytes(uint32_t len);
 void buffer_reset(void);
 
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
new file mode 100644
index 0000000..2d66dce
--- /dev/null
+++ b/vcs-svn/svndiff.c
@@ -0,0 +1,241 @@
+#include "git-compat-util.h"
+#include "line_buffer.h"
+#include "svndiff.h"
+
+#define DEBUG 1
+
+#define SVN_DELTA_WINDOW_SIZE 102400
+#define MAX_ENCODED_INT_LEN 10
+#define MAX_INSTRUCTION_LEN (2*MAX_ENCODED_INT_LEN+1)
+#define MAX_INSTRUCTION_SECTION_LEN (SVN_DELTA_WINDOW_SIZE*MAX_INSTRUCTION_LEN)
+static char buf[SVN_DELTA_WINDOW_SIZE];
+
+/* Remove when linking to gitcore */
+void die(const char *err, ...)
+{
+	va_list params;
+	va_start(params, err);
+	vfprintf(stderr, err, params);
+	printf("\n");
+	va_end(params);
+	exit(128);
+}
+
+/* Return the number of bytes read */
+size_t read_one_size(size_t *size)
+{
+	unsigned char c;
+	size_t result, bsize;
+	result = 0;
+	bsize = 0;
+
+	while (1)
+	{
+		fread(&c, 1, 1, stdin);
+		result = (result << 7) | (c & 127);
+		bsize ++;
+		if (!(c & 128))
+			/* No continuation bit */
+			break;
+	}
+	*size = result;
+	return bsize;
+}
+
+/* Return the number of bytes read */
+size_t read_one_instruction(struct svndiff_instruction *op)
+{
+	unsigned char c;
+	size_t action, bsize;
+	bsize = 0;
+
+	/* Read the 1-byte instruction-selector */
+	fread(&c, 1, 1, stdin);
+	bsize ++;
+
+	/* Decode the instruction selector from the two higher order
+	   bits; the remaining 6 bits may contain the length */
+	action = (c >> 6) & 3;
+	if (action >= 3)
+		die("Invalid instruction %d", action);
+
+	op->action_code = (enum svndiff_action)(action);
+
+	/* Attempt to extract the length length from the remaining
+	   bits */
+	op->length = c & 63;
+	if (op->length == 0)
+	{
+		bsize += read_one_size(&(op->length));
+		if (op->length == 0)
+			die("Zero length instruction");
+	}
+	/* Offset is present if action is copyfrom_source or
+	   copyfrom_target */
+	if (action != copyfrom_new)
+		bsize += read_one_size(&(op->offset));
+	return bsize;
+}
+
+size_t read_instructions(struct svndiff_window *window, size_t *ninst)
+{
+	size_t tpos = 0, npos, bsize;
+	struct svndiff_instruction *op;
+	npos = 0;
+	bsize = 0;
+	*ninst = 0;
+	
+	while (bsize < window->ins_len)
+	{
+		++(*ninst);
+		window->ops = realloc(window->ops, (*ninst) * sizeof(*op));
+		op = window->ops + (*ninst) - 1;
+		bsize += read_one_instruction(op);
+
+		if (DEBUG)
+			fprintf(stderr, "Instruction: %d %d %d (%d)\n",
+				op->action_code, op->length, op->offset, bsize);
+
+		if (op == NULL)
+			die("Invalid diff stream: "
+			    "instruction %d cannot be decoded", *ninst);
+		else if (op->length == 0)
+			die("Invalid diff stream: "
+			    "instruction %d has length zero", *ninst);
+		else if (op->length > window->tview_len - tpos)
+			die("Invalid diff stream: "
+			    "instruction %d overflows the target view", *ninst);
+
+		switch (op->action_code)
+		{
+		case copyfrom_source:
+			if (op->length > window->sview_len - op->offset ||
+			    op->offset > window->sview_len)
+				die("Invalid diff stream: "
+				    "[src] instruction %d overflows "
+				    " the source view", *ninst);
+			break;
+		case copyfrom_target:
+			if (op->offset >= tpos)
+				die("Invalid diff stream: "
+				    "[tgt] instruction %d starts "
+				    "beyond the target view position", *ninst);
+			break;
+		case copyfrom_new:
+			if (op->length > window->newdata_len - npos)
+				die("Invalid diff stream: "
+				    "[new] instruction %d overflows "
+				    "the new data section", *ninst);
+			npos += op->length;
+			break;
+		}
+		tpos += op->length;
+	}
+
+	if (tpos != window->tview_len)
+		die("Delta does not fill the target window");
+	if (npos != window->newdata_len)
+		die("Delta does not contain enough new data");
+	return bsize;
+}
+
+size_t read_window_header(struct svndiff_window *window)
+{
+	size_t bsize = 0;
+
+	/* Read five sizes; various offsets and lengths */
+	bsize += read_one_size(&(window->sview_offset));
+	bsize += read_one_size(&(window->sview_len));
+	bsize += read_one_size(&(window->tview_len));
+	bsize += read_one_size(&(window->ins_len));
+	bsize += read_one_size(&(window->newdata_len));
+
+	if (window->tview_len > SVN_DELTA_WINDOW_SIZE ||
+	    window->sview_len > SVN_DELTA_WINDOW_SIZE ||
+	    window->newdata_len > SVN_DELTA_WINDOW_SIZE + MAX_ENCODED_INT_LEN ||
+	    window->ins_len > MAX_INSTRUCTION_SECTION_LEN)
+		die("Svndiff contains a window that's too large");
+
+	/* Check for integer overflow */
+	if (window->ins_len + window->newdata_len < window->ins_len
+	    || window->sview_len + window->tview_len < window->sview_len
+	    || window->sview_offset + window->sview_len < window->sview_offset)
+		die("Svndiff contains corrupt window header");
+
+	if (DEBUG)
+		fprintf(stderr, "Window header: %d %d %d %d %d\n",
+			window->sview_offset, window->sview_len,
+			window->tview_len, window->ins_len, window->newdata_len);
+	return bsize;
+}
+
+void drive_window(struct svndiff_window *window, FILE *src_fd)
+{
+	struct svndiff_instruction *op;
+	size_t ninst;
+	FILE *target_fd;
+	long target_fd_end;
+
+	/* Populate the first five fields of the the window object
+	   with data from the stream */	
+	read_window_header(window);
+
+	/* Read instructions of length ins_len into window->ops
+	   performing memory allocations as necessary */
+	read_instructions(window, &ninst);
+
+	/* The Applier */
+	/* We're now looking at new_data; read ahead only in the
+	   copyfrom_new case */	
+	target_fd = tmpfile();
+	for (op = window->ops; ninst-- > 0; op++) {
+		switch (op->action_code) {
+		case copyfrom_source:
+			fseek(src_fd, op->offset, SEEK_SET);
+			fread(buf, op->length, 1, src_fd);
+			fwrite(buf, op->length, 1, target_fd);
+			break;
+		case copyfrom_target:
+			fseek(target_fd, op->offset, SEEK_SET);
+			fread(buf, op->length, 1, target_fd);
+			fseek(target_fd, 0, SEEK_END);
+			fwrite(buf, op->length, 1, target_fd);
+			break;
+		case copyfrom_new:
+			fseek(target_fd, 0, SEEK_END);
+			buffer_copy_bytes(op->length, target_fd);
+			break;
+		}
+	}
+	free(window->ops);
+	target_fd_end = ftell(target_fd);
+	fseek(target_fd, 0, SEEK_SET);
+	fread(buf, target_fd_end, 1, target_fd);
+	fwrite(buf, target_fd_end, 1, stdout);
+	fclose (target_fd);
+}
+
+int main(int argc, char **argv)
+{
+	int version;
+	struct svndiff_window *window;
+	FILE *src_fd;
+	buffer_init(NULL);
+
+	/* Read off the 4-byte header: "SVN\0" */
+	fread(&buf, 4, 1, stdin);
+	version = atoi(buf + 3);
+	if (version != 0)
+		die("Version %d unsupported", version);
+
+	/* Setup the source to apply windows to */
+	src_fd = fopen(argv[1], "r");
+
+	/* Read and drive the first window */
+	window = malloc(sizeof(*window));
+	drive_window(window, src_fd);
+	free(window);
+
+	buffer_deinit();
+	return 0;
+}
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
new file mode 100644
index 0000000..6d0607f
--- /dev/null
+++ b/vcs-svn/svndiff.h
@@ -0,0 +1,41 @@
+enum svndiff_action {
+    copyfrom_source,
+    copyfrom_target,
+    copyfrom_new
+};
+
+struct svndiff_instruction
+{
+  enum svndiff_action action_code;
+  size_t offset;
+  size_t length;
+};
+
+/* An svndiff_window object describes how to reconstruct a
+ * contiguous section of the target string (the "target view") using a
+ * specified contiguous region of the source string (the "source
+ * view").  It contains a series of instructions which assemble the
+ * new target string text by pulling together substrings from:
+ *
+ *   - the source view,
+ *
+ *   - the previously constructed portion of the target view,
+ *
+ *   - a string of new data contained within the window structure
+ *
+ * The source view must always slide forward from one window to the
+ * next; that is, neither the beginning nor the end of the source view
+ * may move to the left as we read from a window stream.  This
+ * property allows us to apply deltas to non-seekable source streams
+ * without making a full copy of the source stream.
+ */
+struct svndiff_window
+{
+  size_t sview_offset;
+  size_t sview_len;
+  size_t tview_len;
+  size_t ins_len;
+  size_t newdata_len;
+  struct svndiff_instruction *ops;
+  char *newdata;
+};
-- 
1.7.2.2.409.gdbb11.dirty
