From: Phil Hord <hordp@cisco.com>
Subject: [PATCH v2 1/2] test: git-stash conflict sets up rerere
Date: Sat,  7 Jul 2012 16:46:01 -0400
Message-ID: <1341693962-17090-2-git-send-email-hordp@cisco.com>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 22:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnbuJ-0000wH-Og
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 22:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487Ab2GGUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 16:46:23 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:36480 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2GGUqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 16:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2537; q=dns/txt;
  s=iport; t=1341693983; x=1342903583;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=h21/EYEnlHcH8CSJ24F2E0h01RdbVlJxPZoDvD5epcs=;
  b=DNur1RqdiJE+2helqCn5QhtS2N8EkXF//V/2xc4oQtJOdAJMMZwtl9fN
   qy3mOBzyMWWN9EGPimc/lfeMl+gqPKPRcX/7MHGgR9ZK2XZVsyeqHzzXF
   jaGkuMoT8XKCYB5QXcEnUR2k4ABd6rdZv9aBsqlLA7Xlj5pAP1BvyGJzL
   M=;
X-IronPort-AV: E=Sophos;i="4.77,543,1336348800"; 
   d="scan'208";a="99700235"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by rcdn-iport-3.cisco.com with ESMTP; 07 Jul 2012 20:46:22 +0000
Received: from iptv-lnx-hordp.cisco.com (rtp-hordp-8912.cisco.com [10.117.80.99])
	by rcdn-core2-1.cisco.com (8.14.5/8.14.5) with ESMTP id q67KkKst026361;
	Sat, 7 Jul 2012 20:46:21 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
In-Reply-To: <1341693962-17090-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201166>

Add a failing test to confirm a conflicted stash apply
invokes rerere to record the conflicts and resolve the
the files it can.  In this failing state, mergetool may
be confused by a left-over state from previous rerere
activity.

Also, the next test expected us to finish up with a reset,
which is impossible to do if we fail (as we must) and it's
an unreasonable expectation anyway.  Begin the next test
with a reset of his own instead.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7610-mergetool.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f5e16fc..c9f2fdc 100755
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
@@ -193,7 +203,37 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
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
+    test -e .git/MERGE_RR &&
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
+    test -e .git/MERGE_RR &&
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
