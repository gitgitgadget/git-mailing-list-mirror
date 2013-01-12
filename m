From: Phil Hord <hordp@cisco.com>
Subject: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Sat, 12 Jan 2013 15:46:01 -0500
Message-ID: <1358023561-26773-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Neil Horman <nhorman@tuxdriver.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 21:48:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu80D-0003OS-Rh
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 21:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754285Ab3ALUsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 15:48:08 -0500
Received: from rcdn-iport-7.cisco.com ([173.37.86.78]:59176 "EHLO
	rcdn-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059Ab3ALUsH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 15:48:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1537; q=dns/txt; s=iport;
  t=1358023687; x=1359233287;
  h=from:to:cc:subject:date:message-id;
  bh=ZuXu0cBPUFTvJ6wrvOLfguTzfM1DULnbJZCjPj406R8=;
  b=kiyz+or4fkcy02wm6NNvl7ULMCUAbav5k8p66iZ97vrppGc3aWnxC5/o
   6MiRa/qSl3tePPrp/xC9nfYTSJUlvYX5iUie2fu+QXzTulCmHDc87Ete1
   yZg89LJqFRc9/Yn5t0N1JtehnzrkgEUr64ETBnXwYVWXDJsIIPZ21gHq0
   w=;
X-IronPort-AV: E=Sophos;i="4.84,458,1355097600"; 
   d="scan'208";a="161758419"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-7.cisco.com with ESMTP; 12 Jan 2013 20:48:06 +0000
Received: from ipsn-lnx-hordp.cisco.com (rtp-hordp-8914.cisco.com [10.117.80.101])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id r0CKm5QF002948;
	Sat, 12 Jan 2013 20:48:05 GMT
X-Mailer: git-send-email 1.8.1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213311>

Since 90e1818f9a  (git-rebase: add keep_empty flag, 2012-04-20)
'git rebase --preserve-merges' fails to preserve empty merge commits
unless --keep-empty is also specified.  Merge commits should be
preserved in order to preserve the structure of the rebased graph,
even if the merge commit does not introduce changes to the parent.

Teach rebase not to drop merge commits only because they are empty.

A special case which is not handled by this change is for a merge commit
whose parents are now the same commit because all the previous different
parents have been dropped as a result of this rebase or some previous
operation.
---
 git-rebase--interactive.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 44901d5..8ed7fcc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -190,6 +190,11 @@ is_empty_commit() {
 	test "$tree" = "$ptree"
 }
 
+is_merge_commit()
+{
+	git rev-parse --verify --quiet "$1"^2 >/dev/null 2>&1
+}
+
 # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
 # GIT_AUTHOR_DATE exported from the current environment.
 do_with_author () {
@@ -874,7 +879,7 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
 while read -r shortsha1 rest
 do
 
-	if test -z "$keep_empty" && is_empty_commit $shortsha1
+	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
 	then
 		comment_out="# "
 	else
-- 
1.8.1.dirty
