From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v1 2/2] contrib/subtree: respect spaces in a repository path
Date: Sat,  5 Sep 2015 01:24:11 +0300
Message-ID: <4531a80be47397632eb6293707a0ac08ef18f528.1441404851.git.Alex.Crezoff@gmail.com>
References: <cover.1441404851.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:24:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXzPa-00085K-DO
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 00:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760628AbbIDWYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 18:24:42 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:36380 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760611AbbIDWYh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 18:24:37 -0400
Received: by lanb10 with SMTP id b10so21636977lan.3
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 15:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tVfuwYuyOuYdTrjqs6VjIksAPa4pDS7bf51ObG3vKz8=;
        b=X4zlg4NlGYwIUGXPwjRwNFpx8jeyQ7aH051ZNOluCHc+/vdNQeFBAAU7QEBmPlVEuy
         HNXyRznhXxxkv6G7KKZBGJ8B0OskjexDHq+Xyd8DOCOOyzNnWmvdNf8Uvalx2l2VgIY4
         drHlObTb1k+iCt6lETASEHiBmqHx8qJqczF/5iEstZYKBtFS97cjjkJbST45G4/X3bk0
         ABzcK73glc2LlubgskNYdA3chp3lQX2EE6bVw02yKtCHTBRgox/v+KypxPIcWVCT554I
         deMNML5mgryFJD+1Z1m4AexCArYqAkQX6OnxCpJ/Yn0BTu0uMTsdgs5b3qcnOgWsS4vp
         ZnGg==
X-Received: by 10.152.37.67 with SMTP id w3mr5618769laj.123.1441405476007;
        Fri, 04 Sep 2015 15:24:36 -0700 (PDT)
Received: from localhost ([213.108.22.197])
        by smtp.gmail.com with ESMTPSA id c5sm890410lae.47.2015.09.04.15.24.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 15:24:35 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 2.4.1-21
In-Reply-To: <cover.1441404851.git.Alex.Crezoff@gmail.com>
In-Reply-To: <cover.1441404851.git.Alex.Crezoff@gmail.com>
References: <cover.1441404851.git.Alex.Crezoff@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277344>

Remote repository may have spaces in its path, so take it into account.

Also, as far as there are no tests for the `push` command, add them.

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 contrib/subtree/git-subtree.sh     |  2 +-
 contrib/subtree/t/t7900-subtree.sh | 47 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 72a20c0..308b777 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -735,7 +735,7 @@ cmd_push()
 	    refspec=$2
 	    echo "git push using: " $repository $refspec
 	    localrev=$(git subtree split --prefix="$prefix") || die
-	    git push $repository $localrev:refs/heads/$refspec
+	    git push "$repository" $localrev:refs/heads/$refspec
 	else
 	    die "'$dir' must already exist. Try 'git subtree add'."
 	fi
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 9979827..dfbe443 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 #
 # Copyright (c) 2012 Avery Pennaraum
+# Copyright (c) 2015 Alexey Shumkin
 #
 test_description='Basic porcelain support for subtrees
 
@@ -471,4 +472,50 @@ test_expect_success 'verify one file change per commit' '
 	))
 '
 
+# test push
+
+cd ../..
+
+mkdir test-push
+
+cd test-push
+
+test_expect_success 'init main' '
+	test_create_repo main
+'
+
+test_expect_success 'init sub' '
+	test_create_repo "sub project"
+'
+
+cd ./"sub project"
+
+test_expect_success 'add subproject' '
+	create "sub project" &&
+	git commit -m "Sub project: 1" &&
+	git branch sub-branch-1
+'
+
+cd ../main
+
+test_expect_success 'make first commit and add subproject' '
+	create "main-1" &&
+	git commit -m "main: 1" &&
+	git subtree add "../sub project" --prefix "sub dir" --message "Added subproject" sub-branch-1 &&
+	check_equal "$(last_commit_message)" "Added subproject"
+'
+
+test_expect_success 'make second commit to a subproject file and push it into a sub project' '
+	create "sub dir/sub1" &&
+	git commit -m "Sub project: 2" &&
+	git subtree push "../sub project" --prefix "sub dir" sub-branch-1
+'
+
+cd ../"sub project"
+
+test_expect_success 'Test second commit is pushed' '
+	git checkout sub-branch-1 &&
+	check_equal "$(last_commit_message)" "Sub project: 2"
+'
+
 test_done
-- 
2.4.1-21
