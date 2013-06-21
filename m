From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 06/16] t/t5505-remote: test url-with-# in branches-file
Date: Fri, 21 Jun 2013 16:42:30 +0530
Message-ID: <1371813160-4200-7-git-send-email-artagnon@gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 21 13:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpzKK-0003RE-8U
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 13:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249Ab3FULQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 07:16:13 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:64949 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965513Ab3FULQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 07:16:10 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so7571921pbb.22
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 04:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BVzWUbb9JE7MnfjVgiSqu0pfnE3Os0mnnYGkGb3Gy+o=;
        b=mvJz1uwdN4cQxpBDbuaLlbRr6bCSKvr6x9ua23jRM8M2ZdED+psIB5k+U3Cm5eLIhe
         CbqBeRs83+MH50CHunvZ2DRXQoFuxpBZBlV8AM5XlBq26hCSNgZIZSXqHudFWT1TrR/J
         ++qNgW8F82UrArl+pGuOEpRubB1rcYxESB5BA/AMpW8orfY4oW37+M2VnDt8zAd9Nir9
         o1TjcKsSIxPop644/tB0sGzdlAxE2lzesLHw77ggUcZPDC9JFzvhN0ugZXBdQ+V2l3Nx
         MO0hrl7YoyAYaAXqd5EY9K3EypsPdBH8YdGXTyO/T8t2bBJ4coMqjgyztLo4zrbsBiq3
         NT3Q==
X-Received: by 10.66.154.225 with SMTP id vr1mr16156644pab.85.1371813370409;
        Fri, 21 Jun 2013 04:16:10 -0700 (PDT)
Received: from localhost.localdomain ([122.164.10.8])
        by mx.google.com with ESMTPSA id ig4sm4486341pbc.18.2013.06.21.04.16.08
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Jun 2013 04:16:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.499.g7ad3486.dirty
In-Reply-To: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228599>

Add one more test similar to "migrate a remote from named file in
$GIT_DIR/branches" to check that a url with a # can be used to specify
the branch name (as opposed to the constant "master").

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5505-remote.sh | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index fd0a81e..93e11c8 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -702,27 +702,42 @@ test_expect_success 'migrate a remote from named file in $GIT_DIR/branches' '
 	)
 '
 
-test_expect_success 'remote prune to cause a dangling symref' '
+test_expect_success 'migrate a remote from named file in $GIT_DIR/branches (2)' '
 	git clone one seven &&
+	origin_url=$(pwd)/one &&
+	(
+		cd seven &&
+		git remote rm origin &&
+		echo "quux#foom" > .git/branches/origin &&
+		git remote rename origin origin &&
+		test_path_is_missing .git/branches/origin &&
+		test "$(git config remote.origin.url)" = "quux" &&
+		test "$(git config remote.origin.fetch)" = "refs/heads/foom:refs/heads/origin"
+		test "$(git config remote.origin.push)" = "HEAD:refs/heads/foom"
+	)
+'
+
+test_expect_success 'remote prune to cause a dangling symref' '
+	git clone one eight &&
 	(
 		cd one &&
 		git checkout side2 &&
 		git branch -D master
 	) &&
 	(
-		cd seven &&
+		cd eight &&
 		git remote prune origin
 	) >err 2>&1 &&
 	test_i18ngrep "has become dangling" err &&
 
 	: And the dangling symref will not cause other annoying errors &&
 	(
-		cd seven &&
+		cd eight &&
 		git branch -a
 	) 2>err &&
 	! grep "points nowhere" err &&
 	(
-		cd seven &&
+		cd eight &&
 		test_must_fail git branch nomore origin
 	) 2>err &&
 	grep "dangling symref" err
-- 
1.8.3.1.499.g7ad3486.dirty
