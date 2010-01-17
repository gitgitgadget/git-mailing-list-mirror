From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] rerere: prepare for customizable conflict marker length
Date: Sun, 17 Jan 2010 01:39:03 -0800
Message-ID: <1263721144-18605-8-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:39:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbu-0003v2-V0
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab0AQJjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675Ab0AQJj1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:27 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0AQJjW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E269142E
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Nyl+
	lqQNOAIapA1Nwzv0gmj11no=; b=MZCWdFO+/kI+tglOWKEIYAoA2k2bHaiq36Rk
	e2/q88DYKDAlzZSSC45qL+HNOnfKDdNtBa9/xqCkp1T9Gg0gyQyn/69bYLW98XtE
	rmOtHd6Vsg2mF5Wl+gCaWPXRoVj3gJ/kNNwxoH6/CI7fVDdt0W8alNotOlan47WZ
	IOZQJRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=omb2HN
	tILW+fEAiEZLiSFpuvofFY9qaPSFvovpQb+uywy033yuKRuQeDMyhtmTqvWoYZ4b
	NVzVJYr2SepopDfZDzXRAMXNCkPn1gOhu+wabC+sKHQp6yRmYGrSrZrT69VY1Xhg
	0JWq+cv5MPfaU2GHlVaDQ8l7qUnHr88X9sgyM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D1A39142D
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 498A691428 for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:21 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 31148938-034C-11DF-B287-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137284>

This still uses the hardcoded conflict marker length of 7 but otherwise
prepares the codepath to deal with customized marker length.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c |   51 +++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/rerere.c b/rerere.c
index 5b8ebcb..d4d1507 100644
--- a/rerere.c
+++ b/rerere.c
@@ -98,6 +98,25 @@ static void rerere_io_putstr(const char *str, struct rerere_io *io)
 		ferr_puts(str, io->output, &io->wrerror);
 }
 
+static void rerere_io_putconflict(int ch, int size, struct rerere_io *io)
+{
+	char buf[64];
+
+	while (size) {
+		if (size + 2 < sizeof(buf)) {
+			memset(buf, ch, size);
+			buf[size] = '\n';
+			buf[size + 1] = '\0';
+			size = 0;
+		} else {
+			memset(buf, ch, sizeof(buf) - 1);
+			buf[sizeof(buf) - 1] = '\0';
+			size -= sizeof(buf) - 1;
+		}
+		rerere_io_putstr(buf, io);
+	}
+}
+
 static void rerere_io_putmem(const char *mem, size_t sz, struct rerere_io *io)
 {
 	if (io->output)
@@ -115,7 +134,17 @@ static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 	return strbuf_getwholeline(sb, io->input, '\n');
 }
 
-static int handle_path(unsigned char *sha1, struct rerere_io *io)
+static int is_cmarker(char *buf, int marker_char, int marker_size, int want_sp)
+{
+	while (marker_size--)
+		if (*buf++ != marker_char)
+			return 0;
+	if (want_sp && *buf != ' ')
+		return 0;
+	return isspace(*buf);
+}
+
+static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_size)
 {
 	git_SHA_CTX ctx;
 	int hunk_no = 0;
@@ -129,30 +158,30 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io)
 		git_SHA1_Init(&ctx);
 
 	while (!io->getline(&buf, io)) {
-		if (!prefixcmp(buf.buf, "<<<<<<< ")) {
+		if (is_cmarker(buf.buf, '<', marker_size, 1)) {
 			if (hunk != RR_CONTEXT)
 				goto bad;
 			hunk = RR_SIDE_1;
-		} else if (!prefixcmp(buf.buf, "|||||||") && isspace(buf.buf[7])) {
+		} else if (is_cmarker(buf.buf, '|', marker_size, 0)) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
 			hunk = RR_ORIGINAL;
-		} else if (!prefixcmp(buf.buf, "=======") && isspace(buf.buf[7])) {
+		} else if (is_cmarker(buf.buf, '=', marker_size, 0)) {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				goto bad;
 			hunk = RR_SIDE_2;
-		} else if (!prefixcmp(buf.buf, ">>>>>>> ")) {
+		} else if (is_cmarker(buf.buf, '>', marker_size, 1)) {
 			if (hunk != RR_SIDE_2)
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
 				strbuf_swap(&one, &two);
 			hunk_no++;
 			hunk = RR_CONTEXT;
-			rerere_io_putstr("<<<<<<<\n", io);
+			rerere_io_putconflict('<', marker_size, io);
 			rerere_io_putmem(one.buf, one.len, io);
-			rerere_io_putstr("=======\n", io);
+			rerere_io_putconflict('=', marker_size, io);
 			rerere_io_putmem(two.buf, two.len, io);
-			rerere_io_putstr(">>>>>>>\n", io);
+			rerere_io_putconflict('>', marker_size, io);
 			if (sha1) {
 				git_SHA1_Update(&ctx, one.buf ? one.buf : "",
 					    one.len + 1);
@@ -189,6 +218,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 {
 	int hunk_no = 0;
 	struct rerere_io_file io;
+	int marker_size = 7;
 
 	memset(&io, 0, sizeof(io));
 	io.io.getline = rerere_file_getline;
@@ -205,7 +235,7 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
 		}
 	}
 
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io);
+	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 
 	fclose(io.input);
 	if (io.io.wrerror)
@@ -255,6 +285,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	struct cache_entry *ce;
 	int pos, len, i, hunk_no;
 	struct rerere_io_mem io;
+	int marker_size = 7;
 
 	/*
 	 * Reproduce the conflicted merge in-core
@@ -299,7 +330,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	strbuf_init(&io.input, 0);
 	strbuf_attach(&io.input, result.ptr, result.size, result.size);
 
-	hunk_no = handle_path(sha1, (struct rerere_io *)&io);
+	hunk_no = handle_path(sha1, (struct rerere_io *)&io, marker_size);
 	strbuf_release(&io.input);
 	if (io.io.output)
 		fclose(io.io.output);
-- 
1.6.6.405.g80ed6.dirty
