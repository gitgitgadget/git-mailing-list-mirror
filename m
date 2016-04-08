From: Elijah Newren <newren@gmail.com>
Subject: [RFC/PATCH 04/18] merge-octopus: Abort if index not clean
Date: Thu,  7 Apr 2016 23:58:32 -0700
Message-ID: <1460098726-5958-5-git-send-email-newren@gmail.com>
References: <1460098726-5958-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 09:00:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoQOe-0002y6-78
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 09:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbcDHG7G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 02:59:06 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35422 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932448AbcDHG7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 02:59:03 -0400
Received: by mail-pa0-f65.google.com with SMTP id zy2so8472839pac.2
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsO6XzxeApJ6O2Uo7er6pnfh4e+oKrgFm3GzipVYCe4=;
        b=hV1uniFB7vM72NmjwcuAwdDpurW1cXTLowVya4Z18Dt/A3lCZbTjOqVGwCXq7wvwrz
         6GLE2EoPsVNizASF9L+QEjLEhUVqxVPxqHtjJl6RNmvldz5UhKT8cdyGf+SQvHvOlrmP
         T4V7qPk5MzhMT35UoUSMPH/7VHPAdZcCYY75hPwkH7ohaY/CCFhuxdkzYlSA61cWeWVC
         1+5dgnP/TXw/oLLGv75u4c8+OhQv+yJJZFEpYNsleTHf/lcQR0R9ttSwx56ftFZt/wAh
         T7NO1Fn40KdxSr6pxw+lurNX/nVK0zSl3NMks2yPpu0xsR5LMPmvzt0ObPX8I13scUlJ
         Dddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jsO6XzxeApJ6O2Uo7er6pnfh4e+oKrgFm3GzipVYCe4=;
        b=Zr6zUEQT55tcp1RmXLOIJCOkW219zojhWyoxO+MnvFhBg51NYzcd/jeTqkiXi/DT3p
         bX4ZMmXoZnKcSvVAUaKawz+PIEKaF3O21K+XOZTg7F/HiLOvrvHKAR7yskAJYhd/m5yc
         Zbhy3W6USVxhwcCcLnWOaWzhR+qrBzkk5L7FE76v7I3OEx1PZDxf99GFinH5pAIniL0X
         7MJOuvemRdJ044Iqxau8dzpbpKyI5L3jbwIVKNIZ5ItK4jHCXrcj++3k6TiRexDTBsW9
         Ln6rmn1Zst14Dtk7OiOtccgJgRBc/gZcZBWac+522vphcMFWMt8zu26mTbFCypGCZ9jS
         Jxzg==
X-Gm-Message-State: AD7BkJIkOKf8QtfMKN56+E2JvOSXDXOE1Yuq4TSQdBcJskIu+Fjqe5qo6AKJVl8gfQaP7Q==
X-Received: by 10.66.249.166 with SMTP id yv6mr10342260pac.91.1460098742350;
        Thu, 07 Apr 2016 23:59:02 -0700 (PDT)
Received: from unknownB8F6B118D3EB.attlocal.net ([2602:30a:2c28:20f0:baf6:b1ff:fe18:d3eb])
        by smtp.gmail.com with ESMTPSA id w62sm16371973pfa.79.2016.04.07.23.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Apr 2016 23:59:01 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.18.gc685494
In-Reply-To: <1460098726-5958-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291010>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 git-merge-octopus.sh                     |  5 +++++
 t/t6044-merge-unrelated-index-changes.sh | 21 ++++++---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index 8643f74..a1d7702 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -44,6 +44,11 @@ esac
 # MRC is the current "merge reference commit"
 # MRT is the current "merge result tree"
 
+if ! git diff-index --quiet --cached HEAD --; then
+    echo "Error: Your local changes to the following files need to be resolved before merge"
+    git diff-index --cached --name-only HEAD -- | sed -e 's/^/    /'
+    exit 2
+fi
 MRC=$(git rev-parse --verify -q $head)
 MRT=$(git write-tree)
 NON_FF_MERGE=0
diff --git a/t/t6044-merge-unrelated-index-changes.sh b/t/t6044-merge-unrelated-index-changes.sh
index 726c898..4c1dc5a 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -105,43 +105,34 @@ test_expect_success 'recursive' '
 	test_must_fail git merge -s recursive C^0
 '
 
-test_expect_failure 'octopus, unrelated file touched' '
+test_expect_success 'octopus, unrelated file touched' '
 	git reset --hard &&
 	git checkout B^0 &&
 
 	touch random_file && git add random_file &&
 
 	echo "I think the next line should fail, but maybe it was intended..." &&
-	test_might_fail git merge C^0 D^0 &&
-
-	echo "No matter what, random_file should NOT be part of HEAD" &&
-	test_must_fail git rev-parse HEAD:random_file
+	test_must_fail git merge C^0 D^0
 '
 
-test_expect_failure 'octopus, related file removed' '
+test_expect_success 'octopus, related file removed' '
 	git reset --hard &&
 	git checkout B^0 &&
 
 	git rm b &&
 
 	echo "I think the next line should fail, but maybe it was intended..." &&
-	test_might_fail git merge C^0 D^0 &&
-
-	echo "No matter what, b should still be in HEAD" &&
-	git cat-file -p HEAD:b | grep b$
+	test_must_fail git merge C^0 D^0
 '
 
-test_expect_failure 'octopus, related file modified' '
+test_expect_success 'octopus, related file modified' '
 	git reset --hard &&
 	git checkout B^0 &&
 
 	echo 12 >>a && git add a &&
 
 	echo "I think the next line should fail, but maybe it was intended..." &&
-	test_might_fail git merge C^0 D^0 &&
-
-	echo "No matter what, 12 should NOT be in the copy of a from HEAD" &&
-	git cat-file -p HEAD:a | test_must_fail grep 12
+	test_must_fail git merge C^0 D^0
 '
 
 test_expect_success 'ours' '
-- 
2.8.0.18.gc685494
