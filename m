X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/3] move read_mmfile() into xdiff-interface
Date: Wed, 20 Dec 2006 17:37:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612201736310.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 16:37:17 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34947>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx4RO-00040O-Lb for gcvg-git@gmane.org; Wed, 20 Dec
 2006 17:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030199AbWLTQhK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 11:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbWLTQhK
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 11:37:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:35702 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1030199AbWLTQhJ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006 11:37:09 -0500
Received: (qmail invoked by alias); 20 Dec 2006 16:37:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 20 Dec 2006 17:37:07 +0100
To: git@vger.kernel.org, junkio@cox.net
Sender: git-owner@vger.kernel.org


read_file() was a useful function if you want to work with the xdiff stuff,
so it was renamed and put into a more central place.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-merge-file.c |   20 ++------------------
 xdiff-interface.c    |   19 +++++++++++++++++++
 xdiff-interface.h    |    1 +
 3 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/builtin-merge-file.c b/builtin-merge-file.c
index 6c4c3a3..9135773 100644
--- a/builtin-merge-file.c
+++ b/builtin-merge-file.c
@@ -1,26 +1,10 @@
 #include "cache.h"
 #include "xdiff/xdiff.h"
+#include "xdiff-interface.h"
 
 static const char merge_file_usage[] =
 "git merge-file [-p | --stdout] [-q | --quiet] [-L name1 [-L orig [-L name2]]] file1 orig_file file2";
 
-static int read_file(mmfile_t *ptr, const char *filename)
-{
-	struct stat st;
-	FILE *f;
-
-	if (stat(filename, &st))
-		return error("Could not stat %s", filename);
-	if ((f = fopen(filename, "rb")) == NULL)
-		return error("Could not open %s", filename);
-	ptr->ptr = xmalloc(st.st_size);
-	if (fread(ptr->ptr, st.st_size, 1, f) != 1)
-		return error("Could not read %s", filename);
-	fclose(f);
-	ptr->size = st.st_size;
-	return 0;
-}
-
 int cmd_merge_file(int argc, char **argv, char **envp)
 {
 	char *names[3];
@@ -53,7 +37,7 @@ int cmd_merge_file(int argc, char **argv, char **envp)
 		names[i] = argv[i + 1];
 
 	for (i = 0; i < 3; i++)
-		if (read_file(mmfs + i, argv[i + 1]))
+		if (read_mmfile(mmfs + i, argv[i + 1]))
 			return -1;
 
 	ret = xdl_merge(mmfs + 1, mmfs + 0, names[0], mmfs + 2, names[2],
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 08602f5..6c1f99b 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -102,3 +102,22 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
 	}
 	return 0;
 }
+
+int read_mmfile(mmfile_t *ptr, const char *filename)
+{
+	struct stat st;
+	FILE *f;
+
+	if (stat(filename, &st))
+		return error("Could not stat %s", filename);
+	if ((f = fopen(filename, "rb")) == NULL)
+		return error("Could not open %s", filename);
+	ptr->ptr = xmalloc(st.st_size);
+	if (fread(ptr->ptr, st.st_size, 1, f) != 1)
+		return error("Could not read %s", filename);
+	fclose(f);
+	ptr->size = st.st_size;
+	return 0;
+}
+
+
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 1346908..1918808 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -17,5 +17,6 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
+int read_mmfile(mmfile_t *ptr, const char *filename);
 
 #endif
-- 
1.4.4.2.g35224
