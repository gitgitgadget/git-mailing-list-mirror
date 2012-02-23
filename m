From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 2/4] bundle: put strbuf_readline_fd in strbuf.c with adjustments
Date: Thu, 23 Feb 2012 10:42:22 +0100
Message-ID: <b1d225393ad182bf5e77e9ff43e0ad468944c0cf.1329988335.git.trast@student.ethz.ch>
References: <cover.1329988335.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>,
	<git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 10:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0VCB-0007ak-M6
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 10:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab2BWJmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 04:42:35 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:34756 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755285Ab2BWJmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 04:42:33 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:29 +0100
Received: from thomas.inf.ethz.ch (129.132.209.211) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 23 Feb
 2012 10:42:30 +0100
X-Mailer: git-send-email 1.7.9.1.430.g4998543
In-Reply-To: <cover.1329988335.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.209.211]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191339>

The comment even said that it should eventually go there.  While at
it, match the calling convention and name of the function to the
strbuf_get*line family.  So it now is strbuf_getwholeline_fd.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/technical/api-strbuf.txt |    7 +++++++
 bundle.c                               |   21 ++-------------------
 strbuf.c                               |   16 ++++++++++++++++
 strbuf.h                               |    1 +
 4 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index cc6db5e..827c4bd 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -266,6 +266,13 @@ same behaviour as well.
 	Like `strbuf_getline`, but keeps the trailing terminator (if
 	any) in the buffer.
 
+`strbuf_getwholeline_fd`::
+
+	Like `strbuf_getwholeline`, but operates on a file descriptor.
+	It reads one character at a time, so it is very slow.  Do not
+	use it unless you need the correct position in the file
+	descriptor!
+
 `stripspace`::
 
 	Strip whitespace from a buffer. The second parameter controls if
diff --git a/bundle.c b/bundle.c
index b8acf3c..313de42 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,23 +23,6 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 	list->nr++;
 }
 
-/* Eventually this should go to strbuf.[ch] */
-static int strbuf_readline_fd(struct strbuf *sb, int fd)
-{
-	strbuf_reset(sb);
-
-	while (1) {
-		char ch;
-		ssize_t len = xread(fd, &ch, 1);
-		if (len <= 0)
-			return len;
-		strbuf_addch(sb, ch);
-		if (ch == '\n')
-			break;
-	}
-	return 0;
-}
-
 static int parse_bundle_header(int fd, struct bundle_header *header,
 			       const char *report_path)
 {
@@ -47,7 +30,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	int status = 0;
 
 	/* The bundle header begins with the signature */
-	if (strbuf_readline_fd(&buf, fd) ||
+	if (strbuf_getwholeline_fd(&buf, fd, '\n') ||
 	    strcmp(buf.buf, bundle_signature)) {
 		if (report_path)
 			error("'%s' does not look like a v2 bundle file",
@@ -57,7 +40,7 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
 	}
 
 	/* The bundle header ends with an empty line */
-	while (!strbuf_readline_fd(&buf, fd) &&
+	while (!strbuf_getwholeline_fd(&buf, fd, '\n') &&
 	       buf.len && buf.buf[0] != '\n') {
 		unsigned char sha1[20];
 		int is_prereq = 0;
diff --git a/strbuf.c b/strbuf.c
index ff0b96b..5135d59 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -383,6 +383,22 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 	return 0;
 }
 
+int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
+{
+	strbuf_reset(sb);
+
+	while (1) {
+		char ch;
+		ssize_t len = xread(fd, &ch, 1);
+		if (len <= 0)
+			return EOF;
+		strbuf_addch(sb, ch);
+		if (ch == term)
+			break;
+	}
+	return 0;
+}
+
 int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd, len;
diff --git a/strbuf.h b/strbuf.h
index fbf059f..3effaa8 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -116,6 +116,7 @@ static inline void strbuf_complete_line(struct strbuf *sb)
 
 extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
+extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
 
 extern void stripspace(struct strbuf *buf, int skip_comments);
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
-- 
1.7.9.1.430.g4998543
