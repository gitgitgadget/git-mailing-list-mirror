From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] autoconf: Check for ll hh j z t size specifiers introduced by C99
Date: Fri,  4 Aug 2006 17:55:57 +0200
Message-ID: <11547069591228-git-send-email-jnareb@gmail.com>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 04 17:56:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G922I-0007FZ-WA
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161267AbWHDP4I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161268AbWHDP4I
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:56:08 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:63396 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1161267AbWHDP4H (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:56:07 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k74Ft7om029218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Aug 2006 17:55:07 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k74FtxH9018885;
	Fri, 4 Aug 2006 17:55:59 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k74Ftxix018884;
	Fri, 4 Aug 2006 17:55:59 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24797>

Add custom test for checking whether formatted IO functions
(printf/scanf et.al.) support 'size specifiers' introduced by C99,
namely ll, hh, j, z, t. (representing long long int, char, intmax_t,
size_t, ptrdiff_t).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 178220f..1796cf4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -189,6 +189,27 @@ # sockaddr_storage.
 AC_CHECK_TYPE(struct sockaddr_storage,[],
 [GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE=YesPlease)],
 [#include <netinet/in.h>])
+#
+# Define NO_C99_FORMAT if your formatted IO functions (printf/scanf et.al.)
+# do not support the 'size specifiers' introduced by C99, namely ll, hh,
+# j, z, t. (representing long long int, char, intmax_t, size_t, ptrdiff_t).
+# some C compilers supported these specifiers prior to C99 as an extension.
+AC_CACHE_CHECK(whether IO functions support %ll %hh %j %z %t size specifiers,
+ ac_cv_c_c99_format,
+[# Actually git uses only %z (%zu) in alloc.c, and %t (%td) in mktag.c
+AC_RUN_IFELSE(
+	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
+		[[char buf[64];
+		if (sprintf(buf, "%lld%hhd%jd%zd%td", (long long int)1, (char)2, (intmax_t)3, (size_t)4, (ptrdiff_t)5) != 5)
+		  exit(1);
+		else if (strcmp(buf, "12345"))
+		  exit(2);]])],
+	[ac_cv_c_c99_format=yes],
+	[ac_cv_c_c99_format=no])
+])
+if test $ac_cv_c_c99_format = no; then
+	GIT_CONF_APPEND_LINE(NO_C99_FORMAT=YesPlease)
+fi
 
 
 ## Checks for library functions.
-- 
1.4.1.1
