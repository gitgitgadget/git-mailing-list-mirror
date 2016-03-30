From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/6] submodule update: align reporting path for custom command execution
Date: Tue, 29 Mar 2016 18:27:44 -0700
Message-ID: <1459301266-12403-5-git-send-email-sbeller@google.com>
References: <1459301266-12403-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, jacob.keller@gmail.com,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Mar 30 03:28:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al4vW-0004Ah-3D
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 03:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbcC3B16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 21:27:58 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36351 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbcC3B14 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 21:27:56 -0400
Received: by mail-pf0-f177.google.com with SMTP id e128so7293150pfe.3
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhf0l69DoC8LkR2iEbokdZLVgvc5wnCKtCqyJqTlOKU=;
        b=ZqzRnOC6yTHWgphxzYtwX8aWTOTZsnhSp/MoTypc2gnuOkhxAUUdxU1jdUcJFTQqZm
         6yhSc+SO5GiVNFWZgYaa6tS+gJxcYOBv1DoeyDVDIWQEV2M9VYfjUGQ0pK3aVpLuDiea
         WffSojcvivNFffeJmQ8WEIOmPNdOQU++/CQITgmG8YdX/yhQVjTmbS6/hEZseGKWv9C/
         3Hd6dHtWNTrQrKY81tJquPLO7vDIMFngpMjr15PkT6BVAG6c46INE4zP74oqettrktRM
         LYXo2xPQhn6ehqw/XkgXcNNytk7cLNdAvEB0TbsRIwbUcsw54pzNcg0CNIPQEG9QPF74
         ZdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhf0l69DoC8LkR2iEbokdZLVgvc5wnCKtCqyJqTlOKU=;
        b=B90856XA6HzVUIsQoSszGJQd04MBuYpmjjQibgnKtUuGcZIAQ5iZWWu8U4F650Dznp
         7ZnmAi/ZH+CG0ooM3oPwxbkokDuRikv4iMul1wxqwFm8MVCOMNu+pxjAZYy9FwzZ5Fxk
         z7ujGBCRMyYycUzxW0+V6fXluRhJpRJVpQbeO7balMFESIte3A9Czzx+57FgWha7nBTS
         wzNKopcA0O9UpDA+79VPq38NSDEEGU0I1eRssLFBSSnVrp1N0POQ4Z+4GJdJCQ8JhDCm
         ly67bKVmQ45OUfHfeO+tdN7866CeoHbKjGTU8Ic537leIuCgrhzsXQtuK/Q9zI5JSNPR
         1iHw==
X-Gm-Message-State: AD7BkJKqfkEWxqpyJur4pUxfsfh59680nQJ1UYd6wBSaS0RqWNpH9KNe5sVULKsJo6VR41ey
X-Received: by 10.98.75.157 with SMTP id d29mr8478935pfj.33.1459301276084;
        Tue, 29 Mar 2016 18:27:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:9cc5:9f4:3ffe:cd1])
        by smtp.gmail.com with ESMTPSA id 27sm1122706pfo.58.2016.03.29.18.27.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 18:27:55 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.2.gb331331
In-Reply-To: <1459301266-12403-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290254>

In the predefined actions (merge, rebase, none, checkout), we use
the display path, which is relative to the current working directory.
Also use the display path when running a custom command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  4 ++--
 t/t7406-submodule-update.sh | 29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1024774..753a90d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -802,8 +802,8 @@ Maybe you want to use 'update --init'?")"
 				;;
 			!*)
 				command="${update_module#!}"
-				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$prefix\$sm_path'")"
-				say_msg="$(eval_gettext "Submodule path '\$prefix\$sm_path': '\$command \$sha1'")"
+				die_msg="$(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
+				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
 				must_die_on_failure=yes
 				;;
 			*)
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index d4745f4..01dd324 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -344,16 +344,39 @@ test_expect_success 'submodule update - command in .git/config' '
 	)
 '
 
+cat << EOF >expect
+Execution of 'false $submodulesha1' failed in submodule path 'submodule'
+EOF
+
 test_expect_success 'submodule update - command in .git/config catches failure' '
 	(cd super &&
 	 git config submodule.submodule.update "!false"
 	) &&
 	(cd super/submodule &&
-	  git reset --hard HEAD^
+	  git reset --hard $submodulesha1^
 	) &&
 	(cd super &&
-	 test_must_fail git submodule update submodule
-	)
+	 test_must_fail git submodule update submodule 2>../actual
+	) &&
+	test_cmp actual expect
+'
+
+cat << EOF >expect
+Execution of 'false $submodulesha1' failed in submodule path '../submodule'
+EOF
+
+test_expect_success 'submodule update - command in .git/config catches failure -- subdirectory' '
+	(cd super &&
+	 git config submodule.submodule.update "!false"
+	) &&
+	(cd super/submodule &&
+	  git reset --hard $submodulesha1^
+	) &&
+	(cd super &&
+	 mkdir tmp && cd tmp &&
+	 test_must_fail git submodule update ../submodule 2>../../actual
+	) &&
+	test_cmp actual expect
 '
 
 test_expect_success 'submodule init does not copy command into .git/config' '
-- 
2.8.0.2.gb331331
