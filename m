From: David Turner <dturner@twopensource.com>
Subject: [PATCH 5/9] tests: use --create-reflog option to git update-ref
Date: Fri, 24 Jul 2015 00:45:25 -0400
Message-ID: <1437713129-19373-6-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUsG-00043b-JB
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbbGXEqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:46:15 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33005 "EHLO
	mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbGXEpz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:55 -0400
Received: by qkdl129 with SMTP id l129so8261206qkd.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVzOu5dbxSE3E+avB1+USu61RfEtVXADljSVRHLpsn8=;
        b=l3MzYvveGgYvf70kPZH5cRa7ZOaOmzRs86ToiihengGpgjUhNoJc2WHgzW+t3WZUVz
         KW4IgjwKWSjlCeVLjA/JlZlampuMCQiKomq5D1BAlLtT9z7CfwZH33xhRX9KixcCqWa5
         YaTBsa40lxoT6L1Onq41QJVkwcPF9KAf5rgE3/TXh/mK+hmzrzORU57FQ5I6qaBs0M79
         RAfmDHT54W5ClXuROiO4l/8Nd1ZoaE4/iM9DMtIEGdzD+LCc702vUtxEYyMUDV2gUfuG
         NrTfeele4GHJClIG18Aupqikrgk27DtwL0SY3AmN90tHSoEBg0EkfZyDnZyZ/jgXsKV6
         AFSw==
X-Gm-Message-State: ALoCoQltBA9k7gI+uZYVrd8M+8QA6/hb+FfVvNkxqsknHxMRwhP/zWaz63gs0yLDnv370K2dEHUU
X-Received: by 10.140.239.9 with SMTP id k9mr18551558qhc.38.1437713154144;
        Thu, 23 Jul 2015 21:45:54 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:53 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274553>

Instead of manually precreating reflogs by writing files, use
update-ref --create-reflog to create the reflogs at the same time
we first create the ref.

In one case, we need an entirely empty reflog, so we do a no-op
update-ref with --create-reflog and then expire the reflog.

This makes it slighly easier to test alternate ref backends.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 t/t1400-update-ref.sh       | 5 ++---
 t/t1411-reflog-show.sh      | 3 ++-
 t/t1503-rev-parse-verify.sh | 9 +++------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 9d21c19..0038f28 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -174,12 +174,11 @@ test_expect_success "(not) changed .git/$m" "
 '
 rm -f .git/$m
 
-: a repository with working tree always has reflog these days...
-: >.git/logs/refs/heads/master
+rm .git/logs/refs/heads/master
 test_expect_success \
 	"create $m (logged by touch)" \
 	'GIT_COMMITTER_DATE="2005-05-26 23:30" \
-	 git update-ref HEAD '"$A"' -m "Initial Creation" &&
+	 git update-ref --create-reflog HEAD '"$A"' -m "Initial Creation" &&
 	 test '"$A"' = $(cat .git/'"$m"')'
 test_expect_success \
 	"update $m (logged by touch)" \
diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
index 3eb4f10..ee069ac 100755
--- a/t/t1411-reflog-show.sh
+++ b/t/t1411-reflog-show.sh
@@ -138,7 +138,8 @@ test_expect_success '--date magic does not override explicit @{0} syntax' '
 : >expect
 test_expect_success 'empty reflog file' '
 	git branch empty &&
-	: >.git/logs/refs/heads/empty &&
+	git update-ref --create-reflog refs/heads/empty empty &&
+	git reflog expire --expire=all refs/heads/empty &&
 
 	git log -g empty >actual &&
 	test_cmp expect actual
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 823fe1d..ab27d0d 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -85,8 +85,7 @@ test_expect_success 'fails silently when using -q' '
 
 test_expect_success 'fails silently when using -q with deleted reflogs' '
 	ref=$(git rev-parse HEAD) &&
-	: >.git/logs/refs/test &&
-	git update-ref -m "message for refs/test" refs/test "$ref" &&
+	git update-ref --create-reflog -m "message for refs/test" refs/test "$ref" &&
 	git reflog delete --updateref --rewrite refs/test@{0} &&
 	test_must_fail git rev-parse -q --verify refs/test@{0} >error 2>&1 &&
 	test_must_be_empty error
@@ -94,16 +93,14 @@ test_expect_success 'fails silently when using -q with deleted reflogs' '
 
 test_expect_success 'fails silently when using -q with not enough reflogs' '
 	ref=$(git rev-parse HEAD) &&
-	: >.git/logs/refs/test2 &&
-	git update-ref -m "message for refs/test2" refs/test2 "$ref" &&
+	git update-ref --create-reflog -m "message for refs/test2" refs/test2 "$ref" &&
 	test_must_fail git rev-parse -q --verify refs/test2@{999} >error 2>&1 &&
 	test_must_be_empty error
 '
 
 test_expect_success 'succeeds silently with -q and reflogs that do not go far back enough in time' '
 	ref=$(git rev-parse HEAD) &&
-	: >.git/logs/refs/test3 &&
-	git update-ref -m "message for refs/test3" refs/test3 "$ref" &&
+	git update-ref --create-reflog -m "message for refs/test3" refs/test3 "$ref" &&
 	git rev-parse -q --verify refs/test3@{1.year.ago} >actual 2>error &&
 	test_must_be_empty error &&
 	echo "$ref" >expect &&
-- 
2.0.4.315.gad8727a-twtrsrc
