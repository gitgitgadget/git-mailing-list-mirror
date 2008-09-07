From: arjen@yaph.org (Arjen Laarhoven)
Subject: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Sun, 7 Sep 2008 20:45:37 +0200
Message-ID: <20080907184537.GA4148@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 07 21:19:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcPmt-0005e0-2t
	for gcvg-git-2@gmane.org; Sun, 07 Sep 2008 21:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbYIGTRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2008 15:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754892AbYIGTRi
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Sep 2008 15:17:38 -0400
Received: from regex.yaph.org ([193.202.115.201]:36520 "EHLO regex.yaph.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754268AbYIGTRh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2008 15:17:37 -0400
X-Greylist: delayed 1950 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Sep 2008 15:17:37 EDT
Received: by regex.yaph.org (Postfix, from userid 1000)
	id 8A29F5B7D3; Sun,  7 Sep 2008 20:45:37 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95164>

The standard libc regex library on OSX does not support alternation
in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
functionality on OSX.

To fix this, we use the GNU regex library which is already present in
the compat/ diretory for the MinGW port.  However, simply adding compat/
to the COMPAT_CFLAGS variable causes a conflict between the system
fnmatch.h and the one present in compat/.  To remedy this, move the
regex and fnmatch functionality to their own subdirectories in compat/
so they can be included seperately.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
This patch is based on 'maint'.  It needs testing on MinGW (although
the change is trivial).

Also, I'm sure the problem occurs on more non-Linux systems (or non
GNU libc systems).  If people who have access to those systems (BSD's,
HP-UX, AIX, etc) can test it, I'd be happy to add those systems to the
patch so it can fix for multiple systems at once.

 Makefile                       |    6 ++++--
 compat/{ => fnmatch}/fnmatch.c |    0
 compat/{ => fnmatch}/fnmatch.h |    0
 compat/{ => regex}/regex.c     |    0
 compat/{ => regex}/regex.h     |    0
 t/t4018-diff-funcname.sh       |    6 ++++++
 6 files changed, 10 insertions(+), 2 deletions(-)
 rename compat/{ => fnmatch}/fnmatch.c (100%)
 rename compat/{ => fnmatch}/fnmatch.h (100%)
 rename compat/{ => regex}/regex.c (100%)
 rename compat/{ => regex}/regex.h (100%)

diff --git a/Makefile b/Makefile
index 672ea74..a8b3f9e 100644
--- a/Makefile
+++ b/Makefile
@@ -626,6 +626,8 @@ ifeq ($(uname_S),Darwin)
 	endif
 	NO_STRLCPY = YesPlease
 	NO_MEMMEM = YesPlease
+	COMPAT_CFLAGS += -Icompat/regex
+	COMPAT_OBJS += compat/regex/regex.o
 endif
 ifeq ($(uname_S),SunOS)
 	NEEDS_SOCKET = YesPlease
@@ -750,10 +752,10 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_SVN_TESTS = YesPlease
 	NO_PERL_MAKEMAKER = YesPlease
 	NO_POSIX_ONLY_PROGRAMS = YesPlease
-	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat
+	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
-	COMPAT_OBJS += compat/mingw.o compat/fnmatch.o compat/regex.o compat/winansi.o
+	COMPAT_OBJS += compat/mingw.o compat/fnmatch/fnmatch.o compat/regex/regex.o compat/winansi.o
 	EXTLIBS += -lws2_32
 	X = .exe
 	gitexecdir = ../libexec/git-core
diff --git a/compat/fnmatch.c b/compat/fnmatch/fnmatch.c
similarity index 100%
rename from compat/fnmatch.c
rename to compat/fnmatch/fnmatch.c
diff --git a/compat/fnmatch.h b/compat/fnmatch/fnmatch.h
similarity index 100%
rename from compat/fnmatch.h
rename to compat/fnmatch/fnmatch.h
diff --git a/compat/regex.c b/compat/regex/regex.c
similarity index 100%
rename from compat/regex.c
rename to compat/regex/regex.c
diff --git a/compat/regex.h b/compat/regex/regex.h
similarity index 100%
rename from compat/regex.h
rename to compat/regex/regex.h
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 833d6cb..18bcd97 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -57,4 +57,10 @@ test_expect_success 'last regexp must not be negated' '
 	test_must_fail git diff --no-index Beer.java Beer-correct.java
 '
 
+test_expect_success 'alternation in pattern' '
+	git config diff.java.funcname "^[ 	]*\\(\\(public\\|static\\).*\\)$"
+	git diff --no-index Beer.java Beer-correct.java |
+	grep "^@@.*@@ public static void main("
+'
+
 test_done
-- 
1.6.0.1.337.g5c7d67
