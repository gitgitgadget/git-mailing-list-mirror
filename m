From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule sync: Test we can pass individual submodules
Date: Fri, 26 Feb 2016 12:51:52 -0800
Message-ID: <1456519912-10641-3-git-send-email-sbeller@google.com>
References: <1456519912-10641-1-git-send-email-sbeller@google.com>
Cc: jacob.e.keller@intel.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 21:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZPMt-0004Z3-CX
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933602AbcBZUwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:52:01 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34833 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755098AbcBZUv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:51:59 -0500
Received: by mail-pa0-f42.google.com with SMTP id ho8so58117982pac.2
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 12:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sP6WSGpudoZ8Q44UFSDH0YsWUlPvUaPGOe+vD0ESCh8=;
        b=loN3WbwKFmK0Xu07KUd30/B895QFUIFa/RYRdMO2nO4eZ97zCey0OoSyddKK1jFpsj
         e4+6LqTlVl8YqJ3/5KOP+2hlwQeEUm7w+IaRJgJNXY/wa7VJaNP+kenspZTJhs+aLu1i
         qqd2kls5xqxq423ui7hhhKHkMa1rKYBi1EfBR09BvwxuzSKJNiPYI1SKe3uQrzYzaV1t
         sVR5WD+2/VWtQbI0eOBqdomHiEUSsiPzDPizem2SHKkwiqXQBoqCu+1hU9M+ZGD6fOLs
         4tWph618IK1zzfXkObh8F7OH9C2MxtWZ9/u5VZhNOnRzuSOzoiH0YRC1VIALSX2tyyWl
         0nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sP6WSGpudoZ8Q44UFSDH0YsWUlPvUaPGOe+vD0ESCh8=;
        b=ZwQ32kPEVuIVc25hNysSazWpLT2WrZMcHYruqYVr4sZ1XZOzcPmyS6uG84rD+ow+/g
         fk9U/Kcj8HWkT132BXv6kVW0MxqjPq1KPVeOx+5c0x3UC+LcBDJUG5/OJ8fdjeplznWp
         FI7vq0OCgtvzP8vm0nXGuXHim0wKyfaybRUVv4A3gBiJ1kPSgYn5OElSri5IMN57OVnS
         TEwjyXzj+/ypgDSkx1sIw3IrG6Gg3dW7PuFC+zDApj647ePYwmNE3qncc5yWOKmOlwdP
         r1zCnx8G2sCs6Jhc/TxWB01B26LYob/cxJZYUCs6mP7GZfukY1XPrkDVd//6XsJp0XZi
         UcSQ==
X-Gm-Message-State: AD7BkJI5JF19zng7ewIJUVsiRHMfz1T4heETq1HnKGWuneu/M3SWA/XiFYN5ET3oEwtUWqbT
X-Received: by 10.67.7.197 with SMTP id de5mr4927058pad.105.1456519918786;
        Fri, 26 Feb 2016 12:51:58 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a09f:64c6:9d8b:3a18])
        by smtp.gmail.com with ESMTPSA id k65sm21316746pfb.30.2016.02.26.12.51.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 12:51:58 -0800 (PST)
X-Mailer: git-send-email 2.7.2.368.g934fe14
In-Reply-To: <1456519912-10641-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287621>

The parent patch made changes to the way `git submodule--helper list`
is called. From experience this is a sensitive topic and lots subtle things
can go wrong. As all submodule subcommands except `sync` are setup to
run `git submodule--helper list` in the original directory, I suspected
a possible breakage in `sync` not being able to specify an exact submodule
to run in, so let's add a test for that. Instead of adding a complete new
test we can modify an existing test to additionally test the additional
assertion of having just one submodule work fine.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7403-submodule-sync.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..5dde123 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -28,6 +28,9 @@ test_expect_success setup '
 		git submodule add ../submodule submodule &&
 		test_tick &&
 		git commit -m "submodule"
+		git submodule add ../submodule submodule2 &&
+		test_tick &&
+		git commit -m "second submodule"
 	) &&
 	git clone super super-clone &&
 	(
@@ -149,15 +152,16 @@ test_expect_success 'reset submodule URLs' '
 	reset_submodule_urls super-clone
 '
 
-test_expect_success '"git submodule sync" should update submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync" should update specified submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		git pull --no-recurse-submodules &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync >../../output
+		git submodule sync ../submodule >../../output
 	) &&
 	grep "\\.\\./submodule" output &&
+	! grep submodule2 output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
@@ -177,7 +181,7 @@ test_expect_success '"git submodule sync" should update submodule URLs - subdire
 	)
 '
 
-test_expect_success '"git submodule sync --recursive" should update all submodule URLs - subdirectory' '
+test_expect_success '"git submodule sync --recursive" should update all specified submodule URLs - subdirectory' '
 	(
 		cd super-clone &&
 		(
@@ -186,9 +190,10 @@ test_expect_success '"git submodule sync --recursive" should update all submodul
 		) &&
 		mkdir -p sub &&
 		cd sub &&
-		git submodule sync --recursive >../../output
+		git submodule sync --recursive ../submodule >../../output
 	) &&
 	grep "\\.\\./submodule/sub-submodule" output &&
+	! grep submodule2 output &&
 	test -d "$(
 		cd super-clone/submodule &&
 		git config remote.origin.url
-- 
2.7.2.368.g934fe14
