From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] Move buffer_is_binary() to xdiff-interface.h
Date: Tue, 5 Jun 2007 03:36:11 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706050335010.4046@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Jun 05 04:38:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvOwD-000420-N5
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 04:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbXFECiS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 22:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757767AbXFECiS
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 22:38:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:52410 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757468AbXFECiR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 22:38:17 -0400
Received: (qmail invoked by alias); 05 Jun 2007 02:38:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 05 Jun 2007 04:38:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CUL8worJC2ICD3VmXfTvNtkjcqBwoCez++INt7b
	KQzgplahXCkahl
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49146>


We already have two instances where we want to determine if a buffer
contains binary data as opposed to text.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c            |    6 +-----
 grep.c            |   11 -----------
 xdiff-interface.c |    8 ++++++++
 xdiff-interface.h |    1 +
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 508bc51..1a72688 100644
--- a/diff.c
+++ b/diff.c
@@ -1107,7 +1107,6 @@ static void setup_diff_attr_check(struct git_attr_check *check)
 	check->attr = attr_diff;
 }
 
-#define FIRST_FEW_BYTES 8000
 static int file_is_binary(struct diff_filespec *one)
 {
 	unsigned long sz;
@@ -1127,10 +1126,7 @@ static int file_is_binary(struct diff_filespec *one)
 			return 0;
 		diff_populate_filespec(one, 0);
 	}
-	sz = one->size;
-	if (FIRST_FEW_BYTES < sz)
-		sz = FIRST_FEW_BYTES;
-	return !!memchr(one->data, 0, sz);
+	return buffer_is_binary(one->data, one->size);
 }
 
 static void builtin_diff(const char *name_a,
diff --git a/grep.c b/grep.c
index fcc6762..f05ae84 100644
--- a/grep.c
+++ b/grep.c
@@ -232,17 +232,6 @@ static void show_line(struct grep_opt *opt, const char *bol, const char *eol,
 	printf("%.*s\n", (int)(eol-bol), bol);
 }
 
-/*
- * NEEDSWORK: share code with diff.c
- */
-#define FIRST_FEW_BYTES 8000
-static int buffer_is_binary(const char *ptr, unsigned long size)
-{
-	if (FIRST_FEW_BYTES < size)
-		size = FIRST_FEW_BYTES;
-	return !!memchr(ptr, 0, size);
-}
-
 static int fixmatch(const char *pattern, char *line, regmatch_t *match)
 {
 	char *hit = strstr(line, pattern);
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 10816e9..963bb89 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -122,4 +122,12 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
 
+#define FIRST_FEW_BYTES 8000
+int buffer_is_binary(const char *ptr, unsigned long size)
+{
+	if (FIRST_FEW_BYTES < size)
+		size = FIRST_FEW_BYTES;
+	return !!memchr(ptr, 0, size);
+}
+
 
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 1918808..536f4e4 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -18,5 +18,6 @@ int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
 int read_mmfile(mmfile_t *ptr, const char *filename);
+int buffer_is_binary(const char *ptr, unsigned long size);
 
 #endif
-- 
1.5.2.1.2626.ge1044-dirty
