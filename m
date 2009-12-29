From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 8/9] rerere: refactor rerere logic to make it independent
 from I/O
Date: Tue, 29 Dec 2009 13:42:37 -0800
Message-ID: <1262122958-9378-9-git-send-email-gitster@pobox.com>
References: <1262122958-9378-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 22:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPjqV-0003SS-Hu
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 22:43:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbZL2VnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 16:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbZL2VnB
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 16:43:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbZL2Vm5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 16:42:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AB3DC8C7F3
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wH7a
	EryfC5UGHxImLDy7ozBX3Qs=; b=o7ForlPx4S7qSWXIciGf/sRdPSMHxCZLKF+v
	tBwnToAqVvitxqTycmd6cQfpCraBynYOvXDAOhdnTOMf1x7P1vCVdlBMZ+Is0Lif
	NEBUuRbBlT8UxeOI95hXcnxMMJRy1w3JHPap0eZicxUczxKFf8XqUXDt1kXv9wo/
	jxPxdFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=F9hjks
	Qa3LLXBmAql3GpadLhylRpfJgz2iLwaYLsUcMYQLyu6D1LXnoXuQIanADWKgYdb+
	tErCFWiEmm5Idr8zHep6R0E9BDNwsQO5br7dvZAqp/14rx4kLDrTtwgxiLsBfHxa
	wNaNIq1lx7iUAKmX9a0O02+Z+JMb9vPFdpTEM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A77CD8C7F2
	for <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 096D38C7F1 for
 <git@vger.kernel.org>; Tue, 29 Dec 2009 16:42:55 -0500 (EST)
X-Mailer: git-send-email 1.6.6.60.gc2ff1
In-Reply-To: <1262122958-9378-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 205DFC1A-F4C3-11DE-83E2-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135827>

This splits the handle_file() function into in-core part and I/O
parts of the logic to create the preimage, so that we can compute
the conflict identifier without having to use temporary files.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c |  117 +++++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 82 insertions(+), 35 deletions(-)

diff --git a/rerere.c b/rerere.c
index 88bb4f1..f013ae7 100644
--- a/rerere.c
+++ b/rerere.c
@@ -83,8 +83,41 @@ static inline void ferr_puts(const char *s, FILE *fp, int *err)
 	ferr_write(s, strlen(s), fp, err);
 }
 
-static int handle_file(const char *path,
-	 unsigned char *sha1, const char *output)
+struct rerere_io {
+	int (*getline)(struct strbuf *, struct rerere_io *);
+	void (*putstr)(const char *, struct rerere_io *);
+	void (*putmem)(const char *, size_t, struct rerere_io *);
+	/* some more stuff */
+};
+
+struct rerere_io_file {
+	struct rerere_io io;
+	FILE *input;
+	FILE *output;
+	int wrerror;
+};
+
+static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
+{
+	struct rerere_io_file *io = (struct rerere_io_file *)io_;
+	return strbuf_getwholeline(sb, io->input, '\n');
+}
+
+static void rerere_file_putstr(const char *str, struct rerere_io *io_)
+{
+	struct rerere_io_file *io = (struct rerere_io_file *)io_;
+	if (io->output)
+		ferr_puts(str, io->output, &io->wrerror);
+}
+
+static void rerere_file_putmem(const char *mem, size_t sz, struct rerere_io *io_)
+{
+	struct rerere_io_file *io = (struct rerere_io_file *)io_;
+	if (io->output)
+		ferr_write(mem, sz, io->output, &io->wrerror);
+}
+
+static int handle_path(unsigned char *sha1, struct rerere_io *io)
 {
 	git_SHA_CTX ctx;
 	int hunk_no = 0;
@@ -93,25 +126,11 @@ static int handle_file(const char *path,
 	} hunk = RR_CONTEXT;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(path, "r");
-	FILE *out = NULL;
-	int wrerror = 0;
-
-	if (!f)
-		return error("Could not open %s", path);
-
-	if (output) {
-		out = fopen(output, "w");
-		if (!out) {
-			fclose(f);
-			return error("Could not write %s", output);
-		}
-	}
 
 	if (sha1)
 		git_SHA1_Init(&ctx);
 
-	while (!strbuf_getwholeline(&buf, f, '\n')) {
+	while (!io->getline(&buf, io)) {
 		if (!prefixcmp(buf.buf, "<<<<<<< ")) {
 			if (hunk != RR_CONTEXT)
 				goto bad;
@@ -131,13 +150,11 @@ static int handle_file(const char *path,
 				strbuf_swap(&one, &two);
 			hunk_no++;
 			hunk = RR_CONTEXT;
-			if (out) {
-				ferr_puts("<<<<<<<\n", out, &wrerror);
-				ferr_write(one.buf, one.len, out, &wrerror);
-				ferr_puts("=======\n", out, &wrerror);
-				ferr_write(two.buf, two.len, out, &wrerror);
-				ferr_puts(">>>>>>>\n", out, &wrerror);
-			}
+			io->putstr("<<<<<<<\n", io);
+			io->putmem(one.buf, one.len, io);
+			io->putstr("=======\n", io);
+			io->putmem(two.buf, two.len, io);
+			io->putstr(">>>>>>>\n", io);
 			if (sha1) {
 				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
 					    one.len + 1);
@@ -152,8 +169,8 @@ static int handle_file(const char *path,
 			; /* discard */
 		else if (hunk == RR_SIDE_2)
 			strbuf_addstr(&two, buf.buf);
-		else if (out)
-			ferr_puts(buf.buf, out, &wrerror);
+		else
+			io->putstr(buf.buf, io);
 		continue;
 	bad:
 		hunk = 99; /* force error exit */
@@ -163,21 +180,51 @@ static int handle_file(const char *path,
 	strbuf_release(&two);
 	strbuf_release(&buf);
 
-	fclose(f);
-	if (wrerror)
-		error("There were errors while writing %s (%s)",
-		      path, strerror(wrerror));
-	if (out && fclose(out))
-		wrerror = error("Failed to flush %s: %s",
-				path, strerror(errno));
 	if (sha1)
 		git_SHA1_Final(sha1, &ctx);
-	if (hunk != RR_CONTEXT) {
+	if (hunk != RR_CONTEXT)
+		return -1;
+	return hunk_no;
+}
+
+static int handle_file(const char *path, unsigned char *sha1, const char *output)
+{
+	int hunk_no = 0;
+	struct rerere_io_file io;
+
+	memset(&io, 0, sizeof(io));
+	io.io.getline = rerere_file_getline;
+	io.io.putstr = rerere_file_putstr;
+	io.io.putmem = rerere_file_putmem;
+	io.input = fopen(path, "r");
+	io.wrerror = 0;
+	if (!io.input)
+		return error("Could not open %s", path);
+
+	if (output) {
+		io.output = fopen(output, "w");
+		if (!io.output) {
+			fclose(io.input);
+			return error("Could not write %s", output);
+		}
+	}
+
+	hunk_no = handle_path(sha1, (struct rerere_io *)&io);
+
+	fclose(io.input);
+	if (io.wrerror)
+		error("There were errors while writing %s (%s)",
+		      path, strerror(io.wrerror));
+	if (io.output && fclose(io.output))
+		io.wrerror = error("Failed to flush %s: %s",
+				   path, strerror(errno));
+
+	if (hunk_no < 0) {
 		if (output)
 			unlink_or_warn(output);
 		return error("Could not parse conflict hunks in %s", path);
 	}
-	if (wrerror)
+	if (io.wrerror)
 		return -1;
 	return hunk_no;
 }
-- 
1.6.6
