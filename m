From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 2/2] Add support for URLs to git-apply
Date: Sun,  9 Dec 2007 11:04:32 +0100
Message-ID: <1197194672-28568-2-git-send-email-mh@glandium.org>
References: <1197194672-28568-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 11:05:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1J1w-0006OA-W7
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 11:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbXLIKEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 05:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbXLIKEg
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 05:04:36 -0500
Received: from smtp19.orange.fr ([80.12.242.17]:41380 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbXLIKEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 05:04:35 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1914.orange.fr (SMTP Server) with ESMTP id 585021C0009E
	for <git@vger.kernel.org>; Sun,  9 Dec 2007 11:04:33 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1914.orange.fr (SMTP Server) with ESMTP id 219601C00099;
	Sun,  9 Dec 2007 11:04:33 +0100 (CET)
X-ME-UUID: 20071209100433137.219601C00099@mwinf1914.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1J1U-0007R7-Bc; Sun, 09 Dec 2007 11:04:32 +0100
X-Mailer: git-send-email debian.1.5.3.7.1-dirty
In-Reply-To: <1197194672-28568-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67610>

Instead of doing several "wget -O - url | git-apply -" in a raw, you now
can just git-apply url1 url2 ...

Signed-off-by: Mike Hommey <mh@glandium.org>
---

After spending an afternoon wgetting patches to applying them, I got fed up
and just added basic url support to git-apply. Note that the fwrite_strbuf
function should just live in http.c, but until the http api is fully switched
to use strbufs instead of its struct buffer (which I'm planning to do), it
can stay like this.

 Documentation/git-apply.txt |    3 +-
 builtin-apply.c             |   66 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 59 insertions(+), 10 deletions(-)

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
index 8c8162a..e213bd2 100644
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
@@ -182,12 +185,55 @@ static void say_patch_name(FILE *output, const char *pre,
 #define CHUNKSIZE (8192)
 #define SLOP (16)
 
-static void read_patch_file(struct strbuf *sb, const char *filename)
+#ifndef NO_CURL
+static size_t fwrite_strbuf(const void *ptr, size_t eltsize,
+			size_t nmemb, struct strbuf *buffer)
+{
+	size_t size = eltsize * nmemb;
+	strbuf_add(buffer, ptr, size);
+	return size;
+}
+
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
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_strbuf);
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
@@ -199,13 +245,6 @@ static void read_patch_file(struct strbuf *sb, const char *filename)
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
@@ -2726,7 +2765,14 @@ static int apply_patch(const char *filename, int inaccurate_eof)
 
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
@@ -2926,6 +2972,8 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 		set_default_whitespace_mode(whitespace_option);
 		errs |= apply_patch(arg, inaccurate_eof);
 	}
+	if (used_http)
+		http_cleanup();
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
 		errs |= apply_patch("-", inaccurate_eof);
-- 
1.5.3.7
