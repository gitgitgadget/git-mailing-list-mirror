From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Sun, 12 Apr 2009 22:49:06 +0400
Message-ID: <1239562146-32133-1-git-send-email-catap@catap.ru>
References: <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 12 20:51:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lt4mG-0002Eh-RH
	for gcvg-git-2@gmane.org; Sun, 12 Apr 2009 20:51:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbZDLSuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Apr 2009 14:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZDLSt7
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Apr 2009 14:49:59 -0400
Received: from mx.catap.ru ([85.25.232.43]:48083 "EHLO mx.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206AbZDLSt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Apr 2009 14:49:58 -0400
Received: from catap.static.corbina.ru ([85.21.143.245] helo=satellite.home.catap.ru)
	by mx.catap.ru with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1Lt4kO-0003zr-LY; Sun, 12 Apr 2009 22:49:40 +0400
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1Lt4jq-0008Mx-QC; Sun, 12 Apr 2009 22:49:06 +0400
X-Mailer: git-send-email 1.6.2
In-Reply-To: <7vd4bi9s1m.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116387>

If the response from remote web-server have scp or other not http-like
scheme http-push can't go to change url, because DAV must work only
over HTTP (http and https scheme).

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 http-push.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/http-push.c b/http-push.c
index feeb340..cce9ead 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1457,16 +1457,17 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
 			char *path = ctx->cdata;
-			if (*ctx->cdata == 'h') {
-				path = strstr(path, "//");
-				if (path) {
-					path = strchr(path+2, '/');
-				}
-			}
-			if (path) {
-				path += repo->path_len;
-				ls->dentry_name = xstrdup(path);
+			if (!strcmp(ctx->cdata, "http://")) {
+				path = strchr(path + sizeof("http://") - 1, '/');
+			} else if (!strcmp(ctx->cdata, "https://")) {
+				path = strchr(path + sizeof("https://") - 1, '/');
 			}
+
+			path += repo->path_len;
+
+			ls->dentry_name = xmalloc(strlen(path) -
+						  repo->path_len + 1);
+			strcpy(ls->dentry_name, path + repo->path_len);
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
 		}
-- 
1.6.2
