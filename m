From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/6] git-p4: fix test for unsupported P4 Client Views
Date: Mon,  2 Jan 2012 18:05:50 -0500
Message-ID: <1325545554-16540-3-git-send-email-pw@padd.com>
References: <1325545554-16540-1-git-send-email-pw@padd.com>
Cc: Gary Gibbons <ggibbons@perforce.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 03 00:06:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhqxm-0006Rp-NX
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 00:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab2ABXGj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jan 2012 18:06:39 -0500
Received: from honk.padd.com ([74.3.171.149]:43658 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335Ab2ABXGi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2012 18:06:38 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id CE0F21C7E;
	Mon,  2 Jan 2012 15:06:37 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5B1A8667D7; Mon,  2 Jan 2012 18:06:34 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.409.g3e338
In-Reply-To: <1325545554-16540-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187845>

From: Gary Gibbons <ggibbons@perforce.com>

Change re method in test for unsupported Client View types
(containing %% or *) anywhere in the string rather than
at the begining.

[pw: two tests now succeed]

Signed-off-by: Gary Gibbons <ggibbons@perforce.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4    |    5 ++++-
 t/t9809-git-p4-client-view.sh |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d3c3ad8..c144c89 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1889,9 +1889,12 @@ class P4Sync(Command, P4UserMap):
 
                     # p4 has these %%1 to %%9 arguments in specs to
                     # reorder paths; which we can't handle (yet :)
-                    if re.match('%%\d', v) != None:
+                    if re.search('%%\d', v) != None:
                         print "Sorry, can't handle %%n arguments in client specs"
                         sys.exit(1)
+                    if re.search('\*', v) != None:
+                        print "Sorry, can't handle * mappings in client specs"
+                        sys.exit(1)
 
                     if v.startswith('"'):
                         start = 1
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index 4259fb3..cbf2213 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -89,13 +89,13 @@ test_expect_success 'init depot' '
 '
 
 # double % for printf
-test_expect_failure 'unsupported view wildcard %%n' '
+test_expect_success 'unsupported view wildcard %%n' '
 	client_view "//depot/%%%%1/sub/... //client/sub/%%%%1/..." &&
 	test_when_finished cleanup_git &&
 	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
 '
 
-test_expect_failure 'unsupported view wildcard *' '
+test_expect_success 'unsupported view wildcard *' '
 	client_view "//depot/*/bar/... //client/*/bar/..." &&
 	test_when_finished cleanup_git &&
 	test_must_fail "$GITP4" clone --use-client-spec --dest="$git" //depot
-- 
1.7.8.1.407.gd70cb
