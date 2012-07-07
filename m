From: Phil Hord <hordp@cisco.com>
Subject: [PATCH v2 2/2] stash: invoke rerere in case of conflict
Date: Sat,  7 Jul 2012 16:46:02 -0400
Message-ID: <1341693962-17090-3-git-send-email-hordp@cisco.com>
References: <CABURp0oXhZ5ysm4b3Z=7o+2TB+3wFdMjj4oEwxafApjD4c7ozA@mail.gmail.com>
 <1341693962-17090-1-git-send-email-hordp@cisco.com>
Cc: gitster@pobox.com, phil.hord@gmail.com, Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 22:47:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnbuK-0000wH-9k
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jul 2012 22:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab2GGUqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jul 2012 16:46:36 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:3619 "EHLO
	rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab2GGUqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2012 16:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1413; q=dns/txt;
  s=iport; t=1341693984; x=1342903584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=tm4sUFqT+jJsyaxAg09G9s9CQ/JQ6+A9/9DlUlCPSSo=;
  b=Ji0yEkbvU7Hgtz64vsGh1XT7W0n+s9M7QsQ1Re79YUPk68/mVycipV8O
   VW/3snj1pEN4AUC/IUkXQLjzMTIZoPPD/yOf+m3L0J63hzWwlK6VOe8Gk
   mt2CyRKDyC3HB32E8yIdXCEvyl3VKzlerq38HNHH2EK1muKZL4BIHsp2n
   U=;
X-IronPort-AV: E=Sophos;i="4.77,543,1336348800"; 
   d="scan'208";a="99683323"
Received: from rcdn-core2-1.cisco.com ([173.37.113.188])
  by rcdn-iport-8.cisco.com with ESMTP; 07 Jul 2012 20:46:24 +0000
Received: from iptv-lnx-hordp.cisco.com (rtp-hordp-8912.cisco.com [10.117.80.99])
	by rcdn-core2-1.cisco.com (8.14.5/8.14.5) with ESMTP id q67KkKsu026361;
	Sat, 7 Jul 2012 20:46:23 GMT
X-Mailer: git-send-email 1.7.11.1.213.gb567ea5.dirty
In-Reply-To: <1341693962-17090-1-git-send-email-hordp@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201167>

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
index c9f2fdc..419cc38 100755
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
