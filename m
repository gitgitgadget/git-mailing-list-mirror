From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] t5801 (remote-helpers): cleanup environment sets
Date: Sun, 20 Apr 2014 13:43:37 -0500
Message-ID: <1398019417-8520-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 20 20:54:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbwsO-00044j-U0
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 20:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbaDTSyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 14:54:00 -0400
Received: from mail-yh0-f45.google.com ([209.85.213.45]:41956 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaDTSx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 14:53:59 -0400
Received: by mail-yh0-f45.google.com with SMTP id a41so2926043yho.18
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EwS+lY/3IHh65HDIp0+6QMQ7h/m2aAfwmzoaaHgS4Mw=;
        b=g6hO7CTy26ck0xz7OQXYjab0z08hDI7mkN/mdOvwCTXmnRKv4SwdAmpRAReZXZ2ysd
         nEhhMsffckfoYgkYrUq4eV3S8x7iUIpzpDVIZvwSDdV2vFcdzSSuSQ4S7ipaJGIn0Mhr
         2Jo39pu67qZcv5RKX5DYkuf+E5kLriKZfi0DSYDt7YeuA6AVA6uN7Jiivi11UPEY9VRj
         bNJ6DzMCW+x35OtEE3YODfvLu82OL/QpSyVjUXdBZtainmoCdPu5452YpUReqwZfGKJA
         nygpB/WB43kc6GJMqiOh8E4Q/nk0ifrpXVJJIRJLa7KD9iSvgMMLgLg6JwEj3jC2Apir
         rXsw==
X-Received: by 10.236.123.130 with SMTP id v2mr3838346yhh.85.1398020038314;
        Sun, 20 Apr 2014 11:53:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id o62sm65341403yha.27.2014.04.20.11.53.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 11:53:57 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc3.9.gc73078e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246557>

Commit 512477b (tests: use "env" to run commands with temporary env-var
settings) missed some variables in the remote-helpers test. Also
standardize these.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 25fd2e7..42d1c66 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -212,19 +212,17 @@ test_expect_success 'push update refs failure' '
 	echo "update fail" >>file &&
 	git commit -a -m "update fail" &&
 	git rev-parse --verify testgit/origin/heads/update >expect &&
-	GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" &&
-	export GIT_REMOTE_TESTGIT_PUSH_ERROR &&
-	test_expect_code 1 git push origin update &&
+	test_expect_code 1 env GIT_REMOTE_TESTGIT_FAILURE="non-fast forward" \
+	git push origin update &&
 	git rev-parse --verify testgit/origin/heads/update >actual &&
 	test_cmp expect actual
 	)
 '
 
 test_expect_success 'proper failure checks for fetching' '
-	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
-	export GIT_REMOTE_TESTGIT_FAILURE &&
-	cd local &&
-	test_must_fail git fetch 2> error &&
+	(cd local &&
+	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 \
+	git fetch 2> error &&
 	cat error &&
 	grep -q "Error while running fast-import" error
 	)
@@ -232,7 +230,8 @@ test_expect_success 'proper failure checks for fetching' '
 
 test_expect_success 'proper failure checks for pushing' '
 	(cd local &&
-	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all
+	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 \
+	git push --all
 	)
 '
 
-- 
1.9.1+fc3.9.gc73078e
