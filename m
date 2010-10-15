From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 5/5] svn-fe: Use the cat-blob command to apply deltas
Date: Fri, 15 Oct 2010 23:54:16 +1100
Message-ID: <1287147256-9457-6-git-send-email-david.barr@cordelta.com>
References: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 15 14:55:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6jof-0007tx-2g
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 14:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab0JOMyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 08:54:38 -0400
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37299 "EHLO
	mail08.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755760Ab0JOMyg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Oct 2010 08:54:36 -0400
Received: from localhost.localdomain (d110-33-95-167.mit3.act.optusnet.com.au [110.33.95.167])
	by mail08.syd.optusnet.com.au (8.13.1/8.13.1) with ESMTP id o9FCsPsp006314;
	Fri, 15 Oct 2010 23:54:31 +1100
X-Mailer: git-send-email 1.7.3.32.g634ef
In-Reply-To: <1287147256-9457-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159113>

Use the new cat-blob command for fast-import to extract
blobs so that text-deltas may be applied.

The backchannel should only need to be configured when
parsing v3 svn dump streams.

Based-on-patch-by: Ramkumar Ramachandra <artagnon@gmail.com>
Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
Tested-by: David Barr <david.barr@cordelta.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 contrib/svn-fe/svn-fe.txt |    6 +++-
 t/t9010-svn-fe.sh         |    6 ++--
 vcs-svn/fast_export.c     |   86 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 35f84bd..39ffa07 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -7,7 +7,11 @@ svn-fe - convert an SVN "dumpfile" to a fast-import stream
 
 SYNOPSIS
 --------
-svnadmin dump --incremental REPO | svn-fe [url] | git fast-import
+[verse]
+mkfifo backchannel &&
+svnadmin dump --incremental REPO |
+	svn-fe [url] 3<backchannel |
+	git fast-import --cat-blob-fd=3 3>backchannel
 
 DESCRIPTION
 -----------
diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index de976ed..d750c7a 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -34,10 +34,10 @@ test_dump () {
 		svnadmin load "$label-svn" < "$TEST_DIRECTORY/$dump" &&
 		svn_cmd export "file://$PWD/$label-svn" "$label-svnco" &&
 		git init "$label-git" &&
-		test-svn-fe "$TEST_DIRECTORY/$dump" >"$label.fe" &&
 		(
-			cd "$label-git" &&
-			git fast-import < ../"$label.fe"
+			cd "$label-git" && mkfifo backchannel && \
+			test-svn-fe "$TEST_DIRECTORY/$dump" 3< backchannel | \
+			git fast-import --cat-blob-fd=3 3> backchannel
 		) &&
 		(
 			cd "$label-svnco" &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index b017dfb..812563d 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -8,10 +8,17 @@
 #include "line_buffer.h"
 #include "repo_tree.h"
 #include "string_pool.h"
+#include "svndiff.h"
 
 #define MAX_GITSVN_LINE_LEN 4096
+#define REPORT_FILENO 3
+
+#define SHA1_HEX_LENGTH 40
 
 static uint32_t first_commit_done;
+static struct line_buffer preimage = LINE_BUFFER_INIT;
+static struct line_buffer postimage = LINE_BUFFER_INIT;
+static struct line_buffer backchannel = LINE_BUFFER_INIT;
 
 void fast_export_delete(uint32_t depth, uint32_t *path)
 {
@@ -63,16 +70,91 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
+static int fast_export_save_blob(FILE *out)
+{
+	size_t len;
+	char *header;
+	char *end;
+	char *tail;
+
+	if (!backchannel.infile)
+		backchannel.infile = fdopen(REPORT_FILENO, "r");
+	if (!backchannel.infile)
+		return error("Could not open backchannel fd: %d", REPORT_FILENO);
+	header = buffer_read_line(&backchannel);
+	if (header == NULL)
+		return 1;
+	end = strchr(header, '\0');
+	if (end - header > 7 && !strcmp(end - 7, "missing"))
+		return error("cat-blob reports missing blob: %s", header);
+	if (end - header < SHA1_HEX_LENGTH)
+		return error("cat-blob header too short for SHA1: %s", header);
+	if (strncmp(header + SHA1_HEX_LENGTH, " blob ", 6))
+		return error("cat-blob header has wrong object type: %s", header);
+	len = strtoumax(header + SHA1_HEX_LENGTH + 6, &end, 10);
+	if (end == header + SHA1_HEX_LENGTH + 6)
+		return error("cat-blob header did not contain length: %s", header);
+	if (*end)
+		return error("cat-blob header contained garbage after length: %s", header);
+	buffer_copy_bytes(&backchannel, out, len);
+	tail = buffer_read_line(&backchannel);
+	if (!tail)
+		return 1;
+	if (*tail)
+		return error("cat-blob trailing line contained garbage: %s", tail);
+	return 0;
+}
+
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len,
 			uint32_t delta, uint32_t srcMark, uint32_t srcMode,
 			struct line_buffer *input)
 {
+	long preimage_len = 0;
+
+	if (delta) {
+		if (!preimage.infile)
+			preimage.infile = tmpfile();
+		if (!preimage.infile)
+			die("Unable to open temp file for blob retrieval");
+		if (srcMark) {
+			printf("cat-blob :%"PRIu32"\n", srcMark);
+			fflush(stdout);
+			if (srcMode == REPO_MODE_LNK)
+				fwrite("link ", 1, 5, preimage.infile);
+			if (fast_export_save_blob(preimage.infile))
+				die("Failed to retrieve blob for delta application");
+		}
+		preimage_len = ftell(preimage.infile);
+		fseek(preimage.infile, 0, SEEK_SET);
+		if (!postimage.infile)
+			postimage.infile = tmpfile();
+		if (!postimage.infile)
+			die("Unable to open temp file for blob application");
+		svndiff0_apply(input, len, &preimage, postimage.infile);
+		len = ftell(postimage.infile);
+		fseek(postimage.infile, 0, SEEK_SET);
+	}
+
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
-		buffer_skip_bytes(input, 5);
+		if (delta)
+			buffer_skip_bytes(&postimage, 5);
+		else
+			buffer_skip_bytes(input, 5);
 		len -= 5;
 	}
 	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
-	buffer_copy_bytes(input, stdout, len);
+	if (!delta)
+		buffer_copy_bytes(input, stdout, len);
+	else
+		buffer_copy_bytes(&postimage, stdout, len);
 	fputc('\n', stdout);
+
+	if (preimage.infile) {
+		fseek(preimage.infile, 0, SEEK_SET);
+	}
+
+	if (postimage.infile) {
+		fseek(postimage.infile, 0, SEEK_SET);
+	}
 }
-- 
1.7.3.32.g634ef
