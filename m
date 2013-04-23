From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] rebase: find orig_head unambiguously
Date: Tue, 23 Apr 2013 18:51:14 -0400
Message-ID: <1366757474-29149-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 24 01:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUmD6-00033n-5J
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 01:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab3DWXBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 19:01:12 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:52786 "EHLO
	rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751411Ab3DWXBL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 19:01:11 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Apr 2013 19:01:11 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1971; q=dns/txt; s=iport;
  t=1366758071; x=1367967671;
  h=from:to:cc:subject:date:message-id;
  bh=F1ey83wrPL3KdJDdgIfm9UoXeDfZdbfMUqqIC9th86E=;
  b=cisHJSK03WzuzUQEr9OTmlDioHyY2x4kSjeCj4/lDEnR73xpnFrHpyr1
   ++gI3DlxHjhwkzOnjDr1Ym73tkIEx7cTASawr5LdgYzPQKta0SjSTjqL7
   35lGPJuLslcDWEzCf2dXNJtth18u4LZMo+d0nRxA+InkRt8fdyHfrYDZO
   M=;
X-IronPort-AV: E=Sophos;i="4.87,537,1363132800"; 
   d="scan'208";a="202038750"
Received: from rcdn-core2-3.cisco.com ([173.37.113.190])
  by rcdn-iport-1.cisco.com with ESMTP; 23 Apr 2013 22:51:39 +0000
Received: from ipsn-lnx-hordp.cisco.com (dhcp-64-100-104-138.cisco.com [64.100.104.138])
	by rcdn-core2-3.cisco.com (8.14.5/8.14.5) with ESMTP id r3NMpdTG022339;
	Tue, 23 Apr 2013 22:51:39 GMT
X-Mailer: git-send-email 1.8.2.1.854.g46dda50.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222216>

When we 'git rebase $upstream', git uses 'rev-parse --verify
$current_branch' to find ORIG_HEAD.  But if $current_branch
is ambiguous, 'rev-parse --verify' emits a warning and returns
a SHA1 anyway.  When the wrong ambiguous choice is used,
git-rebase fails non-gracefully:  it emits a warning about
failing to lock $current_branch, an error about being unable to
checkout $current_branch again, and it might even decide the
rebase is a fast-forward when it is not.

In the 'rebase $upstream' case, we already know the unambiguous
spelling of $current_branch is "HEAD".  Fix git-rebase to find
$orig_head unambiguously.

Add a test in t3400-rebase.sh which creates an ambiguous branch
name and rebases it implicitly with 'git rebase $other'.

Signed-off-by: Phil Hord <hordp@cisco.com>
---
 git-rebase.sh     | 2 +-
 t/t3400-rebase.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index b2f1c76..2c692c3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -473,7 +473,7 @@ case "$#" in
 		head_name="detached HEAD"
 		branch_name=HEAD ;# detached
 	fi
-	orig_head=$(git rev-parse --verify "${branch_name}^0") || exit
+	orig_head=$(git rev-parse --verify HEAD) || exit
 	;;
 *)
 	die "BUG: unexpected number of arguments left to parse"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index f6cc102..b58fa1a 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -101,7 +101,14 @@ test_expect_success 'HEAD was detached during rebase' '
 	test $(git rev-parse HEAD@{1}) != $(git rev-parse my-topic-branch@{1})
 '
 
+test_expect_success 'rebase from ambiguous branch name' '
+	git checkout -b topic side &&
+	git rebase master
+'
+
 test_expect_success 'rebase after merge master' '
+	git checkout --detach refs/tags/topic &&
+	git branch -D topic &&
 	git reset --hard topic &&
 	git merge master &&
 	git rebase master &&
-- 
1.8.2.1.854.g46dda50.dirty
