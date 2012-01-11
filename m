From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/5] git-p4: only a single ... wildcard is supported
Date: Wed, 11 Jan 2012 18:31:06 -0500
Message-ID: <1326324670-15967-2-git-send-email-pw@padd.com>
References: <1326324670-15967-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 00:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7ds-00062U-1A
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406Ab2AKXbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 18:31:36 -0500
Received: from honk.padd.com ([74.3.171.149]:34115 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2AKXbf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 18:31:35 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 1249D33A3;
	Wed, 11 Jan 2012 15:31:35 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 1766D31442; Wed, 11 Jan 2012 18:31:31 -0500 (EST)
X-Mailer: git-send-email 1.7.9.rc0.47.gc9457
In-Reply-To: <1326324670-15967-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188399>

Catch the case where a ... exists at the end, and also elsehwere.

Reported-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4    |    4 ++--
 t/t9809-git-p4-client-view.sh |    8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3e1aa27..20208bf 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1207,8 +1207,8 @@ class View(object):
                 die("Can't handle * wildcards in view: %s" % self.path)
             triple_dot_index = self.path.find("...")
             if triple_dot_index >= 0:
-                if not self.path.endswith("..."):
-                    die("Can handle ... wildcard only at end of path: %s" %
+                if triple_dot_index != len(self.path) - 3:
+                    die("Can handle only single ... wildcard, at end: %s" %
                         self.path)
                 self.ends_triple_dot = True
 
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index c9471d5..54204af 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -101,12 +101,18 @@ test_expect_success 'unsupported view wildcard *' '
 	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
 '
 
-test_expect_success 'wildcard ... only supported at end of spec' '
+test_expect_success 'wildcard ... only supported at end of spec 1' '
 	client_view "//depot/.../file11 //client/.../file11" &&
 	test_when_finished cleanup_git &&
 	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
 '
 
+test_expect_success 'wildcard ... only supported at end of spec 2' '
+	client_view "//depot/.../a/... //client/.../a/..." &&
+	test_when_finished cleanup_git &&
+	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
+'
+
 test_expect_success 'basic map' '
 	client_view "//depot/dir1/... //client/cli1/..." &&
 	files="cli1/file11 cli1/file12" &&
-- 
1.7.8.1.409.g3e338.dirty
