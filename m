From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] cherry-pick: add failing test for out-of-order pick
Date: Fri, 13 Jan 2012 00:35:31 +0530
Message-ID: <1326395132-18947-1-git-send-email-artagnon@gmail.com>
References: <20120112183246.GB6038@burratino>
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 20:06:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlPzG-00056W-4B
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 20:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab2ALTGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 14:06:53 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:44697 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754593Ab2ALTGw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 14:06:52 -0500
Received: by obcva7 with SMTP id va7so1077869obc.19
        for <git@vger.kernel.org>; Thu, 12 Jan 2012 11:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=8jNZCB6C1bNCgTkH/OyymVsrPKHa1NNts0gzIUWy5x0=;
        b=CnwT9z/7lhBWI1+jKamMrmzdHBBmD1G6d6F0I+BduoM+G3yD/Qyp73dj8rpBjReHhh
         MQoQIL44d65VNDbKpuEiYjNxC574ECKzVRSP03PN+ipZj+TN9oDM1BxKj4AxtYNfywHv
         8mlYxMic7ZBkRG17+j8u5kaXxSSyTgTmklRFg=
Received: by 10.50.47.136 with SMTP id d8mr5554746ign.21.1326395211886;
        Thu, 12 Jan 2012 11:06:51 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id he16sm20069003ibb.9.2012.01.12.11.06.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jan 2012 11:06:51 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <20120112183246.GB6038@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188470>

The invocation

  $ git cherry-pick commit3 commit1 commit2

picks commits after sorting by date order, which is counter-intuitive.
Add a failing test to t3508 (cherry-pick-many-commits) documenting
this behavior.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Had some weird compulsion to conform to the style of the other tests
 in the previous iteration.

 t/t3508-cherry-pick-many-commits.sh |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/t/t3508-cherry-pick-many-commits.sh b/t/t3508-cherry-pick-many-commits.sh
index 8e09fd0..d9d632d 100755
--- a/t/t3508-cherry-pick-many-commits.sh
+++ b/t/t3508-cherry-pick-many-commits.sh
@@ -59,6 +59,23 @@ test_expect_success 'cherry-pick first..fourth works' '
 	check_head_differs_from fourth
 '
 
+test_expect_failure 'cherry-pick picks commits in the order requested' '
+	git checkout -f master &&
+	git reset --hard first &&
+	test_tick &&
+	git cherry-pick fourth second third &&
+	{
+		git rev-list --reverse HEAD |
+		git diff-tree --stdin -s --format=%s
+	} >actual &&
+	cat >expect <<-\EOF &&
+	fourth
+	second
+	third
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'cherry-pick --strategy resolve first..fourth works' '
 	cat <<-\EOF >expected &&
 	Trying simple merge.
-- 
1.7.8.2
