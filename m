From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 08/14] remote-testgit: exercise more features
Date: Fri,  2 Nov 2012 03:02:12 +0100
Message-ID: <1351821738-17526-9-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bM-0000vf-8w
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796Ab2KBCDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:03 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965791Ab2KBCDB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=T3TYpqdT0cacuSfvaksQUZvEsYA7d3c0co11UqAgJUI=;
        b=YXQ0tnW2RaIlaLq6CT/W3l84u4ZMCaLK+B9dMzS1iWWrCPnULsnZP5e260pwyXF+XO
         aw6NKkK5tZ+1xCX5qg+1rSzwU6k971J+rOblUdVgiBzI81GucHPo1YUho4Uvtg6byAC/
         7jMbEOeJrXj+YxL4VlBfy/J66SJhbhmJMhP9FAckIyV+8jCp42pJPeVrUi7tssTJXhSf
         U/iMGj5m3ZNmahZbqbqcFgCivTZgOFLwHo9SrYkOix7lwONYuI7Rm2M0fmo0p+eILunV
         RINr6W2TLHpNcXOo9XJD8tdbZ5YcaT4ZHuYeprAT45HcJYrR7FSRQeS3QyfJ2zbIGW6l
         LB7Q==
Received: by 10.204.11.91 with SMTP id s27mr25684bks.36.1351821780276;
        Thu, 01 Nov 2012 19:03:00 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id 9sm5776155bkq.13.2012.11.01.19.02.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208903>

Unfortunately they do not work.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit        | 18 +++++++++++++----
 t/t5801-remote-helpers.sh | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 4 deletions(-)
 mode change 100755 => 100644 t/t5801-remote-helpers.sh

diff --git a/git-remote-testgit b/git-remote-testgit
index b9810fd..6c348b0 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -6,24 +6,34 @@ url="$2"
 
 dir="$GIT_DIR/testgit/$alias"
 prefix="refs/testgit/$alias"
-refspec="refs/heads/*:${prefix}/heads/*"
+
+default_refspec="refs/heads/*:${prefix}/heads/*"
+
+refspec="${GIT_REMOTE_TESTGIT_REFSPEC-$default_refspec}"
 
 gitmarks="$dir/git.marks"
 testgitmarks="$dir/testgit.marks"
 
+test -z "$refspec" && prefix="refs"
+
 export GIT_DIR="$url/.git"
 
 mkdir -p "$dir"
 
-test -e "$gitmarks" || echo -n > "$gitmarks"
-test -e "$testgitmarks" || echo -n > "$testgitmarks"
+if [ -z "$GIT_REMOTE_TESTGIT_NO_MARKS" ]; then
+    test -e "$gitmarks" || echo -n > "$gitmarks"
+    test -e "$testgitmarks" || echo -n > "$testgitmarks"
+else
+    echo -n > "$gitmarks"
+    echo -n > "$testgitmarks"
+fi
 
 while read line; do
     case "$line" in
     capabilities)
         echo 'import'
         echo 'export'
-        echo "refspec $refspec"
+        test -n "$refspec" && echo "refspec $refspec"
         echo "*import-marks $gitmarks"
         echo "*export-marks $gitmarks"
         echo
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
old mode 100755
new mode 100644
index 3c4e09a..83561f8
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -105,4 +105,53 @@ test_expect_failure 'push new branch with old:new refspec' '
 	compare_refs local HEAD server refs/heads/new-refspec
 '
 
+test_expect_failure 'cloning without refspec' '
+	GIT_REMOTE_TESTGIT_REFSPEC="" \
+	git clone "testgit::${PWD}/server" local2 &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pulling without refspecs' '
+	(cd local2 &&
+	git reset --hard &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without refspecs' '
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pulling with straight refspec' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing with straight refspec' '
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_REFSPEC="*:*" git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pulling without marks' '
+	(cd local2 &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git pull) &&
+	compare_refs local2 HEAD server HEAD
+'
+
+test_expect_failure 'pushing without marks' '
+	(cd local2 &&
+	echo content >>file &&
+	git commit -a -m three &&
+	GIT_REMOTE_TESTGIT_NO_MARKS=1 git push) &&
+	compare_refs local2 HEAD server HEAD
+'
+
 test_done
-- 
1.8.0
