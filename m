From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] Makefile: quiet shell commands when "make --silent"
Date: Sun, 9 Sep 2012 19:09:21 -0400
Message-ID: <20120909230921.GA23806@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 10 01:09:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAqdE-0005YJ-1j
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 01:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab2IIXJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 19:09:27 -0400
Received: from honk.padd.com ([74.3.171.149]:35056 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755566Ab2IIXJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 19:09:25 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 794712C1B;
	Sun,  9 Sep 2012 16:09:24 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0776232112; Sun,  9 Sep 2012 19:09:21 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205104>

Option "--silent", "--quiet" or "-s" to make prevents
echoing of commands as they are executed.  However, there
are some explicit "echo" commands in the Makefile and in
the two GIT-VERSION-GEN scripts that always echo.

Quiet the explicit "echo"s in Makefile when MAKEFLAG "s"
is set.  Pass this information into both GIT-VERSION-GEN
helpers so that they can run silently too.

Before:

    $ echo >>git.c
    $ make -s
    GIT_VERSION = 1.7.12.378.gaeb1945.dirty
	* new script parameters
    GITGUI_VERSION = 0.16.GITGUI-dirty
    $

After:

    $ echo >>git.c
    $ make -s
    $

Signed-off-by: Pete Wyckoff <pw@padd.com>
---

Make should be silent when given "--silent".

This may help tools that post-process make output, like the
"check-docs" command.  Peff noticed in 5fafce0 (check-docs: get
documented command list from Makefile, 2012-08-08) that:

> ... make will print extra cruft like
> "GIT-VERSION-FILE is up to date" to stdout.

They now can use "make -s" to avoid filtering out the cruft.

		-- Pete

 GIT-VERSION-GEN         | 11 ++++++++++-
 Makefile                | 13 ++++++++-----
 git-gui/GIT-VERSION-GEN | 11 ++++++++++-
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index d2d2d69..97f0825 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -6,6 +6,12 @@ DEF_VER=v1.7.12.GIT
 LF='
 '
 
+silent=
+if test "${1:-}" = "#"
+then
+	silent=1
+fi
+
 # First see if there is a version file (included in release tarballs),
 # then try git-describe, then default.
 if test -f version
@@ -35,7 +41,10 @@ else
 	VC=unset
 fi
 test "$VN" = "$VC" || {
-	echo >&2 "GIT_VERSION = $VN"
+	if test -z "$silent"
+	then
+		echo >&2 "GIT_VERSION = $VN"
+	fi
 	echo "GIT_VERSION = $VN" >$GVF
 }
 
diff --git a/Makefile b/Makefile
index 66e8216..dac5aab 100644
--- a/Makefile
+++ b/Makefile
@@ -305,7 +305,7 @@ all::
 # "git help" is called without a parameter specifying the format.
 
 GIT-VERSION-FILE: FORCE
-	@$(SHELL_PATH) ./GIT-VERSION-GEN
+	@$(SHELL_PATH) ./GIT-VERSION-GEN "$(SILENT_SH_ECHO)"
 -include GIT-VERSION-FILE
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
@@ -1850,6 +1850,9 @@ ifndef V
 	export QUIET_GEN
 	export QUIET_BUILT_IN
 endif
+else
+# in --silent mode, suppress echo command in shell commands
+SILENT_SH_ECHO = \#
 endif
 
 ifdef NO_INSTALL_HARDLINKS
@@ -2074,7 +2077,7 @@ endef
 GIT-SCRIPT-DEFINES: FORCE
 	@FLAGS='$(SCRIPT_DEFINES)'; \
 	    if test x"$$FLAGS" != x"`cat $@ 2>/dev/null`" ; then \
-		echo 1>&2 "    * new script parameters"; \
+		$(SILENT_SH_ECHO)echo 1>&2 "    * new script parameters"; \
 		echo "$$FLAGS" >$@; \
             fi
 
@@ -2451,7 +2454,7 @@ TRACK_PREFIX = $(bindir_SQ):$(gitexecdir_SQ):$(template_dir_SQ):$(prefix_SQ):\
 GIT-PREFIX: FORCE
 	@FLAGS='$(TRACK_PREFIX)'; \
 	if test x"$$FLAGS" != x"`cat GIT-PREFIX 2>/dev/null`" ; then \
-		echo 1>&2 "    * new prefix flags"; \
+		$(SILENT_SH_ECHO)echo 1>&2 "    * new prefix flags"; \
 		echo "$$FLAGS" >GIT-PREFIX; \
 	fi
 
@@ -2460,7 +2463,7 @@ TRACK_CFLAGS = $(CC):$(subst ','\'',$(ALL_CFLAGS)):$(USE_GETTEXT_SCHEME)
 GIT-CFLAGS: FORCE
 	@FLAGS='$(TRACK_CFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-CFLAGS 2>/dev/null`" ; then \
-		echo 1>&2 "    * new build flags"; \
+		$(SILENT_SH_ECHO)echo 1>&2 "    * new build flags"; \
 		echo "$$FLAGS" >GIT-CFLAGS; \
             fi
 
@@ -2469,7 +2472,7 @@ TRACK_LDFLAGS = $(subst ','\'',$(ALL_LDFLAGS))
 GIT-LDFLAGS: FORCE
 	@FLAGS='$(TRACK_LDFLAGS)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-LDFLAGS 2>/dev/null`" ; then \
-		echo 1>&2 "    * new link flags"; \
+		$(SILENT_SH_ECHO)echo 1>&2 "    * new link flags"; \
 		echo "$$FLAGS" >GIT-LDFLAGS; \
             fi
 
diff --git a/git-gui/GIT-VERSION-GEN b/git-gui/GIT-VERSION-GEN
index 6570943..ba17163 100755
--- a/git-gui/GIT-VERSION-GEN
+++ b/git-gui/GIT-VERSION-GEN
@@ -6,6 +6,12 @@ DEF_VER=0.16.GITGUI
 LF='
 '
 
+silent=
+if test "${1:-}" = "#"
+then
+	silent=1
+fi
+
 tree_search ()
 {
 	head=$1
@@ -75,6 +81,9 @@ else
 	VC=unset
 fi
 test "$VN" = "$VC" || {
-	echo >&2 "GITGUI_VERSION = $VN"
+	if test -z "$silent"
+	then
+		echo >&2 "GITGUI_VERSION = $VN"
+	fi
 	echo "GITGUI_VERSION = $VN" >$GVF
 }
-- 
1.7.12.378.gaeb1945.dirty
