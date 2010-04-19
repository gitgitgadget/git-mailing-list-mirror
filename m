From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] Fix checkout of large files to network shares under Windows
 XP
Date: Mon, 19 Apr 2010 14:45:55 +0200
Message-ID: <4BCC5083.30801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 19 14:46:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3qMt-0007SC-7U
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 14:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab0DSMqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 08:46:18 -0400
Received: from lo.gmane.org ([80.91.229.12]:54819 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754712Ab0DSMqR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Apr 2010 08:46:17 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1O3qMe-0007HI-Ls
	for git@vger.kernel.org; Mon, 19 Apr 2010 14:46:12 +0200
Received: from 91-67-62-42-dynip.superkabel.de ([91.67.62.42])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 14:46:12 +0200
Received: from sschuberth by 91-67-62-42-dynip.superkabel.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Apr 2010 14:46:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 91-67-62-42-dynip.superkabel.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145294>

This fixes msysGit issue 409, see
http://code.google.com/p/msysgit/issues/detail?id=409

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 compat/mingw.c |   24 ++++++++++++++++++++++++
 compat/mingw.h |    3 +++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 7ec615c..672d074 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -293,6 +293,30 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }
 
+#undef write
+ssize_t mingw_write(int fd, const void *buf, size_t count)
+{
+	ssize_t written = 0;
+	size_t total = 0, size = count;
+
+	while (total < count && size > 0) {
+		written = write(fd, buf, size);
+		if (written < 0 && errno == EINVAL) {
+			// There seems to be a bug in the Windows XP network stack that
+			// causes writes with sizes > 64 MB to fail, so we halve the size
+			// until we succeed or ultimately fail.
+			size /= 2;
+		} else {
+			buf += written;
+			total += written;
+			if (total + size > count)
+				size = count - total;
+		}
+	}
+
+	return written < 0 ? written : total;
+}
+
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index 756f3ab..751bb4c 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -178,6 +178,9 @@ int mingw_rmdir(const char *path);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open
 
+ssize_t mingw_write(int fd, const void *buf, size_t count);
+#define write mingw_write
+
 FILE *mingw_fopen (const char *filename, const char *otype);
 #define fopen mingw_fopen
 
-- 
1.7.0.2.msysgit.0.898.gbf4f.dirty
