From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH, RFC] Fix build problems related to profile-directed optimization
Date: Thu,  2 Feb 2012 14:03:37 -0500
Message-ID: <1328209417-8206-1-git-send-email-tytso@mit.edu>
Cc: Theodore Ts'o <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 20:03:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt1wi-0000Oj-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 20:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533Ab2BBTDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 14:03:41 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:39280 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757083Ab2BBTDk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 14:03:40 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1Rt1wY-00012B-QT; Thu, 02 Feb 2012 19:03:38 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Rt1wX-0002Gq-Ct; Thu, 02 Feb 2012 14:03:37 -0500
X-Mailer: git-send-email 1.7.8.11.gefc1f.dirty
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189674>

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
PROFILE_GEN and PROFILE_USE and then using these to directly
manipulate CFLAGS and EXTLIBS.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andi Kleen <ak@linux.intel.com>
---
 INSTALL  |    4 ++--
 Makefile |   31 +++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/INSTALL b/INSTALL
index 6fa83fe..978ed09 100644
--- a/INSTALL
+++ b/INSTALL
@@ -28,8 +28,8 @@ set up install paths (via config.mak.autogen), so you can write instead
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with
 
-	$ make profile-all
-	# make prefix=... install
+	$ make prefix=... profile-all
+	# make prefix=... PROFILE_USE=t install
 
 This will run the complete test suite as training workload and then
 rebuild git with the generated profile feedback. This results in a git
diff --git a/Makefile b/Makefile
index c457c34..15d1df4 100644
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
+ifdef PROFILE_GEN
+	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
+	EXTLIBS += -lgcov
+	export CCACHE_DISABLE=t
+endif
+
+ifdef PROFILE_USE
+	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
+	export CCACHE_DISABLE=t
+endif
+
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
@@ -2701,14 +2719,11 @@ cover_db_html: cover_db
 #
 .PHONY: profile-all profile-clean
 
-PROFILE_GEN_CFLAGS := $(CFLAGS) -fprofile-generate -DNO_NORETURN=1
-PROFILE_USE_CFLAGS := $(CFLAGS) -fprofile-use -fprofile-correction -DNO_NORETURN=1
-
 profile-clean:
-	$(RM) $(addsuffix *.gcda,$(object_dirs))
-	$(RM) $(addsuffix *.gcno,$(object_dirs))
+	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
+	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
 profile-all: profile-clean
-	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" all
-	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test
-	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all
+	$(MAKE) PROFILE_GEN=t all
+	$(MAKE) PROFILE_GEN=t -j1 test
+	$(MAKE) PROFILE_USE=t all
-- 
1.7.8.11.gefc1f.dirty
