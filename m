From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] t/t7503-pre-commit-hook.sh: Add GIT_PREFIX tests
Date: Thu,  2 Jun 2011 02:26:25 -0700
Message-ID: <1307006785-17529-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 11:30:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS4Ey-0002Dk-MG
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 11:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab1FBJav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 05:30:51 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46139 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab1FBJau (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 05:30:50 -0400
Received: by pzk9 with SMTP id 9so309319pzk.19
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 02:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=7Iry++8Y7v77GuL67r5eMFu8wtG1L8s6VCX4DddOUl0=;
        b=JAKX08N3JeabRzEj7Vp4pMTw0hk6fYflzUK1tjxUQwhRJ+ID1gcNy7BCBSkd97hu1O
         GTo5REfcyBeOaIstM8TT8ZgaEZo9svwMVJS8WiB1R8E0w+Ie/ydns52qNMp+cy/gDerH
         RNiv36xz/iTDPlXg1L7yQLBSWKf9WxyFPyVfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ghZhvVH5anUoKmrsCgLBuBcuMzwC54FO4Qz5gqduUGwT99ASDQDcg2kJVOuhweaail
         vd0uyNHkSK5Xi1A9aQri8uDcuZBUxglDdurdbllWN44CC08j6NllxmswLz4T9MWA3FAX
         +JJ+MD3nslPoY3NN98jhqayyp+NNp7twVWkAY=
Received: by 10.68.20.137 with SMTP id n9mr195136pbe.121.1307007050417;
        Thu, 02 Jun 2011 02:30:50 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m9sm439751pbd.39.2011.06.02.02.30.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Jun 2011 02:30:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.253.ga984a1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174933>

Ensure that the pre-commit hook has access to GIT_PREFIX.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Requires da/git-prefix-everywhere currently in next

 t/t7503-pre-commit-hook.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 8528f64..ee7f0cd 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -84,5 +84,38 @@ test_expect_success POSIXPERM '--no-verify with non-executable hook' '
 	git commit --no-verify -m "more content"
 
 '
+chmod +x "$HOOK"
+
+# a hook that checks $GIT_PREFIX and succeeds inside the
+# success/ subdirectory only
+cat > "$HOOK" <<EOF
+#!/bin/sh
+test \$GIT_PREFIX = success/
+EOF
+
+test_expect_success 'with hook requiring GIT_PREFIX' '
+
+	echo "more content" >> file &&
+	git add file &&
+	mkdir success &&
+	(
+		cd success &&
+		git commit -m "hook requires GIT_PREFIX = success/"
+	) &&
+	rmdir success
+'
+
+test_expect_success 'with failing hook requiring GIT_PREFIX' '
+
+	echo "more content" >> file &&
+	git add file &&
+	mkdir fail &&
+	(
+		cd fail &&
+		test_must_fail git commit -m "hook must fail"
+	) &&
+	rmdir fail &&
+	git checkout -- file
+'
 
 test_done
-- 
1.7.6.rc0.253.ga984a1
