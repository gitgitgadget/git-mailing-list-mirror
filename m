From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] connect.c: drop path_match function
Date: Mon, 12 Dec 2011 19:49:59 -0500
Message-ID: <20111213004959.GD3699@sigill.intra.peff.net>
References: <20111213003925.GA28403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Sawicki <kevin@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGZM-0005V6-1G
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1LMAuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:50:03 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48432
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753709Ab1LMAuC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:50:02 -0500
Received: (qmail 8400 invoked by uid 107); 13 Dec 2011 00:56:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 19:56:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:49:59 -0500
Content-Disposition: inline
In-Reply-To: <20111213003925.GA28403@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186993>

This function was used for comparing local and remote ref
names during fetch (which makes it a candidate for "most
confusingly named function of the year").

It no longer has any callers, so let's get rid of it.

Signed-off-by: Jeff King <peff@peff.net>
---
I just did the exact-string match inline in the previous patch. I could
also have modified path_match to do it. But really, I can't think of a
worse name for a global function in a system which is all about
managing content in paths. Unless, you know, it actually matched paths.
Which it doesn't.

 cache.h   |    1 -
 connect.c |   21 ---------------------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 408e880..2ad063f 100644
--- a/cache.h
+++ b/cache.h
@@ -1029,7 +1029,6 @@ struct ref {
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
-extern int path_match(const char *path, int nr, char **match);
 struct extra_have_objects {
 	int nr, alloc;
 	unsigned char (*array)[20];
diff --git a/connect.c b/connect.c
index 48df90b..2a0a040 100644
--- a/connect.c
+++ b/connect.c
@@ -105,27 +105,6 @@ int server_supports(const char *feature)
 		strstr(server_capabilities, feature) != NULL;
 }
 
-int path_match(const char *path, int nr, char **match)
-{
-	int i;
-	int pathlen = strlen(path);
-
-	for (i = 0; i < nr; i++) {
-		char *s = match[i];
-		int len = strlen(s);
-
-		if (!len || len > pathlen)
-			continue;
-		if (memcmp(path + pathlen - len, s, len))
-			continue;
-		if (pathlen > len && path[pathlen - len - 1] != '/')
-			continue;
-		*s = 0;
-		return (i + 1);
-	}
-	return 0;
-}
-
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-- 
1.7.8.13.g74677
