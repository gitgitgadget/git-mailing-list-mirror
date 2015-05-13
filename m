From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH 2/2] pull: handle --log=<n>
Date: Wed, 13 May 2015 17:17:41 +0800
Message-ID: <1431508661-21729-3-git-send-email-pyokagan@gmail.com>
References: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Cc: Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 11:18:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsSny-0006yM-8x
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 11:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346AbbEMJSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 05:18:15 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33745 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933333AbbEMJSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 05:18:11 -0400
Received: by pdbnk13 with SMTP id nk13so45674431pdb.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kQbFz3snZRbU3QAcbKdp0d/YP1fKkSvHZLDRDoObO+w=;
        b=mKgVQt6fDTTOq8/RJWMplzLDsajCf7ooiF4fw2zWaBx3BH7KJeZkC2kPGn74ZjxZw4
         pujaTjoTGvlUfdBlND71lcmb93YJf8Ml2qaUrKXZ1lp1FTrkRBKrp0tlTTyXMR2xRzFg
         Qo1ok2F9RdfFJmNx2U+cL8JaUqm4i8cuIoFq3onKPuyzFfIAmVA20DC68tk65/B6kURs
         oqRaKGKRanhGiRjher7fIfCGHgwdsPe8D8VvjxrKFw7JF1+YoIlviH1tD3C9sSBvebVY
         /ghOAxUgN2RtnA+hagYd3frzB/WgbwGXR1Gx7wZtxyu3Y2y7FYkIr9ysZ4G6/TeoDHog
         8QKA==
X-Received: by 10.66.255.10 with SMTP id am10mr12641383pad.60.1431508691036;
        Wed, 13 May 2015 02:18:11 -0700 (PDT)
Received: from yoshi.pyokagan.tan ([116.86.132.138])
        by mx.google.com with ESMTPSA id kh6sm18632898pbc.50.2015.05.13.02.18.08
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 May 2015 02:18:09 -0700 (PDT)
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1431508661-21729-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268963>

Since efb779f (merge, pull: add '--(no-)log' command line option,
2008-04-06) git-pull supported the (--no-)log switch and would pass it
to git-merge.

96e9420 (merge: Make '--log' an integer option for number of shortlog
entries, 2010-09-08) implemented support for the --log=<n> switch, which
would explicitly set the number of shortlog entries. However, git-pull
does not recognize this option, and will instead pass it to git-fetch,
leading to "unknown option" errors.

Fix this by matching --log=* in addition to --log and --no-log.

This fixes the failing test '--log=1 limits shortlog length'.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 git-pull.sh         | 4 ++--
 t/t5524-pull-msg.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

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
index 593405d..64754b1 100755
--- a/t/t5524-pull-msg.sh
+++ b/t/t5524-pull-msg.sh
@@ -35,7 +35,7 @@ test_expect_success pull '
 )
 '
 
-test_expect_failure '--log=1 limits shortlog length' '
+test_expect_success '--log=1 limits shortlog length' '
 (
 	cd cloned &&
 	git reset --hard HEAD^ &&
-- 
2.1.4
