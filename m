From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 7/9] git-verify-pack: buffer overrun paranoia
Date: Thu, 10 Aug 2006 17:02:36 +0200
Message-ID: <11552221583008-git-send-email-rene.scharfe@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 17:02:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBC3c-0007Kf-Ll
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 17:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWHJPCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 11:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161304AbWHJPCo
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 11:02:44 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:10437
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1161306AbWHJPCk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 11:02:40 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id B42697034; Thu, 10 Aug 2006 17:02:38 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.2.rc4.g242a
In-Reply-To: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25187>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 verify-pack.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/verify-pack.c b/verify-pack.c
index 94fe0f3..1076001 100644
--- a/verify-pack.c
+++ b/verify-pack.c
@@ -26,6 +26,15 @@ static int verify_one_pack(const char *p
 		len += 4;
 	}
 
+	/*
+	 * add_packed_git() uses our buffer (containing "foo.idx") to
+	 * build the pack filename ("foo.pack").  Make sure it fits.
+	 */
+	if (len + 1 >= PATH_MAX) {
+		arg[len - 4] = '\0';
+		return error("name too long: %s.pack", arg);
+	}
+
 	pack = add_packed_git(arg, len, 1);
 	if (!pack)
 		return error("packfile %s not found.", arg);
-- 
1.4.2.rc2.g822a
