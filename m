From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH (update)] make: By default, remove -pthread on Darwin (it is included by cstdlib).
Date: Mon, 26 Jan 2009 11:33:29 -0500
Message-ID: <1232987609-6229-1-git-send-email-ted@tedpavlic.com>
References: <1232987160-5635-1-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, Ted Pavlic <ted@tedpavlic.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 17:35:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUQS-0002gR-D4
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbZAZQdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbZAZQdj
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:33:39 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:53519 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbZAZQdi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jan 2009 11:33:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 7A80980D803D;
	Mon, 26 Jan 2009 11:27:33 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ggznyWx3IdZF; Mon, 26 Jan 2009 11:27:33 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 5CD4180D803E;
	Mon, 26 Jan 2009 11:27:33 -0500 (EST)
X-Mailer: git-send-email 1.6.1.213.g28da8
In-Reply-To: <1232987160-5635-1-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107230>

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

This update adds the documentation comment in the Makefile to
configure.ac as well.

 Makefile     |   11 +++++++++++
 configure.ac |    8 ++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index b4d9cb4..86f0a66 100644
--- a/Makefile
+++ b/Makefile
@@ -70,6 +70,14 @@ all::
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
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
@@ -817,6 +825,9 @@ ifeq ($(uname_S),Darwin)
 			BASIC_LDFLAGS += -L/opt/local/lib
 		endif
 	endif
+	ifndef FORCE_DARWIN_PTHREAD_LIBS
+		PTHREAD_LIBS =
+	endif
 endif
 
 ifndef CC_LD_DYNPATH
diff --git a/configure.ac b/configure.ac
index 082a03d..a53d97c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -578,6 +578,14 @@ GIT_PARSE_WITH(expat))
 # specify your own (or DarwinPort's) include directories and
 # library directories by defining CFLAGS and LDFLAGS appropriately.
 #
+# Define FORCE_DARWIN_PTHREAD_LIBS if you are building on Darwin/Mac OS
+# X and want PTHREAD_LIBS to be set. On Mac OS X, all components of the
+# C standard library that are defined to be thread safe by the POSIX
+# standard already include the pthread library. Hence, the -pthread
+# option is redundant and will generate an 'unrecognized option'
+# warning. So PTHREAD_LIBS will be cleared unless
+# FORCE_DARWIN_PTHREAD_LIBS is set.
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_ICONV if your libc does not properly support iconv.
-- 
1.6.1.213.g28da8
