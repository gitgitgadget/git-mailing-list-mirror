From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 03/16] vcs-svn: make buffer_copy_bytes return length read
Date: Sat, 19 Mar 2011 18:20:41 +1100
Message-ID: <1300519254-20201-4-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTx-0007ZM-2X
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193Ab1CSHVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:36 -0400
Received: from [119.15.97.146] ([119.15.97.146]:59809 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753609Ab1CSHVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 0A5A4C04D;
	Sat, 19 Mar 2011 18:17:47 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DPbN0Y2tqW+G; Sat, 19 Mar 2011 18:17:42 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 73A4BC04C;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169399>

From: Jonathan Nieder <jrnieder@gmail.com>

Currently buffer_copy_bytes does not report to its caller whether
it encountered an early end of file.

Add a return value representing the number of bytes read (but not
the number of bytes copied).  This way all three unusual conditions
can be distinguished: input error with buffer_ferror, output error
with ferror(outfile), early end of input by checking the return
value.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/line_buffer.c |   18 +++++++++---------
 vcs-svn/line_buffer.h |    3 ++-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index a78c5d8..08d7cae 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -104,20 +104,20 @@ void buffer_read_binary(struct line_buffer *buf,
 	strbuf_fread(sb, size, buf->infile);
 }
 
-void buffer_copy_bytes(struct line_buffer *buf, off_t len)
+off_t buffer_copy_bytes(struct line_buffer *buf, off_t nbytes)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
-	off_t in;
-	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
-		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+	off_t done = 0;
+	while (done < nbytes && !feof(buf->infile) && !ferror(buf->infile)) {
+		off_t len = nbytes - done;
+		off_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		in = fread(byte_buffer, 1, in, buf->infile);
-		len -= in;
+		done += in;
 		fwrite(byte_buffer, 1, in, stdout);
-		if (ferror(stdout)) {
-			buffer_skip_bytes(buf, len);
-			return;
-		}
+		if (ferror(stdout))
+			return done + buffer_skip_bytes(buf, nbytes - done);
 	}
+	return done;
 }
 
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 7d10f9c..f5c468a 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -26,7 +26,8 @@ char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
-void buffer_copy_bytes(struct line_buffer *buf, off_t len);
+/* Returns number of bytes read (not necessarily written). */
+off_t buffer_copy_bytes(struct line_buffer *buf, off_t len);
 off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
 
 #endif
-- 
1.7.3.2.846.gf4b062
