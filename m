From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 1/5] msvc: Fix compilation errors caused by poll.h emulation
Date: Thu, 31 Jan 2013 18:28:35 +0000
Message-ID: <510AB7D3.7010407@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:38:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0z22-0006x1-BJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3AaSiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:38:21 -0500
Received: from mdfmta005.mxout.tch.inty.net ([91.221.169.46]:48843 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752877Ab3AaSiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:38:19 -0500
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])
	by mdfmta005.tch.inty.net (Postfix) with ESMTP id E03D218C713;
	Thu, 31 Jan 2013 18:38:18 +0000 (GMT)
Received: from mdfmta005.tch.inty.net (unknown [127.0.0.1])	by mdfmta005.tch.inty.net (Postfix) with ESMTP id 29B3F18C712;	Thu, 31 Jan 2013 18:38:18 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta005.tch.inty.net (Postfix) with ESMTP;	Thu, 31 Jan 2013 18:38:16 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
X-MDF-HostID: 18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215143>


Commit 0f77dea9 ("mingw: move poll out of sys-folder", 24-10-2011), along
with other commits in the 'ef/mingw-upload-archive' branch (see commit
7406aa20), effectively reintroduced the same problem addressed by commit
56fb3ddc ("msvc: Fix compilation errors in compat/win32/sys/poll.c",
04-12-2010).

In order to fix the compilation errors, we use the same solution adopted
in that earlier commit. In particular, we set _WIN32_WINNT to 0x0502
(which would target Windows Server 2003) prior to including the winsock2.h
header file.

Also, we delete the compat/vcbuild/include/sys/poll.h header file, since
it is now redundant and it's presence may cause some confusion.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/vcbuild/include/sys/poll.h | 1 -
 git-compat-util.h                 | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)
 delete mode 100644 compat/vcbuild/include/sys/poll.h

diff --git a/compat/vcbuild/include/sys/poll.h b/compat/vcbuild/include/sys/poll.h
deleted file mode 100644
index 0d8552a..0000000
--- a/compat/vcbuild/include/sys/poll.h
+++ /dev/null
@@ -1 +0,0 @@
-/* Intentionally empty file to support building git with MSVC */
diff --git a/git-compat-util.h b/git-compat-util.h
index cc2abee..204cb1e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -86,6 +86,9 @@
 #define _SGI_SOURCE 1
 
 #ifdef WIN32 /* Both MinGW and MSVC */
+# if defined (_MSC_VER)
+#  define _WIN32_WINNT 0x0502
+# endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
 #include <windows.h>
-- 
1.8.1
