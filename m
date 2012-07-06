From: Phil Hord <hordp@cisco.com>
Subject: [PATCH 2/2] Clear rerere status during stash conflict
Date: Fri,  6 Jul 2012 12:22:52 -0400
Message-ID: <1341591772-26251-3-git-send-email-hordp@cisco.com>
References: <1341591772-26251-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 06 18:32:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnBSj-0003GR-2l
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 18:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957Ab2GFQcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 12:32:41 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:27735 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934Ab2GFQcj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 12:32:39 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jul 2012 12:32:38 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2095; q=dns/txt;
  s=iport; t=1341592359; x=1342801959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=3Om31yYJ9vfPiyNSNd5O3dlaANas3+Lc9DFDBFRVnxw=;
  b=kLMFZV2QA5juIYzbOLTzvkAtE/zsn8w/8mRLChyBHA4GlU08TQmzCumn
   xSAEDMw3S9oSkeXz7GkaVvDzRPbJtO/UsYYhasMVtmR6TQwfEmAb/LuyK
   VtHY/tWGbY6ESp5jEP6uyZTbsyrhI3XuqohJHUiua2pxx7Xa7pi3zyxi8
   M=;
X-IronPort-AV: E=Sophos;i="4.77,537,1336348800"; 
   d="scan'208";a="99461769"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by rcdn-iport-3.cisco.com with ESMTP; 06 Jul 2012 16:23:13 +0000
Received: from iptv-lnx-hordp.cisco.com (dhcp-64-100-104-40.cisco.com [64.100.104.40])
	by rcdn-core-1.cisco.com (8.14.5/8.14.5) with ESMTP id q66GNASf020339;
	Fri, 6 Jul 2012 16:23:13 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
In-Reply-To: <1341591772-26251-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201123>

The presence of a GIT_DIR/MERGE_RR file indicates we
were resolving a merge which had rerere candidates for
recording.  But the file does not get deleted after
all resolutions are completed.  This is ok for most
cases because the file will get replaced when the
next merge happens.  But stash apply directly uses
a merge backend, which is not supported by rerere.
The prior rerere state is left behind (in MERGE_RR)
rather than being cleaned up or overwritten as it
would with a normal merge.

This then confuses mergetool who thinks a rerere
operation is in play when it is not.

When we encounter a conflicted stash,  ask rerere to
clean up with 'git rerere clear'.  This is safe to do
since we know that rerere is not taking part in this
conflict resolution, and any previous unresolved rerere
activity would have prevented us from attempting the
stash apply in the first place.

Change the test for this flaw to expect success.

Signed-off-by: Phil Hord <hordp@cisco.com>
Mentored-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh         | 1 +
 t/t7610-mergetool.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..5bd45ef 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -469,6 +469,7 @@ apply_stash () {
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
+		git rerere clear
 		if test -n "$INDEX_OPTION"
 		then
 			gettextln "Index was not unstashed." >&2
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 2796c53..99e8c1d 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -203,7 +203,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
     git reset --hard
 '
 
-test_expect_failure 'mergetool ignores rerere in git-stash conflicts'  '
+test_expect_success 'mergetool ignores rerere in git-stash conflicts'  '
     git checkout -b stash3 stash1 &&
     git config rerere.enabled true &&
     echo "Conflicting stash content" >file11 &&
-- 
1.7.11.1.213.gb567ea5.dirty
