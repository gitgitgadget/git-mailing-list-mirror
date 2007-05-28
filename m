From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 1/3] builtin-pack-objects: don't fail, if delta is not possible
Date: Mon, 28 May 2007 23:20:57 +0200
Message-ID: <11803872591522-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsmeR-00048V-7E
	for gcvg-git@gmane.org; Mon, 28 May 2007 23:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbXE1VVG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 17:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752293AbXE1VVG
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 17:21:06 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:59439 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbXE1VVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 17:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 5E1317C16AB3;
	Mon, 28 May 2007 23:21:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IqVv-4F5DRg; Mon, 28 May 2007 23:21:00 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id F30F57C16A81; Mon, 28 May 2007 23:20:59 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48646>

If builtin-pack-objects runs out of memory while finding
the best deltas, it bails out with an error.

If the delta index creation fails (because there is not enough memory),
we can downgrade the error message to a warning and continue with the
next object.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
The patches apply on top of next.

 builtin-pack-objects.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index e52332d..17627b3 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1454,8 +1454,12 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->index) {
 		src->index = create_delta_index(src->data, src_size);
-		if (!src->index)
-			die("out of memory");
+		if (!src->index) {
+			static int warned = 0;
+			if (!warned++)
+				warning("suboptimal pack - out of memory");
+			return 0;
+		}
 	}
 
 	delta_buf = create_delta(src->index, trg->data, trg_size, &delta_size, max_size);
-- 
1.5.2.846.g9a144
