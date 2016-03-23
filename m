From: Stanislav Kolotinskiy <stanislav@assembla.com>
Subject: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Wed, 23 Mar 2016 18:24:22 +0200
Message-ID: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
Cc: Stanislav Kolotinskiy <stanislav@assembla.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 17:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ailaR-0004fW-Vh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 17:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbcCWQYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 12:24:44 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33944 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbcCWQYn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 12:24:43 -0400
Received: by mail-wm0-f45.google.com with SMTP id p65so240828655wmp.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 09:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=assembla-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EIQIVEuN4YpfhER8o5V5zOcK1UIOCXbzmdXZqth/0vM=;
        b=NxCKa3jBZvWR0CmZaNjwI9MkAa/ZLiNa3aL0xjnyINzhntFqI6jR0QYgGGHErlLCm+
         QcwZSHFvAQwCyATjxSAPWB/qzyj1AvbqN/12RQD3OsGel6Nv3WZiKgmcWD2kbdgEW4ny
         OTm+TGinvQ0bgkdE+TkDmgthAJcFnP/SfRL97ZedUJ37kxgyZXiiZ3e+8XAvlt1zkJfS
         mTBkgNL6IATiqHpEu2n0pPUAwdUt8QXdBfFThLuC7v/BJc+0zrpqfVAP1OM00zFYfRNj
         xsw48SALa3gvmGzY5GmxplRXsuU4om90UuR5NVSsvSVGr3oelKUc+KeSlEN6vRDOOQbK
         V1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EIQIVEuN4YpfhER8o5V5zOcK1UIOCXbzmdXZqth/0vM=;
        b=SGWhMW/1e9Q0oYHsmIPKS1wyYA2kJoyVHSQV/1LezL/1BggJO8aAbfhR068K7GFZa8
         2WCS7EVz/vQEKwvEWbfLklHZ1hZpSJthqiwUBKS6xdbMiFNgyRL+dvMnbBZOewQ2Hah1
         lWCnnEdsSA1d7WX/3OMahaROcU4z3UHiSvKbv2NOgZj9FnDjrtfzaL1GsnAMm+tV1bPR
         aDBlljUpNBRsDksvQwD9G3ud8qczujbJemSppudARiqCJ3o6bXSzG9Byff+FN5LLwJwm
         z9PVx41F8tG0wUshRPgJgxkgX0wpnTpad7+wLA1Ad3sfQpuk+aWDhQm98wZG/TA0pQVB
         eXZg==
X-Gm-Message-State: AD7BkJKtivQEfJ8r5JnmwFLKDSThb+nIUTvh3dsyegagISp67rQ6K6KpCAl1h3PsRCuk2g==
X-Received: by 10.194.184.234 with SMTP id ex10mr4207528wjc.8.1458750281905;
        Wed, 23 Mar 2016 09:24:41 -0700 (PDT)
Received: from localhost.localdomain ([217.26.172.139])
        by smtp.gmail.com with ESMTPSA id t82sm3668615wmt.17.2016.03.23.09.24.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 09:24:40 -0700 (PDT)
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289665>

When using git send-pack with --all option
and a target directory, usage message is being
displayed instead of performing the actual transmission.

The reason for this issue is that refspecs variable is being
calculated in a different way comparing to previous versions,
and even though the number of refspecs (nr_refspecs) is 0,
refspecs contain all the arguments and switches passed to send-pack.

This ensures that send-pack will stop execution only when --all
or --mirror switch is used in conjunction with any refs passed.

Signed-off-by: Stanislav Kolotinskiy <stanislav@assembla.com>
---
 builtin/send-pack.c      |  2 +-
 t/t9904-send-pack-all.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100755 t/t9904-send-pack-all.sh

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f6e5d64..19f0577 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -225,7 +225,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	 * --all and --mirror are incompatible; neither makes sense
 	 * with any refspecs.
 	 */
-	if ((refspecs && (send_all || args.send_mirror)) ||
+	if ((nr_refspecs > 0 && (send_all || args.send_mirror)) ||
 	    (send_all && args.send_mirror))
 		usage_with_options(send_pack_usage, options);
 
diff --git a/t/t9904-send-pack-all.sh b/t/t9904-send-pack-all.sh
new file mode 100755
index 0000000..f68d004
--- /dev/null
+++ b/t/t9904-send-pack-all.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='Make sure that send-pack --all copies all refs'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	git init --bare bare_repo && git init repo && (
+		cd repo &&
+
+		git remote add origin ../bare_repo &&
+		date >file1 && git add file1 && test_tick &&
+		git commit -m Initial &&
+		git push origin master &&
+
+		git checkout -b other && date >file2 &&
+		git add file2 && test_tick &&
+		git commit -m Other &&
+		git push origin other
+	) && git init another && (
+		cd another &&
+
+		git config receive.denyCurrentBranch ignore
+	)
+'
+
+test_expect_success 'send-pack --all should copy all refs' '
+	cd bare_repo && git send-pack --all ../another
+'
+
+test_done
-- 
2.7.4
