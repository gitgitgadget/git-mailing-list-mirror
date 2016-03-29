From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] submodule update --init: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 15:23:44 -0700
Message-ID: <1459290228-9069-3-git-send-email-sbeller@google.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23U-0002JJ-3G
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266AbcC2WX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:23:59 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33670 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756665AbcC2WX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:23:57 -0400
Received: by mail-pa0-f43.google.com with SMTP id zm5so24434583pac.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGaE/DFXP0GawMj6FWyDmIgi+CflmXtgoQ4jTWD6mvs=;
        b=lesAmzvWBtBF83M5c6d1mor/9GlXgUiL+xKaWX81N60kdHOYRL6HlTlX+d9H9nUO9k
         IUFgeaLTxAlYkp4XUBTYkDWxCdGe8SMhmrfOiRcSwit+s9ZXiJm/uWAcPRYqIfUBbB+z
         +ZTwLHtkBv8RZGNPOOIHEWDWsefaIxTBb0qf68wE0kgLwLzh2LnEXXkErsZswWtxlo5q
         ib0+s/s+Zxn9oWe87NnPjJgazl8yBhxqg57Mv9qfbOSVttwHNa3OpsE8WQ3iCrhcnj/+
         GXUOd3SLjlcfW4jy86WcOBKFcd3J69ZAJXU9TjjNRmsLL0ktXamU7WiQQI/UCJohtZYL
         wfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGaE/DFXP0GawMj6FWyDmIgi+CflmXtgoQ4jTWD6mvs=;
        b=UP8iZZ315diRk7pyhMTcIG5kCbESjx1q4G37JYBO6QZ+woit2HhFniKJX0TiQk1tex
         gcRaucmiWXr4SLDWCcSW5lKispDIeLCUG0gMH55nmiFPiyFYjXz+QZ2n+gnNAWjy9fhI
         uRs5kOBsAWZB5IrPzIFmCVGd47xh1N5bZMcxgPT4HChLkBj0V9E+jUWd1byZcm2AexfZ
         Pn2Niw1Z79g6iQpuxuwRYgmNdEvkegn6Neq9ZvMHOOMD3XpYQKpiOTDR7IaEKe3TAdhd
         /RBSkSFpvaxiKIDRdU3jV2M9oXK0l9JWOE1LClzH9kGtJSXa15664GmM+7FyWk2gZcFE
         FRKw==
X-Gm-Message-State: AD7BkJIZAeN3gq/HJ0mRYXu9fDOP5xM5Arm0rFmnBxaD+qtLoZv2vpKZSdNZr2/CMM0u9Q5l
X-Received: by 10.66.65.228 with SMTP id a4mr7390219pat.4.1459290236938;
        Tue, 29 Mar 2016 15:23:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id wb7sm699582pab.3.2016.03.29.15.23.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:23:56 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290207>

The new test demonstrates a failure in the code prior to this patch.
Instead of getting the expected
    Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
the `super` directory is omitted and you get
    Submodule 'submodule' (${pwd}/submodule) registered for path '../submodule'
instead.

That happens because the prefix is ignored in `git submodule add`, probably
because that function itself cannot recurse; it may however called by
recursive instances of `git submodule update`, so we need to respect the
`prefix`.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  2 +-
 t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2838069..fdb5fbd 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -474,7 +474,7 @@ cmd_init()
 		die_if_unmatched "$mode"
 		name=$(git submodule--helper name "$sm_path") || exit
 
-		displaypath=$(relative_path "$sm_path")
+		displaypath=$(relative_path "$prefix$sm_path")
 
 		# Copy url setting when it is not set yet
 		if test -z "$(git config "submodule.$name.url")"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..9a4ba41 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -63,6 +63,10 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../none none &&
 	 test_tick &&
 	 git commit -m "none"
+	) &&
+	git clone . recursivesuper &&
+	( cd recursivesuper
+	 git submodule add ../super super
 	)
 '
 
@@ -95,6 +99,35 @@ test_expect_success 'submodule update from subdirectory' '
 	)
 '
 
+supersha1=$(cd super && git rev-parse HEAD)
+mergingsha1=$(cd super/merging && git rev-parse HEAD)
+nonesha1=$(cd super/none && git rev-parse HEAD)
+rebasingsha1=$(cd super/rebasing && git rev-parse HEAD)
+submodulesha1=$(cd super/submodule && git rev-parse HEAD)
+pwd=$(pwd)
+
+cat <<EOF >expect
+Submodule path '../super': checked out '$supersha1'
+Submodule 'merging' ($pwd/merging) registered for path '../super/merging'
+Submodule 'none' ($pwd/none) registered for path '../super/none'
+Submodule 'rebasing' ($pwd/rebasing) registered for path '../super/rebasing'
+Submodule 'submodule' ($pwd/submodule) registered for path '../super/submodule'
+Submodule path '../super/merging': checked out '$mergingsha1'
+Submodule path '../super/none': checked out '$nonesha1'
+Submodule path '../super/rebasing': checked out '$rebasingsha1'
+Submodule path '../super/submodule': checked out '$submodulesha1'
+EOF
+
+test_expect_success 'submodule update --init --recursive from subdirectory' '
+	git -C recursivesuper/super reset --hard HEAD^ &&
+	(cd recursivesuper &&
+	 mkdir tmp &&
+	 cd tmp &&
+	 git submodule update --init --recursive ../super >../../actual
+	) &&
+	test_cmp expect actual
+'
+
 apos="'";
 test_expect_success 'submodule update does not fetch already present commits' '
 	(cd submodule &&
-- 
2.8.0.4.g5639dee.dirty
