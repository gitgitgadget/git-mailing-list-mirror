From: Tarmigan Casebolt <tarmigan+git@gmail.com>
Subject: [PATCH] Smart-http: check if repository is OK to export before serving it
Date: Sun, 27 Dec 2009 23:22:46 -0500
Message-ID: <1261974166-66866-1-git-send-email-tarmigan+git@gmail.com>
References: <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com>
Cc: git@vger.kernel.org, Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 05:23:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP78f-0003mU-Ld
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 05:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbZL1EXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 23:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbZL1EXV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 23:23:21 -0500
Received: from mail-qy0-f192.google.com ([209.85.221.192]:64081 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225AbZL1EXU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 23:23:20 -0500
Received: by qyk30 with SMTP id 30so4673892qyk.33
        for <git@vger.kernel.org>; Sun, 27 Dec 2009 20:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=i+hITwyO1UKVoOzuso5lFmIboynsvgdZO6fOzH755RA=;
        b=p6Z6/LruP1gW0YPmM+NlFl6rf/cRx8R3jGhAG1oyEzHtDWyiTNRG5woA2YxcMEi/+V
         txDfIT21m4FKMMcGq2Q4IakWovfBKNieNriE7qKhkCeMSjnu4LrQH8YT6BdHU27kE/5O
         w/78Ckws4XscKhBY1xASvEvCMS99hR0Izwusc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=s/Ap1s1zVhgHOQeUgNcl3VpKYiZj6TExUgHt0/Y1rP504G7d/n8Z1bfyKBdimjTmxu
         fCbI4FWZAFbjt+/UZ+LzpJS3PdsCp2j+FP5fFW1Gmi5rwTm0irRkb8lL9PSLKNtG/3L0
         oECFsAag8uua29DzetRxDTGEpki5PwJSFNfW8=
Received: by 10.224.87.80 with SMTP id v16mr915612qal.30.1261974199854;
        Sun, 27 Dec 2009 20:23:19 -0800 (PST)
Received: from localhost.localdomain (c-69-141-151-64.hsd1.nj.comcast.net [69.141.151.64])
        by mx.google.com with ESMTPS id 7sm25138132qwb.52.2009.12.27.20.23.18
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 27 Dec 2009 20:23:19 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.g8eede.dirty
In-Reply-To: <905315640912272007i8b4904dv2b93879789b453fb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135726>

Similar to how git-daemon checks whether a repository is OK to be
exported, smart-http should also check.  This check can be satisfied
in two different ways: the environmental variable GIT_HTTP_EXPORT_ALL
may be set to export all repositories, or the individual repository
may have the file git-daemon-export-ok.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
---
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
index f729488..9de85cb 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -648,6 +648,9 @@ int main(int argc, char **argv)
 	setup_path();
 	if (!enter_repo(dir, 0))
 		not_found("Not a git repository: '%s'", dir);
+	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
+	    access("git-daemon-export-ok", F_OK) )
+		forbidden("Repository not exported: '%s'", dir);
 
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
index ed034bc..126f6d5 100755
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
@@ -91,6 +91,20 @@ get_static_files() {
 	GET $IDX_URL "$1"
 }
 
+SMART=smart_noexport
+test_expect_success 'no export by default' '
+	log_div "no git-daemon-export-ok"
+	get_static_files "403 Forbidden"
+'
+test_expect_success 'export if git-daemon-export-ok' '
+	log_div "git-daemon-export-ok"
+        (cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
+	 touch git-daemon-export-ok
+	) &&
+        get_static_files "200 OK"
+'
+
+SMART=smart
 test_expect_success 'direct refs/heads/master not found' '
 	log_div "refs/heads/master"
 	GET refs/heads/master "404 Not Found"
@@ -145,7 +159,6 @@ test_expect_success 'http.receivepack false' '
 	GET info/refs?service=git-receive-pack "403 Forbidden" &&
 	POST git-receive-pack 0000 "403 Forbidden"
 '
-
 run_backend() {
 	REQUEST_METHOD=GET \
 	GIT_PROJECT_ROOT="$HTTPD_DOCUMENT_ROOT_PATH" \
@@ -179,6 +192,28 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
 
 cat >exp <<EOF
 
+###  no git-daemon-export-ok
+###
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 403 -
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 403 -
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
 ###  refs/heads/master
 ###
 GET  /smart/repo.git/refs/heads/master HTTP/1.1 404 -
-- 
1.6.6.1.g8eede.dirty
