From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sat, 19 Nov 2011 14:45:44 +0100
Message-ID: <1321710345-2299-1-git-send-email-vfr@lyx.org>
Cc: msysgit@googlegroups.com, gitster@pobox.com, kusmabite@gmail.com,
	Johannes.Schindelin@gmx.de, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 14:46:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRlFH-0001Ff-8T
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 14:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab1KSNqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 08:46:09 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61415 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab1KSNqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 08:46:08 -0500
Received: by eye27 with SMTP id 27so4234439eye.19
        for <git@vger.kernel.org>; Sat, 19 Nov 2011 05:46:07 -0800 (PST)
Received: by 10.213.8.207 with SMTP id i15mr133930ebi.47.1321710367130;
        Sat, 19 Nov 2011 05:46:07 -0800 (PST)
Received: from localhost.localdomain (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id t6sm12308813eeb.11.2011.11.19.05.46.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Nov 2011 05:46:06 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185691>

When compiled with MSVC, git crashes on Windows when calling
fstat(stdout) when stdout is closed. fstat is being called at the end of
run_builtin and this will thus be a problem for builtin command that close
stdout. This happens for 'format-patch' which closes stdout after a call to
freopen which directs stdout to the format patch file.

To prevent the crash and to prevent git from writing cruft into the patch
file, we do not close stdout, but redirect it to "nul" instead.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 compat/mingw.c |    8 ++++++++
 compat/mingw.h |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index efdc703..8943df5 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -319,6 +319,14 @@ ssize_t mingw_write(int fd, const void *buf, size_t count)
 	return write(fd, buf, min(count, 31 * 1024 * 1024));
 }
 
+#undef fclose
+int mingw_fclose (FILE *stream)
+{
+	if (fileno(stream) == 1 && freopen("nul", "w", stream))
+		return 0;
+	return fclose(stream);
+}
+
 #undef fopen
 FILE *mingw_fopen (const char *filename, const char *otype)
 {
diff --git a/compat/mingw.h b/compat/mingw.h
index ff18401..80a6015 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -179,6 +179,9 @@ int mingw_open (const char *filename, int oflags, ...);
 ssize_t mingw_write(int fd, const void *buf, size_t count);
 #define write mingw_write
 
+int mingw_fclose(FILE *stream);
+#define fclose mingw_fclose
+
 FILE *mingw_fopen (const char *filename, const char *otype);
 #define fopen mingw_fopen
 
-- 
1.7.4.1
