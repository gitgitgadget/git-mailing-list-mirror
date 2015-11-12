From: larsxschneider@gmail.com
Subject: [PATCH v1] add test to demonstrate that shallow recursive clones fail
Date: Thu, 12 Nov 2015 10:04:09 +0100
Message-ID: <1447319049-51371-1-git-send-email-larsxschneider@gmail.com>
Cc: sbeller@google.com, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 12 10:04:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zwnnp-0006D0-Eq
	for gcvg-git-2@plane.gmane.org; Thu, 12 Nov 2015 10:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964AbbKLJEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 04:04:15 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35227 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbbKLJEM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 04:04:12 -0500
Received: by wmdw130 with SMTP id w130so144887098wmd.0
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dufQJgOCnx5vQBdQMAoA2R0V5Ljzly3luWpLE9oZb5Q=;
        b=W9lx1TaJNSfzRBt/QsLiB6LAcJ9IhmJueyBfn3/WEsWbHmTGhqhxU89fMyt5o9gqGV
         Hg2vOiBxRa6q5YcwSFQvVxb041Wxz7VQ8jdhHptW/FYuLVUMooKe7brgUiGjAUA8FQJA
         0yjqIQ2E04Fr5GAEmylKRk4A88T2uF7K372zRk6/86fwsf6d9Ypv9W3eOBzIduypHFeE
         8bKBE3g9dVDGJm3ppJXQ46O0s1jUNkCSlBcNBn1waIsHlz4TytL6zJFcwKAKLxH283rE
         ii30/1x2EvAkcqL9SLbC6iC9waKWghuj5BExDnoanoOGovojEGGlvwajVo0eQGKZ1udA
         YX0A==
X-Received: by 10.194.114.70 with SMTP id je6mr14708434wjb.7.1447319051678;
        Thu, 12 Nov 2015 01:04:11 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB6E5E.dip0.t-ipconnect.de. [93.219.110.94])
        by smtp.gmail.com with ESMTPSA id z13sm7664916wjr.47.2015.11.12.01.04.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Nov 2015 01:04:10 -0800 (PST)
X-Mailer: git-send-email 2.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281213>

From: Lars Schneider <larsxschneider@gmail.com>

"git clone --recursive --depth 1 --single-branch <url>" clones the
submodules successfully. However, it does not obey "--depth 1" for
submodule cloning.

The following workaround does only work if the used submodule pointer
is on the default branch. Otherwise "git submodule update" fails with
"fatal: reference is not a tree:" and "Unable to checkout".
git clone --depth 1 --single-branch <url>
cd <repo-name>
git submodule update --init --recursive --depth 1

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t7412-submodule-recursive.sh | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100755 t/t7412-submodule-recursive.sh

diff --git a/t/t7412-submodule-recursive.sh b/t/t7412-submodule-recursive.sh
new file mode 100755
index 0000000..c639f96
--- /dev/null
+++ b/t/t7412-submodule-recursive.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='Test shallow cloning of repos with submodules'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git checkout -b master &&
+	echo file >file &&
+	git add file &&
+	test_tick &&
+	git commit -m "master commit" &&
+
+	git checkout -b branch &&
+	echo file >branch-file &&
+	git add branch-file &&
+	test_tick &&
+	git commit -m "branch commit" &&
+
+	git checkout master &&
+
+	git clone . repo &&
+	(
+		cd repo &&
+		git submodule add ../. submodule &&
+		(
+			cd submodule &&
+			git checkout branch
+		) &&
+		git add submodule &&
+		test_tick &&
+		git commit -m "submodule"
+	)
+'
+
+test_expect_failure shallow-clone-recursive '
+	URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
+	echo $URL &&
+	git clone --recursive --depth 1 --single-branch $URL clone-recursive &&
+	(
+		cd "clone-recursive" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	) &&
+	(
+		cd "clone-recursive/submodule" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines
+	)
+'
+
+test_expect_failure shallow-clone-recursive-workaround '
+	URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
+	echo $URL &&
+	git clone --depth 1 --single-branch $URL clone-recursive-workaround &&
+	(
+		cd "clone-recursive-workaround" &&
+		git log --oneline >lines &&
+		test_line_count = 1 lines &&
+		git submodule update --init --recursive --depth 1
+	)
+'
+
+test_done
-- 
2.5.1
