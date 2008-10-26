From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Add mksnpath and git_snpath which allow to specify the
	output buffer
Date: Sun, 26 Oct 2008 22:59:13 +0100
Message-ID: <20081026215913.GA18594@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 26 23:00:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuDf0-0003ho-JI
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 23:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYJZV7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2008 17:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbYJZV7T
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 17:59:19 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:44379 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYJZV7S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 17:59:18 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AE81pE/a
Received: from tigra.home (Fab75.f.strato-dslnet.de [195.4.171.117])
	by post.webmailer.de (fruni mo64) (RZmta 17.14)
	with ESMTP id t002aek9QLwpX3 ; Sun, 26 Oct 2008 22:59:14 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 2BAB6277C8;
	Sun, 26 Oct 2008 22:59:14 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id E8EEC36D27; Sun, 26 Oct 2008 22:59:13 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99185>

Both are actually just vsnprintf's but additionally call cleanup_path
on the result. To be used as alternatives to mkpath and git_path where
the buffer for the created path may not be reused by subsequent calls
of the same formatting function.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 cache.h |    4 ++++
 path.c  |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index b0edbf9..a9024db 100644
--- a/cache.h
+++ b/cache.h
@@ -495,6 +495,10 @@ extern int check_repository_format(void);
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
+extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+extern char *git_snpath(char *buf, size_t n, const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
 /* Return a statically allocated filename matching the sha1 signature */
 extern char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
diff --git a/path.c b/path.c
index 76e8872..85ab28a 100644
--- a/path.c
+++ b/path.c
@@ -32,6 +32,44 @@ static char *cleanup_path(char *path)
 	return path;
 }
 
+char *mksnpath(char *buf, size_t n, const char *fmt, ...)
+{
+	va_list args;
+	unsigned len;
+
+	va_start(args, fmt);
+	len = vsnprintf(buf, n, fmt, args);
+	va_end(args);
+	if (len >= n) {
+		snprintf(buf, n, bad_path);
+		return buf;
+	}
+	return cleanup_path(buf);
+}
+
+char *git_snpath(char *buf, size_t n, const char *fmt, ...)
+{
+	const char *git_dir = get_git_dir();
+	va_list args;
+	size_t len;
+
+	len = strlen(git_dir);
+	if (n < len + 1)
+		goto bad;
+	memcpy(buf, git_dir, len);
+	if (len && !is_dir_sep(git_dir[len-1]))
+		buf[len++] = '/';
+	va_start(args, fmt);
+	len += vsnprintf(buf + len, n - len, fmt, args);
+	va_end(args);
+	if (len >= n)
+		goto bad;
+	return cleanup_path(buf);
+bad:
+	snprintf(buf, n, bad_path);
+	return buf;
+}
+
 char *mkpath(const char *fmt, ...)
 {
 	va_list args;
-- 
1.6.0.3.540.g3f8b
