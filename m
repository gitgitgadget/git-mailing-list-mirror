From: Johannes Sixt <j6t@kdbg.org>
Subject: [Replacement PATCH 1/7] MinGW: truncate exit()'s argument to lowest 8 bits
Date: Sun, 5 Jul 2009 20:57:46 +0200
Message-ID: <200907052057.46200.j6t@kdbg.org>
References: <cover.1246734159.git.j6t@kdbg.org> <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 05 20:58:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNWuU-0007RA-W4
	for gcvg-git-2@gmane.org; Sun, 05 Jul 2009 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351AbZGES5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2009 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753043AbZGES5r
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jul 2009 14:57:47 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46987 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751687AbZGES5r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2009 14:57:47 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 14DD92C400D;
	Sun,  5 Jul 2009 20:57:46 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 752EB8E22A;
	Sun,  5 Jul 2009 20:57:46 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122747>

For some reason, MinGW's bash cannot reliably detect failure of the child
process if a negative value is passed to exit(). This fixes it by
truncating the exit code in all calls of exit().

This issue was worked around in run_builtin() of git.c (2488df84 builtin
run_command: do not exit with -1, 2007-11-15). This workaround is no longer
necessary and is reverted.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.h |    2 ++
 git.c          |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 4f7ba4c..c1859c5 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -92,6 +92,8 @@ static inline int fcntl(int fd, int cmd, long arg)
 	errno = EINVAL;
 	return -1;
 }
+/* bash cannot reliably detect negative return codes as failure */
+#define exit(code) exit((code) & 0xff)
 
 /*
  * simple adaptors
diff --git a/git.c b/git.c
index f4d53f4..65ed733 100644
--- a/git.c
+++ b/git.c
@@ -245,7 +245,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 	status = p->fn(argc, argv, prefix);
 	if (status)
-		return status & 0xff;
+		return status;
 
 	/* Somebody closed stdout? */
 	if (fstat(fileno(stdout), &st))
-- 
1.6.3.3.393.g6b649
