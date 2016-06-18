Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CA620189
	for <e@80x24.org>; Sat, 18 Jun 2016 19:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbcFRTh2 (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 15:37:28 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33611 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949AbcFRTh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 15:37:27 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so8025329pac.0
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 12:37:27 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ceN/ccvcBEkxfdYkH73mjXZvD14JhWrOTFVWWVFfmVM=;
        b=nJWrFmVYnROIZTYW5wbAxqryRS13mH9n/AkXy4FwShT0U2fJEHiIO3vZxJHAMLfU7W
         mLfL53zWRWLfOTtfEwjVQXT2bn5Fiafir9f5m2uOjUVnoqLt6Nk7DB6uZy3gKC1oIppC
         3+3EE3fWI3cdlf/dITSrh6MXEKfK0WXimkjz+IVkqWvJ4dWDJObUgBEv+h8MShpErkCe
         1wpdCO+TF7H2gi3gnodfVDMtjC37z+nDlhfm6NFm0GNvw0kd0Sb7leB7c1kdXHemAjV+
         3JMFjlouNWvAqLdGjBE5KTAhu0VmQG1PXflCi55sc4uRl2rvWatVr6ikvEVFJeKA2t4b
         jtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ceN/ccvcBEkxfdYkH73mjXZvD14JhWrOTFVWWVFfmVM=;
        b=MUkJCpjTeBGUi0oFESY3wZ3BkYSsOPRR5J4NVmgtvNXl94b7SpD469JvinBsY60J7b
         YAg53jq+yS+ikOpOTRUkdRD0eAuEw79VrBPFaE9bsamiYpTHzJBzEbIdDDnRiYxpF85n
         4W7aFkH3P3NoiQ/pQBysDy5x9X8aOjgSApi90A4d7Dwbv9KVvmyFqg0IkRtRbieksDRj
         Gh7+pTaGGS2J53aM1AHUVCo5iS/y7aU/a7xPRsh/qc5SDOxXl7HdANG4DV8mjQxwBNvR
         EKFRBq/SzGt/pKOaVSV5dGnOoFcMMTxtsztXvoB0WwnDRsGeZFrPpP829gzQkUbAM8aC
         Ku6Q==
X-Gm-Message-State: ALyK8tKew94k3QUz36EuFPkyiGPzLrqrBIv3oecKBQzsbzG4thdZalBA0NPcP2tN78wtAg==
X-Received: by 10.66.160.41 with SMTP id xh9mr10674685pab.85.1466278646959;
        Sat, 18 Jun 2016 12:37:26 -0700 (PDT)
Received: from localhost.localdomain ([113.23.115.12])
        by smtp.gmail.com with ESMTPSA id yp4sm43210922pab.48.2016.06.18.12.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jun 2016 12:37:26 -0700 (PDT)
From:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
To:	git@vger.kernel.org
Cc:	LE Manh Cuong <cuong.manhle.vn@gmail.com>
Subject: [PATCH] git-sh-setup.sh: fix missing double quotes variables
Date:	Sun, 19 Jun 2016 02:37:10 +0700
Message-Id: <20160618193710.32265-1-cuong.manhle.vn@gmail.com>
X-Mailer: git-send-email 2.9.0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Leaving shell variables un-quotes can lead to security vulnerabilities. In:

    : ${x=.}

`$x` is always expanded, cause `glob+split` on its result. There're some
globs is too expensive to expand, like:

    x='/*/*/*/*/../../../../*/*/*/*/../../../../*/*/*/*' sh -c ':
    ${x=.}'

Run it and our machine will hang/crash (especially in Linux).

`LESS`, `LV` and `GIT_OBJECT_DIRECTORY` variables in `git-sh-setup` are
vulnerable with this case.

Fix this vulnerability  by quoting those variables.

Signed-off-by: LE Manh Cuong <cuong.manhle.vn@gmail.com>
---
 git-sh-setup.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index c48139a..85db5f1 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -160,8 +160,8 @@ git_pager() {
 	else
 		GIT_PAGER=cat
 	fi
-	: ${LESS=-FRX}
-	: ${LV=-c}
+	: "${LESS=-FRX}"
+	: "${LV=-c}"
 	export LESS LV
 
 	eval "$GIT_PAGER" '"$@"'
@@ -344,7 +344,7 @@ git_dir_init () {
 		echo >&2 "Unable to determine absolute path of git directory"
 		exit 1
 	}
-	: ${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}
+	: "${GIT_OBJECT_DIRECTORY="$(git rev-parse --git-path objects)"}"
 }
 
 if test -z "$NONGIT_OK"
-- 
2.9.0

