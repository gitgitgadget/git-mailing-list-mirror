From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/3] Make rsh.c use sq_quote_buf()
Date: Mon, 10 Oct 2005 13:50:06 -0700
Message-ID: <434AD3FE.204@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030700060805020305000507"
X-From: git-owner@vger.kernel.org Mon Oct 10 22:55:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4bN-0005Nq-Im
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVJJUuN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVJJUuM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:50:12 -0400
Received: from terminus.zytor.com ([192.83.249.54]:10648 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751222AbVJJUuL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:50:11 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AKo8hj006953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 13:50:08 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9931>

This is a multi-part message in MIME format.
--------------030700060805020305000507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------030700060805020305000507
Content-Type: text/x-patch;
 name="02-make-rsh-c-use-sq-quote-buf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-make-rsh-c-use-sq-quote-buf.patch"

Make rsh.c use sq_quote_buf()

---
commit 16e46159b554116a7d95a206913fcdf7e79e07d0
tree c075951382add702148d7a2c2b4e0298efab8082
parent cc114823f72bd8d912abf7f7a7515853c554a9f3
author Peter Anvin <hpa@tazenda.sc.orionmulti.com> Mon, 10 Oct 2005 12:23:44 -0700
committer Peter Anvin <hpa@tazenda.sc.orionmulti.com> Mon, 10 Oct 2005 12:23:44 -0700

 rsh.c |   46 +++++-----------------------------------------
 1 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/rsh.c b/rsh.c
index bad5cff..8278eab 100644
--- a/rsh.c
+++ b/rsh.c
@@ -1,52 +1,16 @@
-#include "rsh.h"
-
 #include <string.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 
+#include "rsh.h"
+#include "quote.h"
 #include "cache.h"
 
 #define COMMAND_SIZE 4096
 
 /*
- * Write a shell-quoted version of a string into a buffer, and
- * return bytes that ought to be output excluding final null.
- */
-static int shell_quote(char *buf, int nmax, const char *str)
-{
-	char ch;
-	int nq;
-	int oc = 0;
-
-	while ( (ch = *str++) ) {
-		nq = 0;
-		if ( strchr(" !\"#$%&\'()*;<=>?[\\]^`{|}", ch) )
-			nq = 1;
-
-		if ( nq ) {
-			if ( nmax > 1 ) {
-				*buf++ = '\\';
-				nmax--;
-			}
-			oc++;
-		}
-
-		if ( nmax > 1 ) {
-			*buf++ = ch;
-			nmax--;
-		}
-		oc++;
-	}
-
-	if ( nmax )
-		*buf = '\0';
-
-	return oc;
-}
-			
-/*
- * Append a string to a string buffer, with or without quoting.  Return true
- * if the buffer overflowed.
+ * Append a string to a string buffer, with or without shell quoting.
+ * Return true if the buffer overflowed.
  */
 static int add_to_string(char **ptrp, int *sizep, const char *str, int quote)
 {
@@ -56,7 +20,7 @@ static int add_to_string(char **ptrp, in
 	int err = 0;
 
 	if ( quote ) {
-		oc = shell_quote(p, size, str);
+		oc = sq_quote_buf(p, size, str);
 	} else {
 		oc = strlen(str);
 		memcpy(p, str, (oc >= size) ? size-1 : oc);

--------------030700060805020305000507--
