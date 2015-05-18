From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v2] pull: handle --log=<n>
Date: Mon, 18 May 2015 21:39:56 +0800
Message-ID: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 15:40:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuLHP-0004Cr-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 15:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbERNkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 09:40:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35648 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbbERNkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 09:40:20 -0400
Received: by pdea3 with SMTP id a3so149191189pde.2
        for <git@vger.kernel.org>; Mon, 18 May 2015 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=z4nstb7tC8XwOqH2EKR/qjy8AQbhbuJ7ZBTJ2+3yjYY=;
        b=J8q0RTQUOh0tG5GWxFTirNZ6M1WCqZCiu5IhgsWMUeYHs+EYwsg+uWvqP0fb4gIjeu
         +NAG5an4HM9F8tcxZtJxzRX2ZMhDZ0VwXq05TnxE0a670taN5ZRbIusmVGFMMAxfvECv
         FP39xybotktKQg1GwoFrpM7lHUpeY/i8q3PF4dxNTgUvf8xHJfNZoiJpt8u4aecIJE+U
         AQWDWAYoVWO1n/BMzzNo4sjF25+iRjWcIPrlh206k6XxVyRjjia4Zt692UgJr9cocn2J
         0uMe8cnw0Sx6Wf1RXSdz5MqgigaWEkDnVoq4LxURzT/kkJJAVcYLM+D5DvhdNEbXzTrf
         kRzQ==
X-Received: by 10.66.159.68 with SMTP id xa4mr45019027pab.105.1431956419836;
        Mon, 18 May 2015 06:40:19 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id wa4sm10204934pab.17.2015.05.18.06.40.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 06:40:17 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269245>

Since efb779f (merge, pull: add '--(no-)log' command line option,
2008-04-06) git-pull supported the (--no-)log switch and would pass it
to git-merge.

96e9420 (merge: Make '--log' an integer option for number of shortlog
entries, 2010-09-08) implemented support for the --log=<n> switch, which
would explicitly set the number of shortlog entries. However, git-pull
does not recognize this option, and will instead pass it to git-fetch,
leading to "unknown option" errors.

Fix this by matching --log=* in addition to --log and --no-log.

Implement a test for this use case.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
This is a re-roll of [1].

The only change is the removal of "verbose".

Thanks Matthieu for the review last round.

[1] http://thread.gmane.org/gmane.comp.version-control.git/268961

 git-pull.sh         |  4 ++--
 t/t5524-pull-msg.sh | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 9ed01fd..5ff4545 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -81,8 +81,8 @@ do
 		diffstat=--no-stat ;;
 	--stat|--summary)
 		diffstat=--stat ;;
-	--log|--no-log)
-		log_arg=$1 ;;
+	--log|--log=*|--no-log)
+		log_arg="$1" ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=--no-commit ;;
 	--c|--co|--com|--comm|--commi|--commit)
diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
index 8cccecc..eebb8c9 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -17,6 +17,9 @@ test_expect_success setup '
 		git commit -m "add bfile"
 	) &&
 	test_tick && test_tick &&
+	echo "second" >afile &&
+	git add afile &&
+	git commit -m "second commit" &&
 	echo "original $dollar" >afile &&
 	git add afile &&
 	git commit -m "do not clobber $dollar signs"
@@ -32,4 +35,18 @@ test_expect_success pull '
 )
 '
 
+test_expect_failure '--log=1 limits shortlog length' '
+(
+	cd cloned &&
+	git reset --hard HEAD^ &&
+	test "$(cat afile)" = original &&
+	test "$(cat bfile)" = added &&
+	git pull --log=1 &&
+	git log -3 &&
+	git cat-file commit HEAD >result &&
+	grep Dollar result &&
+	! grep "second commit" result
+)
+'
+
 test_done
-- 
2.1.4
