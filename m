From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/9] git-verify-pack: more careful path handling
Date: Thu, 10 Aug 2006 17:02:32 +0200
Message-ID: <11552221581834-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:03:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3Y-0007Kf-IV
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbWHJPCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWHJPCk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:40 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:8133
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161297AbWHJPCj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:39 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 7D7B5702B; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25191>

Use strlcpy() to copy the filename into a buffer and complain if it
doesn't fit.  Also move the path buffer into verify_one_pack(); it is
used only there.  Now we can const'ify the first argument of this
function.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/verify-pack.c b/verify-pack.c
index 7201596..2c814a6 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -1,10 +1,15 @@
 #include "cache.h"
 #include "pack.h"
 
-static int verify_one_pack(char *arg, int verbose)
+static int verify_one_pack(const char *path, int verbose)
 {
-	int len = strlen(arg);
+	char arg[PATH_MAX];
+	int len;
 	struct packed_git *g;
+
+	len = strlcpy(arg, path, PATH_MAX);
+	if (len >= PATH_MAX)
+		return error("name too long: %s", path);
 	
 	while (1) {
 		/* Should name foo.idx, but foo.pack may be named;
@@ -37,8 +42,6 @@ int main(int ac, char **av)
 	int nothing_done = 1;
 
 	while (1 < ac) {
-		char path[PATH_MAX];
-
 		if (!no_more_options && av[1][0] == '-') {
 			if (!strcmp("-v", av[1]))
 				verbose = 1;
@@ -48,8 +51,7 @@ int main(int ac, char **av)
 				usage(verify_pack_usage);
 		}
 		else {
-			strcpy(path, av[1]);
-			if (verify_one_pack(path, verbose))
+			if (verify_one_pack(av[1], verbose))
 				errs++;
 			nothing_done = 0;
 		}
-- 
1.4.2.rc2.g822a
