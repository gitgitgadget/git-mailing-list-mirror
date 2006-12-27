From: Junio C Hamano <junkio@cox.net>
Subject: gcc -L/path/lib -R/path/lib
Date: Wed, 27 Dec 2006 14:13:39 -0800
Message-ID: <7v1wml56ng.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Dec 27 23:14:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzh2M-0005aF-Rp
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 23:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWL0WNm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 17:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWL0WNm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 17:13:42 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56326 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbWL0WNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 17:13:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061227221340.BMYV15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Dec 2006 17:13:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3yDt1W00f1kojtg0000000; Wed, 27 Dec 2006 17:13:53 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35485>

While trying git with cURL 7.16.0, I found that in my
environment (Debian x86-64, mostly testing, with gcc 4.1.2
prerelease), gcc does not seem to like -R/path/lib to be used to
specify the runtime library paths.

I am a bit surprised if nobody had this issue before, so I might
be reinventing the wheel and in a wrong/suboptimal way, but this
patch seems to work around the issue for me.

Comments?


diff --git a/Makefile b/Makefile
index 52d4a3a..7b24323 100644
--- a/Makefile
+++ b/Makefile
@@ -79,6 +79,10 @@ all:
 #
 # Define NO_ICONV if your libc does not properly support iconv.
 #
+# Define NO_R_TO_GCC if your gcc does not like "-R/path/lib" that
+# tells runtime paths for dynamic libraries; "-Wl,-rpath=/path/lib"
+# is used instead.
+#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
@@ -422,11 +426,19 @@ ifeq ($(uname_S),Darwin)
 	endif
 endif
 
+ifdef NO_R_TO_GCC_LINKER
+	# Some gcc does not accept and pass -R to the linker to specify
+	# the runtime dynamic library path.
+	CC_LD_DYNPATH = -Wl,-rpath=
+else
+	CC_LD_DYNPATH = -R
+endif
+
 ifndef NO_CURL
 	ifdef CURLDIR
-		# This is still problematic -- gcc does not always want -R.
+		# Try "-Wl,-rpath=$(CURLDIR)/lib" in such a case.
 		BASIC_CFLAGS += -I$(CURLDIR)/include
-		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
+		CURL_LIBCURL = -L$(CURLDIR)/lib $(CC_LD_DYNPATH)$(CURLDIR)/lib -lcurl
 	else
 		CURL_LIBCURL = -lcurl
 	endif
@@ -445,9 +457,8 @@ endif
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
-		# Again this may be problematic -- gcc does not always want -R.
 		BASIC_CFLAGS += -I$(OPENSSLDIR)/include
-		OPENSSL_LINK = -L$(OPENSSLDIR)/lib -R$(OPENSSLDIR)/lib
+		OPENSSL_LINK = -L$(OPENSSLDIR)/lib $(CC_LD_DYNPATH)$(OPENSSLDIR)/lib
 	else
 		OPENSSL_LINK =
 	endif
@@ -463,9 +474,8 @@ else
 endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
-		# Again this may be problematic -- gcc does not always want -R.
 		BASIC_CFLAGS += -I$(ICONVDIR)/include
-		ICONV_LINK = -L$(ICONVDIR)/lib -R$(ICONVDIR)/lib
+		ICONV_LINK = -L$(ICONVDIR)/lib $(CC_LD_DYNPATH)$(ICONVDIR)/lib
 	else
 		ICONV_LINK =
 	endif
