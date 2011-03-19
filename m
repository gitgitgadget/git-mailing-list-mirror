From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 04/16] vcs-svn: improve reporting of input errors
Date: Sat, 19 Mar 2011 18:20:42 +1100
Message-ID: <1300519254-20201-5-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTx-0007ZM-JI
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab1CSHVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:40 -0400
Received: from [119.15.97.146] ([119.15.97.146]:62275 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752574Ab1CSHVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id F3837C05F;
	Sat, 19 Mar 2011 18:17:45 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ccZs3jnInW3s; Sat, 19 Mar 2011 18:17:42 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 8DB0DC04D;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169400>

From: Jonathan Nieder <jrnieder@gmail.com>

Catch input errors and exit early enough to print a reasonable
diagnosis based on errno.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/fast_export.c |   13 +++++++++++--
 vcs-svn/svndump.c     |   22 +++++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 1d50512..4748253 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -120,15 +120,24 @@ static const char *get_response_line(void)
 	die("unexpected end of fast-import feedback");
 }
 
+static void die_short_read(struct line_buffer *input)
+{
+	if (buffer_ferror(input))
+		die_errno("error reading dump file");
+	die("invalid dump: unexpected end of file");
+}
+
 void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
 		/* svn symlink blobs start with "link " */
-		buffer_skip_bytes(input, 5);
 		len -= 5;
+		if (buffer_skip_bytes(input, 5) != 5)
+			die_short_read(input);
 	}
 	printf("data %"PRIu32"\n", len);
-	buffer_copy_bytes(input, len);
+	if (buffer_copy_bytes(input, len) != len)
+		die_short_read(input);
 	fputc('\n', stdout);
 }
 
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 7bc2d3d..dbb9c16 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -133,6 +133,13 @@ static void handle_property(const char *key, const char *val, uint32_t len,
 	}
 }
 
+static void die_short_read(void)
+{
+	if (buffer_ferror(&input))
+		die_errno("error reading dump file");
+	die("invalid dump: unexpected end of file");
+}
+
 static void read_props(void)
 {
 	char key[16] = {0};
@@ -159,7 +166,9 @@ static void read_props(void)
 			die("invalid property line: %s\n", t);
 		len = atoi(&t[2]);
 		val = buffer_read_string(&input, len);
-		buffer_skip_bytes(&input, 1);	/* Discard trailing newline. */
+		/* Discard trailing newline. */
+		if (buffer_skip_bytes(&input, 1) != 1)
+			die_short_read();
 
 		switch (type) {
 		case 'K':
@@ -402,7 +411,11 @@ void svndump_read(const char *url)
 			if (memcmp(t, "Content-length", 14))
 				continue;
 			len = atoi(val);
-			buffer_read_line(&input);
+			t = buffer_read_line(&input);
+			if (!t)
+				die_short_read();
+			if (*t)
+				die("invalid dump: expected blank line after content length header");
 			if (active_ctx == REV_CTX) {
 				read_props();
 			} else if (active_ctx == NODE_CTX) {
@@ -410,10 +423,13 @@ void svndump_read(const char *url)
 				active_ctx = INTERNODE_CTX;
 			} else {
 				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
-				buffer_skip_bytes(&input, len);
+				if (buffer_skip_bytes(&input, len) != len)
+					die_short_read();
 			}
 		}
 	}
+	if (buffer_ferror(&input))
+		die_short_read();
 	if (active_ctx == NODE_CTX)
 		handle_node();
 	if (active_ctx == REV_CTX)
-- 
1.7.3.2.846.gf4b062
