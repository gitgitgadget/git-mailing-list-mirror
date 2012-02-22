From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 1/2] bundle: put strbuf_readline_fd in strbuf.c with adjustments
Date: Wed, 22 Feb 2012 20:34:22 +0100
Message-ID: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch>
References: <4F451259.7010304@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 20:34:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Hxh-0000cX-BB
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 20:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263Ab2BVTec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 14:34:32 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:50991 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab2BVTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 14:34:31 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 20:34:26 +0100
Received: from thomas.inf.ethz.ch (129.132.209.16) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 20:34:27 +0100
X-Mailer: git-send-email 1.7.9.1.430.g4998543
In-Reply-To: <4F451259.7010304@codethink.co.uk>
X-Originating-IP: [129.132.209.16]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191272>

The comment even said that it should eventually go there.  While at
it, match the calling convention and name of the function to the
strbuf_get*line family.  So it now is strbuf_getwholeline_fd.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

I was left looking for strbuf_readline_fd() for a while, then tried to
look for the readline() from the libc that it would presumably match.
Hence this cleanup.

 bundle.c |   21 ++-------------------
 strbuf.c |   16 ++++++++++++++++
 strbuf.h |    1 +
 3 files changed, 19 insertions(+), 19 deletions(-)

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
