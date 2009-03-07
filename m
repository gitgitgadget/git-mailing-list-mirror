From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Brown paper bag fix for MinGW 64-bit stat
Date: Sat, 7 Mar 2009 15:37:18 +0100 (CET)
Message-ID: <03fcab37c921f5728deded11c07bdf32a263b79b.1236436185u.git.johannes.schindelin@gmx.de>
References: <cover.1236436185u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Mar 07 15:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfxfv-0001lF-Uk
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 15:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753913AbZCGOfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 09:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbZCGOfs
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 09:35:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:51748 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753478AbZCGOfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 09:35:47 -0500
Received: (qmail invoked by alias); 07 Mar 2009 14:35:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 07 Mar 2009 15:35:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UXq02HxMUaqlsb6WvxsBd32de5Z6sQwnsdeNMfO
	IJCeueEzpiVD9u
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <cover.1236436185u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112540>

When overriding the identifier "stat" so that "struct stat" will be
substituted with "struct _stati64" everywhere, I tried to fix the calls
to the _function_ stat(), too, but I forgot to change the earlier
attempt "stat64" to "_stati64" there.

So, the stat() calls were overridden by calls to _stati64() instead.

Unfortunately, there is a function _stati64() so that I missed that
calls to stat() were not actually overridden by calls to mingw_lstat(),
but t4200-rerere.sh showed the error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Aaargh.

	I am very, very sorry.

	Actually, it was quite funny that t4200 displayed the bug; I 
	_guess_ it was due to a time zone issue, as the times were exactly 
	one hour off (and the machine I tested on is at UTC+0100 right now).

	And due to that bug, "rerere gc" would not collect the garbage.

	So even if the C runtime provides a _stati64() function that 
	pretends to work, it does not, and this patch is absolutely necessary.

	Now, if only the tests would not take ages to run on Windows...  
	then I would not be tempted to skip them when sending the next patches.

 compat/mingw.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index 92fb310..a0b74fb 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -169,7 +169,7 @@ int mingw_lstat(const char *file_name, struct stat *buf);
 int mingw_fstat(int fd, struct stat *buf);
 #define fstat mingw_fstat
 #define lstat mingw_lstat
-#define stat64(x,y) mingw_lstat(x,y)
+#define _stati64(x,y) mingw_lstat(x,y)
 
 int mingw_utime(const char *file_name, const struct utimbuf *times);
 #define utime mingw_utime
-- 
1.6.2.327.g0fa6c
