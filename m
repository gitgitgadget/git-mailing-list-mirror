From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] refs.c: enable large transactions
Date: Wed, 21 Jan 2015 15:23:45 -0800
Message-ID: <1421882625-916-7-git-send-email-sbeller@google.com>
References: <1421882625-916-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu,
	peff@peff.net, loic@dachary.org
X-From: git-owner@vger.kernel.org Thu Jan 22 00:24:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE4d8-0000Vt-Sk
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 00:24:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbbAUXYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 18:24:05 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39443 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbbAUXXy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 18:23:54 -0500
Received: by mail-ie0-f179.google.com with SMTP id x19so10908694ier.10
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 15:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vYcCQSYS4XJPox+XmUNsm+LR3C8A/ex9n/GcbnqNw7A=;
        b=nDq0TGNl/XAWKyHgIZN/aKOFXfcdMKVU32TRrDupcHoaZ645HG+xISVbLGjpggcPEC
         OCRQ+usYaUk6kub3bZDcMaCnhY8G3x/q5jhIgSMDtz7HcQcvIZVSkNnVFBp/H3RxFWxV
         DBZdMAVAlhm+1D+R0mS2xVq8VbZspt/HORD12i5Bcno3JOVjtvHnB7K2XU08622agr6U
         HedkfBl8QWgp6GZAfXtMc8l9TCeKyY7gw2FQd1qd+NBL+U/3dH7t92Q6tOy+/Cuyj9Ej
         29rAOAfokbfrZ4qchCC4dPbSHqA/UStJMAufiIpcmOoKAXADl81hiNZDa0vYtJUf/4TM
         +iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vYcCQSYS4XJPox+XmUNsm+LR3C8A/ex9n/GcbnqNw7A=;
        b=GIt99CDxNuWiqwIAaRNKS4kQpwmVYPfsg4+p63oAE0l0SYojpT+c1aHbjBVO8AKBY5
         bPNx3oIFbjwMAap55WO2wF9IomfhFES2/43DTZCc03xHBwmlJdczrva59I9f9IZvT411
         UA5VsQYk7GS9x+xMADtn/Y5bGcPo2qWrVgVgVcxUYEf/mziI1oMy1n81UZMYLu9oV2qk
         L01I1lChjTVP1TT+tFCCmZrlf0VkaW2+U6Fz/qFdRk/FlXAwfu+wwfOZ1W9LcF7jBY2V
         BF7a4/53bKrlj6jmNRFy7FsT/Epm/CsdEHpHd5MZNa0WdGrZYI750xTCN0mqvlWBHzpU
         P6pw==
X-Gm-Message-State: ALoCoQnEJOZOdMJEm850hyHt2a56Kzw88Hc6eAnf9GK3rrJBE6iB2Xs+j3npOTna110ooIkua3xP
X-Received: by 10.43.154.138 with SMTP id le10mr36082352icc.50.1421882634219;
        Wed, 21 Jan 2015 15:23:54 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a4e7:f2b3:5669:74a3])
        by mx.google.com with ESMTPSA id kt1sm662763igb.20.2015.01.21.15.23.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Jan 2015 15:23:53 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421882625-916-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262782>

By closing the file descriptors after creating the lock file we are not
limiting the size of the transaction by the number of available file
descriptors.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c                | 14 +++++++++++++-
 t/t1400-update-ref.sh |  4 ++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 0161667..014ef59 100644
--- a/refs.c
+++ b/refs.c
@@ -3068,7 +3068,17 @@ static ssize_t write_in_full_to_lockfile(struct lock_file *lock,
 					 const void *buf,
 					 size_t count)
 {
-	return write_in_full(lock->fd, buf, count);
+	if (lock->fd == -1) {
+		int ret;
+		if (reopen_lock_file(lock) < 0)
+			return -1;
+		ret = write_in_full(lock->fd, buf, count);
+		if (close_lock_file(lock) < 0)
+			return -1;
+		return ret;
+	} else {
+		return write_in_full(lock->fd, buf, count);
+	}
 }
 
 /*
@@ -3797,6 +3807,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 				    update->refname);
 			goto cleanup;
 		}
+		/* Do not keep all lock files open at the same time. */
+		close_lock_file(update->lock->lk);
 	}
 
 	/* Perform updates first so live commits remain referenced */
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index ea98b9b..751b6dc 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1071,7 +1071,7 @@ run_with_limited_open_files () {
 
 test_lazy_prereq ULIMIT 'run_with_limited_open_files true'
 
-test_expect_failure ULIMIT 'large transaction creating branches does not burst open file limit' '
+test_expect_success ULIMIT 'large transaction creating branches does not burst open file limit' '
 (
 	for i in $(seq 33)
 	do
@@ -1082,7 +1082,7 @@ test_expect_failure ULIMIT 'large transaction creating branches does not burst o
 )
 '
 
-test_expect_failure ULIMIT 'large transaction deleting branches does not burst open file limit' '
+test_expect_success ULIMIT 'large transaction deleting branches does not burst open file limit' '
 (
 	for i in $(seq 33)
 	do
-- 
2.2.1.62.g3f15098
