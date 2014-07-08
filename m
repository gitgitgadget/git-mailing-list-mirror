From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 4/4] Fix profile feedback with -jN and add profile-fast
Date: Mon,  7 Jul 2014 23:35:11 -0700
Message-ID: <1404801311-15365-5-git-send-email-andi@firstfloor.org>
References: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 08:35:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4P0G-0005EQ-98
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 08:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbaGHGfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 02:35:43 -0400
Received: from one.firstfloor.org ([193.170.194.197]:33417 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbaGHGfb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 02:35:31 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 902E68677D;
	Tue,  8 Jul 2014 08:35:28 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 6FDCFA207C; Mon,  7 Jul 2014 23:35:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253008>

From: Andi Kleen <ak@linux.intel.com>

Profile feedback always failed for me with -jN. The problem
was that there was no implicit ordering between the profile generate
stage and the profile use stage. So some objects in the later stage
would be linked with profile generate objects, and fail due
to the missing -lgcov.

This adds a new profile target that implicitely enforces the
correct ordering by using submakes. Plus a profile-install target
to also install. This is also nicer to type that PROFILE=...

Plus I always run the performance test suite now for the full
profile run.

In addition I also added a profile-fast / profile-fast-install
target the only runs the performance test suite instead of the
whole test suite. This significantly speeds up the profile build,
which was totally dominated by test suite run time. However
it may have less coverage of course.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 INSTALL  | 14 ++++++++++++--
 Makefile | 21 +++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/INSTALL b/INSTALL
index ba01e74..6ec7a24 100644
--- a/INSTALL
+++ b/INSTALL
@@ -28,7 +28,7 @@ set up install paths (via config.mak.autogen), so you can write instead
 If you're willing to trade off (much) longer build time for a later
 faster git you can also do a profile feedback build with
 
-	$ make prefix=/usr PROFILE=BUILD all
+	$ make prefix=/usr profile
 	# make prefix=/usr PROFILE=BUILD install
 
 This will run the complete test suite as training workload and then
@@ -36,10 +36,20 @@ rebuild git with the generated profile feedback. This results in a git
 which is a few percent faster on CPU intensive workloads.  This
 may be a good tradeoff for distribution packagers.
 
+Alternatively you can run profile feedback only with the git benchmark
+suite. This runs significantly faster than the full test suite, but
+has less coverage:
+
+	$ make prefix=/usr profile-fast
+	# make prefix=/usr PROFILE=BUILD install
+
 Or if you just want to install a profile-optimized version of git into
 your home directory, you could run:
 
-	$ make PROFILE=BUILD install
+	$ make profile-install
+
+or
+	$ make profile-fast-install
 
 As a caveat: a profile-optimized build takes a *lot* longer since the
 git tree must be built twice, and in order for the profiling
diff --git a/Makefile b/Makefile
index ba64be9..a760402 100644
--- a/Makefile
+++ b/Makefile
@@ -1643,13 +1643,20 @@ SHELL = $(SHELL_PATH)
 all:: shell_compatibility_test
 
 ifeq "$(PROFILE)" "BUILD"
-ifeq ($(filter all,$(MAKECMDGOALS)),all)
-all:: profile-clean
+all:: profile
+endif
+
+profile:: profile-clean
 	$(MAKE) PROFILE=GEN all
 	$(MAKE) PROFILE=GEN -j1 test
 	$(MAKE) PROFILE=GEN -j1 perf
-endif
-endif
+	$(MAKE) PROFILE=USE all
+
+profile-fast: profile-clean
+	$(MAKE) PROFILE=GEN all
+	$(MAKE) PROFILE=GEN -j1 perf
+	$(MAKE) PROFILE=USE all
+
 
 all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
@@ -2336,6 +2343,12 @@ mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
 install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
 
+profile-install: profile
+	$(MAKE) install
+
+profile-fast-install: profile-fast
+	$(MAKE) install
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-- 
2.0.1
