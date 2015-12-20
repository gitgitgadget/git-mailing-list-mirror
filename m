From: larsxschneider@gmail.com
Subject: [PATCH v3 1/3] submodule: add test to demonstrate that shallow recursive clones fail
Date: Mon, 21 Dec 2015 00:19:53 +0100
Message-ID: <1450653595-22676-2-git-send-email-larsxschneider@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Cc: sbeller@google.com, peff@peff.net, Jens.Lehmann@web.de,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 21 00:20:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAnHM-0004OI-2F
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 00:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbbLTXUS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 18:20:18 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36601 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbLTXUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 18:20:01 -0500
Received: by mail-wm0-f66.google.com with SMTP id r67so11114938wmg.3
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 15:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2tE2muIKXNvjdukAWfb/8L6ZcXggifg9ZUyS1dsHMOg=;
        b=d8p06qCWjtuyMZLAgjxyPAybEa16xVzsDs/Mc8mZRettc5DMFpP6sTI20y1ligNcQc
         nC8O6JKbNNjjCF2WaU16cm21WbkmYt4tnndl12bWtK70evGwgn8Tduhp5CmrXW6Pb++z
         FLXRjXOocEGtBLYz9iQt6JvGJeGmpxNN2oq4p/J7ruvTWJ1iBxX9tZ3ZA1x5Ujdw3o4K
         MHupdU2K63//45O0YM8XJv9EYqp6rwBZLNmnTDoZMplq7UeB1nT8bLI01U+qZUh6lkt2
         lnwYZYiu+xUzRgiS2Tl5D5hBnEUQLOmtRQIws/fFraYgvAUABq6ilXVg+4c0VdiWj1Q4
         8H6Q==
X-Received: by 10.194.88.130 with SMTP id bg2mr16867762wjb.162.1450653599830;
        Sun, 20 Dec 2015 15:19:59 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id da10sm25396623wjb.22.2015.12.20.15.19.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 15:19:59 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282778>

From: Lars Schneider <larsxschneider@gmail.com>

"git clone --recursive --depth 1 --single-branch <url>" clones the
submodules successfully. However, it does not obey "--depth 1" for
submodule cloning.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t7412-submodule-recursive.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100755 t/t7412-submodule-recursive.sh

diff --git a/t/t7412-submodule-recursive.sh b/t/t7412-submodule-recursive.sh
new file mode 100755
index 0000000..58b3eb9
--- /dev/null
+++ b/t/t7412-submodule-recursive.sh
@@ -0,0 +1,52 @@
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
+	git commit -m "master commit 1" &&
+
+	git checkout -b branch &&
+	echo file >branch-file &&
+	git add branch-file &&
+	test_tick &&
+	git commit -m "branch commit 1" &&
+
+	git checkout master &&
+	git clone . repo &&
+	(
+		cd repo &&
+		git checkout master &&
+		git submodule add ../. submodule &&
+		(
+			cd submodule &&
+			git checkout branch
+		) &&
+		git add submodule &&
+		test_tick &&
+		git commit -m "master commit 2"
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
+test_done
-- 
2.5.1
