From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make sq_expand() available as sq_quote().
Date: Thu, 07 Jul 2005 23:58:32 -0700
Message-ID: <7v3bqpdbs7.fsf@assigned-by-dhcp.cox.net>
References: <20050706203139.GA19198@kroah.com>
	<Pine.LNX.4.58.0507061335100.4159@g5.osdl.org>
	<7v64vnwrwg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 08 08:59:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqmoq-0002Je-Ue
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 08:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbVGHG6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 02:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVGHG6f
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 02:58:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30164 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261476AbVGHG6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2005 02:58:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050708065832.OBUW1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 8 Jul 2005 02:58:32 -0400
To: git@vger.kernel.org
In-Reply-To: <7v64vnwrwg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 06 Jul 2005 14:23:11 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

A useful shell safety helper sq_expand() was hidden as a static
function in diff.c.  Extract it out and make it available as
sq_quote().

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
>>>>> "JCH" == Junio C Hamano <junkio@cox.net> writes:

JCH> I am not going to do it myself immediately so there is no worry
JCH> to race against me ;-).

Well, I ended up doing it myself just as a diversion from
thinking about pulls ;-).  As you said, one _must_ be very
careful when feeding a shell, but being careful does not
necessarily hard.

This is the first part; the next one will depend on it.

 Makefile |    3 +++
 diff.c   |   47 ++++++-----------------------------------------
 quote.c  |   41 +++++++++++++++++++++++++++++++++++++++++
 quote.h  |   26 ++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 41 deletions(-)
 create mode 100644 quote.c
 create mode 100644 quote.h

500d2196566027419b1b8effc28f78eb9a60f086
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -65,6 +65,9 @@ LIB_H=cache.h object.h blob.h tree.h com
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
 
+LIB_H += quote.h
+LIB_OBJS += quote.o 
+
 LIB_H += diff.h count-delta.h
 LIB_OBJS += diff.o diffcore-rename.o diffcore-pickaxe.o diffcore-pathspec.o \
 	count-delta.o diffcore-break.o diffcore-order.o
diff --git a/diff.c b/diff.c
--- a/diff.c
+++ b/diff.c
@@ -5,6 +5,7 @@
 #include <sys/wait.h>
 #include <signal.h>
 #include "cache.h"
+#include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
 
@@ -40,42 +41,6 @@ static const char *external_diff(void)
 	return external_diff_cmd;
 }
 
-/* Help to copy the thing properly quoted for the shell safety.
- * any single quote is replaced with '\'', and the caller is
- * expected to enclose the result within a single quote pair.
- *
- * E.g.
- *  original     sq_expand     result
- *  name     ==> name      ==> 'name'
- *  a b      ==> a b       ==> 'a b'
- *  a'b      ==> a'\''b    ==> 'a'\''b'
- */
-static char *sq_expand(const char *src)
-{
-	static char *buf = NULL;
-	int cnt, c;
-	const char *cp;
-	char *bp;
-
-	/* count bytes needed to store the quoted string. */
-	for (cnt = 1, cp = src; *cp; cnt++, cp++)
-		if (*cp == '\'')
-			cnt += 3;
-
-	buf = xmalloc(cnt);
-	bp = buf;
-	while ((c = *src++)) {
-		if (c != '\'')
-			*bp++ = c;
-		else {
-			bp = strcpy(bp, "'\\''");
-			bp += 4;
-		}
-	}
-	*bp = 0;
-	return buf;
-}
-
 static struct diff_tempfile {
 	const char *name; /* filename external diff should read from */
 	char hex[41];
@@ -167,16 +132,16 @@ static void builtin_diff(const char *nam
 			 int complete_rewrite)
 {
 	int i, next_at, cmd_size;
-	const char *diff_cmd = "diff -L'%s%s' -L'%s%s'";
-	const char *diff_arg  = "'%s' '%s'||:"; /* "||:" is to return 0 */
+	const char *diff_cmd = "diff -L%s%s -L%s%s";
+	const char *diff_arg  = "%s %s||:"; /* "||:" is to return 0 */
 	const char *input_name_sq[2];
 	const char *path0[2];
 	const char *path1[2];
 	const char *name_sq[2];
 	char *cmd;
 
-	name_sq[0] = sq_expand(name_a);
-	name_sq[1] = sq_expand(name_b);
+	name_sq[0] = sq_quote(name_a);
+	name_sq[1] = sq_quote(name_b);
 
 	/* diff_cmd and diff_arg have 6 %s in total which makes
 	 * the sum of these strings 12 bytes larger than required.
@@ -186,7 +151,7 @@ static void builtin_diff(const char *nam
 	cmd_size = (strlen(diff_cmd) + strlen(diff_opts) +
 			strlen(diff_arg) - 9);
 	for (i = 0; i < 2; i++) {
-		input_name_sq[i] = sq_expand(temp[i].name);
+		input_name_sq[i] = sq_quote(temp[i].name);
 		if (!strcmp(temp[i].name, "/dev/null")) {
 			path0[i] = "/dev/null";
 			path1[i] = "";
diff --git a/quote.c b/quote.c
new file mode 100644
--- /dev/null
+++ b/quote.c
@@ -0,0 +1,41 @@
+#include "cache.h"
+#include "quote.h"
+
+/* Help to copy the thing properly quoted for the shell safety.
+ * any single quote is replaced with '\'', and the caller is
+ * expected to enclose the result within a single quote pair.
+ *
+ * E.g.
+ *  original     sq_quote     result
+ *  name     ==> name      ==> 'name'
+ *  a b      ==> a b       ==> 'a b'
+ *  a'b      ==> a'\''b    ==> 'a'\''b'
+ */
+char *sq_quote(const char *src)
+{
+	static char *buf = NULL;
+	int cnt, c;
+	const char *cp;
+	char *bp;
+
+	/* count bytes needed to store the quoted string. */
+	for (cnt = 3, cp = src; *cp; cnt++, cp++)
+		if (*cp == '\'')
+			cnt += 3;
+
+	buf = xmalloc(cnt);
+	bp = buf;
+	*bp++ = '\'';
+	while ((c = *src++)) {
+		if (c != '\'')
+			*bp++ = c;
+		else {
+			bp = strcpy(bp, "'\\''");
+			bp += 4;
+		}
+	}
+	*bp++ = '\'';
+	*bp = 0;
+	return buf;
+}
+
diff --git a/quote.h b/quote.h
new file mode 100644
--- /dev/null
+++ b/quote.h
@@ -0,0 +1,26 @@
+#ifndef QUOTE_H
+#define QUOTE_H
+
+
+/* Help to copy the thing properly quoted for the shell safety.
+ * any single quote is replaced with '\'', and the whole thing
+ * is enclosed in a single quote pair.
+ *
+ * For example, if you are passing the result to system() as an
+ * argument:
+ *
+ * sprintf(cmd, "foobar %s %s", sq_quote(arg0), sq_quote(arg1))
+ *
+ * would be appropriate.  If the system() is going to call ssh to
+ * run the command on the other side:
+ *
+ * sprintf(cmd, "git-diff-tree %s %s", sq_quote(arg0), sq_quote(arg1));
+ * sprintf(rcmd, "ssh %s %s", sq_quote(host), sq_quote(cmd));
+ *
+ * Note that the above examples leak memory!  Remember to free result from
+ * sq_quote() in a real application.
+ */
+
+char *sq_quote(const char *src);
+
+#endif
