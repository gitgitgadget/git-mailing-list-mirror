From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5 27/28] http tests: use /dumb/ URL prefix
Date: Fri, 30 Oct 2009 17:47:46 -0700
Message-ID: <1256950067-27938-29-git-send-email-spearce@spearce.org>
References: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 01:49:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N429w-0001yQ-5K
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 01:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757590AbZJaAtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 20:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757584AbZJaAtO
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 20:49:14 -0400
Received: from george.spearce.org ([209.20.77.23]:36972 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125AbZJaAsC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 20:48:02 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 32B82381D3; Sat, 31 Oct 2009 00:48:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 35F3538267;
	Sat, 31 Oct 2009 00:47:58 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.181.gd6f41
In-Reply-To: <1256950067-27938-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131807>

To clarify what part of the HTTP transprot is being tested we change
the URLs used by existing tests to include /dumb/ at the start,
indicating they use the non-Git aware code paths.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
CC: Tay Ray Chuan <rctay89@gmail.com>
---
 t/lib-httpd/apache.conf |    7 ++++++-
 t/t5540-http-push.sh    |   10 +++++-----
 t/t5550-http-fetch.sh   |    4 ++--
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 21aa42f..47a438f 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -8,6 +8,11 @@ ErrorLog error.log
 <IfModule !mod_log_config.c>
 	LoadModule log_config_module modules/mod_log_config.so
 </IfModule>
+<IfModule !mod_alias.c>
+	LoadModule alias_module modules/mod_alias.so
+</IfModule>
+
+Alias /dumb/ www/
 
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
@@ -26,7 +31,7 @@ SSLEngine On
 	LoadModule dav_fs_module modules/mod_dav_fs.so
 
 	DAVLockDB DAVLock
-	<Location />
+	<Location /dumb/>
 		Dav on
 	</Location>
 </IfDefine>
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index d1234f9..4a9450e 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -42,7 +42,7 @@ test_expect_success 'setup remote repository' '
 
 test_expect_success 'clone remote repository' '
 	cd "$ROOT_PATH" &&
-	git clone $HTTPD_URL/test_repo.git test_repo_clone
+	git clone $HTTPD_URL/dumb/test_repo.git test_repo_clone
 '
 
 test_expect_success 'push to remote repository with packed refs' '
@@ -75,7 +75,7 @@ test_expect_success 'http-push fetches unpacked objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
 
-	git clone $HTTPD_URL/test_repo_unpacked.git \
+	git clone $HTTPD_URL/dumb/test_repo_unpacked.git \
 		"$ROOT_PATH"/fetch_unpacked &&
 
 	# By reset, we force git to retrieve the object
@@ -84,14 +84,14 @@ test_expect_success 'http-push fetches unpacked objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+	 git push -f -v $HTTPD_URL/dumb/test_repo_unpacked.git master)
 '
 
 test_expect_success 'http-push fetches packed objects' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
 		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
 
-	git clone $HTTPD_URL/test_repo_packed.git \
+	git clone $HTTPD_URL/dumb/test_repo_packed.git \
 		"$ROOT_PATH"/test_repo_clone_packed &&
 
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
@@ -104,7 +104,7 @@ test_expect_success 'http-push fetches packed objects' '
 	 git remote rm origin &&
 	 git reflog expire --expire=0 --all &&
 	 git prune &&
-	 git push -f -v $HTTPD_URL/test_repo_packed.git master)
+	 git push -f -v $HTTPD_URL/dumb/test_repo_packed.git master)
 '
 
 test_expect_success 'create and delete remote branch' '
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index 0e69324..776057c 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -30,7 +30,7 @@ test_expect_success 'create http-accessible bare repository' '
 '
 
 test_expect_success 'clone http repository' '
-	git clone $HTTPD_URL/repo.git clone &&
+	git clone $HTTPD_URL/dumb/repo.git clone &&
 	test_cmp file clone/file
 '
 
@@ -58,7 +58,7 @@ test_expect_success 'fetch packed objects' '
 	cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
 	git --bare repack &&
 	git --bare prune-packed &&
-	git clone $HTTPD_URL/repo_pack.git
+	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
 stop_httpd
-- 
1.6.5.2.181.gd6f41
