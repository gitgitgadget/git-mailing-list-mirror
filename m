From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] git-commit-tree: if i18n.commitencoding is utf-8 (default),
 check it
Date: Fri, 22 Dec 2006 22:06:08 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222204010.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:06:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxrao-0004iL-1R
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbWLVVGL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbWLVVGL
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:06:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:44127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752724AbWLVVGK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:06:10 -0500
Received: (qmail invoked by alias); 22 Dec 2006 21:06:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 22 Dec 2006 22:06:08 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35219>


Now, git-commit-tree refuses to commit when i18n.commitencoding is
either unset, or set to "utf-8", and the commit message does not
minimally conform to the UTF-8 encoding.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	Unfortunately, I could not think of a shorter oneline description. 
	But my next patch fixes at least the output in shortlog.

 builtin-commit-tree.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index 856f3cd..810b440 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -7,6 +7,7 @@
 #include "commit.h"
 #include "tree.h"
 #include "builtin.h"
+#include "utf8.h"
 
 #define BLOCKING (1ul << 14)
 
@@ -32,7 +33,7 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 	len = vsnprintf(one_line, sizeof(one_line), fmt, args);
 	va_end(args);
 	size = *sizep;
-	newsize = size + len;
+	newsize = size + len + 1;
 	alloc = (size + 32767) & ~32767;
 	buf = *bufp;
 	if (newsize > alloc) {
@@ -40,7 +41,7 @@ static void add_buffer(char **bufp, unsigned int *sizep, const char *fmt, ...)
 		buf = xrealloc(buf, alloc);
 		*bufp = buf;
 	}
-	*sizep = newsize;
+	*sizep = newsize - 1;
 	memcpy(buf + size, one_line, len);
 }
 
@@ -127,6 +128,15 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	while (fgets(comment, sizeof(comment), stdin) != NULL)
 		add_buffer(&buffer, &size, "%s", comment);
 
+	/* And check the encoding */
+	buffer[size] = '\0';
+	if (!strcmp(git_commit_encoding, "utf-8") && utf8_strlen(buffer) < 0) {
+		fprintf(stderr, "Commit message does not conform to UTF-8.\n"
+			"Please fix the message,"
+			" or set the config variable i18n.commitencoding.\n");
+		return 1;
+	}
+
 	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
-- 
1.4.4.3.ge5f98-dirty
