From: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
Subject: [PATCH] for-each-ref: Always check stat_tracking_info()'s return value.
Date: Fri,  2 Jan 2015 17:44:02 +0200
Message-ID: <1420213442-5310-1-git-send-email-raphael.kubo.da.costa@intel.com>
Cc: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 16:44:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y74OT-0004IX-7r
	for gcvg-git-2@plane.gmane.org; Fri, 02 Jan 2015 16:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbbABPnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2015 10:43:55 -0500
Received: from mga01.intel.com ([192.55.52.88]:14767 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752321AbbABPnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2015 10:43:53 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP; 02 Jan 2015 07:43:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="435883022"
Received: from mvtammin-mobl.ger.corp.intel.com (HELO rkubodac-mobl1.ger.corp.intel.com) ([10.252.20.213])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jan 2015 07:31:43 -0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261976>

The code handling %(upstream:track) and %(upstream:trackshort) assumed
it always had a valid branch that had been sanitized earlier in
populate_value(), and thus did not check the return value of the call to
stat_tracking_info().

While there is indeed some sanitization code that basically corresponds
to stat_tracking_info() returning 0 (no base branch set), the function
can also return -1 when the base branch did exist but has since then
been deleted.

In this case, num_ours and num_theirs had undefined values and a call to
`git for-each-ref --format="%(upstream:track)"` could print spurious
values such as

  [behind -111794512]
  [ahead 38881640, behind 5103867]

even for repositories with one single commit.

We now properly verify stat_tracking_info()'s return value and do not
print anything if it returns -1. This behavior also matches the
documentation ("has no effect if the ref does not have tracking
information associated with it").

Signed-off-by: Raphael Kubo da Costa <raphael.kubo.da.costa@intel.com>
---
 builtin/for-each-ref.c  | 11 +++++++++--
 t/t6300-for-each-ref.sh | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 603a90e..52e6323 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -717,7 +717,10 @@ static void populate_value(struct refinfo *ref)
 				 starts_with(name, "upstream")) {
 				char buf[40];
 
-				stat_tracking_info(branch, &num_ours, &num_theirs);
+				if (stat_tracking_info(branch, &num_ours,
+						       &num_theirs) != 1)
+					continue;
+
 				if (!num_ours && !num_theirs)
 					v->s = "";
 				else if (!num_ours) {
@@ -735,7 +738,11 @@ static void populate_value(struct refinfo *ref)
 			} else if (!strcmp(formatp, "trackshort") &&
 				   starts_with(name, "upstream")) {
 				assert(branch);
-				stat_tracking_info(branch, &num_ours, &num_theirs);
+
+				if (stat_tracking_info(branch, &num_ours,
+							&num_theirs) != 1)
+					continue;
+
 				if (!num_ours && !num_theirs)
 					v->s = "=";
 				else if (!num_ours)
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index bda354c..775c255 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -335,6 +335,21 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 '
 
 cat >expected <<EOF
+
+
+EOF
+
+test_expect_success 'Check that :track[short] works when upstream is gone' '
+	git branch --track to_delete master &&
+	git branch --track parent_gone to_delete &&
+	git branch -D to_delete &&
+	git for-each-ref --format="%(upstream:track)" refs/heads/parent_gone >actual &&
+	git for-each-ref --format="%(upstream:trackshort)" refs/heads/parent_gone >>actual &&
+	git branch -D parent_gone &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 $(git rev-parse --short HEAD)
 EOF
 
-- 
2.1.4
