From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 5/5] t6200-fmt-merge-msg: Exercise '--log' to configure shortlog length
Date: Wed,  8 Sep 2010 23:29:57 +0530
Message-ID: <1283968797-31793-6-git-send-email-artagnon@gmail.com>
References: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 20:03:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtOz5-0001BB-9N
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 20:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752537Ab0IHSC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 14:02:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50851 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab0IHSCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 14:02:25 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so195346iwn.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=puK7Su8QABNbOLm91/lSRpf4Ecgjz76Z92gIjPWLBxU=;
        b=kgStCJqQMahtOM7k1ef8Zd8T2Tn4XXvqrJpWXhcNLmaYkYBDkOw4yaVTrcUQu4s9m3
         Mtd0cLV+y/5eRBnYILWP9ywR1UMblgqGg5VB6E/fd2RCt/LFM+3J12+7Rkll6Irb6Zcl
         Z7CSgLY0RHGFOjzqXxNl7gQ5yKFYMRMhfbyuo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QFFWETf9nUtISbsjwT0G5wYftGjNeLnjQrRdlGJAiYtZyg8ownTJaD4DI20oVKERfT
         v4gCBPJ38kgeKb6lyErnh03XxbLOegWxWMBoawliOLSGRKrkwmTemtbdCGDxc+znwnKA
         yyNY/KcR4AqcQj3EKXV+UndsYoypGN4/DK/18=
Received: by 10.231.146.129 with SMTP id h1mr10227107ibv.181.1283968944677;
        Wed, 08 Sep 2010 11:02:24 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id z6sm199616ibc.12.2010.09.08.11.02.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 11:02:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1283968797-31793-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155806>

Add a test to exercise the '--log' command-line option of 'git
fmt-merge-msg'. It controls the number of shortlog entries to display
in merge commit messages.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Thanks-to: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 9b600a8..9a16806 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -177,6 +177,49 @@ test_expect_success 'merge.log=0 disables shortlog' '
 	test_cmp expected actual
 '
 
+test_expect_success '--log=3 limits shortlog length' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left: (5 commits)
+	  Left #5
+	  Left #4
+	  Left #3
+	  ...
+	EOF
+
+	git fmt-merge-msg --log=3 <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--log=5 shows all 5 commits' '
+	cat >expected <<-EOF &&
+	Merge branch ${apos}left${apos}
+
+	* left:
+	  Left #5
+	  Left #4
+	  Left #3
+	  Common #2
+	  Common #1
+	EOF
+
+	git fmt-merge-msg --log=5 <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--no-log disables shortlog' '
+	echo "Merge branch ${apos}left${apos}" >expected &&
+	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success '--log=0 disables shortlog' '
+	echo "Merge branch ${apos}left${apos}" >expected &&
+	git fmt-merge-msg --no-log <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'fmt-merge-msg -m' '
 	echo "Sync with left" >expected &&
 	cat >expected.log <<-EOF &&
-- 
1.7.2.2.409.gdbb11.dirty
