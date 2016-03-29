From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 5/6] submodule update: align reporting path for custom command execution
Date: Tue, 29 Mar 2016 15:23:47 -0700
Message-ID: <1459290228-9069-6-git-send-email-sbeller@google.com>
References: <1459290228-9069-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jacob.keller@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 30 00:24:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al23e-0002PT-Oe
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 00:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758194AbcC2WYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 18:24:10 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35475 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757685AbcC2WYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 18:24:01 -0400
Received: by mail-pf0-f174.google.com with SMTP id n5so25456397pfn.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4p15Lw3UVfKlIsa5vDPD9iJRih+dsYB2yFm3/Y6Wk+s=;
        b=Uu80unpEJtp6IavvtBlZKBMMB6dRLLQ2mnYTKrWFuZg2PrTUDXU8+ALYzX5HDA2PzU
         tWYDmMdplpxACaqKLUQs6x/9zqdJkB0fHrnNoBERbh/Ix+x8usLQ879si/H9q2AXLPYF
         DL5GZwDiBUydgOGZ2tig2+JR/MizD6bhxb/Ee+Ia/nBrHtJeYjddILLrgxCbJ2hVrW4f
         xJq2KsB/ZbJ7nAwj6kqvzmOiWI4i5K3YHVbChGBBKLYqfYuCVnZoG5BqSoUcM3ISfClR
         xqa+01s9rYCoIlwrfBq0lV3HDObxyPogYcJ/Nv3+YjzL8JRywlKUm17Zt/LFTqHX76Dz
         pdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4p15Lw3UVfKlIsa5vDPD9iJRih+dsYB2yFm3/Y6Wk+s=;
        b=Rai4O3yrnl2iMVxafb1iIlUh9MtvH3T0lH2OiTYyt0MDkO8Xe/aLTrANIYy8zXT8uo
         mm0562q2oCVEQloTOSDpPhctGcTYIICxY1kGivMl1pv8U06gFgJ1DQir4lgDj29D16UH
         zX2qcsDaO5GT0yGZXMW73aDtasvZNluTV0t1yFLhj1aH4B1YZXHDCa9PjMKw/84skDif
         sFtiQEivrpnLMouX/6oR9afOswDxBprL/ZSAYn6B827z3/F0iTjV9seRecCiguedaYGU
         GTGcR9SsAASdi/8piLVYGVaU6gfMXf57xPHVlZA1zzrvLVPZEpKYx1yiwYEQQ6PNxbex
         thtg==
X-Gm-Message-State: AD7BkJIgTd3oxJUTQ+YG81VSCxdo6vZ7xjSzXdsqgep8pQqWAmtNDBUdsUFY1BGiQnk1Ttvj
X-Received: by 10.98.71.210 with SMTP id p79mr7383085pfi.4.1459290240278;
        Tue, 29 Mar 2016 15:24:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:3dd0:2ad7:f302:a06])
        by smtp.gmail.com with ESMTPSA id d19sm626798pfj.92.2016.03.29.15.23.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 15:23:59 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.4.g5639dee.dirty
In-Reply-To: <1459290228-9069-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290210>

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
2.8.0.4.g5639dee.dirty
