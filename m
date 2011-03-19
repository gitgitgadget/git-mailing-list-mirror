From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 02/16] vcs-svn: make buffer_skip_bytes return length read
Date: Sat, 19 Mar 2011 18:20:40 +1100
Message-ID: <1300519254-20201-3-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTh-0007RX-1V
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab1CSHVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:34 -0400
Received: from [119.15.97.146] ([119.15.97.146]:50184 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753622Ab1CSHVV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id 9BB94C062;
	Sat, 19 Mar 2011 18:17:47 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bVKxHSJJjtHQ; Sat, 19 Mar 2011 18:17:42 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 5A080C04B;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169397>

From: Jonathan Nieder <jrnieder@gmail.com>

Currently there is no way to detect when input ended if it ended
early during buffer_skip_bytes.  Tell the calling program how many
bytes were actually skipped for easier debugging.

Existing callers will still ignore early EOF.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/line_buffer.c   |   13 +++++++------
 vcs-svn/line_buffer.h   |    2 +-
 vcs-svn/line_buffer.txt |    3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 6930aac..a78c5d8 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -120,15 +120,16 @@ void buffer_copy_bytes(struct line_buffer *buf, off_t len)
 	}
 }
 
-void buffer_skip_bytes(struct line_buffer *buf, off_t len)
+off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
-	off_t in;
-	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
-		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		in = fread(byte_buffer, 1, in, buf->infile);
-		len -= in;
+	off_t done = 0;
+	while (done < nbytes && !feof(buf->infile) && !ferror(buf->infile)) {
+		off_t len = nbytes - done;
+		off_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		done += fread(byte_buffer, 1, in, buf->infile);
 	}
+	return done;
 }
 
 void buffer_reset(struct line_buffer *buf)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index a090dd6..7d10f9c 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -27,6 +27,6 @@ char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
 void buffer_copy_bytes(struct line_buffer *buf, off_t len);
-void buffer_skip_bytes(struct line_buffer *buf, off_t len);
+off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
 
 #endif
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index e89cc41..4ef0755 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -76,7 +76,8 @@ Functions
 
 `buffer_skip_bytes`::
 	Discards `len` bytes from the input stream (stopping early
-	if necessary because of an error or eof).
+	if necessary because of an error or eof).  Return value is
+	the number of bytes successfully read.
 
 `buffer_reset`::
 	Deallocates non-static buffers.
-- 
1.7.3.2.846.gf4b062
