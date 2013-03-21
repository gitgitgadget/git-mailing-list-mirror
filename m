From: Jeff King <peff@peff.net>
Subject: [PATCH 2/4] fast-import: use pointer-to-pointer to keep list tail
Date: Thu, 21 Mar 2013 07:08:17 -0400
Message-ID: <20130321110817.GB18819@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 21 12:08:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIdMa-000578-7m
	for gcvg-git-2@plane.gmane.org; Thu, 21 Mar 2013 12:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741Ab3CULIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Mar 2013 07:08:25 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756615Ab3CULIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Mar 2013 07:08:24 -0400
Received: (qmail 20718 invoked by uid 107); 21 Mar 2013 11:10:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Mar 2013 07:10:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2013 07:08:17 -0400
Content-Disposition: inline
In-Reply-To: <20130321110338.GA18552@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218709>

This is shorter, idiomatic, and it means the compiler does
not get confused about whether our "e" pointer is valid,
letting us drop the "e = e" hack.

Signed-off-by: Jeff King <peff@peff.net>
---
And it fixes an instance of Linus's "people do not understand pointers"
from here:

  http://meta.slashdot.org/story/12/10/11/0030249/linus-torvalds-answers-your-questions

 fast-import.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index c2a814e..583a439 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2613,7 +2613,7 @@ static struct hash_list *parse_merge(unsigned int *count)
 
 static struct hash_list *parse_merge(unsigned int *count)
 {
-	struct hash_list *list = NULL, *n, *e = e;
+	struct hash_list *list = NULL, **tail = &list, *n;
 	const char *from;
 	struct branch *s;
 
@@ -2641,11 +2641,9 @@ static struct hash_list *parse_merge(unsigned int *count)
 			die("Invalid ref name or SHA1 expression: %s", from);
 
 		n->next = NULL;
-		if (list)
-			e->next = n;
-		else
-			list = n;
-		e = n;
+		*tail = n;
+		tail = &n->next;
+
 		(*count)++;
 		read_next_command();
 	}
-- 
1.8.2.rc2.8.g2161951
