From: Elijah Newren <newren@gmail.com>
Subject: [PATCH] cache_tree_free: Fix small memory leak
Date: Mon,  6 Sep 2010 15:40:16 -0600
Message-ID: <1283809216-26867-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 23:39:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsjPB-0006sl-BL
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 23:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783Ab0IFViv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 17:38:51 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:39691 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622Ab0IFVit (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 17:38:49 -0400
Received: by pxi10 with SMTP id 10so1112425pxi.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 14:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ryUl8LPc5S048r2JLu4ZwoU1ZmepXJVuXzytTAln8N8=;
        b=Ya8H5HbhImJLyMbAsshnz212BHa6YCui8y9bXdLEgu8IxHG0ZwK+Aa19Pzyspxu8uj
         JQs/QJBTL6LudqKYvvDXo1QGd+hq/Oeulmf1OMKbjnSN8j58Lk743rDie0/j5if7wmuy
         iINIBWMdYMMOWQpsgqHyNbQ3/iRmihqR79XCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=nye7usHk12bHKl7Mc15I/yYjbCivEv2bQqqierv7qZoaz3ydg1L+FvPIfLT21XDTM+
         zOPFwQ8SlcKmxkRzZQNpl8XFjaAEq50azqa05oszNUhEPgdULva5mimRjenBagd+Jhk4
         dYwjPD5Mr36fZ8CZe/zglwDDeBNyAV6o6S0bs=
Received: by 10.114.148.15 with SMTP id v15mr381291wad.127.1283809128828;
        Mon, 06 Sep 2010 14:38:48 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r37sm12058447wak.11.2010.09.06.14.38.46
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 14:38:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.5.g2c13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155627>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache-tree.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index c60cf91..f755590 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -22,8 +22,10 @@ void cache_tree_free(struct cache_tree **it_p)
 	if (!it)
 		return;
 	for (i = 0; i < it->subtree_nr; i++)
-		if (it->down[i])
+		if (it->down[i]) {
 			cache_tree_free(&it->down[i]->cache_tree);
+			free(it->down[i]);
+		}
 	free(it->down);
 	free(it);
 	*it_p = NULL;
-- 
1.7.2.3.5.g2c13
