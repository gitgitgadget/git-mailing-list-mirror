From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] http-push.c: DAV must support olny http and https scheme
Date: Fri, 10 Apr 2009 17:44:20 +0400
Message-ID: <1239371060-3978-1-git-send-email-catap@catap.ru>
Cc: "Kirill A. Korinskiy" <catap@catap.ru>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 10 16:27:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsHhB-0006gS-Ly
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 16:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754365AbZDJOZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 10:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754567AbZDJOZa
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 10:25:30 -0400
Received: from mx.catap.ru ([85.25.232.43]:50834 "EHLO mx.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754334AbZDJOZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 10:25:30 -0400
X-Greylist: delayed 2383 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Apr 2009 10:25:30 EDT
Received: from [195.218.190.224] (helo=satellite.home.catap.ru)
	by mx.catap.ru with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LsH2v-00071a-KU; Fri, 10 Apr 2009 17:45:29 +0400
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LsH1o-00012i-Qt; Fri, 10 Apr 2009 17:44:20 +0400
X-Mailer: git-send-email 1.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116259>

If the response from remote web-server have scp or other not http-like
scheme http-push can't go to change url, because DAV must work only
over HTTP (http and https scheme).

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 http-push.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/http-push.c b/http-push.c
index feeb340..48c9a04 100644
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
+			path += remote->path_len;
+
+			ls->dentry_name = xmalloc(strlen(path) -
+						  remote->path_len + 1);
+			strcpy(ls->dentry_name, path + remote->path_len);
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
 		}
-- 
1.6.2
