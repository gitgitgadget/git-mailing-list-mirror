From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 17/27] refs: on symref reflog expire, lock symref not referrent
Date: Thu, 18 Feb 2016 00:17:40 -0500
Message-ID: <1455772670-21142-18-git-send-email-dturner@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Feb 18 06:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWGzS-0001Pz-6X
	for gcvg-git-2@plane.gmane.org; Thu, 18 Feb 2016 06:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424925AbcBRFSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 00:18:54 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:36320 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424911AbcBRFSv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 00:18:51 -0500
Received: by mail-qg0-f50.google.com with SMTP id y9so29819064qgd.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 21:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vxty+WfwiUJLFw4mI4FAUAyuQSPzeUJIpCR/ErLoxzY=;
        b=pbD4SKpnbm1mbmMMepIGRJOB8/gJ1RHdmy+XyKuqJCrISmTKuyc4gYvHDKLjRqxy1b
         SFs3n158S8uBjYL1X+M3tX3Y01fxvM0ZAHeKh2wRNK8gJGLBuIbjjcBt/+Hp34jvTNbc
         tc0WAMd66Hu2ffUrGseBdKVMF1tB27G00m6t+iKbOO8HMjAyvr5Sp+NCGMETZjy4W1dx
         P+TUCOLndNWkBK7R4kO+d++AOZCk9H2l97fiUqlp0/hwd3tjIq7oIrlyJcNcmo0Dz5Xr
         BCSVgpf2CZ0NAOtNcE0FeCID+Fx4DALbugM9ORmWvvkrioHzqwHeeRKGrDZJAILt6RUT
         2pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vxty+WfwiUJLFw4mI4FAUAyuQSPzeUJIpCR/ErLoxzY=;
        b=DM3OOq/caq9nenL7eI5/M1Rpy9LtSzoVTZJPsvASBqq5RcJu2vJysXZwUjZSfDdvpd
         S1BWRlgshd3Vh0NPb47ghqZFCb17sCI47LdMxpL/W7KAY3gI49F53nLM2Pr/kzqXsUm2
         jalwykMLzNBOrE3vdhzk+ujZrY73BkjcSNB13xtnEds7Yc6623VqN9f1DtRwtpGa4Pxa
         u3LobjT06VYW8Y0zEWZJ2f4N/n9knDmOb+U+ysKGsEsVc703swRQOn2yEtMS3aGcQ1jW
         9GWxsomjpN7bGqZfD+d9VDMlHISmLZKUITD5tathHeSqAZptznoEAuaoyMrYV9vayw0p
         wInw==
X-Gm-Message-State: AG10YORgV5TE0GWWXQdf3CHiswx+9GunNNrUcAQJXaLivNnSZGGnFkwP5DkW/+lzEWnBow==
X-Received: by 10.141.28.149 with SMTP id f143mr7036441qhe.66.1455772730424;
        Wed, 17 Feb 2016 21:18:50 -0800 (PST)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id q22sm1965322qkl.19.2016.02.17.21.18.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 21:18:49 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286583>

When locking a symbolic ref to expire a reflog, lock the symbolic
ref (using REF_NODEREF) instead of its referent.

Add a test for this.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 refs/files-backend.c |  3 ++-
 t/t1410-reflog.sh    | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4863b21..42f2d5b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3365,7 +3365,8 @@ static int files_reflog_expire(const char *refname, const unsigned char *sha1,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, 0, &type, &err);
+	lock = lock_ref_sha1_basic(refname, sha1, NULL, NULL, REF_NODEREF,
+				   &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index c623824..9cf91dc 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -338,4 +338,14 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
+test_expect_success 'reflog expire operates on symref not referrent' '
+	git branch -l the_symref &&
+	git branch -l referrent &&
+	git update-ref referrent HEAD &&
+	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
+	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
+	touch .git/refs/heads/referrent.lock &&
+	git reflog expire --expire=all the_symref
+'
+
 test_done
-- 
2.4.2.767.g62658d5-twtrsrc
