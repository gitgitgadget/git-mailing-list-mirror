From: "Kirill A. Korinskiy" <catap@catap.ru>
Subject: [PATCH] handle_remote_ls_ctx can parsing href starting at http://
Date: Sat, 20 Dec 2008 14:23:33 +0300
Message-ID: <1229772213-11932-1-git-send-email-catap@catap.ru>
Cc: git@vger.kernel.org, "Kirill A. Korinskiy" <catap@catap.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 12:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDzxy-00056U-0E
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 12:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbYLTLYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 06:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752404AbYLTLYf
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 06:24:35 -0500
Received: from void.catap.ru ([213.248.54.140]:49378 "EHLO void.catap.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752361AbYLTLYe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 06:24:34 -0500
Received: (qmail 7767 invoked from network); 20 Dec 2008 11:24:33 -0000
Received: from catap.dialup.corbina.ru (HELO mx3.catap.ru) (85.21.143.245)
  by void.catap.ru with ESMTPS (AES256-SHA encrypted); 20 Dec 2008 11:24:33 -0000
Received: from localhost
	([127.0.0.1] helo=satellite.home.catap.ru ident=catap)
	by mx3.catap.ru with esmtp (Exim 4.63)
	(envelope-from <catap@catap.ru>)
	id 1LDzwb-0001oJ-6x; Sat, 20 Dec 2008 14:24:29 +0300
Received: from catap by satellite.home.catap.ru with local (Exim 4.69)
	(envelope-from <catap@satellite.home.catap.ru>)
	id 1LDzvh-00037X-HI; Sat, 20 Dec 2008 14:23:33 +0300
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103638>

The program call remote_ls() to get remote objects over http;
handle_remote_ls_ctx() is used to parse it's response to populated
"struct remote_ls_ctx" that is returned from remote_ls().

The handle_remote_ls_ctx() function assumed that the server will
returned local path in href field, but RFC 4918 demand of support full
URI (http://localhost/repo.git for example).

This resulted in push failure (git-http-push ask server
PROPFIND /repo.git/alhost:8080/repo.git/refs/) when a server returned
full URI.

Signed-off-by: Kirill A. Korinskiy <catap@catap.ru>
---
 http-push.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/http-push.c b/http-push.c
index 7c6460919bf3eba10c46cede11ffdd9c53fd2dd2..abf0269e0fe20a43a6247fc7584dc2d58322a8fa 100644
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
@@ -1424,9 +1425,10 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 				ls->userFunc(ls);
 			}
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_NAME) && ctx->cdata) {
-			ls->dentry_name = xmalloc(strlen(ctx->cdata) -
+			char *path = strstr(ctx->cdata, remote->path);
+			ls->dentry_name = xmalloc(strlen(path) -
 						  remote->path_len + 1);
-			strcpy(ls->dentry_name, ctx->cdata + remote->path_len);
+			strcpy(ls->dentry_name, path + remote->path_len);
 		} else if (!strcmp(ctx->name, DAV_PROPFIND_COLLECTION)) {
 			ls->dentry_flags |= IS_DIR;
 		}
@@ -2206,10 +2208,11 @@ int main(int argc, char **argv)
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
@@ -2238,8 +2241,9 @@ int main(int argc, char **argv)
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
