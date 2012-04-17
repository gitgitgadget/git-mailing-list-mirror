From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] compat/mingw.h: Set S_ISUID to prevent a fast-import test
 failure
Date: Tue, 17 Apr 2012 19:00:04 +0100
Message-ID: <4F8DAFA4.2050502@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 20:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKDV5-0005xl-UT
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 20:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087Ab2DQSvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 14:51:25 -0400
Received: from anchor-post-1.mail.demon.net ([195.173.77.132]:37832 "EHLO
	anchor-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752014Ab2DQSvY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 14:51:24 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1SKDUo-0007Wu-hh; Tue, 17 Apr 2012 18:51:23 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195790>


The current t9300-fast-import.sh test number 62 ("L: nested tree
copy does not corrupt deltas") was introduced in commit 9a0edb79
("fast-import: add a test for tree delta base corruption",
15-08-2011). A fix for the demonstrated problem was introduced
by commit 8fb3ad76 ("fast-import: prevent producing bad delta",
15-08-2011). However, this fix didn't work on MinGW and so this
test has always failed on MinGW.

Part of the solution in commit 8fb3ad76 was to add an NO_DELTA
preprocessor constant which was defined as follows:

  +/*
  + * We abuse the setuid bit on directories to mean "do not delta".
  + */
  +#define NO_DELTA S_ISUID
  +

Unfortunately, the S_ISUID constant on MinGW is defined as zero.

In order to fix the problem, we simply alter the definition of
S_ISUID in the mingw header file to a more appropriate value.
Also, we take the opportunity to similarly define S_ISGID and
S_ISVTX.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/mingw.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index ef5b150..61a6521 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -22,9 +22,10 @@ typedef int socklen_t;
 #define S_IWOTH 0
 #define S_IXOTH 0
 #define S_IRWXO (S_IROTH | S_IWOTH | S_IXOTH)
-#define S_ISUID 0
-#define S_ISGID 0
-#define S_ISVTX 0
+
+#define S_ISUID 0004000
+#define S_ISGID 0002000
+#define S_ISVTX 0001000
 
 #define WIFEXITED(x) 1
 #define WIFSIGNALED(x) 0
-- 
1.7.10
