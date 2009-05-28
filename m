From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/4] Makefile: introduce SANE_TOOL_PATH for prepending required elements to PATH
Date: Wed, 27 May 2009 21:17:08 -0500
Message-ID: <8D9Pn2N3FZLQcyxrPABrGxTLa3Dlq25WDqK5xSJyY6cvQv4mphIUXvRu59EA7ewVS-vbi5IZUc4@cipher.nrlssc.navy.mil>
References: <8D9Pn2N3FZLQcyxrPABrG-rVdsP-X00e6c8oj-YzYQzWI-MvSy5AAzVjbQS0XsK76Ax9XKaLBbU@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG3rdrFXFL1OddmlhE77V4q-K8NSzkS8xbqdJw0C0CnqkCcLEUU_UEIs@cipher.nrlssc.navy.mil> <8D9Pn2N3FZLQcyxrPABrG-BSSbTCg9PE0lVG9rBAr5BVQibQYcIzXrxDf4S0P9Pb6AZO5MBuasg@cipher.nrlssc.navy.mil>
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 04:17:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9VBo-0001II-T4
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 04:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZE1CR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 22:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbZE1CR3
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 22:17:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48235 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbZE1CRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 22:17:24 -0400
Received: by mail.nrlssc.navy.mil id n4S2HMTU009408; Wed, 27 May 2009 21:17:22 -0500
In-Reply-To: <8D9Pn2N3FZLQcyxrPABrG-BSSbTCg9PE0lVG9rBAr5BVQibQYcIzXrxDf4S0P9Pb6AZO5MBuasg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 28 May 2009 02:17:22.0501 (UTC) FILETIME=[6F4A5750:01C9DF3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120137>

From: Junio C Hamano <gitster@pobox.com>

Some platforms (like SunOS and family) have kept their common binaries at
some historical moment in time, and introduced new binaries with modern
features in a special location like /usr/xpg4/bin or /usr/ucb.  Some of the
features provided by these modern binaries are expected and required by git.
If the featureful binaries are not in the users path, then git could end up
using the less featureful binary and fail.

So provide a mechanism to prepend elements to the users PATH at runtime so
the modern binaries will be found.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---


I liked this patch.  Seems like the right thing to do on Solaris.

-brandon


 Makefile        |   14 ++++++++++++++
 git-sh-setup.sh |    2 ++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8b377f3..3f4708f 100644
--- a/Makefile
+++ b/Makefile
@@ -3,6 +3,11 @@ all::
 
 # Define V=1 to have a more verbose compile.
 #
+# Define SHELL_PATH to a POSIX shell if your /bin/sh is broken.
+#
+# Define SANE_TOOL_PATH to a colon-separated list of paths to prepend
+# to PATH if your tools in /usr/bin are broken.
+#
 # Define SNPRINTF_RETURNS_BOGUS if your are on a system which snprintf()
 # or vsnprintf() return -1 instead of number of characters which would
 # have been written to the final string if enough space had been available.
@@ -703,6 +708,7 @@ ifeq ($(uname_S),SunOS)
 	NEEDS_NSL = YesPlease
 	NEEDS_RESOLV = YesPlease
 	SHELL_PATH = /bin/bash
+	SANE_TOOL_PATH = /usr/xpg6/bin:/usr/xpg4/bin
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
@@ -871,6 +877,13 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifdef SANE_TOOL_PATH
+BROKEN_PATH_FIX = s|^. @@PATH@@|PATH=$(SANE_TOOL_PATH)|
+PATH := $(SANE_TOOL_PATH):${PATH}
+else
+BROKEN_PATH_FIX = d
+endif
+
 ifeq ($(uname_S),Darwin)
 	ifndef NO_FINK
 		ifeq ($(shell test -d /sw/lib && echo y),y)
@@ -1272,6 +1285,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e '/^# @@PATH@@/$(BROKEN_PATH_FIX)' \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 8382339..7802581 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -11,6 +11,8 @@
 # exporting it.
 unset CDPATH
 
+# @@PATH@@:$PATH
+
 die() {
 	echo >&2 "$@"
 	exit 1
-- 
1.6.3.1.24.g152f4
