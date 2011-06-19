From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 1/3] Add option to disable NORETURN
Date: Sat, 18 Jun 2011 18:07:03 -0700
Message-ID: <1308445625-30667-1-git-send-email-andi@firstfloor.org>
Cc: Junio C Hamano <gitster@pobox.com>, Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 19 03:08:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY6VF-0003Wp-LZ
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 03:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab1FSBIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 21:08:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:52176 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab1FSBId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 21:08:33 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 18 Jun 2011 18:08:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,387,1304319600"; 
   d="scan'208";a="17899094"
Received: from tassilo.jf.intel.com ([10.7.201.108])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2011 18:08:32 -0700
Received: by tassilo.jf.intel.com (Postfix, from userid 501)
	id 2A246241C46; Sat, 18 Jun 2011 18:07:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175995>

From: Junio C Hamano <gitster@pobox.com>

Due to a bug in gcc 4.6+ it can crash when doing profile feedback
with a noreturn function pointer

(http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)

This adds a Makefile variable to disable noreturns.

[Patch by Junio, description by Andi Kleen]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile          |    6 ++++++
 git-compat-util.h |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index e40ac0c..03b4499 100644
--- a/Makefile
+++ b/Makefile
@@ -153,6 +153,9 @@ all::
 # that tells runtime paths to dynamic libraries;
 # "-Wl,-rpath=/path/lib" is used instead.
 #
+# Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
+# as the compiler can crash (http://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
+#
 # Define USE_NSEC below if you want git to care about sub-second file mtimes
 # and ctimes. Note that you need recent glibc (at least 2.2.4) for this, and
 # it will BREAK YOUR LOCAL DIFFS! show-diff and anything using it will likely
@@ -1374,6 +1377,9 @@ endif
 ifdef USE_ST_TIMESPEC
 	BASIC_CFLAGS += -DUSE_ST_TIMESPEC
 endif
+ifdef NO_NORETURN
+	BASIC_CFLAGS += -DNO_NORETURN
+endif
 ifdef NO_NSEC
 	BASIC_CFLAGS += -DNO_NSEC
 endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e0bb81e..9925cf0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -218,7 +218,7 @@ extern char *gitbasename(char *);
 #if __HP_cc >= 61000
 #define NORETURN __attribute__((noreturn))
 #define NORETURN_PTR
-#elif defined(__GNUC__)
+#elif defined(__GNUC__) && !defined(NO_NORETURN)
 #define NORETURN __attribute__((__noreturn__))
 #define NORETURN_PTR __attribute__((__noreturn__))
 #elif defined(_MSC_VER)
-- 
1.7.4.4
