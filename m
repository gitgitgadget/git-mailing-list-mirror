From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v3 02/10] unix-sockets: use strbuf_getcwd()
Date: Mon, 28 Jul 2014 20:25:40 +0200
Message-ID: <53D695A4.2030403@web.de>
References: <53D694A2.8030007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Karsten Blees <karsten.blees@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 20:25:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBpcO-0002I5-Le
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 20:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbaG1SZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 14:25:49 -0400
Received: from mout.web.de ([212.227.17.12]:51920 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbaG1SZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 14:25:48 -0400
Received: from [192.168.178.27] ([79.253.140.83]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0Lxwme-1WOHKM2ooW-015HkO; Mon, 28 Jul 2014 20:25:42
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <53D694A2.8030007@web.de>
X-Provags-ID: V03:K0:/3sVVO771o28U4rAY85BL/EVZxOxuO2jqUri/uhL3N0VJePvFcn
 GXjx2jz6MKVulHrIjvkvqTg2VVV5MpVCO0HNzp7TvRqIEmjim0haLHHqY/njk87EhOy3k/3
 vQMZWHkRTmIWV8+8F6pzV2dfzvlaGVi1BcPuFADBcQKYZ/S5zYq8ekScMK6+Hhlxwwkmdcz
 29iFCQDUk+FzTWk5v22jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254335>

Instead of using a PATH_MAX-sized buffer, which can be too small on some
file systems, use strbuf_getcwd(), which handles any path getcwd()
returns.  Also preserve the errno set by strbuf_getcwd() instead of
setting it to ENAMETOOLONG; that way a more appropriate error message
can be shown based on the actual reason for failing.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 unix-socket.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 91bd6b8..19ed48b 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -18,12 +18,12 @@ static int chdir_len(const char *orig, int len)
 }
 
 struct unix_sockaddr_context {
-	char orig_dir[PATH_MAX];
+	char *orig_dir;
 };
 
 static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
 {
-	if (!ctx->orig_dir[0])
+	if (!ctx->orig_dir)
 		return;
 	/*
 	 * If we fail, we can't just return an error, since we have
@@ -32,6 +32,7 @@ static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
 	 */
 	if (chdir(ctx->orig_dir) < 0)
 		die("unable to restore original working directory");
+	free(ctx->orig_dir);
 }
 
 static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
@@ -39,10 +40,11 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 {
 	int size = strlen(path) + 1;
 
-	ctx->orig_dir[0] = '\0';
+	ctx->orig_dir = NULL;
 	if (size > sizeof(sa->sun_path)) {
 		const char *slash = find_last_dir_sep(path);
 		const char *dir;
+		struct strbuf cwd = STRBUF_INIT;
 
 		if (!slash) {
 			errno = ENAMETOOLONG;
@@ -56,11 +58,9 @@ static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
 			errno = ENAMETOOLONG;
 			return -1;
 		}
-
-		if (!getcwd(ctx->orig_dir, sizeof(ctx->orig_dir))) {
-			errno = ENAMETOOLONG;
+		if (strbuf_getcwd(&cwd))
 			return -1;
-		}
+		ctx->orig_dir = strbuf_detach(&cwd, NULL);
 		if (chdir_len(dir, slash - dir) < 0)
 			return -1;
 	}
-- 
2.0.2
