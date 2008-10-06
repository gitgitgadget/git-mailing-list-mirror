From: Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH] Do not use errno when pread() returns 0
Date: Mon,  6 Oct 2008 19:28:41 +0200
Message-ID: <1223314121-21528-1-git-send-email-sam@rfc1149.net>
Cc: Samuel Tardieu <sam@rfc1149.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 06 19:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmuDm-0007v4-Ph
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbYJFRsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbYJFRsy
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:48:54 -0400
Received: from revol2.enst.fr ([137.194.2.14]:54562 "EHLO smtp2.enst.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbYJFRsx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 13:48:53 -0400
X-Greylist: delayed 1210 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Oct 2008 13:48:53 EDT
Received: from localhost (localhost [127.0.0.1])
	by smtp2.enst.fr (Postfix) with ESMTP id 821B6B833B;
	Mon,  6 Oct 2008 19:28:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at enst.fr
Received: from arrakis.enst.fr (arrakis.enst.fr [137.194.161.143])
	by smtp2.enst.fr (Postfix) with ESMTP id 5234DB833A;
	Mon,  6 Oct 2008 19:28:41 +0200 (CEST)
Received: by arrakis.enst.fr (Postfix, from userid 1000)
	id 460142094D; Mon,  6 Oct 2008 19:28:41 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.778.gaeab5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97612>

If we use pread() while at the end of the file, it will return 0, which is
not an error from the operating system point of view. In this case, errno
has not been set and must not be used.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>

---
 index-pack.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index 2e4c088..73860bf 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -365,8 +365,11 @@ static void *get_data_from_pack(struct object_entry *obj)
 	data = src;
 	do {
 		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
-		if (n <= 0)
+		if (n < 0)
 			die("cannot pread pack file: %s", strerror(errno));
+		if (!n)
+			die("premature end of pack file, %lu bytes missing",
+			    len - rdy);
 		rdy += n;
 	} while (rdy < len);
 	data = xmalloc(obj->size);
-- 
tg: (395ff9b..) short-pread (depends on: spearce/next)
