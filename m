From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/2] Add profile feedback build to git
Date: Wed,  8 Jun 2011 14:43:37 -0700
Message-ID: <1307569417-8924-2-git-send-email-andi@firstfloor.org>
References: <1307569417-8924-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 23:44:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUQYa-0003rM-BT
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 23:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301Ab1FHVox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 17:44:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:43517 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417Ab1FHVov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 17:44:51 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 08 Jun 2011 14:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,340,1304319600"; 
   d="scan'208";a="10910073"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by orsmga002.jf.intel.com with ESMTP; 08 Jun 2011 14:44:49 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 937FD242B3D; Wed,  8 Jun 2011 14:43:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1307569417-8924-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175461>

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

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index e40ac0c..85e2679 100644
--- a/Makefile
+++ b/Makefile
@@ -2486,3 +2486,20 @@ cover_db: coverage-report
 
 cover_db_html: cover_db
 	cover -report html -outputdir cover_db_html cover_db
+
+### profile feedback build
+#
+.PHONY: profile-all profile-clean
+
+PROFILE_GEN_CFLAGS := $(CFLAGS) -fprofile-generate
+PROFILE_USE_CFLAGS := $(CFLAGS) -fprofile-use -fprofile-correction
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
