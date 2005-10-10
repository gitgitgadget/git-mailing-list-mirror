From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] Enhanced sq_quote()
Date: Mon, 10 Oct 2005 13:49:34 -0700
Message-ID: <434AD3DE.6040300@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080005090705090209080803"
X-From: git-owner@vger.kernel.org Mon Oct 10 22:55:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4b8-0005Hg-JX
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVJJUtq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVJJUtp
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:49:45 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9368 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751223AbVJJUto
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:49:44 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9AKnaJk006923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Oct 2005 13:49:37 -0700
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9929>

This is a multi-part message in MIME format.
--------------080005090705090209080803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------080005090705090209080803
Content-Type: text/x-patch;
 name="01-create-function-to-sq-quote-into-a-buffer.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="01-create-function-to-sq-quote-into-a-buffer.patch"

Create function to sq_quote into a buffer
Handle !'s for csh-based shells

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit cc114823f72bd8d912abf7f7a7515853c554a9f3
tree 9766b638ae175b9206855f2613e07507ed51fbca
parent d5b0c9ea178dab3599674ccff50645c0464b8c31
author Peter Anvin <hpa@tazenda.sc.orionmulti.com> Mon, 10 Oct 2005 12:21:35 -0700
committer Peter Anvin <hpa@tazenda.sc.orionmulti.com> Mon, 10 Oct 2005 12:21:35 -0700

 quote.c |   56 ++++++++++++++++++++++++++++++++++----------------------
 quote.h |   11 +++++++++--
 2 files changed, 43 insertions(+), 24 deletions(-)

diff --git a/quote.c b/quote.c
index 5e6fda3..9d5d0bc 100644
--- a/quote.c
+++ b/quote.c
@@ -2,40 +2,52 @@
 #include "quote.h"
 
 /* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', and the caller is
- * expected to enclose the result within a single quote pair.
+ * any single quote is replaced with '\'', any exclamation point
+ * is replaced with '\!', and the whole thing is enclosed in a
  *
  * E.g.
  *  original     sq_quote     result
  *  name     ==> name      ==> 'name'
  *  a b      ==> a b       ==> 'a b'
  *  a'b      ==> a'\''b    ==> 'a'\''b'
+ *  a!b      ==> a'\!'b    ==> 'a'\!'b'
  */
-char *sq_quote(const char *src)
+#define EMIT(x) ( (++len < n) && (*bp++ = (x)) )
+
+size_t sq_quote_buf(char *dst, size_t n, const char *src)
 {
-	static char *buf = NULL;
-	int cnt, c;
-	const char *cp;
-	char *bp;
-
-	/* count bytes needed to store the quoted string. */
-	for (cnt = 3, cp = src; *cp; cnt++, cp++)
-		if (*cp == '\'')
-			cnt += 3;
+	char c;
+	char *bp = dst;
+	size_t len = 0;
 
-	buf = xmalloc(cnt);
-	bp = buf;
-	*bp++ = '\'';
+	EMIT('\'');
 	while ((c = *src++)) {
-		if (c != '\'')
-			*bp++ = c;
-		else {
-			bp = strcpy(bp, "'\\''");
-			bp += 4;
+		if (c == '\'' || c == '!') {
+			EMIT('\'');
+			EMIT('\\');
+			EMIT(c);
+			EMIT('\'');
+		} else {
+			EMIT(c);
 		}
 	}
-	*bp++ = '\'';
-	*bp = 0;
+	EMIT('\'');
+
+	if ( n )
+		*bp = 0;
+
+	return len;
+}
+
+char *sq_quote(const char *src)
+{
+	char *buf;
+	size_t cnt;
+
+	cnt = sq_quote_buf(NULL, 0, src) + 1;
+	buf = xmalloc(cnt);
+	sq_quote_buf(buf, cnt, src);
+
 	return buf;
 }
 
diff --git a/quote.h b/quote.h
index c8cfb3a..50ce1df 100644
--- a/quote.h
+++ b/quote.h
@@ -1,10 +1,12 @@
 #ifndef QUOTE_H
 #define QUOTE_H
 
+#include <stddef.h>
 
 /* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', and the whole thing
- * is enclosed in a single quote pair.
+ * any single quote is replaced with '\'', any exclamation point
+ * is replaced with '\!', and the whole thing is enclosed in a
+ * single quote pair.
  *
  * For example, if you are passing the result to system() as an
  * argument:
@@ -19,8 +21,13 @@
  *
  * Note that the above examples leak memory!  Remember to free result from
  * sq_quote() in a real application.
+ *
+ * sq_quote_buf() writes to an existing buffer of specified size; it
+ * will return the number of characters that would have been written
+ * excluding the final null regardless of the buffer size.
  */
 
 char *sq_quote(const char *src);
+size_t sq_quote_buf(char *dst, size_t n, const char *src);
 
 #endif

--------------080005090705090209080803--
