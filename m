From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 3/3] Add profile feedback build to git v2
Date: Sat, 18 Jun 2011 18:07:05 -0700
Message-ID: <1308445625-30667-3-git-send-email-andi@firstfloor.org>
References: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 03:08:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY6VG-0003Wp-5e
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 03:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711Ab1FSBIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 21:08:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:49219 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222Ab1FSBId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 21:08:33 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 18 Jun 2011 18:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,387,1304319600"; 
   d="scan'208";a="19934778"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2011 18:08:32 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 30BA4241C48; Sat, 18 Jun 2011 18:07:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175996>

From: Andi Kleen <ak@linux.intel.com>

Add a gcc profile feedback build option "profile-all" to the
main Makefile. It simply runs the test suite to generate feedback
data and the recompiles the main executables with that. The basic
structure is similar to the existing gcov code.

gcc is often able to generate better code with profile feedback
data. The training load also doesn't need to be too similar
to the actual load, it still gives benefits.

The test suite run is unfortunately quite long. It would
be good to find a suitable subset that runs faster and still
gives reasonable feedback.

For now the test suite runs single threaded (I had some
trouble running the test suite with -jX)

I tested it with git gc and git blame kernel/sched.c on a Linux
kernel tree. For gc I get about 2.7% improvement in wall clock
time by using the feedback build, for blame about 2.4%.
That's not gigantic, but not shabby either for a very small patch.

If anyone has any favourite CPU intensive git benchmarks feel
free to try them too.

I hope distributors will switch to use a feedback build in their
packages.

v2: Set NO_NORETURN variable in build
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 03b4499..d00718f 100644
--- a/Makefile
+++ b/Makefile
@@ -2492,3 +2492,20 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+### profile feedback build
+#
+.PHONY: profile-all profile-clean
+
+PROFILE_GEN_CFLAGS := $(CFLAGS) -fprofile-generate -DNO_NORETURN=1
+PROFILE_USE_CFLAGS := $(CFLAGS) -fprofile-use -fprofile-correction -DNO_NORETURN=1
+
+profile-clean:
+	$(RM) $(addsuffix *.gcda,$(object_dirs))
+	$(RM) $(addsuffix *.gcno,$(object_dirs))
+
+profile-all: profile-clean
+	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" all
+	$(MAKE) CFLAGS="$(PROFILE_GEN_CFLAGS)" -j1 test
+	$(MAKE) CFLAGS="$(PROFILE_USE_CFLAGS)" all
+	
-- 
1.7.4.4
