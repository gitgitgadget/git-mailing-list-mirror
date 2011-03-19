From: David Barr <david.barr@cordelta.com>
Subject: [PATCH 01/16] vcs-svn: improve support for reading large files
Date: Sat, 19 Mar 2011 18:20:39 +1100
Message-ID: <1300519254-20201-2-git-send-email-david.barr@cordelta.com>
References: <1300518231-20008-1-git-send-email-david.barr@cordelta.com>
 <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>,
	David Barr <david.barr@cordelta.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 19 08:21:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0qTy-0007ZM-3d
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 08:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444Ab1CSHVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 03:21:42 -0400
Received: from [119.15.97.146] ([119.15.97.146]:60948 "EHLO mailhost.cordelta"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753503Ab1CSHVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 03:21:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mailhost.cordelta (Postfix) with ESMTP id A9C92C061;
	Sat, 19 Mar 2011 18:17:46 +1100 (EST)
X-Virus-Scanned: amavisd-new at mailhost.cordelta
Received: from mailhost.cordelta ([127.0.0.1])
	by localhost (mailhost.cordelta [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PTuIXe-pIiCn; Sat, 19 Mar 2011 18:17:42 +1100 (EST)
Received: from dba.cordelta (unknown [192.168.123.140])
	by mailhost.cordelta (Postfix) with ESMTP id 3FB4AC046;
	Sat, 19 Mar 2011 18:17:42 +1100 (EST)
X-Mailer: git-send-email 1.7.3.2.846.gf4b062
In-Reply-To: <1300519254-20201-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169401>

From: Jonathan Nieder <jrnieder@gmail.com>

Move from uint32_t to off_t as the fundamental unit of length used by
the line_buffer library.  Performance would get worse if anything but
I think it's worth it for support of deltas that need to skip large
pieces (> 4 GiB).

Exception: buffer_read_string still takes a uint32_t, since it keeps
its result in an in-core obj_pool.

Callers still have to be updated to take advantage of this.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
---
 vcs-svn/line_buffer.c |    8 ++++----
 vcs-svn/line_buffer.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index eb8a6a7..6930aac 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -104,10 +104,10 @@ void buffer_read_binary(struct line_buffer *buf,
 	strbuf_fread(sb, size, buf->infile);
 }
 
-void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
+void buffer_copy_bytes(struct line_buffer *buf, off_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
-	uint32_t in;
+	off_t in;
 	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		in = fread(byte_buffer, 1, in, buf->infile);
@@ -120,10 +120,10 @@ void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
 	}
 }
 
-void buffer_skip_bytes(struct line_buffer *buf, uint32_t len)
+void buffer_skip_bytes(struct line_buffer *buf, off_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
-	uint32_t in;
+	off_t in;
 	while (len > 0 && !feof(buf->infile) && !ferror(buf->infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		in = fread(byte_buffer, 1, in, buf->infile);
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 3c9629e..a090dd6 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -26,7 +26,7 @@ char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 int buffer_read_char(struct line_buffer *buf);
 void buffer_read_binary(struct line_buffer *buf, struct strbuf *sb, uint32_t len);
-void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
-void buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
+void buffer_copy_bytes(struct line_buffer *buf, off_t len);
+void buffer_skip_bytes(struct line_buffer *buf, off_t len);
 
 #endif
-- 
1.7.3.2.846.gf4b062
