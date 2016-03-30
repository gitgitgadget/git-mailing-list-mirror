From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 2/6] submodule update --init: correct path handling in recursive submodules
Date: Tue, 29 Mar 2016 18:27:42 -0700
Message-ID: <1459301266-12403-3-git-send-email-sbeller@google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:28:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4vP-00047S-AD
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758427AbcC3B14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:27:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36314 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753805AbcC3B1y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:54 -0400
Received: by mail-pa0-f43.google.com with SMTP id tt10so27217792pab.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9a2AcNrUe5mql5+SMOOtIfB586zqBCu2OtHcvIMGUKc=;
        b=cLLi840uhgEzxIscnF26mg6zklRLt6r0v3ZGajx4IXqgNaBLaskKg9C8rgmODKPPqK
         6oGfaJeqBbS59sS1BQ8hmWNHRfx3keLCZ3sqvx4dAMP/be2/Lp4pT2HP6h75PcWNtNRb
         FQpbMd9fnqM0FYDjT1hsD6yxrHQ0ccy0ZYohvyPMJd4Vk8KnuUCSPuUHFEh/2OF86ph6
         /0Rry+dlvfTwqrDsUC9qLsuSaNk5EozxyHrfPP64WgZvAnhw+mADGnrsxpqtRFOblNWD
         j9kB2aSjUpT8KsR5SkyCuXn2VUP5DYKfb8XN9zJMxm7pXG2wXN7dJrLkFwi9AtZBxJnb
         goew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9a2AcNrUe5mql5+SMOOtIfB586zqBCu2OtHcvIMGUKc=;
        b=YeS5fzUSiw7SDu/tH47QmIuJmOURQmHUwn7bQvITPvTjVxhZvNAaHvK6Xq2iKQA6Ef
         1d2OWoCdDp36Mep05gO0hf6cL3GN8vPm71i/WaKuMaoEEBrYCPWOyUGaojEV9xE/KlpS
         czy3iaSctHUcw9rqZQilZiagQWIY6yN1U+dVUn/8nRUOOdhdmRlC06L5YXtONxwRn8hS
         7qqf20mRbFqahRTn65Vxqityrb/mgyhq4VjsOxJEjoM02duGUPOR59PIIaMGzeP7/Cpr
         Wz4nsAv/8jR/UGm0d3qXjHfzDZEhXsJ0HHT2D92GTcLqIMc4i7cuqHCK4qzpHAy64gvG
         ffrQ==
X-Gm-Message-State: AD7BkJKlOp67R4Fqnq56m9g12X55ggoNUYJVMMjYwFfHu/eM6XLPvd9JyJO2/WEiJmBDArFK
X-Received: by 10.66.132.37 with SMTP id or5mr8499426pab.144.1459301273619;
        Tue, 29 Mar 2016 18:27:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id g70sm1154129pfj.13.2016.03.29.18.27.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:53 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459301266-12403-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290253>

When calling `git submodule init` from a recursive instance of
`git submodule update --recursive`, the reported path is wrong as it
skips the nested submodules.

The new test demonstrates a failure in the code prior to this patch.
Instead of getting the expected
    Submodule 'submodule' (${pwd}/submodule) registered for path '../super/submodule'
the `super` directory is omitted and you get
    Submodule 'submodule' (${pwd}/submodule) registered for path '../submodule'
instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    * Use `git -C <path>` instead of `cd <path> && git`.
    * Reword commit message

 git-submodule.sh            |  2 +-
 t/t7406-submodule-update.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b3f248c..9fffa5c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -473,7 +473,7 @@ cmd_init()
 		die_if_unmatched "$mode"
 		name=$(git submodule--helper name "$sm_path") || exit
 
-		displaypath=$(relative_path "$sm_path")
+		displaypath=$(relative_path "$prefix$sm_path")
 
 		# Copy url setting when it is not set yet
 		if test -z "$(git config "submodule.$name.url")"
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 68ea31d..d4745f4 100755
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
 
+supersha1=$(git -C super rev-parse HEAD)
+mergingsha1=$(git -C super/merging rev-parse HEAD)
+nonesha1=$(git -C super/none rev-parse HEAD)
+rebasingsha1=$(git -C super/rebasing rev-parse HEAD)
+submodulesha1=$(git -C super/submodule rev-parse HEAD)
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
2.8.0.2.gb331331
