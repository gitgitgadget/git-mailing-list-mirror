From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v5.1 3/3] http-backend: Test configuration options
Date: Wed,  4 Nov 2009 17:16:38 -0800
Message-ID: <1257383798-29826-3-git-send-email-spearce@spearce.org>
References: <1257383798-29826-1-git-send-email-spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 02:17:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5qyE-0002AX-JW
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 02:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757759AbZKEBQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 20:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757285AbZKEBQl
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 20:16:41 -0500
Received: from george.spearce.org ([209.20.77.23]:37447 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755628AbZKEBQf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 20:16:35 -0500
Received: by george.spearce.org (Postfix, from userid 1000)
	id 63EC7E0006; Thu,  5 Nov 2009 01:16:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 327B1381FF
	for <git@vger.kernel.org>; Thu,  5 Nov 2009 01:16:39 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.2.295.g0d105
In-Reply-To: <1257383798-29826-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132182>

Test the major configuration settings which control access to
the repository:

  http.getanyfile
  http.uploadpack
  http.receivepack

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 t/t5560-http-backend.sh |  229 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 229 insertions(+), 0 deletions(-)
 create mode 100755 t/t5560-http-backend.sh

diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
new file mode 100755
index 0000000..908ba07
--- /dev/null
+++ b/t/t5560-http-backend.sh
@@ -0,0 +1,229 @@
+#!/bin/sh
+
+test_description='test git-http-backend'
+. ./test-lib.sh
+
+if test -n "$NO_CURL"; then
+	say 'skipping test, git built without http support'
+	test_done
+fi
+
+LIB_HTTPD_PORT=${LIB_HTTPD_PORT-'5560'}
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+find_file() {
+	cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	find $1 -type f |
+	sed -e 1q
+}
+
+config() {
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" config $1 $2
+}
+
+GET() {
+	curl --include "$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
+	tr '\015' Q <out |
+	sed '
+		s/Q$//
+		1q
+	' >act &&
+	echo "HTTP/1.1 $2" >exp &&
+	test_cmp exp act
+}
+
+POST() {
+	curl --include --data "$2" \
+	--header "Content-Type: application/x-$1-request" \
+	"$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
+	tr '\015' Q <out |
+	sed '
+		s/Q$//
+		1q
+	' >act &&
+	echo "HTTP/1.1 $3" >exp &&
+	test_cmp exp act
+}
+
+log_div() {
+	echo >>"$HTTPD_ROOT_PATH"/access.log
+	echo "###  $1" >>"$HTTPD_ROOT_PATH"/access.log
+	echo "###" >>"$HTTPD_ROOT_PATH"/access.log
+}
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one &&
+
+	mkdir "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git --bare init &&
+	 : >objects/info/alternates &&
+	 : >objects/info/http-alternates
+	) &&
+	git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master &&
+
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git repack -a -d
+	) &&
+
+	echo other >file &&
+	git add file &&
+	git commit -m two &&
+	git push public master:master &&
+
+	LOOSE_URL=$(find_file objects/??) &&
+	PACK_URL=$(find_file objects/pack/*.pack) &&
+	IDX_URL=$(find_file objects/pack/*.idx)
+'
+
+get_static_files() {
+	GET HEAD "$1" &&
+	GET info/refs "$1" &&
+	GET objects/info/packs "$1" &&
+	GET objects/info/alternates "$1" &&
+	GET objects/info/http-alternates "$1" &&
+	GET $LOOSE_URL "$1" &&
+	GET $PACK_URL "$1" &&
+	GET $IDX_URL "$1"
+}
+
+test_expect_success 'direct refs/heads/master not found' '
+	log_div "refs/heads/master"
+	GET refs/heads/master "404 Not Found"
+'
+test_expect_success 'static file is ok' '
+	log_div "getanyfile default"
+	get_static_files "200 OK"
+'
+test_expect_success 'static file if http.getanyfile true is ok' '
+	log_div "getanyfile true"
+	config http.getanyfile true &&
+	get_static_files "200 OK"
+'
+test_expect_success 'static file if http.getanyfile false fails' '
+	log_div "getanyfile false"
+	config http.getanyfile false &&
+	get_static_files "403 Forbidden"
+'
+
+test_expect_success 'http.uploadpack default enabled' '
+	log_div "uploadpack default"
+	GET info/refs?service=git-upload-pack "200 OK"  &&
+	POST git-upload-pack 0000 "200 OK"
+'
+test_expect_success 'http.uploadpack true' '
+	log_div "uploadpack true"
+	config http.uploadpack true &&
+	GET info/refs?service=git-upload-pack "200 OK" &&
+	POST git-upload-pack 0000 "200 OK"
+'
+test_expect_success 'http.uploadpack false' '
+	log_div "uploadpack false"
+	config http.uploadpack false &&
+	GET info/refs?service=git-upload-pack "403 Forbidden" &&
+	POST git-upload-pack 0000 "403 Forbidden"
+'
+
+test_expect_success 'http.receivepack default disabled' '
+	log_div "receivepack default"
+	GET info/refs?service=git-receive-pack "403 Forbidden"  &&
+	POST git-receive-pack 0000 "403 Forbidden"
+'
+test_expect_success 'http.receivepack true' '
+	log_div "receivepack true"
+	config http.receivepack true &&
+	GET info/refs?service=git-receive-pack "200 OK" &&
+	POST git-receive-pack 0000 "200 OK"
+'
+test_expect_success 'http.receivepack false' '
+	log_div "receivepack false"
+	config http.receivepack false &&
+	GET info/refs?service=git-receive-pack "403 Forbidden" &&
+	POST git-receive-pack 0000 "403 Forbidden"
+'
+
+cat >exp <<EOF
+
+###  refs/heads/master
+###
+GET  /smart/repo.git/refs/heads/master HTTP/1.1 404 -
+
+###  getanyfile default
+###
+GET  /smart/repo.git/HEAD HTTP/1.1 200
+GET  /smart/repo.git/info/refs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
+
+###  getanyfile true
+###
+GET  /smart/repo.git/HEAD HTTP/1.1 200
+GET  /smart/repo.git/info/refs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
+
+###  getanyfile false
+###
+GET  /smart/repo.git/HEAD HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403 -
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403 -
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 403 -
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 403 -
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 403 -
+
+###  uploadpack default
+###
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
+
+###  uploadpack true
+###
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
+POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
+
+###  uploadpack false
+###
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-upload-pack HTTP/1.1 403 -
+
+###  receivepack default
+###
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+
+###  receivepack true
+###
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
+POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
+
+###  receivepack false
+###
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+EOF
+test_expect_success 'server request log matches test results' '
+	sed -e "
+		s/^.* \"//
+		s/\"//
+		s/ [1-9][0-9]*\$//
+		s/^GET /GET  /
+	" >act <"$HTTPD_ROOT_PATH"/access.log &&
+	test_cmp exp act
+'
+
+stop_httpd
+test_done
-- 
1.6.5.2.295.g0d105
