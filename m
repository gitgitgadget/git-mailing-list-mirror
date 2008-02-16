From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] parse_tag: fail, if tagged objected would be NULL
Date: Sat, 16 Feb 2008 14:04:40 +0100
Message-ID: <12031670802582-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 14:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQMjD-0004Rk-VF
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 14:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbYBPNEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 08:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbYBPNEm
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 08:04:42 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:34428 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbYBPNEl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 08:04:41 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 771C3680B59A;
	Sat, 16 Feb 2008 14:04:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VArJtoQiyU9l; Sat, 16 Feb 2008 14:04:40 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 57BAE68018CD; Sat, 16 Feb 2008 14:04:40 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74044>

The cause of a NULL in tag->tagged can be:
* a unknown object type is used
* the tag points to a object with an other type as stated
  in the tag.

Both situations are most likley be caused by a not welformed
tag. Catching this error here avoids doing tag->tagged!=NULL
checks in the rest of git.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
In my option, this change would simplity many things.

tag.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tag.c b/tag.c
index 38bf913..96fef70 100644
--- a/tag.c
+++ b/tag.c
@@ -82,8 +82,12 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	} else {
 		error("Unknown type %s", type);
 		item->tagged = NULL;
+		return -1;
 	}
 
+	if (!item->tagged)
+		return -1;
+
 	if (item->tagged && track_object_refs) {
 		struct object_refs *refs = alloc_object_refs(1);
 		refs->ref[0] = item->tagged;
-- 
1.5.4.1.gcb4c5
