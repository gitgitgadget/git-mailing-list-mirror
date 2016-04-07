From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH] format-patch: allow --no-patch to disable patch output
Date: Thu,  7 Apr 2016 09:46:39 -0700
Message-ID: <1460047599-9267-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 07 18:46:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoD52-0002Ng-7s
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 18:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbcDGQqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 12:46:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:42408 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755546AbcDGQqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 12:46:47 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 07 Apr 2016 09:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,449,1455004800"; 
   d="scan'208";a="950269494"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.173])
  by orsmga002.jf.intel.com with ESMTP; 07 Apr 2016 09:46:40 -0700
X-Mailer: git-send-email 2.8.1.102.ga49ec4a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290925>

The documentation for format-patch indicates that --no-patch wilL
suppress patch output. It also incorrectly mentions that -s will also
suppress the patch output, but this is incorrect because -s is used to
add the sign-off line first. Fix the documentation to remove the
indication about -s. Fix builtin format-patch to prevent always adding
the patch incase --no-patch is given. An alternative approach would be
to remove --no-patch from the documentation for git-format-patch, and
add an error check to indicate that --no-patch is not supported.

Add a test for --no-patch to ensure it functions as expected.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 Documentation/diff-options.txt |  2 ++
 builtin/log.c                  |  4 ++--
 t/t4014-format-patch.sh        | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4b0318e2ac15..471ee47d0b07 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -27,7 +27,9 @@ ifdef::git-diff[]
 	This is the default.
 endif::git-diff[]
 
+ifndef::git-format-patch[]
 -s::
+endif::git-format-patch[]
 --no-patch::
 	Suppress diff output. Useful for commands like `git show` that
 	show the patch by default, or to cancel the effect of `--patch`.
diff --git a/builtin/log.c b/builtin/log.c
index dff3fbbb437c..10f74837945b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1390,8 +1390,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 rev.diffopt.output_format == DIFF_FORMAT_PATCH))
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY;
 
-	/* Always generate a patch */
-	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
+	if (!(rev.diffopt.output_format & DIFF_FORMAT_NO_OUTPUT))
+		rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 
 	rev.zero_commit = zero_commit;
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index eed2981b96df..ef9cfca30a9e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -618,6 +618,32 @@ test_expect_success 'format-patch -p suppresses stat' '
 
 '
 
+cat >expect << EOF
+From 422768ba4254e7abbeb467b6fe254472207e3d1f Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Thu, 7 Apr 2005 15:20:13 -0700
+Subject: [PATCH 1/2] This is an excessively long subject line for a message
+ due to the habit some projects have of not having a short, one-line subject
+ at the start of the commit message, but rather sticking a whole paragraph
+ right at the start as the only thing in the commit message. It had better not
+ become the filename for the patch.
+Header1: B E Cipient <rcipient@example.com>
+To: Someone <someone@out.there>
+Cc: C E Cipient <rcipient@example.com>
+
+-- 
+2.8.1.102.ga49ec4a.dirty
+
+EOF
+
+test_expect_success 'format-patch --no-patch suppresses patch' '
+
+	git format-patch --no-patch -2 &&
+	cat 0001-This-is-an-excessively-long-subject-line-for-a-messa.patch > output &&
+	test_cmp expect output
+
+'
+
 test_expect_success 'format-patch from a subdirectory (1)' '
 	filename=$(
 		rm -rf sub &&
-- 
2.8.1.102.ga49ec4a
