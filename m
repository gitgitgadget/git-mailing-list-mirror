From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH v3 1/9] decorate.c: compact table when growing
Date: Sun,  5 May 2013 18:32:49 +0300
Message-ID: <1367767977-14513-2-git-send-email-kevin@bracey.fi>
References: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 17:44:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ16c-0001zc-LQ
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 17:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951Ab3EEPoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 11:44:02 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:35024 "EHLO
	mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751910Ab3EEPn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 11:43:59 -0400
Received: from mail636.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 4CECCDC17CC
	for <git@vger.kernel.org>; Sun,  5 May 2013 17:33:02 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 5 May 2013 17:33:07 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 5 May 2013 17:33:06 +0200
X-Ovh-Mailout: 178.32.228.2 (mo2.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g682c2d9
In-Reply-To: <1367767977-14513-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 8913186614384890079
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -58
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedriedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -58
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedriedvucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenudcurhgrnhguohhmuchsthhrihhnghdlshdmucdlgedvmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223406>

When growing the table, take the opportunity to "compact" it by removing
entries with NULL decoration.

Users may have "removed" decorations by passing NULL to
insert_decoration. An object's table entry can't actually be removed
during normal operation, as it would break the linear hash collision
search. But we can remove NULL decoration entries when rebuilding the
table.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 decorate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/decorate.c b/decorate.c
index 2f8a63e..7cb5d29 100644
--- a/decorate.c
+++ b/decorate.c
@@ -49,7 +49,7 @@ static void grow_decoration(struct decoration *n)
 		const struct object *base = old_hash[i].base;
 		void *decoration = old_hash[i].decoration;
 
-		if (!base)
+		if (!decoration)
 			continue;
 		insert_decoration(n, base, decoration);
 	}
-- 
1.8.3.rc0.28.g682c2d9
