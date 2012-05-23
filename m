From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 1/2] submodule: document handling of relative superproject origin URLs
Date: Thu, 24 May 2012 02:45:53 +1000
Message-ID: <1337791554-31294-2-git-send-email-jon.seymour@gmail.com>
References: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 23 18:46:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEhz-00075y-LX
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759261Ab2EWQq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 12:46:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38840 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757056Ab2EWQqY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 12:46:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so10118333pbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uAG7DLT5rkqrRwgvAx41U59JqP9XqxTo19w2c/yzm9w=;
        b=RRjFpQRYSg6okCxyvqMh5CNTfkCEue1+Hmuv56Bldy5NLZcy9av86GTlVhcvIqXhs7
         Afktng4iyunmMMJ4/1kzSIz+nzwjYUzG6NQQsTBNkYcRdLpQEE3ZxzyxRlXaSqiwTLwR
         taeP6SQPGYoZWhbRlSoyo+ETHOxkmNV+o/26NG2c7PevcKxz0UUoYnIDYkMIM+FvqesS
         zIQ9XsVWA2Y/oJh1KsGWvT7y4u1mdM1hX+6CWjUH0vMQNzvisINVqWG7ii/dfxk8hPpZ
         4SZH1VAM5oC6e5d1940zdEgnIDcQkTfJiMTAP0gllcSUcYI8rlVlRquqhGcV+887jw01
         dKkA==
Received: by 10.68.201.73 with SMTP id jy9mr11913386pbc.19.1337791584596;
        Wed, 23 May 2012 09:46:24 -0700 (PDT)
Received: from ubuntu.au.ibm.com ([101.114.128.220])
        by mx.google.com with ESMTPS id ss8sm2352494pbc.43.2012.05.23.09.46.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 23 May 2012 09:46:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.2.594.g24e850d
In-Reply-To: <1337791554-31294-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198308>

These tests document how submodule sync and init handle various
kinds of relative super project origin URLs.  The submodule URL
path is ../subrepo.

6 cases are documented:
  foo
  foo/bar
  ./foo
  ./foo/bar
  ../foo
  ../foo/bar

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7400-submodule-basic.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++
 t/t7403-submodule-sync.sh  | 63 +++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..97e7a73 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -507,6 +507,68 @@ test_expect_success 'relative path works with user@host:path' '
 	)
 '
 
+test_expect_success 'relative path works with foo' "
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url foo &&
+		echo \"cannot strip one component off url 'foo'\" >expect &&
+		test_must_fail git submodule init 2>actual &&
+		cat actual &&
+		test_cmp expect actual
+	)
+"
+
+test_expect_success 'relative path works with foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = foo/subrepo
+	)
+'
+
+test_expect_success 'relative path works with ./foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ./foo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ./subrepo
+	)
+'
+
+test_expect_success 'relative path works with ./foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ./foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ./foo/subrepo
+	)
+'
+
+test_expect_success 'relative path works with ../foo' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ../foo &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../subrepo
+	)
+'
+
+test_expect_success 'relative path works with ../foo/bar' '
+	(
+		cd reltest &&
+		cp pristine-.git-config .git/config &&
+		git config remote.origin.url ../foo/bar &&
+		git submodule init &&
+		test "$(git config submodule.sub.url)" = ../foo/subrepo
+	)
+'
+
 test_expect_success 'moving the superproject does not break submodules' '
 	(
 		cd addtest &&
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 3620215..3784c9b 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -26,7 +26,9 @@ test_expect_success setup '
 	(cd super-clone && git submodule update --init) &&
 	git clone super empty-clone &&
 	(cd empty-clone && git submodule init) &&
-	git clone super top-only-clone
+	git clone super top-only-clone &&
+	git clone super relative-clone &&
+	(cd relative-clone && git submodule update --init)
 '
 
 test_expect_success 'change submodule' '
@@ -86,4 +88,63 @@ test_expect_success '"git submodule sync" should not vivify uninteresting submod
 	)
 '
 
+test_expect_success '"git submodule sync" handles origin URL of the form foo' "
+	(cd relative-clone &&
+	 git remote set-url origin foo
+	 echo \"cannot strip one component off url 'foo'\" > expect &&
+	 test_must_fail git submodule sync 2> actual &&
+	 test_cmp expect actual
+	)
+"
+
+test_expect_success '"git submodule sync" handles origin URL of the form foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin foo/bar
+	 git submodule sync &&
+	(cd submodule &&
+	 test "$(git config remote.origin.url)" == "foo/submodule"
+	)
+	)
+'
+
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo' '
+	(cd relative-clone &&
+	 git remote set-url origin ./foo
+	 git submodule sync &&
+	(cd submodule &&
+	 test "$(git config remote.origin.url)" == "./submodule"
+	)
+	)
+'
+
+test_expect_success '"git submodule sync" handles origin URL of the form ./foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin ./foo/bar
+	 git submodule sync &&
+	(cd submodule &&
+	 test "$(git config remote.origin.url)" == "./foo/submodule"
+	)
+	)
+'
+
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo
+	 git submodule sync &&
+	(cd submodule &&
+	 test "$(git config remote.origin.url)" == "../submodule"
+	)
+	)
+'
+
+test_expect_success '"git submodule sync" handles origin URL of the form ../foo/bar' '
+	(cd relative-clone &&
+	 git remote set-url origin ../foo/bar
+	 git submodule sync &&
+	(cd submodule &&
+	 test "$(git config remote.origin.url)" == "../foo/submodule"
+	)
+	)
+'
+
 test_done
-- 
1.7.10.2.594.g24e850d
