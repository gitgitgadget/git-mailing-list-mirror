From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Mon, 13 Apr 2009 16:42:34 +0400
Message-ID: <1239626554-26206-1-git-send-email-catap@catap.ru>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 13 14:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtLax-0001oT-1i
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 14:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbZDMMoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 08:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZDMMoD
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 08:44:03 -0400
Received: from mx.catap.ru ([85.25.232.43]:53017 "EHLO mx.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbZDMMoD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 08:44:03 -0400
Received: from [195.218.190.224] (helo=satellite.home.catap.ru)
	by mx.catap.ru with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LtLVn-00026x-RL; Mon, 13 Apr 2009 16:43:43 +0400
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LtLUg-0006pg-Qp; Mon, 13 Apr 2009 16:42:34 +0400
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116436>

If the response from remote web-server have scp or other not http-like
scheme http-push can't go to change url, because DAV must work only
over HTTP (http and https scheme).

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 http-push.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/http-push.c b/http-push.c
index 5138224..79c8201 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1486,16 +1486,23 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
 			char *path = ctx->cdata;
-			if (*ctx->cdata == 'h') {
-				path = strstr(path, "//");
-				if (path) {
-					path = strchr(path+2, '/');
-				}
+
+			if (!strncasecmp(ctx->cdata, "http://", sizeof("http://") - 1)) {
+				path = strchr(path + sizeof("http://") - 1, '/');
+			} else if (!strncasecmp(ctx->cdata, "https://",
+						sizeof("https://") - 1)) {
+				path = strchr(path + sizeof("https://") - 1, '/');
+			} else if (strstr(path, "://")) {
+				path = NULL;
 			}
+
 			if (path) {
 				path += repo->path_len;
 				ls->dentry_name = xstrdup(path);
+			} else {
+				fprintf(stderr, "Not valid URI: %s\n", ctx->cdata);
 			}
+
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
 		}
-- 
1.6.2
