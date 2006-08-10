From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 6/9] git-verify-pack: free pack after use and a cleanup
Date: Thu, 10 Aug 2006 17:02:35 +0200
Message-ID: <11552221582064-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:03:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3t-0007Pt-MW
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWHJPCt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161310AbWHJPCr
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:47 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:10181
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161303AbWHJPCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id A94617032; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25193>

Plug memory leak in verify_one_pack() by freeing the struct packed_git
we got from add_packed_git().  Also rename g to pack and pull an
assignment out of an if statement while we're at it.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/verify-pack.c b/verify-pack.c
index 1dcef52..c7bed1e 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -5,7 +5,8 @@ static int verify_one_pack(const char *p
 {
 	char arg[PATH_MAX];
 	int len;
-	struct packed_git *g;
+	struct packed_git *pack;
+	int err;
 
 	len = strlcpy(arg, path, PATH_MAX);
 	if (len >= PATH_MAX)
@@ -25,10 +26,14 @@ static int verify_one_pack(const char *p
 		len += 4;
 	}
 
-	if (!(g = add_packed_git(arg, len, 1)))
+	pack = add_packed_git(arg, len, 1);
+	if (!pack)
 		return error("packfile %s not found.", arg);
 
-	return verify_pack(g, verbose);
+	err = verify_pack(pack, verbose);
+	free(pack);
+
+	return err;
 }
 
 static const char verify_pack_usage[] = "git-verify-pack [-v] <pack>...";
-- 
1.4.2.rc2.g822a
