Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035DDC433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 00:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354271AbhLBAQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 19:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354248AbhLBAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 19:16:05 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4672C06175D
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 16:12:41 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 0EC7C58058C07; Thu,  2 Dec 2021 01:12:39 +0100 (CET)
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 943575805951A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 01:12:38 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] http-backend: CGI error messages need to be output on stdout
Date:   Thu,  2 Dec 2021 01:12:37 +0100
Message-Id: <20211202001238.21808-1-jengelh@inai.de>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Accessing a clone-only URL with a browser would always show a blank
page, because the reason string "Request is not supported" was
sent to the wrong file descriptor.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 http-backend.c          |  4 ++--
 t/t5561-http-backend.sh | 46 ++++++++++++++++++++---------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git http-backend.c http-backend.c
index 3d6e2ff17f..8f1b69d127 100644
--- http-backend.c
+++ http-backend.c
@@ -134,7 +134,7 @@ static NORETURN void not_found(struct strbuf *hdr, const char *err, ...)
 
 	va_start(params, err);
 	if (err && *err)
-		vfprintf(stderr, err, params);
+		vprintf(err, params);
 	va_end(params);
 	exit(0);
 }
@@ -150,7 +150,7 @@ static NORETURN void forbidden(struct strbuf *hdr, const char *err, ...)
 
 	va_start(params, err);
 	if (err && *err)
-		vfprintf(stderr, err, params);
+		vprintf(err, params);
 	va_end(params);
 	exit(0);
 }
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

