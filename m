From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 1/2] test: mergetool ignores rerere in git-stash
Date: Fri,  6 Jul 2012 12:22:51 -0400
Message-ID: <1341591772-26251-2-git-send-email-hordp@cisco.com>
References: <1341591772-26251-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 18:32:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnBSj-0003GR-Iw
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 18:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757962Ab2GFQcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 12:32:43 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:27735 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934Ab2GFQcl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 12:32:41 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2012 12:32:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1910; q=dns/txt;
  s=iport; t=1341592361; x=1342801961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0Y+KSQcI+M5KaQ3S0So1w+ZtVzXxZvF3ZNKNIerlDLw=;
  b=P+2J6mobw5sCysUwf29DZtp1D2xT/NMeEo2cEVoPf9j5sVuk7fJQX0KS
   LNSBjSfUxGzlddCoveWld3MrmjX9jq40JGogUdIwbELlNuF3oIXtsXVzU
   SWW9dz9+fZ+fV9mzd4oFNZf0ndibMVCqrLPpz1/2d7IHu1HK1N2RqJAD2
   I=;
X-IronPort-AV: E=Sophos;i="4.77,537,1336348800"; 
   d="scan'208";a="99461765"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-3.cisco.com with ESMTP; 06 Jul 2012 16:23:12 +0000
Received: from iptv-lnx-hordp.cisco.com (dhcp-64-100-104-40.cisco.com [64.100.104.40])
	by rcdn-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id q66GNASe020339;
	Fri, 6 Jul 2012 16:23:12 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
In-Reply-To: <1341591772-26251-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201122>

Add a failing test to confirm the leftover rerere
state files interfere with git-mergetool during a
conflicted stash apply.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 t/t7610-mergetool.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index f5e16fc..2796c53 100755
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
@@ -193,7 +203,25 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
     git reset --hard
 '
 
+test_expect_failure 'mergetool ignores rerere in git-stash conflicts'  '
+    git checkout -b stash3 stash1 &&
+    git config rerere.enabled true &&
+    echo "Conflicting stash content" >file11 &&
+    git stash &&
+    test_must_fail git merge stash2 &&
+    echo resolved >file11 &&
+    git add file11 &&
+    git commit -mResolved-previous-conflict &&
+    test -e .git/MERGE_RR &&
+    test_must_fail git stash apply &&
+    test_must_fail test -e .git/MERGE_RR &&
+    test -n "$(git ls-files -u)" &&
+    output="$(git mergetool --no-prompt)" &&
+    test "$output" != "No files need merging"
+'
+
 test_expect_success 'mergetool takes partial path' '
+    git reset --hard
     git config rerere.enabled false &&
     git checkout -b test12 branch1 &&
     git submodule update -N &&
-- 
1.7.11.1.213.gb567ea5.dirty
