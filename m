From: Amos Waterland <apw@us.ibm.com>
Subject: [PATCH] AIX compile fix for repo-config.c
Date: Wed, 4 Jan 2006 19:31:02 -0500
Message-ID: <20060105003102.GA21251@kvasir.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 01:31:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuJ2D-0007ML-CA
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 01:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWAEAbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jan 2006 19:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWAEAbN
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jan 2006 19:31:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43666 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750855AbWAEAbM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2006 19:31:12 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k050VBHq013473
	for <git@vger.kernel.org>; Wed, 4 Jan 2006 19:31:11 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k050VBpu094840
	for <git@vger.kernel.org>; Wed, 4 Jan 2006 19:31:11 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k050VBD5022805
	for <git@vger.kernel.org>; Wed, 4 Jan 2006 19:31:11 -0500
Received: from kvasir.watson.ibm.com (kvasir.watson.ibm.com [9.2.218.19])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k050VBN8022782;
	Wed, 4 Jan 2006 19:31:11 -0500
Received: from apw by kvasir.watson.ibm.com with local (Exim 4.52)
	id 1EuJ1y-0005ct-Au; Wed, 04 Jan 2006 19:31:02 -0500
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14182>

AIX 5 has a /usr/include/regex.h containing this code:

 #ifdef  _NO_PROTO
 extern  char    *regex();
 extern  char    *regcmp();
 #else /* _NO_PROTO */
 extern  char    *regex(const char *, const char *, ...);
 extern  char    *regcmp(const char *, ...);
 #endif  /* _NO_PROTO */

This means that repo-config.c is trying to redefine the `regex' symbol.
Here is a simple patch that just uses `regexp' as the symbol name instead.

Signed-off-by: Amos Waterland <apw@us.ibm.com>

--- repo-config.c.orig	Wed Jan  4 18:58:21 2006
+++ repo-config.c	Wed Jan  4 18:59:15 2006
@@ -6,7 +6,7 @@
 
 static char* key = NULL;
 static char* value = NULL;
-static regex_t* regex = NULL;
+static regex_t* regexp = NULL;
 static int do_all = 0;
 static int do_not_match = 0;
 static int seen = 0;
@@ -14,9 +14,9 @@
 static int show_config(const char* key_, const char* value_)
 {
 	if (!strcmp(key_, key) &&
-			(regex == NULL ||
+			(regexp == NULL ||
 			 (do_not_match ^
-			  !regexec(regex, value_, 0, NULL, 0)))) {
+			  !regexec(regexp, value_, 0, NULL, 0)))) {
 		if (do_all) {
 			printf("%s\n", value_);
 			return 0;
@@ -46,8 +46,8 @@
 			regex_++;
 		}
 
-		regex = (regex_t*)malloc(sizeof(regex_t));
-		if (regcomp(regex, regex_, REG_EXTENDED)) {
+		regexp = (regex_t*)malloc(sizeof(regex_t));
+		if (regcomp(regexp, regex_, REG_EXTENDED)) {
 			fprintf(stderr, "Invalid pattern: %s\n", regex_);
 			return -1;
 		}
@@ -59,9 +59,9 @@
 		free(value);
 	}
 	free(key);
-	if (regex) {
-		regfree(regex);
-		free(regex);
+	if (regexp) {
+		regfree(regexp);
+		free(regexp);
 	}
 
 	if (do_all)
