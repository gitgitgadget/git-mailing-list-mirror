From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/9] git-verify-pack: insist on .idx extension
Date: Thu, 10 Aug 2006 17:02:33 +0200
Message-ID: <11552221583172-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:03:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3X-0007Kf-Tq
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161302AbWHJPCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbWHJPCk
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:40 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:9157
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161302AbWHJPCj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:39 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 8EACE702C; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25192>

git-verify-pack can be called with a filename without .idx extension.
add_packed_git() on the other hand depends on its presence.  So
instead of trying to call it with whatever the user gave us check for
that extension and add it if it's missing.

That means that you can't name your index file "blah" and your pack
file ".pack" anymore ("git-verify-pack blah" currently works in that
case).  I think this regression is a good change. ;-)

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff a/verify-pack.c b/verify-pack.c
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -18,13 +18,12 @@
 		if (has_extension(arg, len, ".pack")) {
 			strcpy(arg + len - 5, ".idx");
 			len--;
+		} else if (!has_extension(arg, len, ".idx")) {
+			if (len + 4 >= PATH_MAX)
+				return error("name too long: %s.idx", arg);
+			strcpy(arg + len, ".idx");
+			len += 4;
 		}
-		/* Should name foo.idx now */
-		if ((g = add_packed_git(arg, len, 1)))
-			break;
-		/* No?  did you name just foo? */
-		strcpy(arg + len, ".idx");
-		len += 4;
 		if ((g = add_packed_git(arg, len, 1)))
 			break;
 		return error("packfile %s not found.", arg);
