Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5555C4332F
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354691AbhLBAms (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354670AbhLBAmY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:24 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E225C06174A
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 16:39:02 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id CB0AE59C59B76; Thu,  2 Dec 2021 01:39:00 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 80ED859C59B75
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 01:39:00 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: [PATCH] http-backend: give a hint that web browser access is not supported
Date:   Thu,  2 Dec 2021 01:39:00 +0100
Message-Id: <20211202003900.26124-1-jengelh@inai.de>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using a browser to access a URI that is served by http-backend,
nothing but a blank page is shown. This is not helpful.

Emit the same "Request not handled" messages, but to the CGI stream
at stdout. Use the HTTP REQUEST_URI for this so that filesystem paths
are not revealed more than necessary. Add a paragraph that browsing
to http-backend URIs is not something that should normally be done.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
Previously botched the commit message. not_found is not very nice
to extend; one can but make a new function.

 http-backend.c          | 36 +++++++++++++++++++++++++++-----
 t/t5561-http-backend.sh | 46 ++++++++++++++++++++---------------------
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git http-backend.c http-backend.c
index 3d6e2ff17f..f7858e9c49 100644
--- http-backend.c
+++ http-backend.c
@@ -139,6 +139,25 @@ static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
 	exit(0);
 }
 
+static NORETURN void not_found_2(struct strbuf *hdr, const char *dir,
+				 const char *pathinfo, const char *err,
+				 const char *hint)
+{
+	http_status(hdr, 404, "Not Found");
+	hdr_nocache(hdr);
+	strbuf_add(hdr, "\r\n", 2);
+	if (pathinfo != NULL)
+		strbuf_addf(hdr, "%s: ", pathinfo);
+	strbuf_addf(hdr, "%s.\r\n", err);
+	if (hint != NULL)
+		strbuf_addf(hdr, "%s\r\n", hint);
+	end_headers(hdr);
+
+	if (err && *err)
+		fprintf(stderr, "%s: %s\n", dir, err);
+	exit(0);
+}
+
 __attribute__((format (printf, 2, 3)))
 static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
 {
@@ -736,7 +755,8 @@ static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
 
 int cmd_main(int argc, const char **argv)
 {
-	char *method = getenv("REQUEST_METHOD");
+	const char *method = getenv("REQUEST_METHOD");
+	const char *pathinfo = getenv("PATH_INFO");
 	const char *proto_header;
 	char *dir;
 	struct service_cmd *cmd = NULL;
@@ -775,15 +795,21 @@ int cmd_main(int argc, const char **argv)
 		regfree(&re);
 	}
 
-	if (!cmd)
-		not_found(&hdr, "Request not supported: '%s'", dir);
+	if (!cmd) {
+		const char *hint = "";
+		if (strcmp(method, "GET") == 0)
+			hint = "You cannot use a web browser to access "
+			       "this URL. Only git operations like "
+			       "clone/ls-remote/etc. will work.\n";
+		not_found_2(&hdr, dir, pathinfo, "Request not supported", hint);
+	}
 
 	setup_path();
 	if (!enter_repo(dir, 0))
-		not_found(&hdr, "Not a git repository: '%s'", dir);
+		not_found_2(&hdr, dir, pathinfo, "Not a git repository", NULL);
 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
 	    access("git-daemon-export-ok", F_OK) )
-		not_found(&hdr, "Repository not exported: '%s'", dir);
+		not_found_2(&hdr, dir, pathinfo, "Repository not exported", NULL);
 
 	http_config();
 	max_request_buffer = git_env_ulong("GIT_HTTP_MAX_REQUEST_BUFFER",
diff --git t/t5561-http-backend.sh t/t5561-http-backend.sh
index 9c57d84315..d8add36fb4 100755
--- t/t5561-http-backend.sh
+++ t/t5561-http-backend.sh
@@ -44,7 +44,7 @@ grep '^[^#]' >exp <<EOF
 
 ###  refs/heads/main
 ###
-GET  /smart/repo.git/refs/heads/main HTTP/1.1 404 -
+GET  /smart/repo.git/refs/heads/main HTTP/1.1 404
 
 ###  getanyfile default
 ###
@@ -59,14 +59,14 @@ GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
 
 ###  no git-daemon-export-ok
 ###
-GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 404 -
-GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 404 -
+GET  /smart_noexport/repo.git/HEAD HTTP/1.1 404
+GET  /smart_noexport/repo.git/info/refs HTTP/1.1 404
+GET  /smart_noexport/repo.git/objects/info/packs HTTP/1.1 404
+GET  /smart_noexport/repo.git/objects/info/alternates HTTP/1.1 404
+GET  /smart_noexport/repo.git/objects/info/http-alternates HTTP/1.1 404
+GET  /smart_noexport/repo.git/$LOOSE_URL HTTP/1.1 404
+GET  /smart_noexport/repo.git/$PACK_URL HTTP/1.1 404
+GET  /smart_noexport/repo.git/$IDX_URL HTTP/1.1 404
 
 ###  git-daemon-export-ok
 ###
@@ -92,14 +92,14 @@ GET  /smart/repo.git/$IDX_URL HTTP/1.1 200
 
 ###  getanyfile false
 ###
-GET  /smart/repo.git/HEAD HTTP/1.1 403 -
-GET  /smart/repo.git/info/refs HTTP/1.1 403 -
-GET  /smart/repo.git/objects/info/packs HTTP/1.1 403 -
-GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403 -
-GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403 -
-GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 403 -
-GET  /smart/repo.git/$PACK_URL HTTP/1.1 403 -
-GET  /smart/repo.git/$IDX_URL HTTP/1.1 403 -
+GET  /smart/repo.git/HEAD HTTP/1.1 403
+GET  /smart/repo.git/info/refs HTTP/1.1 403
+GET  /smart/repo.git/objects/info/packs HTTP/1.1 403
+GET  /smart/repo.git/objects/info/alternates HTTP/1.1 403
+GET  /smart/repo.git/objects/info/http-alternates HTTP/1.1 403
+GET  /smart/repo.git/$LOOSE_URL HTTP/1.1 403
+GET  /smart/repo.git/$PACK_URL HTTP/1.1 403
+GET  /smart/repo.git/$IDX_URL HTTP/1.1 403
 
 ###  uploadpack default
 ###
@@ -113,13 +113,13 @@ POST /smart/repo.git/git-upload-pack HTTP/1.1 200 -
 
 ###  uploadpack false
 ###
-GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403 -
-POST /smart/repo.git/git-upload-pack HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs?service=git-upload-pack HTTP/1.1 403
+POST /smart/repo.git/git-upload-pack HTTP/1.1 403
 
 ###  receivepack default
 ###
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403
 
 ###  receivepack true
 ###
@@ -128,8 +128,8 @@ POST /smart/repo.git/git-receive-pack HTTP/1.1 200 -
 
 ###  receivepack false
 ###
-GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403 -
-POST /smart/repo.git/git-receive-pack HTTP/1.1 403 -
+GET  /smart/repo.git/info/refs?service=git-receive-pack HTTP/1.1 403
+POST /smart/repo.git/git-receive-pack HTTP/1.1 403
 EOF
 test_expect_success 'server request log matches test results' '
 	check_access_log exp
-- 
2.34.0

