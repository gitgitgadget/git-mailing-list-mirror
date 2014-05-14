From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v7 36/42] refs.c: pack all refs before we start to rename a ref
Date: Wed, 14 May 2014 14:17:10 -0700
Message-ID: <1400102236-30082-37-git-send-email-sahlberg@google.com>
References: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 23:17:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkgYY-0002V2-Ur
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 23:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbaENVRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 17:17:39 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:64251 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753068AbaENVRc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 17:17:32 -0400
Received: by mail-pa0-f73.google.com with SMTP id lj1so37230pab.0
        for <git@vger.kernel.org>; Wed, 14 May 2014 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fg6EN8KeEKesUCj3q21pfLrJa4LSOgnA0YWfQfvwvW0=;
        b=efSQxQLAJr/lScuIX1vxW8h2yTEifv3KHVhF+KwCdK+v59Nw9jSYdlb927NqtvAV0b
         LndEvxCm6ggwXZfGet33VcHeuRRgHcHWr2nr/9c618E5i1KMPhB6L+X3Fa029et2F2en
         Dn+l9Den+KAz0HpA5ITMbuVRjS0BnaFrFeCw6CF+g52qJwtLAY4Vj0RIzWl3ZuDiohAk
         4NX+DKCR8brr1mAJbm2LX336GBM3XzOFWMb67myyphLRRiroWGCqqpEwfrAWcIOHCF3m
         Nm8Gf9M3VsudkJGcaZbxIfeDsJoNwnNVqUayBU6+nEVaz+7KtIJFGesnsCPHRFsa8Rm1
         /Aqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fg6EN8KeEKesUCj3q21pfLrJa4LSOgnA0YWfQfvwvW0=;
        b=Tce2BIVfBFT0g/e24Z8ZFFu8+jtG3ts/kWE00ddaNbXQGwZbCRJNmsU1/RJLOh/66v
         ecAE7eHdLxuGfPfifBAQyT3TrPpyj7rtAQRibZeLlolfWtAEeUCp06WI2gSF6fnYw9Xp
         b1kOWfOpHaZnaTjRQhdsOyFg24ySuTVUtWH8QBVb7Am0tdfmmjgdrdh3606YTb+O4Ptv
         4PKQzMHOZsEQzIDgvbYx0wD9rfD/FMOvl8aeS2DrnzwVRjyS8uoqi94l2ntyKCWbNtVX
         DwFJVbO01zkYxepb8yQ3KTVS1m9Au6BRFlMLEST0WkkbwYNFwa63FbHFikiJddrvT7gC
         ZrEw==
X-Gm-Message-State: ALoCoQkxOq961190kPXnXmFvOIXRsu0eGbQeYLbW43qrm+XqCExpO9kIHGOZEvgME1zo5NtgZDGi
X-Received: by 10.66.148.10 with SMTP id to10mr2940000pab.12.1400102252004;
        Wed, 14 May 2014 14:17:32 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id h18si146347yhj.0.2014.05.14.14.17.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id CCCD95A42DA;
	Wed, 14 May 2014 14:17:31 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id AF562E0CB6; Wed, 14 May 2014 14:17:31 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.471.g2055d11.dirty
In-Reply-To: <1400102236-30082-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248955>

This means that most loose refs will no longer be present after the rename
which triggered a test failure since it assumes the file for an unrelated
ref would still be present after the rename.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c            | 3 +++
 t/t3200-branch.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index cb14420..157a094 100644
--- a/refs.c
+++ b/refs.c
@@ -2596,6 +2596,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldrefname, strerror(errno));
 
+	if (pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE))
+		return error("unable to pack refs");
+
 	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF)) {
 		error("unable to delete old %s", oldrefname);
 		goto rollback;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index ac31b71..fafd38a 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -289,7 +289,7 @@ test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
 	git symbolic-ref refs/heads/master2 &&
-	test_path_is_file .git/refs/heads/master &&
+	test_path_is_missing .git/refs/heads/master &&
 	test_path_is_missing .git/refs/heads/master3
 '
 
-- 
2.0.0.rc3.471.g2055d11.dirty
