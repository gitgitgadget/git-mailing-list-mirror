From: Dennis Stosberg <dennis@stosberg.net>
Subject: Build fixes for Solaris 9
Date: Tue, 11 Apr 2006 18:37:58 +0200
Message-ID: <20060411163758.G1237b62a@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Apr 11 18:38:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTLsW-0005nf-Lw
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 18:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345AbWDKQiE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 12:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWDKQiE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 12:38:04 -0400
Received: from ncs.stosberg.net ([217.195.44.246]:58287 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751345AbWDKQiD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Apr 2006 12:38:03 -0400
Received: from leonov (p213.54.77.13.tisdip.tiscali.de [213.54.77.13])
	by ncs.stosberg.net (Postfix) with ESMTP id 95395AEBA0EE
	for <git@vger.kernel.org>; Tue, 11 Apr 2006 18:37:52 +0200 (CEST)
Received: by leonov (Postfix, from userid 500)
	id 1B3CEEE722; Tue, 11 Apr 2006 18:37:58 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
X-ICQ: 63537718
X-PGP-Key: 94951CAB
User-Agent: mutt-ng/devel-r796 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18613>

Hello,

The attached patch allows git to be built on Solaris 9, which does
not have setenv() and unsetenv().

Also, Solaris needs strings.h for index().  A few days ago there was
a thread about this on the list and the result was that strchr() is
more portable than index() and is used everywhere in git anyway.  So
instead of including strings.h, this patch replaces all remaining
calls to index() by strchr().

Regards,
Dennis


diff --git a/Makefile b/Makefile
index c0409f3..ff645d8 100644
--- a/Makefile
+++ b/Makefile
@@ -248,6 +248,10 @@ ifeq ($(uname_S),SunOS)
 		NO_UNSETENV = YesPlease
 		NO_SETENV = YesPlease
 	endif
+	ifeq ($(uname_R),5.9)
+		NO_UNSETENV = YesPlease
+		NO_SETENV = YesPlease
+	endif
 	INSTALL = ginstall
 	TAR = gtar
 	ALL_CFLAGS += -D__EXTENSIONS__
diff --git a/http-fetch.c b/http-fetch.c
index 71a7daf..861644b 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -597,7 +597,7 @@ static void process_alternates_response(
 				newalt->packs = NULL;
 				path = strstr(target, "//");
 				if (path) {
-					path = index(path+2, '/');
+					path = strchr(path+2, '/');
 					if (path)
 						newalt->path_len = strlen(path);
 				}
@@ -678,7 +678,7 @@ static void
 xml_start_tag(void *userData, const char *name, const char **atts)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = index(name, ':');
+	const char *c = strchr(name, ':');
 	int new_len;
 
 	if (c == NULL)
@@ -707,7 +707,7 @@ static void
 xml_end_tag(void *userData, const char *name)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = index(name, ':');
+	const char *c = strchr(name, ':');
 	char *ep;
 
 	ctx->userFunc(ctx, 1);
@@ -1261,7 +1261,7 @@ int main(int argc, char **argv)
 	alt->next = NULL;
 	path = strstr(url, "//");
 	if (path) {
-		path = index(path+2, '/');
+		path = strchr(path+2, '/');
 		if (path)
 			alt->path_len = strlen(path);
 	}
diff --git a/http-push.c b/http-push.c
index 57cefde..994ee90 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1211,7 +1211,7 @@ static void
 xml_start_tag(void *userData, const char *name, const char **atts)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = index(name, ':');
+	const char *c = strchr(name, ':');
 	int new_len;
 
 	if (c == NULL)
@@ -1240,7 +1240,7 @@ static void
 xml_end_tag(void *userData, const char *name)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
-	const char *c = index(name, ':');
+	const char *c = strchr(name, ':');
 	char *ep;
 
 	ctx->userFunc(ctx, 1);
@@ -2350,7 +2350,7 @@ int main(int argc, char **argv)
 			char *path = strstr(arg, "//");
 			remote->url = arg;
 			if (path) {
-				path = index(path+2, '/');
+				path = strchr(path+2, '/');
 				if (path)
 					remote->path_len = strlen(path);
 			}
