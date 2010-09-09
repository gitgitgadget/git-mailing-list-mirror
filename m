From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] vcs-svn: Fix some printf format compiler warnings
Date: Thu, 09 Sep 2010 18:24:06 +0100
Message-ID: <4C891836.6070608@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, artagnon@gmail.com,
	jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 19:51:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtlHf-0004Wu-GX
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 19:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066Ab0IIRvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 13:51:32 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:64526 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959Ab0IIRvb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 13:51:31 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1OtlHV-00047q-iJ; Thu, 09 Sep 2010 17:51:30 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155869>


In particular, on systems that define uint32_t as an unsigned long,
gcc complains as follows:

    CC vcs-svn/fast_export.o
vcs-svn/fast_export.c: In function `fast_export_modify':
vcs-svn/fast_export.c:28: warning: unsigned int format, uint32_t arg (arg 2)
vcs-svn/fast_export.c:28: warning: int format, uint32_t arg (arg 3)
vcs-svn/fast_export.c: In function `fast_export_commit':
vcs-svn/fast_export.c:42: warning: int format, uint32_t arg (arg 5)
vcs-svn/fast_export.c:62: warning: int format, uint32_t arg (arg 2)
vcs-svn/fast_export.c: In function `fast_export_blob':
vcs-svn/fast_export.c:72: warning: int format, uint32_t arg (arg 2)
vcs-svn/fast_export.c:72: warning: int format, uint32_t arg (arg 3)
    CC vcs-svn/svndump.o
vcs-svn/svndump.c: In function `svndump_read':
vcs-svn/svndump.c:260: warning: int format, uint32_t arg (arg 3)

In order to suppress the warnings we use the C99 format specifier
macros PRIo32 and PRIu32 from <inttypes.h>.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

The addition to git-compat-util.h is required in order to not break
the build on both MinGW and MSVC; there are other (better?) ways to
fix this, but this was simple and seems to be in keeping with the
current code.

ATB,
Ramsay Jones

 git-compat-util.h     |    4 ++++
 vcs-svn/fast_export.c |    9 +++++----
 vcs-svn/svndump.c     |    2 +-
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 877096e..81883e7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -160,6 +160,10 @@ extern char *gitbasename(char *);
 #define PRIx32 "x"
 #endif
 
+#ifndef PRIo32
+#define PRIo32 "o"
+#endif
+
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 256a052..6cfa256 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -25,7 +25,7 @@ void fast_export_modify(uint32_t depth, uint32_t *path, uint32_t mode,
 			uint32_t mark)
 {
 	/* Mode must be 100644, 100755, 120000, or 160000. */
-	printf("M %06o :%d ", mode, mark);
+	printf("M %06"PRIo32" :%"PRIu32" ", mode, mark);
 	pool_print_seq(depth, path, '/', stdout);
 	putchar('\n');
 }
@@ -38,7 +38,8 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	if (!log)
 		log = "";
 	if (~uuid && ~url) {
-		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN, "\n\ngit-svn-id: %s@%d %s\n",
+		snprintf(gitsvnline, MAX_GITSVN_LINE_LEN,
+				"\n\ngit-svn-id: %s@%"PRIu32" %s\n",
 				 pool_fetch(url), revision, pool_fetch(uuid));
 	} else {
 		*gitsvnline = '\0';
@@ -59,7 +60,7 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	repo_diff(revision - 1, revision);
 	fputc('\n', stdout);
 
-	printf("progress Imported commit %d.\n\n", revision);
+	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
@@ -69,7 +70,7 @@ void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len)
 		buffer_skip_bytes(5);
 		len -= 5;
 	}
-	printf("blob\nmark :%d\ndata %d\n", mark, len);
+	printf("blob\nmark :%"PRIu32"\ndata %"PRIu32"\n", mark, len);
 	buffer_copy_bytes(len);
 	fputc('\n', stdout);
 }
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 630eeb5..53d0215 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -257,7 +257,7 @@ void svndump_read(const char *url)
 				handle_node();
 				active_ctx = REV_CTX;
 			} else {
-				fprintf(stderr, "Unexpected content length header: %d\n", len);
+				fprintf(stderr, "Unexpected content length header: %"PRIu32"\n", len);
 				buffer_skip_bytes(len);
 			}
 		}
-- 
1.7.2.1
