From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Smart-http: check if repository is OK to export before serving it
Date: Mon, 28 Dec 2009 16:49:00 -0500
Message-ID: <1262036940-9678-1-git-send-email-tarmigan+git@gmail.com>
References: <20091228170811.GE2252@spearce.org>
Cc: git@vger.kernel.org, spearce@spearce.org,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 22:49:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPNTI-0003t9-MT
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 22:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbZL1Vtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 16:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbZL1Vtm
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 16:49:42 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:45145 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZL1Vtm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 16:49:42 -0500
Received: by qw-out-2122.google.com with SMTP id 8so882005qwh.37
        for <git@vger.kernel.org>; Mon, 28 Dec 2009 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=VTw1PjCUojG9YrqV3Q2AxJNDvKn2P6wnTla+bHmgTgo=;
        b=YcuoLTC9SlldlPLM8ETLx3XDGWlcOuO3LwHTangZWW+IiXJLU5FU+YkolxAOVajLwK
         x8CKgupjSLG4+Nsyx5rhtLHI0fdi4r43FxpHArEf8zarv0E2eMPsMwKutt70C+ub0juf
         MMqMxrA595o+jRAcBjS1XftYRhedZcCDMdLkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=i4f2gDLJEXiJH6EXDD2BqpBlJoxZSGb0y/CPmOiZ/D85Ewt3k9Xwg3iCisHFOL4cVo
         PfP7Ya++NDumwT0sLhwo5QdepikYwJ1pDGayWdOY3VflrfVMRFCh4+c80mwW+E3Fh66d
         xoTocH6829BdWZao4cYEEaJaz2oZCAfBt1FE4=
Received: by 10.224.41.138 with SMTP id o10mr7722716qae.249.1262036980648;
        Mon, 28 Dec 2009 13:49:40 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 20sm10743268qyk.5.2009.12.28.13.49.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 28 Dec 2009 13:49:39 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.g8d7b9
In-Reply-To: <20091228170811.GE2252@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135765>

Similar to how git-daemon checks whether a repository is OK to be
exported, smart-http should also check.  This check can be satisfied
in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
may be set to export all repositories, or the individual repository
may have the file git-daemon-export-ok.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
OK, I see what you're saying Shawn.  I've changed it back to "404 
Not Found" again.

I've also reordered the new tests since the last time I sent it out.
The new tests use the same test as in
"static file is ok"
so put the new tests after that test in case that test breaks.

 Documentation/git-http-backend.txt |   10 +++++++++
 http-backend.c                     |    3 ++
 t/lib-httpd/apache.conf            |    5 ++++
 t/t5560-http-backend.sh            |   39 ++++++++++++++++++++++++++++++++++-
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 67aec06..c8fe08a 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -18,6 +18,11 @@ The program supports clients fetching using both the smart HTTP protcol
 and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
 
+It verifies that the directory has the magic file
+"git-daemon-export-ok", and it will refuse to export any git directory
+that hasn't explicitly been marked for export this way (unless the
+GIT_HTTP_EXPORT_ALL environmental variable is set).
+
 By default, only the `upload-pack` service is enabled, which serves
 'git-fetch-pack' and 'git-ls-remote' clients, which are invoked from
 'git-fetch', 'git-pull', and 'git-clone'.  If the client is authenticated,
@@ -70,6 +75,7 @@ Apache 2.x::
 +
 ----------------------------------------------------------------
 SetEnv GIT_PROJECT_ROOT /var/www/git
+SetEnv GIT_HTTP_EXPORT_ALL
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 +
@@ -157,6 +163,10 @@ by the invoking web server, including:
 * QUERY_STRING
 * REQUEST_METHOD
 
+The GIT_HTTP_EXPORT_ALL environmental variable may be passed to
+'git-http-backend' to bypass the check for the "git-daemon-export-ok"
+file in each repository before allowing export of that repository.
+
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
 ensuring that any reflogs created by 'git-receive-pack' contain some
diff --git a/http-backend.c b/http-backend.c
index f729488..345c12b 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -648,6 +648,9 @@ int main(int argc, char **argv)
 	setup_path();
 	if (!enter_repo(dir, 0))
 		not_found("Not a git repository: '%s'", dir);
+	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
+	    access("git-daemon-export-ok", F_OK) )
+		not_found("Repository not exported: '%s'", dir);
 
 	git_config(http_config, NULL);
 	cmd->imp(cmd_arg);
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 0fe3fd0..4961505 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -22,8 +22,13 @@ Alias /dumb/ www/
 
 <Location /smart/>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</Location>
+<Location /smart_noexport/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 </Location>
 ScriptAlias /smart/ ${GIT_EXEC_PATH}/git-http-backend/
+ScriptAlias /smart_noexport/ ${GIT_EXEC_PATH}/git-http-backend/
 <Directory ${GIT_EXEC_PATH}>
 	Options None
 </Directory>
diff --git a/t/t5560-http-backend.sh b/t/t5560-http-backend.sh
index ed034bc..04a9896 100755
--- a/t/t5560-http-backend.sh
+++ b/t/t5560-http-backend.sh
@@ -23,7 +23,7 @@ config() {
 }
 
 GET() {
-	curl --include "$HTTPD_URL/smart/repo.git/$1" >out 2>/dev/null &&
+	curl --include "$HTTPD_URL/$SMART/repo.git/$1" >out 2>/dev/null &&
 	tr '\015' Q <out |
 	sed '
 		s/Q$//
@@ -91,6 +91,7 @@ get_static_files() {
 	GET $IDX_URL "$1"
 }
 
+SMART=smart
 test_expect_success 'direct refs/heads/master not found' '
 	log_div "refs/heads/master"
 	GET refs/heads/master "404 Not Found"
@@ -99,6 +100,19 @@ test_expect_success 'static file is ok' '
 	log_div "getanyfile default"
 	get_static_files "200 OK"
 '
+SMART=smart_noexport
+test_expect_success 'no export by default' '
+	log_div "no git-daemon-export-ok"
+	get_static_files "404 Not Found"
+'
+test_expect_success 'export if git-daemon-export-ok' '
+	log_div "git-daemon-export-ok"
+        (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 touch git-daemon-export-ok
+	) &&
+        get_static_files "200 OK"
+'
+SMART=smart
 test_expect_success 'static file if http.getanyfile true is ok' '
 	log_div "getanyfile true"
 	config http.getanyfile true &&
@@ -145,7 +159,6 @@ test_expect_success 'http.receivepack false' '
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
-
 run_backend() {
 	REQUEST_METHOD=GET \
 	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
@@ -194,6 +207,28 @@ GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 200
 GET  /smart/repo.git/$PACK_URL HTTP/1.1 200
 GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
 
+###  no git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 404 -
+
+###  git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 200
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 200
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 200
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 200 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 200 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 200
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 200
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 200
+
 ###  getanyfile true
 ###
 GET  /smart/repo.git/HEAD HTTP/1.1 200
-- 
1.6.6.1.g8d7b9
