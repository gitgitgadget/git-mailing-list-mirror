From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Simplify CFLAGS/DEFINES in Makefile
Date: Fri, 04 Nov 2005 23:57:00 -0800
Message-ID: <7vvez7r0hf.fsf_-_@assigned-by-dhcp.cox.net>
References: <118833cc0511040721w7f3990fbw631feaa6a4bda936@mail.gmail.com>
	<7voe50wblp.fsf@assigned-by-dhcp.cox.net>
	<20051104182342.GA27711@old.davidb.org>
	<7vek5ww8q5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brown <git@davidb.org>, Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 08:58:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYIvZ-0004j5-GI
	for gcvg-git@gmane.org; Sat, 05 Nov 2005 08:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbVKEH5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 02:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbVKEH5K
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 02:57:10 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:49375 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751221AbVKEH5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2005 02:57:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051105075620.IYIR776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Nov 2005 02:56:20 -0500
To: git@vger.kernel.org
In-Reply-To: <7vek5ww8q5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 04 Nov 2005 10:47:46 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11175>

Junio C Hamano <junkio@cox.net> writes:

> David Brown <git@davidb.org> writes:
>
>> And the additional CFLAGS will only apply to the compilation of foo.
>> Since the ALL_CFLAGS is expanded lazily, it gets expanded for each target,
>> and the rule above causes CFLAGS to have extra values only on that target.
>
> Lazy expansion is true, but the reason we did ALL_CFLAGS was to
> make CFLAGS overridable from the command line.
>
> I suspect that this would currently fail to add -I/some/where/include
> on the compilation command line:
>
> 	make CFLAGS='-Os -g' CURLDIR=/some/where
>
> while CURL_LIBCURL is set correctly on the linkage command line.

So here is a proposed fix.  Likes, dislikes, "you are a idiot
and you do not understand make"s?

-jc

-- >8 -- cut here -- >8 --
I think the original intention was to make CFLAGS overridable
from the make command line, but somehow we ended up accumulating
conditional makefile sections that wrongly appends values to
CFLAGs.  These assignments do not work when the user actually
override them from the make command line!

DEFINES are handled the same way; it was seemingly overridable,
but the makefile sections had assignments, which meant
overriding it from the command line broke things.

This simplifies things by limiting the internal futzing to
ALL_CFLAGS, and by removing DEFINES altogether.  Overriding
CFLAGS from the command line should start working with this
change.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Makefile |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

applies-to: ef3876e50bb5e91a6fb40d4e59df2178c6f40237
3502cee71d7c0d1a0c9d792f9d185886e91d5d26
diff --git a/Makefile b/Makefile
index 6c01dc2..6064672 100644
--- a/Makefile
+++ b/Makefile
@@ -37,25 +37,21 @@
 # 1461501637330902918203684832716283019655932542976 hashes do not give you
 # sufficient guarantee that no collisions between objects will ever happen.
 
-# DEFINES += -DCOLLISION_CHECK
-
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
 # randomly break unless your underlying filesystem supports those sub-second
 # times (my ext3 doesn't).
 
-# DEFINES += -DUSE_NSEC
-
 # Define USE_STDEV below if you want git to care about the underlying device
 # change being considered an inode change from the update-cache perspective.
 
-# DEFINES += -DUSE_STDEV
-
 GIT_VERSION = 0.99.9.GIT
 
+# CFLAGS is for the users to override from the command line.
+
 CFLAGS = -g -O2 -Wall
-ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINES) $(DEFINES)
+ALL_CFLAGS = $(CFLAGS)
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
@@ -194,19 +190,19 @@ ifeq ($(uname_S),SunOS)
 	NO_STRCASESTR = YesPlease
 	INSTALL = ginstall
 	TAR = gtar
-	PLATFORM_DEFINES += -D__EXTENSIONS__
+	ALL_CFLAGS += -D__EXTENSIONS__
 endif
 ifeq ($(uname_O),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_IPV6 = YesPlease
 	X = .exe
-	PLATFORM_DEFINES += -DUSE_SYMLINK_HEAD=0
+	ALL_CFLAGS += -DUSE_SYMLINK_HEAD=0
 endif
 ifeq ($(uname_S),OpenBSD)
 	NO_STRCASESTR = YesPlease
 	NEEDS_LIBICONV = YesPlease
-	PLATFORM_DEFINES += -I/usr/local/include -L/usr/local/lib
+	ALL_CFLAGS += -I/usr/local/include -L/usr/local/lib
 endif
 ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
@@ -217,7 +213,7 @@ endif
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not want -R.
-		CFLAGS += -I$(CURLDIR)/include
+		ALL_CFLAGS += -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/lib -R$(CURLDIR)/lib -lcurl
 	else
 		CURL_LIBCURL = -lcurl
@@ -240,13 +236,13 @@ ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
 	ifdef OPENSSLDIR
 		# Again this may be problematic -- gcc does not always want -R.
-		CFLAGS += -I$(OPENSSLDIR)/include
+		ALL_CFLAGS += -I$(OPENSSLDIR)/include
 		OPENSSL_LINK = -L$(OPENSSLDIR)/lib -R$(OPENSSLDIR)/lib
 	else
 		OPENSSL_LINK =
 	endif
 else
-	DEFINES += -DNO_OPENSSL
+	ALL_CFLAGS += -DNO_OPENSSL
 	MOZILLA_SHA1 = 1
 	OPENSSL_LIBSSL =
 endif
@@ -258,7 +254,7 @@ endif
 ifdef NEEDS_LIBICONV
 	ifdef ICONVDIR
 		# Again this may be problematic -- gcc does not always want -R.
-		CFLAGS += -I$(ICONVDIR)/include
+		ALL_CFLAGS += -I$(ICONVDIR)/include
 		ICONV_LINK = -L$(ICONVDIR)/lib -R$(ICONVDIR)/lib
 	else
 		ICONV_LINK =
@@ -276,15 +272,15 @@ ifdef NEEDS_NSL
 	SIMPLE_LIB += -lnsl
 endif
 ifdef NO_STRCASESTR
-	DEFINES += -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1
+	ALL_CFLAGS += -Dstrcasestr=gitstrcasestr -DNO_STRCASESTR=1
 	LIB_OBJS += compat/strcasestr.o
 endif
 ifdef NO_MMAP
-	DEFINES += -Dmmap=gitfakemmap -Dmunmap=gitfakemunmap -DNO_MMAP
+	ALL_CFLAGS += -Dmmap=gitfakemmap -Dmunmap=gitfakemunmap -DNO_MMAP
 	LIB_OBJS += compat/mmap.o
 endif
 ifdef NO_IPV6
-	DEFINES += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
+	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
 endif
 
 ifdef PPC_SHA1
@@ -305,7 +301,7 @@ endif
 endif
 endif
 
-DEFINES += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER))
+ALL_CFLAGS += -DSHA1_HEADER=$(call shellquote,$(SHA1_HEADER))
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
---
0.99.9.GIT
