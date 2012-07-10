From: Phil Hord <hordp@cisco.com>
Subject: [PATCH v3 2/2] stash: invoke rerere in case of conflict
Date: Tue, 10 Jul 2012 18:52:28 -0400
Message-ID: <1341960748-26949-2-git-send-email-hordp@cisco.com>
References: <1341960748-26949-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 00:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SojIm-0008FV-EN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 00:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698Ab2GJWwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jul 2012 18:52:41 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:29484 "EHLO
	rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab2GJWwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2012 18:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1413; q=dns/txt;
  s=iport; t=1341960758; x=1343170358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BmiRVZ1gwfRGzNRQZVYaBc2pa4UVEKWdeUTxGAXA28c=;
  b=MUCojk7hlFMfX5Ex/bverwxC5Ceb9F+5KqBY1k35iTZ3uevBzUCMJqMc
   f8dJCf345s6yEC8mVccqSKvOkz5SrizHZEtmnedBAJyypnvAjUeZ/FAC8
   Bx77wkVfyMV7ZTvBIAGsWLyT5psebCCN2EJClya9GqyF9f37QS68uA+B7
   E=;
X-IronPort-AV: E=Sophos;i="4.77,561,1336348800"; 
   d="scan'208";a="100603112"
Received: from rcdn-core-2.cisco.com ([173.37.93.153])
  by rcdn-iport-5.cisco.com with ESMTP; 10 Jul 2012 22:52:38 +0000
Received: from iptv-lnx-hordp.cisco.com (dhcp-64-100-104-93.cisco.com [64.100.104.93])
	by rcdn-core-2.cisco.com (8.14.5/8.14.5) with ESMTP id q6AMqamZ018722;
	Tue, 10 Jul 2012 22:52:37 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
In-Reply-To: <1341960748-26949-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201283>

'stash apply' directly calls a backend merge function
which does not automatically invoke rerere.  This
confuses mergetool when leftover rerere state is left
behind from previous merges.

Invoke rerere explicitly when we encounter a conflict
during stash apply

Change the test for this flaw to expect success.

Signed-off-by: Phil Hord <hordp@cisco.com>
Mentored-by: Junio C Hamano <gitster@pobox.com>
---
 git-stash.sh         | 1 +
 t/t7610-mergetool.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-stash.sh b/git-stash.sh
index 4e2c7f8..bbefdf6 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -469,6 +469,7 @@ apply_stash () {
 	else
 		# Merge conflict; keep the exit status from merge-recursive
 		status=$?
+		git rerere
 		if test -n "$INDEX_OPTION"
 		then
 			gettextln "Index was not unstashed." >&2
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 725f316..6fa0c70 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -203,7 +203,7 @@ test_expect_success 'mergetool skips resolved paths when rerere is active' '
     git reset --hard
 '
 
-test_expect_failure 'conflicted stash sets up rerere'  '
+test_expect_success 'conflicted stash sets up rerere'  '
     git config rerere.enabled true &&
     git checkout stash1 &&
     echo "Conflicting stash content" >file11 &&
-- 
1.7.11.1.213.gb567ea5.dirty
