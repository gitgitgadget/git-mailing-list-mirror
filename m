From: Phil Hord <hordp@cisco.com>
Subject: [PATCH v3 1/2] test: git-stash conflict sets up rerere
Date: Tue, 10 Jul 2012 18:52:27 -0400
Message-ID: <1341960748-26949-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 00:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SojIl-0008FV-TT
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 00:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639Ab2GJWwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 18:52:38 -0400
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:46939 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab2GJWwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 18:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2644; q=dns/txt;
  s=iport; t=1341960757; x=1343170357;
  h=from:to:cc:subject:date:message-id;
  bh=D3htmaRGYlyDCAFjgeZZ9arm8fj65FBK8P9YsnvvGFI=;
  b=WlQb7ufx30OfZONLjTl1IkMW7VhApAwhTA7iyAn+0sYbGdCuWzuANNKN
   a32rnvQ/mwRxO7omVmIu6bHvlCgU3FNtTiY833LgU+Sspih4mkxuqrzWV
   HQq3bqbibA9DzFq4YRt+qYhKi7AwTolppZl+heXp6e1qia53jZvea4bXR
   M=;
X-IronPort-AV: E=Sophos;i="4.77,561,1336348800"; 
   d="scan'208";a="100606935"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-7.cisco.com with ESMTP; 10 Jul 2012 22:52:37 +0000
Received: from iptv-lnx-hordp.cisco.com (dhcp-64-100-104-93.cisco.com [64.100.104.93])
	by rcdn-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id q6AMqamY018722;
	Tue, 10 Jul 2012 22:52:36 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201282>

Add a failing test to confirm a conflicted stash apply
invokes rerere to record the conflicts and resolve the
the files it can.

mergetool may be confused by a left-over
state from previous rerere activity causing it to
think no files have conflicts even though they do.
This condition is not verified by this test since a
subsequent commit will change the behavior to enable
rerere for stash conflicts.

Also, the next test expected us to finish up with a reset,
which is impossible to do if we fail (as we must) and it's
an unreasonable expectation anyway.  Begin the next test
with a reset of his own instead.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7610-mergetool.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f5e16fc..725f316 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -55,6 +55,16 @@ test_expect_success 'setup' '
     git rm file12 &&
     git commit -m "branch1 changes" &&
 
+    git checkout -b stash1 master &&
+    echo stash1 change file11 >file11 &&
+    git add file11 &&
+    git commit -m "stash1 changes" &&
+
+    git checkout -b stash2 master &&
+    echo stash2 change file11 >file11 &&
+    git add file11 &&
+    git commit -m "stash2 changes" &&
+
     git checkout master &&
     git submodule update -N &&
     echo master updated >file1 &&
@@ -193,7 +203,35 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
     git reset --hard
 '
 
+test_expect_failure 'conflicted stash sets up rerere'  '
+    git config rerere.enabled true &&
+    git checkout stash1 &&
+    echo "Conflicting stash content" >file11 &&
+    git stash &&
+
+    git checkout --detach stash2 &&
+    test_must_fail git stash apply &&
+
+    test -n "$(git ls-files -u)" &&
+    conflicts="$(git rerere remaining)" &&
+    test "$conflicts" = "file11" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" != "No files need merging" &&
+
+    git commit -am "save the stash resolution" &&
+
+    git reset --hard stash2 &&
+    test_must_fail git stash apply &&
+
+    test -n "$(git ls-files -u)" &&
+    conflicts="$(git rerere remaining)" &&
+    test -z "$conflicts" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" = "No files need merging"
+'
+
 test_expect_success 'mergetool takes partial path' '
+    git reset --hard
     git config rerere.enabled false &&
     git checkout -b test12 branch1 &&
     git submodule update -N &&
-- 
1.7.11.1.213.gb567ea5.dirty
