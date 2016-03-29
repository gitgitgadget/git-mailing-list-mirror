From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/6] submodule update --init: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 16:02:34 -0700
Message-ID: <1459292558-5840-3-git-send-email-sbeller@google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:02:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2ez-0000Sj-CE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbcC2XCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:02:50 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34585 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcC2XCs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:48 -0400
Received: by mail-pf0-f180.google.com with SMTP id x3so26184212pfb.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xhRx08zZxrLTqte7IKa2iu62t7JNf2aiaxTV1proLCY=;
        b=b1AmvaAdSXzk7h1LIC4dhzLKlbbcmaFyevqbDSH/HqIVsCPw+LJrCRV5ZrDXw+7osc
         CD8fxW24Zx/PZJ71/OJyI4weT+v9OHZpAb12YAhzr9DqGQtPDxd4YEiPMCmOp+UooLkB
         j8BV8h+bm/iLzZZRXxeMQ47Ln/0GZ5YoOpAyeHjriXJQ1HpmgoJupLfoIrmHmLmRk8EX
         Jnx+TRfkNWCbCjQBL2mm3IiE0LluoFNoE51IsTsA2S4rXYZfsPsYeUtunIZbCeFCAtZR
         /l/W6wrkF+AvZQnO1Pldp4am8i0eJOthH78N3XWQzGrcdZBry7urb1550JQwpNKNuUzI
         JHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xhRx08zZxrLTqte7IKa2iu62t7JNf2aiaxTV1proLCY=;
        b=DedHmJjNPyKEo/J8wFtHP7rQdgY6tN3jxRhXp0VpJpCA1INIDuly+1N18TbuwDfLQX
         zcx+5h8PKGx1miRTjKkQpzObSz5mzPsT6//AnLwD8RxkMCZiMDpjbou6cLyXddGH+y8u
         x5L9ICaXy7gmItHopXjHW0aHkg0ma1zYWTjcRMt39Tt27ld/3TlSkacQxdVMQZKV0wP9
         8XX5hPTj7NVhdKgS8MnEtos/EBBNdNs+Hv2WFQnYgF+socDcsKkDo0F66kgMau8DD4+X
         vLYUQl+YVgeeMzG5Z0bAtW88FDyxCl7I4eFODpFS9bhGsxU9jZMHNroyqxB6RHEPyAsB
         ocig==
X-Gm-Message-State: AD7BkJJDaOjqidMO9J/m+9xtFUq+VQ2kS41vPO1dTgCPO92lYmB+BpIOqxBZOB+TIBXmRF+4
X-Received: by 10.98.33.208 with SMTP id o77mr7718511pfj.108.1459292567068;
        Tue, 29 Mar 2016 16:02:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id s197sm746106pfs.62.2016.03.29.16.02.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:46 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
In-Reply-To: <1459292558-5840-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290214>

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
2.8.0.6.g3d0b0ba
