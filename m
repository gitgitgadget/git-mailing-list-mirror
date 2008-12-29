From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] http-push: support full URI in handle_remote_ls_ctx()
Date: Mon, 29 Dec 2008 05:32:15 +0300
Message-ID: <1230517935-11299-1-git-send-email-catap@catap.ru>
References: <7vmyekag6p.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 03:35:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH7xw-00018j-NV
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 03:34:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbYL2Cd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 21:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbYL2Cd0
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 21:33:26 -0500
Received: from void.catap.ru ([213.248.54.140]:37897 "EHLO void.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbYL2Cd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 21:33:26 -0500
Received: (qmail 22741 invoked from network); 29 Dec 2008 02:33:24 -0000
Received: from catap.dialup.corbina.ru (HELO mx3.catap.ru) (85.21.143.245)
  by void.catap.ru with ESMTPS (AES256-SHA encrypted); 29 Dec 2008 02:33:24 -0000
Received: from localhost
	([127.0.0.1] helo=satellite.home.catap.ru ident=catap)
	by mx3.catap.ru with esmtp (Exim 4.63)
	(envelope-from <catap@catap.ru>)
	id 1LH7wW-0004yc-J5; Mon, 29 Dec 2008 05:33:20 +0300
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LH7vT-0002wf-4w; Mon, 29 Dec 2008 05:32:15 +0300
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <7vmyekag6p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104068>

The program calls remote_ls() to get list of files from the server
over HTTP; handle_remote_ls_ctx() is used to parse its response to
populate "struct remote_ls_ctx" that is returned from remote_ls().

The handle_remote_ls_ctx() function assumed that the server returns a
local path in href field, but RFC 4918 (14.7) demand of support full
URI (e.g. "http://localhost:8080/repo.git").

This resulted in push failure (e.g. git-http-push issues a PROPFIND
request to "/repo.git/alhost:8080/repo.git/refs/" to the server).

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 http-push.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7c6460919bf3eba10c46cede11ffdd9c53fd2dd2..a4b7d08663504a57008f66a39fffe293f62c1d08 100644
--- a/http-push.c
+++ b/http-push.c
@@ -87,6 +87,7 @@ static struct object_list *objects;
 struct repo
 {
 	char *url;
+	char *path;
 	int path_len;
 	int has_info_refs;
 	int can_update_info_refs;
@@ -1424,9 +1425,19 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 				ls->userFunc(ls);
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
-			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
+			char *path = ctx->cdata;
+			if (*ctx->cdata == 'h') {
+				path = strstr(path, "//");
+				if (path) {
+					path = strchr(path+2, '/');
+				}
+			}
+			if (path) {
+				path += remote->path_len;
+			}
+			ls->dentry_name = xmalloc(strlen(path) -
 						  remote->path_len + 1);
-			strcpy(ls->dentry_name, ctx->cdata + remote->path_len);
+			strcpy(ls->dentry_name, path + remote->path_len);
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
 		}
@@ -2206,10 +2217,11 @@ int main(int argc, char **argv)
 		if (!remote->url) {
 			char *path = strstr(arg, "//");
 			remote->url = arg;
+			remote->path_len = strlen(arg);
 			if (path) {
-				path = strchr(path+2, '/');
-				if (path)
-					remote->path_len = strlen(path);
+				remote->path = strchr(path+2, '/');
+				if (remote->path)
+					remote->path_len = strlen(remote->path);
 			}
 			continue;
 		}
@@ -2238,8 +2250,9 @@ int main(int argc, char **argv)
 		rewritten_url = xmalloc(strlen(remote->url)+2);
 		strcpy(rewritten_url, remote->url);
 		strcat(rewritten_url, "/");
+		remote->path = rewritten_url + (remote->path - remote->url);
+		remote->path_len++;
 		remote->url = rewritten_url;
-		++remote->path_len;
 	}
 
 	/* Verify DAV compliance/lock support */
-- 
1.5.6.5
