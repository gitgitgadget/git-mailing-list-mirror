From: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
Subject: [PATCH] Normalise directory names when pushing to some WebDAV servers
Date: Fri, 19 Nov 2010 01:06:03 +0100
Message-ID: <1290125163-31065-1-git-send-email-gabriel.corona@enst-bretagne.fr>
Cc: Gabriel Corona <gabriel.corona@enst-bretagne.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 01:17:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJEfl-0001Ki-Np
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 01:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761238Ab0KSARV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 19:17:21 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:49329 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760541Ab0KSARU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 19:17:20 -0500
Received: from localhost.localdomain (unknown [88.180.106.44])
	by smtp3-g21.free.fr (Postfix) with ESMTP id B2C26A60F2;
	Fri, 19 Nov 2010 01:17:13 +0100 (CET)
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161719>

Fix a bug when pushing to WebDAV servers which do not use a trailing
slash for collection names. The previous implementation fails to see
that the requested resource "refs/" is the same resource as "refs"
and loads every reference twice (once for refs/ and once for refs).

This implementation normalises every collection name by appending a
trailing slash if necessary.

This can be tested with old versions of Apache (such as the WebDAV
server of GMX, Apache 2.0.63).
---
 http-push.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/http-push.c b/http-push.c
index c9bcd11..aeb37ab 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1083,6 +1083,18 @@ static void process_ls_ref(struct remote_ls_ctx *ls)
 		one_remote_ref(ls->dentry_name);
 }
 
+static void normalize_dirname(char** name) {
+	char* res;
+	int len = strlen(*name);
+	if((*name)[len-1]=='/') return;
+	res = malloc(len+2);
+	strcpy(res, *name);
+	res[len]='/';
+	res[len+1]='\0';
+	free(*name);
+	*name = res;
+}
+
 static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 {
 	struct remote_ls_ctx *ls = (struct remote_ls_ctx *)ctx->userData;
@@ -1090,6 +1102,7 @@ static void handle_remote_ls_ctx(struct xml_ctx *ctx, int tag_closed)
 	if (tag_closed) {
 		if (!strcmp(ctx->name, DAV_PROPFIND_RESP) && ls->dentry_name) {
 			if (ls->dentry_flags & IS_DIR) {
+				normalize_dirname(&ls->dentry_name);
 				if (ls->flags & PROCESS_DIRS) {
 					ls->userFunc(ls);
 				}
-- 
1.7.2.3
