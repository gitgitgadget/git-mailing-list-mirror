From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Move add_to_string to "quote.c" and make it extern.
Date: Mon, 11 Sep 2006 06:59:22 +0200
Message-ID: <20060911065922.93139e5d.chriscool@tuxfamily.org>
References: <200609110643.13486.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 11 06:53:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMdnX-0000Ji-LF
	for gcvg-git@gmane.org; Mon, 11 Sep 2006 06:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbWIKEx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Sep 2006 00:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbWIKEx2
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Sep 2006 00:53:28 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:22152 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S932067AbWIKEx2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Sep 2006 00:53:28 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id 2E73B47DA6;
	Mon, 11 Sep 2006 06:53:26 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
In-Reply-To: <200609110643.13486.chriscool@tuxfamily.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26835>

So that this function may be used in places other than "rsh.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 quote.c |   29 +++++++++++++++++++++++++++++
 quote.h |    6 ++++++
 rsh.c   |   29 -----------------------------
 3 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/quote.c b/quote.c
index a38786c..200e4e2 100644
--- a/quote.c
+++ b/quote.c
@@ -106,6 +106,35 @@ char *sq_quote_argv(const char** argv, i
 	return buf;
 }
 
+/*
+ * Append a string to a string buffer, with or without shell quoting.
+ * Return true if the buffer overflowed.
+ */
+int add_to_string(char **ptrp, int *sizep, const char *str, int quote)
+{
+	char *p = *ptrp;
+	int size = *sizep;
+	int oc;
+	int err = 0;
+
+	if ( quote ) {
+		oc = sq_quote_buf(p, size, str);
+	} else {
+		oc = strlen(str);
+		memcpy(p, str, (oc >= size) ? size-1 : oc);
+	}
+
+	if ( oc >= size ) {
+		err = 1;
+		oc = size-1;
+	}
+
+	*ptrp  += oc;
+	**ptrp  = '\0';
+	*sizep -= oc;
+	return err;
+}
+
 char *sq_dequote(char *arg)
 {
 	char *dst = arg;
diff --git a/quote.h b/quote.h
index a6c4611..1a29e79 100644
--- a/quote.h
+++ b/quote.h
@@ -33,6 +33,12 @@ extern void sq_quote_print(FILE *stream,
 extern size_t sq_quote_buf(char *dst, size_t n, const char *src);
 extern char *sq_quote_argv(const char** argv, int count);
 
+/*
+ * Append a string to a string buffer, with or without shell quoting.
+ * Return true if the buffer overflowed.
+ */
+extern int add_to_string(char **ptrp, int *sizep, const char *str, int quote);
+
 /* This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
  * produced.
diff --git a/rsh.c b/rsh.c
index 07166ad..8a1db45 100644
--- a/rsh.c
+++ b/rsh.c
@@ -8,35 +8,6 @@ #include "cache.h"
 
 #define COMMAND_SIZE 4096
 
-/*
- * Append a string to a string buffer, with or without shell quoting.
- * Return true if the buffer overflowed.
- */
-static int add_to_string(char **ptrp, int *sizep, const char *str, int quote)
-{
-	char *p = *ptrp;
-	int size = *sizep;
-	int oc;
-	int err = 0;
-
-	if ( quote ) {
-		oc = sq_quote_buf(p, size, str);
-	} else {
-		oc = strlen(str);
-		memcpy(p, str, (oc >= size) ? size-1 : oc);
-	}
-
-	if ( oc >= size ) {
-		err = 1;
-		oc = size-1;
-	}
-
-	*ptrp  += oc;
-	**ptrp  = '\0';
-	*sizep -= oc;
-	return err;
-}
-
 int setup_connection(int *fd_in, int *fd_out, const char *remote_prog, 
 		     char *url, int rmt_argc, char **rmt_argv)
 {
-- 
1.4.2.g430e
