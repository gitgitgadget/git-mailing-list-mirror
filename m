From: Mike Hommey <mh@glandium.org>
Subject: [Replacement PATCH 4/4] Add support for URLs to git-apply
Date: Mon, 10 Dec 2007 10:06:58 +0100
Message-ID: <1197277618-13727-1-git-send-email-mh@glandium.org>
References: <1197219900-19334-4-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 10:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1ec9-0001Ck-Jq
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 10:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbXLJJHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 04:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751652AbXLJJHZ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 04:07:25 -0500
Received: from vuizook.err.no ([85.19.215.103]:57570 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbXLJJHY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 04:07:24 -0500
Received: from aputeaux-153-1-79-219.w81-249.abo.wanadoo.fr ([81.249.109.219] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1J1ecE-0003Je-91; Mon, 10 Dec 2007 10:08:00 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1J1ebK-0003Zj-54; Mon, 10 Dec 2007 10:06:58 +0100
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: <1197219900-19334-4-git-send-email-mh@glandium.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 5.2): Yes, score=5.2 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67692>

Instead of doing several "wget -O - url | git-apply -" in a raw, you now
can just git-apply url1 url2 ...

Signed-off-by: Mike Hommey <mh@glandium.org>
---

 A #ifndef NO_CURL was missing in the previous patch.

 Documentation/git-apply.txt |    3 +-
 builtin-apply.c             |   60 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index bae3e7b..2d5d725 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -25,7 +25,8 @@ OPTIONS
 -------
 <patch>...::
 	The files to read patch from.  '-' can be used to read
-	from the standard input.
+	from the standard input. They can also be http, https or
+	ftp URLs.
 
 --stat::
 	Instead of applying the patch, output diffstat for the
diff --git a/builtin-apply.c b/builtin-apply.c
index 8c8162a..28645c7 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -12,6 +12,9 @@
 #include "blob.h"
 #include "delta.h"
 #include "builtin.h"
+#ifndef NO_CURL
+#include "http.h"
+#endif
 
 /*
  *  --check turns on checking that the working tree matches the
@@ -182,12 +185,47 @@ static void say_patch_name(FILE *output, const char *pre,
 #define CHUNKSIZE (8192)
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, const char *filename)
+#ifndef NO_CURL
+static int used_http;
+
+static void read_patch_url(struct strbuf *sb, const char *url)
+{
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	if (! used_http) {
+		http_init();
+		used_http = 1;
+	}
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, sb);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK)
+			die("git-apply: could not open %s", url);
+	}
+}
+#endif
+
+static void read_patch(struct strbuf *sb, const char *filename)
 {
 	int fd;
 
 	if (!strcmp(filename, "-")) {
 		fd = 0;
+#ifndef NO_CURL
+	} else if (!strncmp(filename, "http://", 7) ||
+		   !strncmp(filename, "https://", 8) ||
+		   !strncmp(filename, "ftp://", 6)) {
+		read_patch_url(sb, filename);
+		return;
+#endif
 	} else {
 		fd = open(filename, O_RDONLY);
 		if (fd < 0)
@@ -199,13 +237,6 @@ static void read_patch_file(struct strbuf *sb, const char *filename)
 		die("git-apply: read returned %s", strerror(errno));
 
 	close(fd);
-	/*
-	 * Make sure that we have some slop in the buffer
-	 * so that we can do speculative "memcmp" etc, and
-	 * see to it that it is NUL-filled.
-	 */
-	strbuf_grow(sb, SLOP);
-	memset(sb->buf + sb->len, 0, SLOP);
 }
 
 static unsigned long linelen(const char *buffer, unsigned long size)
@@ -2726,7 +2757,14 @@ static int apply_patch(const char *filename, int inaccurate_eof)
 
 	strbuf_init(&buf, 0);
 	patch_input_file = filename;
-	read_patch_file(&buf, filename);
+	read_patch(&buf, filename);
+	/*
+	 * Make sure that we have some slop in the buffer
+	 * so that we can do speculative "memcmp" etc, and
+	 * see to it that it is NUL-filled.
+	 */
+	strbuf_grow(&buf, SLOP);
+	memset(buf.buf + buf.len, 0, SLOP);
 	offset = 0;
 	while (offset < buf.len) {
 		struct patch *patch;
@@ -2926,6 +2964,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(arg, inaccurate_eof);
 	}
+#ifndef NO_CURL
+	if (used_http)
+		http_cleanup();
+#endif
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch("-", inaccurate_eof);
-- 
1.5.3.7.1148.gcfe7
