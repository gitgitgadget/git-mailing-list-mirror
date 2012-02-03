From: Ted Ts'o <tytso@mit.edu>
Subject: Re: [PATCH, RFC] Fix build problems related to profile-directed
 optimization
Date: Thu, 2 Feb 2012 21:07:43 -0500
Message-ID: <20120203020743.GE1032@thunk.org>
References: <1328209417-8206-1-git-send-email-tytso@mit.edu>
 <7vvcnpuhpo.fsf@alter.siamese.dyndns.org>
 <20120202201226.GA1032@thunk.org>
 <7vvcnou40u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 03:07:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt8Z7-0002DJ-LE
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 03:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab2BCCHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 21:07:48 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:52724 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973Ab2BCCHr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 21:07:47 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1Rt8Yy-0001Vl-U1; Fri, 03 Feb 2012 02:07:45 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1Rt8Yx-0004Kf-Lo; Thu, 02 Feb 2012 21:07:43 -0500
Content-Disposition: inline
In-Reply-To: <7vvcnou40u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189734>

What do you think of this?  I'm still running a test build --- "make
PROFILE=BUILD all" takes quite a long time, so this is still an RFC; I
figure there will still be some places where people will point out
more nits to be polished.  :-)

(In particular, I just noticed I left the V=1 for debugging purposes
in this version....)

	      	   	       	      - Ted

>From 4bf14e732216fd1327da2e3c8c6dfc0a3f689e1b Mon Sep 17 00:00:00 2001
From: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 2 Feb 2012 13:56:22 -0500
Subject: [PATCH] Fix build problems related to profile-directed optimization

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

The developer can run "make PROFILE=BUILD all ; make PROFILE=BUILD
install" to do an automatic two-pass build using the test suite as the
sample workload for the purpose of profiling.

Alternatively, the profiling version of binaries can be built using:

	make PROFILE=GEN PROFILE_DIR=/var/cache/profile all
	make PROFILE=GEN install

and then after git has been used a number of times, the optimized
version of the binary can be built as follows:

	make PROFILE=USE PROFILE_DIR=/var/cache/profile all
	make PROFILE=USE install

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andi Kleen <ak@linux.intel.com>
---
 INSTALL  |    4 ++--
 Makefile |   41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/INSTALL b/INSTALL
index 6fa83fe..73b654b 100644
--- a/INSTALL
+++ b/INSTALL
@@ -28,8 +28,8 @@ set up install paths (via config.mak.autogen), so you can write instead
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with
 
-	$ make profile-all
-	# make prefix=... install
+	$ make --prefix=/usr PROFILE=BUILD all
+	# make --prefix=/usr PROFILE=BUILD install
 
 This will run the complete test suite as training workload and then
 rebuild git with the generated profile feedback. This results in a git
diff --git a/Makefile b/Makefile
index c457c34..7d66d5c 100644
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
+else ifneq "$PROFILE" ""
+	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
+	export CCACHE_DISABLE=t
+	V=1
+endif
+
 # Shell quote (do not use $(call) to accommodate ancient setups);
 
 SHA1_HEADER_SQ = $(subst ','\'',$(SHA1_HEADER))
@@ -1828,7 +1846,15 @@ export DIFF TAR INSTALL DESTDIR SHELL_PATH
 
 SHELL = $(SHELL_PATH)
 
-all:: shell_compatibility_test $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: shell_compatibility_test
+
+ifeq "$(PROFILE)" "BUILD"
+all:: profile-clean
+	$(MAKE) PROFILE=GEN all
+	$(MAKE) PROFILE=GEN -j1 test
+endif
+
+all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
@@ -2699,16 +2725,9 @@ cover_db_html: cover_db
 
 ### profile feedback build
 #
-.PHONY: profile-all profile-clean
-
-PROFILE_GEN_CFLAGS := $(CFLAGS) -fprofile-generate -DNO_NORETURN=1
-PROFILE_USE_CFLAGS := $(CFLAGS) -fprofile-use -fprofile-correction -DNO_NORETURN=1
+.PHONY: profile-clean
 
 profile-clean:
-	$(RM) $(addsuffix *.gcda,$(object_dirs))
-	$(RM) $(addsuffix *.gcno,$(object_dirs))
+	$(RM) $(addsuffix *.gcda,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
+	$(RM) $(addsuffix *.gcno,$(addprefix $(PROFILE_DIR)/, $(object_dirs)))
 
-profile-all: profile-clean
-	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" all
-	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test
-	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all
-- 
1.7.8.11.gefc1f.dirty
