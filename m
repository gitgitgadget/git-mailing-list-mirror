From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH v2] branch: die when setting branch as own upstream
Date: Sat,  1 Mar 2014 21:19:16 +0900
Message-ID: <1393676356-67203-1-git-send-email-modocache@gmail.com>
References: <vpqa9db1e0l.fsf@anie.imag.fr>
Cc: modocache <modocache@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:19:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJitN-00012S-4O
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbaCAMTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 07:19:15 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33793 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaCAMTO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:19:14 -0500
Received: by mail-pa0-f52.google.com with SMTP id rd3so377078pab.39
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IwdKVowaDW9NfOT/xvRNTqjjpndHAs3MYp3QPQ9BNNU=;
        b=T6Q4lGws0Vin/8z1sl38kyLf2E4VqdUK8V5XkPl1ZWmx+1/nb8wnL4VmSO3SF2Ux3M
         m//LVYgVaf2IfOC3IwzgywsEAgYOEEzLnfy9RcYj7vO32Ai712sUXbOsaTjWyOTnwmM3
         HDuDcAgf/7ccvPZcm8PGI67psrcjNLl3yydd95Ttu6ghAGZEI2bzs2WUHQZpM+dtHSQr
         VKLGjFUmmEC786SyxW9pchuykuwcZ4/qbXO+7yAdIDnicAf0WdqK2vvesaQKziR4Yogw
         vwbJhRI9XO4OJaNs9DdNLfWnbQTO9m4Xhfa+OdpJBMi77fdjq5BxmaLctrLVlC3KVayY
         aAhA==
X-Received: by 10.66.197.135 with SMTP id iu7mr241870pac.149.1393676353989;
        Sat, 01 Mar 2014 04:19:13 -0800 (PST)
Received: from localhost.localdomain (p1157-ipbf5204marunouchi.tokyo.ocn.ne.jp. [118.8.132.157])
        by mx.google.com with ESMTPSA id op3sm15855602pbc.40.2014.03.01.04.19.12
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 04:19:13 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
In-Reply-To: <vpqa9db1e0l.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243064>

From: modocache <modocache@gmail.com>

Branch set as own upstream using one of the following commands returns
immediately with an exit code of 0:

- `git branch --set-upstream-to foo refs/heads/foo`
- `git branch --force --track foo foo`

Since neither of these actions currently set the upstream, an exit code
of 0 is misleading. Instead, exit with a status code indicating failure
by using the die function.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 branch.c          | 9 ++-------
 t/t3200-branch.sh | 6 +++---
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/branch.c b/branch.c
index e163f3c..9bac8b5 100644
--- a/branch.c
+++ b/branch.c
@@ -54,13 +54,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-	if (shortname
-	    && !strcmp(local, shortname)
-	    && !origin) {
-		warning(_("Not setting branch %s as its own upstream."),
-			local);
-		return;
-	}
+	if (shortname && !strcmp(local, shortname) && !origin)
+		die(_("Not setting branch %s as its own upstream."), local);
 
 	strbuf_addf(&key, "branch.%s.remote", local);
 	git_config_set(key.buf, origin ? origin : ".");
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6164126..3ac493f 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -507,10 +507,10 @@ EOF
 	test_cmp expected actual
 '
 
-test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
-	git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
+test_expect_success '--set-upstream-to fails if used to set branch as own upstream' '
+	test_must_fail git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
 	cat >expected <<EOF &&
-warning: Not setting branch my13 as its own upstream.
+fatal: Not setting branch my13 as its own upstream.
 EOF
 	test_i18ncmp expected actual
 '
-- 
1.8.3.4 (Apple Git-47)
