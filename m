From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/6] submodule update: align reporting path for custom command execution
Date: Tue, 29 Mar 2016 16:02:36 -0700
Message-ID: <1459292558-5840-5-git-send-email-sbeller@google.com>
References: <1459292558-5840-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 01:03:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al2f5-0000Wh-Kl
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 01:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758220AbcC2XCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 19:02:51 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34623 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbcC2XCu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 19:02:50 -0400
Received: by mail-pf0-f181.google.com with SMTP id x3so26185006pfb.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 16:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Du/arZ1AszlVu29sRlIAvlGLnu3DQGqCJIsKs8693Dk=;
        b=IRSBhbxs8AsAFvpaeKLxoDDoQRJ3O1fX0AqpHBMsuKpHPNC6HuYmBYVSQORty2mkDS
         /NjogU1//1VD9GstmbL4DnngGL5WPMFsoghoEcxSET+YGBi3ILuTgGN9982F0DVX6Czw
         v6LkZBofqFav6pByQJKPvHL3s2wlp+Oq4z/0Y+EGMZ80DMctSuO6m4j0cOPMMqJUZil0
         Y3mqxEzCgY6eIp1L0Mu3vKrKfNDatXiVpx8KCOIYZznf0VPhQLe5RUEqPIA31fq5707K
         KGLfdFgQJDfOR+pRAJP7EH+kP6bTJykQQBxjH8GArnktGC4cgT0gbEVATP7Ci87eR37+
         MuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Du/arZ1AszlVu29sRlIAvlGLnu3DQGqCJIsKs8693Dk=;
        b=KW1yAjj+N6EqgR/AMs1vNiEczWg81G73ju8AmY6wojv/Mdaet0wEvkoZ5xuNGNJSmy
         VwpJev7wQNa1q/3G2O1fr5qs+6vmcYAEMfas79BW9QmmBzFb0MkkvppQbCjAItlrHSa3
         rQHwr+G3jJkKKPRRU307Y+6i0E99x2YcNi0YVZcfsNp+G5DKBC5Ov79qYqes4CrI1yIr
         PMFXgh1wDiel0Rk4lszyFyidTinP3YOhS1yZTplb+suMltDnfB5Gaf2InLdMbRqkrLY/
         bKB4RD/Mhjv1rjSle2tSVDiYObaK4GrTZySEaQz+awnc4MpfLLdhzHCr0AgEWmNmYLiI
         J1Hw==
X-Gm-Message-State: AD7BkJIXC8g5X8X5jjfTjLdBymUR69kne6iWkcVmrgAqm9nLqYSNVmss982BREdEaP+SCV64
X-Received: by 10.98.80.70 with SMTP id e67mr7672752pfb.136.1459292569628;
        Tue, 29 Mar 2016 16:02:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id q4sm723777pfi.94.2016.03.29.16.02.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 16:02:49 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g3d0b0ba
In-Reply-To: <1459292558-5840-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290217>

In the predefined actions (merge, rebase, none, checkout), we use
the display path, which is relative to the current working directory.
Also use the display path when running a custom command.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  4 ++--
 t/t7406-submodule-update.sh | 29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 11ed32a..be2a2b5 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -803,8 +803,8 @@ Maybe you want to use 'update --init'?")"
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
index 9a4ba41..f062065 100755
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
2.8.0.6.g3d0b0ba
