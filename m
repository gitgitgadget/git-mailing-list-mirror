From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] Fix build problems related to profile-directed optimization
Date: Mon,  6 Feb 2012 01:00:17 -0500
Message-ID: <1328508017-7277-1-git-send-email-tytso@mit.edu>
References: <20120206055750.GA6615@thunk.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 07:00:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuHct-0007tz-G2
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab2BFGAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:00:23 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:36492 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753717Ab2BFGAW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:00:22 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RuHci-0006Sp-6Z; Mon, 06 Feb 2012 06:00:21 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RuHcf-0001u2-C5; Mon, 06 Feb 2012 01:00:17 -0500
X-Mailer: git-send-email 1.7.9.107.g8e04a
In-Reply-To: <20120206055750.GA6615@thunk.org>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190025>

There was a number of problems I ran into when trying the
profile-directed optimizations added by Andi Kleen in git commit
7ddc2710b9.  (This was using gcc 4.4 found on many enterprise
distros.)

1) The -fprofile-generate and -fprofile-use commands are incompatible
with ccache; the code ends up looking in the wrong place for the gcda
files based on the ccache object names.

2) If the makefile notices that CFLAGS are different, it will rebuild
all of the binaries.  Hence the recipe originally specified by the
INSTALL file ("make profile-all" followed by "make install") doesn't
work.  It will appear to work, but the binaries will end up getting
built with no optimization.

This patch fixes this by using an explicit set of options passed via
the PROFILE variable then using this to directly manipulate CFLAGS and
EXTLIBS.

The developer can run "make PROFILE=BUILD all ; sudo make
PROFILE=BUILD install" automatically run a two-pass build with the
test suite run in between as the sample workload for the purpose of
recording profiling information to do the profile-directed
optimization.

Alternatively, the profiling version of binaries can be built using:

	make PROFILE=GEN PROFILE_DIR=/var/cache/profile all
	make PROFILE=GEN install

and then after git has been used for a while, the optimized version of
the binary can be built as follows:

	make PROFILE=USE PROFILE_DIR=/var/cache/profile all
	make PROFILE=USE install

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andi Kleen <ak@linux.intel.com>
---
 INSTALL  |   17 +++++++++++++----
 Makefile |   53 +++++++++++++++++++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/INSTALL b/INSTALL
index 6fa83fe..58b2b86 100644
--- a/INSTALL
+++ b/INSTALL
@@ -28,16 +28,25 @@ set up install paths (via config.mak.autogen), so you can write instead
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with
 
-	$ make profile-all
-	# make prefix=... install
+	$ make prefix=/usr PROFILE=BUILD all
+	# make prefix=/usr PROFILE=BUILD install
 
 This will run the complete test suite as training workload and then
 rebuild git with the generated profile feedback. This results in a git
 which is a few percent faster on CPU intensive workloads.  This
 may be a good tradeoff for distribution packagers.
 
-Note that the profile feedback build stage currently generates
-a lot of additional compiler warnings.
+Or if you just want to install a profile-optimized version of git into
+your home directory, you could run:
+
+	$ make PROFILE=BUILD install
+
+As a caveat: a profile-optimized build takes a *lot* longer since the
+git tree must be built twice, and in order for the profiling
+measurements to work properly, ccache must be disabled and the test
+suite has to be run using only a single CPU.  In addition, the profile
+feedback build stage currently generates a lot of additional compiler
+warnings.
 
 Issues of note:
 
diff --git a/Makefile b/Makefile
index c457c34..719ffca 100644
--- a/Makefile
+++ b/Makefile
@@ -1772,6 +1772,24 @@ ifdef ASCIIDOC7
 	export ASCIIDOC7
 endif
 
+### profile feedback build
+#
+
+# Can adjust this to be a global directory if you want to do extended
+# data gathering
+PROFILE_DIR := $(CURDIR)
+
+ifeq "$(PROFILE)" "GEN"
+	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
+	EXTLIBS += -lgcov
+	export CCACHE_DISABLE=t
+	V=1
+else ifneq "$(PROFILE)" ""
+	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
+	export CCACHE_DISABLE=t
+	V=1
+endif
+
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
@@ -1828,7 +1846,17 @@ export DIFF TAR INSTALL DESTDIR SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
-all:: shell_compatibility_test $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: shell_compatibility_test
+
+ifeq "$(PROFILE)" "BUILD"
+ifeq ($(filter all,$(MAKECMDGOALS)),all)
+all:: profile-clean
+	$(MAKE) PROFILE=GEN all
+	$(MAKE) PROFILE=GEN -j1 test
+endif
+endif
+
+all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
@@ -2557,7 +2585,11 @@ distclean: clean
 	$(RM) configure
 	$(RM) po/git.pot
 
-clean:
+profile-clean:
+	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
+	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
+
+clean: profile-clean
 	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o vcs-svn/*.o \
 		builtin/*.o $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
@@ -2587,7 +2619,7 @@ ifndef NO_TCLTK
 endif
 	$(RM) GIT-VERSION-FILE GIT-CFLAGS GIT-LDFLAGS GIT-GUI-VARS GIT-BUILD-OPTIONS
 
-.PHONY: all install clean strip
+.PHONY: all install profile-clean clean strip
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
 .PHONY: FORCE cscope
 
@@ -2697,18 +2729,3 @@ cover_db: coverage-report
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
 
-### profile feedback build
-#
-.PHONY: profile-all profile-clean
-
-PROFILE_GEN_CFLAGS := $(CFLAGS) -fprofile-generate -DNO_NORETURN=1
-PROFILE_USE_CFLAGS := $(CFLAGS) -fprofile-use -fprofile-correction -DNO_NORETURN=1
-
-profile-clean:
-	$(RM) $(addsuffix *.gcda,$(object_dirs))
-	$(RM) $(addsuffix *.gcno,$(object_dirs))
-
-profile-all: profile-clean
-	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" all
-	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test
-	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all
-- 
1.7.9.107.g8e04a
