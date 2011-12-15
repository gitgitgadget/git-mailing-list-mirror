From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] t5704 (bundle): rewrite for larger coverage
Date: Thu, 15 Dec 2011 22:15:27 +0530
Message-ID: <1323967528-10537-2-git-send-email-artagnon@gmail.com>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <1323967528-10537-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 17:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbERK-0001CY-3y
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 17:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567Ab1LOQpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 11:45:44 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42502 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565Ab1LOQpn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 11:45:43 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so3006690iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vACxhCY6VNIT03AfizjNLyKw2UkgCvD2Zw+bPP1P8KQ=;
        b=fNBtd562XYr8l9Vnk7c2kwmqh+zzzdfHwzSMnS0BGMLNeing8lalKG0rA2LBLvJjO6
         IQc04q/UMsAldPRNxFdYVrdg1/jnU5d5ekB7dAgxNtE3XdMsYKrsV2MrvwMPa6ZUNYMs
         9dRA5n7zy6oJzRIX4J01oT2cQ1+Z3vHswn97o=
Received: by 10.42.162.130 with SMTP id y2mr3104925icx.26.1323967543487;
        Thu, 15 Dec 2011 08:45:43 -0800 (PST)
Received: from localhost.localdomain ([122.174.88.206])
        by mx.google.com with ESMTPS id lu10sm11031370igc.0.2011.12.15.08.45.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 08:45:40 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323967528-10537-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187211>

Rewrite the git-bundle testsuite to exercise more of its
functionality.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5704-bundle.sh |   95 ++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 728ccd8..09ff4f1 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -1,56 +1,99 @@
 #!/bin/sh
 
-test_description='some bundle related tests'
+test_description='Test git-bundle'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
+	git config core.logAllRefUpdates false &&
+	test_commit initial &&
+	git checkout -b branch &&
+	test_commit second &&
+	test_commit third &&
+	git checkout master &&
+	test_commit fourth file
+'
 
-	: > file &&
-	git add file &&
-	test_tick &&
-	git commit -m initial &&
-	test_tick &&
-	git tag -m tag tag &&
-	: > file2 &&
-	git add file2 &&
-	: > file3 &&
-	test_tick &&
-	git commit -m second &&
-	git add file3 &&
-	test_tick &&
-	git commit -m third
+test_expect_success 'create succeeds' '
+	git bundle create bundle second third &&
+	cat >expect <<-\EOF &&
+	OBJID	refs/tags/third
+	OBJID	refs/tags/second
+	EOF
+	{
+		git ls-remote bundle |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
+'
 
+test_expect_success 'verify succeeds' '
+	git bundle create bundle second third &&
+	git bundle verify bundle
 '
 
-test_expect_success 'tags can be excluded by rev-list options' '
+test_expect_success 'list-heads succeeds' '
+	git bundle create bundle second third &&
+	cat >expect <<-\EOF &&
+	OBJID refs/tags/second
+	OBJID refs/tags/third
+	EOF
+	{
+		git bundle list-heads bundle |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
+'
 
-	git bundle create bundle --all --since=7.Apr.2005.15:16:00.-0700 &&
-	git ls-remote bundle > output &&
-	! grep tag output
+test_expect_success 'create dies on invalid bundle filename' '
+	mkdir adir &&
+	test_expect_code 128 git bundle create adir --all
+'
 
+test_expect_success 'disallow stray command-line options' '
+	test_must_fail git bundle create --junk bundle second third
 '
 
-test_expect_success 'die if bundle file cannot be created' '
+test_expect_failure 'disallow stray command-line arguments' '
+	git bundle create bundle second third &&
+	test_must_fail git bundle verify bundle junk
+'
 
-	mkdir adir &&
-	test_must_fail git bundle create adir --all
+test_expect_success 'create accepts rev-list options to narrow refs' '
+	git bundle create bundle --all -- file &&
+	cat >expect <<-\EOF &&
+	OBJID	HEAD
+	OBJID	refs/tags/fourth
+	OBJID	refs/heads/master
+	EOF
+	{
+		git ls-remote bundle |
+		sed "s/$_x40/OBJID/g"
+	} >actual &&
+	test_cmp expect actual
+'
 
+test_expect_success 'unbundle succeeds' '
+	saved=$(git rev-parse third) &&
+	git bundle create bundle second third fourth &&
+	git tag -d second third fourth &&
+	git branch -D branch &&
+	git reset --hard initial &&
+	git prune &&
+	test_must_fail git reset --hard $saved &&
+	git bundle unbundle bundle &&
+	git reset --hard $saved
 '
 
 test_expect_failure 'bundle --stdin' '
-
 	echo master | git bundle create stdin-bundle.bdl --stdin &&
 	git ls-remote stdin-bundle.bdl >output &&
 	grep master output
-
 '
 
 test_expect_failure 'bundle --stdin <rev-list options>' '
-
 	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
 	git ls-remote hybrid-bundle.bdl >output &&
 	grep master output
-
 '
 
 test_done
-- 
1.7.4.1
