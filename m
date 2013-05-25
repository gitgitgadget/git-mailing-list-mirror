From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/48] remote-helpers: tests: general improvements
Date: Fri, 24 May 2013 21:29:21 -0500
Message-ID: <1369449004-17981-6-git-send-email-felipe.contreras@gmail.com>
References: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:32:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4H7-0001Sh-W7
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450Ab3EYCb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:31:59 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:52316 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab3EYCb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:31:58 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so6964849oah.21
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ywi9RDmx73ogr8gfDh38iHlZfBSvbfBcy0AUjRXc9PE=;
        b=RGgS65oqbKbF+JdokvtMyb5U+eE6nm4eWZmsVzcXVH3jfoa+vdqO/e7dwwpiIKIZ9t
         xqBNZWYRoU60QiG/7EfxEYlOPrHcbdW3wWWxxbnWgt1yCI2YeXGtboQzEI4R09anLYQr
         R8fgy4IpZa8YfjdryFMEA7PF7TxGc9dgfhf6TDyt/xiQ6sHN6RZLUAHF8EVLbq/VOCdT
         Ar+uPy1ST2Wb9DXaOy8ixc0lCUG3HGSZoU0gxjAIaeHRS63EuqxuJnfqx9zEqOsgfgZE
         3dNto1AtooKXMOAv4G3H06wLO6ao06FnGDatj0s6stqaKmfGqfwG9J7rRgEcEkgZOEBS
         izTQ==
X-Received: by 10.60.47.1 with SMTP id z1mr13747451oem.134.1369449117741;
        Fri, 24 May 2013 19:31:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id x5sm20591997oep.1.2013.05.24.19.31.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:31:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369449004-17981-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225419>

So that we don't need a temporary directory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh       | 21 ++++++++++----------
 contrib/remote-helpers/test-hg-bidi.sh   | 15 +++++----------
 contrib/remote-helpers/test-hg-hg-git.sh | 33 +++++++++++---------------------
 contrib/remote-helpers/test-hg.sh        |  7 +++++--
 4 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index f760110..1ae7376 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -190,9 +190,11 @@ test_expect_success 'different authors' '
 	test_cmp expected actual
 '
 
+# cleanup previous stuff
+rm -rf bzrrepo gitrepo
+
 test_expect_success 'fetch utf-8 filenames' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp && LC_ALL=C" &&
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=C" &&
 
 	LC_ALL=en_US.UTF-8
 	export LC_ALL
@@ -223,8 +225,9 @@ test_expect_success 'fetch utf-8 filenames' '
 '
 
 test_expect_success 'push utf-8 filenames' '
+	test_when_finished "rm -rf bzrrepo gitrepo && LC_ALL=C" &&
+
 	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp && LC_ALL=C" &&
 
 	LC_ALL=en_US.UTF-8
 	export LC_ALL
@@ -255,8 +258,7 @@ test_expect_success 'push utf-8 filenames' '
 '
 
 test_expect_success 'pushing a merge' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
 
 	(
 	bzr init bzrrepo &&
@@ -297,8 +299,7 @@ origin/trunk
 EOF
 
 test_expect_success 'proper bzr repo' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
 
 	bzr init-repo bzrrepo &&
 
@@ -323,13 +324,11 @@ test_expect_success 'proper bzr repo' '
 	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ../actual
 	) &&
 
-	test_cmp ../expected actual
+	test_cmp expected actual
 '
 
 test_expect_success 'strip' '
-	# Do not imitate this style; always chdir inside a subshell instead
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
 
 	(
 	bzr init bzrrepo &&
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helpers/test-hg-bidi.sh
index f569697..490a395 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -77,8 +77,7 @@ setup () {
 setup
 
 test_expect_success 'encoding' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -115,8 +114,7 @@ test_expect_success 'encoding' '
 '
 
 test_expect_success 'file removal' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -148,8 +146,7 @@ test_expect_success 'file removal' '
 '
 
 test_expect_success 'git tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -177,8 +174,7 @@ test_expect_success 'git tags' '
 '
 
 test_expect_success 'hg branch' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -214,8 +210,7 @@ test_expect_success 'hg branch' '
 '
 
 test_expect_success 'hg tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index 7f579c8..6f0819c 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -114,8 +114,7 @@ setup () {
 setup
 
 test_expect_success 'executable bit' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -150,8 +149,7 @@ test_expect_success 'executable bit' '
 '
 
 test_expect_success 'symlink' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -181,8 +179,7 @@ test_expect_success 'symlink' '
 '
 
 test_expect_success 'merge conflict 1' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	hg init hgrepo1 &&
@@ -216,8 +213,7 @@ test_expect_success 'merge conflict 1' '
 '
 
 test_expect_success 'merge conflict 2' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	hg init hgrepo1 &&
@@ -251,8 +247,7 @@ test_expect_success 'merge conflict 2' '
 '
 
 test_expect_success 'converged merge' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	hg init hgrepo1 &&
@@ -287,8 +282,7 @@ test_expect_success 'converged merge' '
 '
 
 test_expect_success 'encoding' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -327,8 +321,7 @@ test_expect_success 'encoding' '
 '
 
 test_expect_success 'file removal' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -367,8 +360,7 @@ test_expect_success 'file removal' '
 '
 
 test_expect_success 'git tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	(
 	git init -q gitrepo &&
@@ -394,8 +386,7 @@ test_expect_success 'git tags' '
 '
 
 test_expect_success 'hg author' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	for x in hg git; do
 		(
@@ -461,8 +452,7 @@ test_expect_success 'hg author' '
 '
 
 test_expect_success 'hg branch' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	for x in hg git; do
 		(
@@ -498,8 +488,7 @@ test_expect_success 'hg branch' '
 '
 
 test_expect_success 'hg tags' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf gitrepo* hgrepo*" &&
 
 	for x in hg git; do
 		(
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index 8d1154b..043f6c6 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -122,6 +122,9 @@ test_expect_success 'update bookmark' '
 	hg -R hgrepo bookmarks | egrep "devel[	 ]+3:"
 '
 
+# cleanup previous stuff
+rm -rf hgrepo
+
 author_test () {
 	echo $1 >> content &&
 	hg commit -u "$2" -m "add $1" &&
@@ -129,8 +132,7 @@ author_test () {
 }
 
 test_expect_success 'authors' '
-	mkdir -p tmp && cd tmp &&
-	test_when_finished "cd .. && rm -rf tmp" &&
+	test_when_finished "rm -rf hgrepo gitrepo" &&
 
 	(
 	hg init hgrepo &&
@@ -139,6 +141,7 @@ test_expect_success 'authors' '
 	touch content &&
 	hg add content &&
 
+	> ../expected &&
 	author_test alpha "" "H G Wells <wells@example.com>" &&
 	author_test beta "test" "test <unknown>" &&
 	author_test beta "test <test@example.com> (comment)" "test <test@example.com>" &&
-- 
1.8.3.rc3.312.g47657de
