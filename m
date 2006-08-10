From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/9] git-verify-pack: get rid of while loop
Date: Thu, 10 Aug 2006 17:02:34 +0200
Message-ID: <11552221581038-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:04:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3x-0007Pt-Dt
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161319AbWHJPCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161314AbWHJPCp
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:45 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:10693
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161307AbWHJPCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 9F9447030; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25195>

Get rid of that while loop which was apparently used as a way to avoid
goto's (why?).  It's easy now because there is only one break left at
the end of it.  Also make the comment clearer.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff a/verify-pack.c b/verify-pack.c
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -11,23 +11,23 @@
 	if (len >= PATH_MAX)
 		return error("name too long: %s", path);
 	
-	while (1) {
-		/* Should name foo.idx, but foo.pack may be named;
-		 * convert it to foo.idx
-		 */
-		if (has_extension(arg, len, ".pack")) {
-			strcpy(arg + len - 5, ".idx");
-			len--;
-		} else if (!has_extension(arg, len, ".idx")) {
-			if (len + 4 >= PATH_MAX)
-				return error("name too long: %s.idx", arg);
-			strcpy(arg + len, ".idx");
-			len += 4;
-		}
-		if ((g = add_packed_git(arg, len, 1)))
-			break;
-		return error("packfile %s not found.", arg);
+	/*
+	 * In addition to "foo.idx" we accept "foo.pack" and "foo";
+	 * normalize these forms to "foo.idx" for add_packed_git().
+	 */
+	if (has_extension(arg, len, ".pack")) {
+		strcpy(arg + len - 5, ".idx");
+		len--;
+	} else if (!has_extension(arg, len, ".idx")) {
+		if (len + 4 >= PATH_MAX)
+			return error("name too long: %s.idx", arg);
+		strcpy(arg + len, ".idx");
+		len += 4;
 	}
+
+	if (!(g = add_packed_git(arg, len, 1)))
+		return error("packfile %s not found.", arg);
+
 	return verify_pack(g, verbose);
 }
 
