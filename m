From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH] make: By default, remove -pthread on Darwin (it is included by cstdlib).
Date: Mon, 26 Jan 2009 11:26:00 -0500
Message-ID: <1232987160-5635-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 17:27:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUJF-0007zi-JZ
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZAZQ0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbZAZQ0K
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:26:10 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:42924 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751606AbZAZQ0J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 11:26:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id E975380D8047;
	Mon, 26 Jan 2009 11:20:03 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t7ZWLupACfRo; Mon, 26 Jan 2009 11:20:03 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id D582580D803E;
	Mon, 26 Jan 2009 11:20:03 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107225>

As discussed in

http://lists.apple.com/archives/Unix-porting/2005/Mar/msg00019.html

the Mac OS X C standard library is always thread safe and always
includes the pthread library. So explicitly using -pthread causes an
'unrecognized option' compiler warning.

This patch clears PTHREAD_LIBS by default. However, if
FORCE_DARWIN_PTHREAD_LIBS is defined, then PTHREAD_LIBS will be set as
before.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b4d9cb4..30764af 100644
--- a/Makefile
+++ b/Makefile
@@ -70,6 +70,15 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+#
+# Define FORCE_DARWIN_PTHREAD_LIBS if you are building on Darwin/Mac OS
+# X and want PTHREAD_LIBS to be set. On Mac OS X, all components of the
+# C standard library that are defined to be thread safe by the POSIX
+# standard already include the pthread library. Hence, the -pthread
+# option is redundant and will generate an 'unrecognized option'
+# warning. So PTHREAD_LIBS will be cleared unless
+# FORCE_DARWIN_PTHREAD_LIBS is set.
+#
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
 #
@@ -817,6 +826,9 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	ifndef FORCE_DARWIN_PTHREAD_LIBS
+		PTHREAD_LIBS =
+	endif
 endif
 
 ifndef CC_LD_DYNPATH
-- 
1.6.1.213.g28da8
