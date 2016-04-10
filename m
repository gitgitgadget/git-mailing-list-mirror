From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 5/6] Add a testcase demonstrating a bug with trivial merges
Date: Sat,  9 Apr 2016 23:13:39 -0700
Message-ID: <1460268820-8308-6-git-send-email-newren@gmail.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 08:14:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ap8dL-00049x-Jl
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 08:14:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbcDJGOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 02:14:01 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35551 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcDJGNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 02:13:54 -0400
Received: by mail-pa0-f66.google.com with SMTP id zy2so12010360pac.2
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 23:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t4WfjBSE08cLOOpdbym3VFOC/F9D2FlLQnUdSs8n3/A=;
        b=ztf5YBTMLZPOJTBxfU8pMdkOmRfzlu3SVM1dT/KvFeUdRBdTHHGy4uCw8DjBPurkie
         BnPKuM09jVA74EKApXQRWCsWwWcsFE/V/PK9KU2zouoMdssupIGXj7XkpT8tbZyzkQEo
         snQKi+fTRkVxJ29Dvu+1sqx4RuYRN89njfLOCL86iC++vY4UKC3KpWWuu0qHNO3JflMZ
         Q/neUaES9yLa1d79mcFJDzoGMJ41qbJqRzyOxdmYhkrwGBN46TrKbt+ZT1ca2URYfMa3
         YnE/glEZnLNzJLDzHr7Q4aooNQn2Yyy/iTcAD9d67nf/Ca7okx6HBDlERqUeM5IOweXW
         NJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t4WfjBSE08cLOOpdbym3VFOC/F9D2FlLQnUdSs8n3/A=;
        b=ZYzEH2VdJMaqdfa69BRPq0FEsQH+zYGxqZW32Is0vnW9+KRmGaBc6NiAOlBsLD+TPw
         CU1ap8ffnF7KoYsaBfsd0rrioCTgt1cHsoiFE3xbOmol3CfaRCzz4lzMT5yQs3JNMrje
         HeiJSc8gNWgypR+9oAmanFPCI1pqmnxwfRwS6VD3c6YNzVHhiZeMP1FBvlkZ6rKx/3ZH
         hh6zAw+mO+EOO/69RMhuhHrfoWYsvbMK9aokDcq+M1rUpEWod02+9JToZzlzFgW4oTux
         52uihXYpgeQYVlx/7SVXmPVL66pT/OEtKNMIRfVmxxIJaIadBGnlI/yCPSdwKnqAWJyz
         NxAA==
X-Gm-Message-State: AD7BkJIw6YaC2JFqtlPEV2xZ/ZGyY7+Sv7QGJFqavOt/X8Wp91eAPdYdQnSRfRgNZxSqfw==
X-Received: by 10.66.144.4 with SMTP id si4mr24262813pab.0.1460268833642;
        Sat, 09 Apr 2016 23:13:53 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id p26sm28228711pfi.84.2016.04.09.23.13.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2016 23:13:52 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.6.g5833b2a
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291145>

Repeating a trivially merge more than once will leave the index out of
sync, despite being clean before the merge and operating on the exact
same heads as the first run.  The recorded merge has the correct tree and
the working tree is brought up to date, it is just the index that is left
as it was before the merge.  Every attempt to repeat the merge beyond the
first will leave the index in the same weird out-of-sync state.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7605-merge-resolve.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 0cb9d11..2f80037 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -27,7 +27,7 @@ test_expect_success 'setup' '
 	git tag c3
 '
 
-test_expect_success 'merge c1 to c2' '
+merge_c1_to_c2_cmds='
 	git reset --hard c1 &&
 	git merge -s resolve c2 &&
 	test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
@@ -41,6 +41,10 @@ test_expect_success 'merge c1 to c2' '
 	test 3 = $(git ls-files | wc -l)
 '
 
+test_expect_success 'merge c1 to c2'        "$merge_c1_to_c2_cmds"
+
+test_expect_failure 'merge c1 to c2, again' "$merge_c1_to_c2_cmds"
+
 test_expect_success 'merge c2 to c3 (fails)' '
 	git reset --hard c2 &&
 	test_must_fail git merge -s resolve c3
-- 
2.8.0.21.g229f62a
