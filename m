From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: gitk problems: can't unset "idinlist(...)"
Date: Fri, 20 Jul 2007 23:11:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707202304350.27249@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org>
 <20070721050912.GB20622@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 21 08:12:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC8CC-0003dn-DZ
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 08:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760353AbXGUGLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 02:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbXGUGLc
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 02:11:32 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44277 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129AbXGUGLa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 02:11:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L6BOHG024434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Jul 2007 23:11:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6L6BJiJ003532;
	Fri, 20 Jul 2007 23:11:19 -0700
In-Reply-To: <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.714 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53144>



On Fri, 20 Jul 2007, Linus Torvalds wrote:
> 
> Junio, didn't we have some parent simplification patches recently?

Yeah. Junio, I think your 11d6596709e04b8d2b429f230b2ed570d013f812 is 
buggy.

Here's a patch. Not very well tested, but it makes gitk happy and passes 
all the tests. And I really think Junio's code was very dubious (it did 
that "p = p->next" *every* time, and then did "pp = &p->next", so "pp" 
would end up jumping by multiple entries.

The new code only ever changes "pp" - either by moving p->next into it 
(delete the current entry) or by moving pp forward by one (keep the 
current entry).

That's much more logical, but somebody should double-check me anyway.

		Linus

---
Subject: Fix up duplicate parents removal

This removes duplicate parents properly, making gitk happy again.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 revision.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/revision.c b/revision.c
index 28b5f2e..7036cf2 100644
--- a/revision.c
+++ b/revision.c
@@ -1323,16 +1323,17 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 
 static void remove_duplicate_parents(struct commit *commit)
 {
-	struct commit_list *p;
-	struct commit_list **pp = &commit->parents;
+	struct commit_list **pp, *p;
 
 	/* Examine existing parents while marking ones we have seen... */
-	for (p = commit->parents; p; p = p->next) {
+	pp = &commit->parents;
+	while ((p = *pp) != NULL) {
 		struct commit *parent = p->item;
-		if (parent->object.flags & TMP_MARK)
+		if (parent->object.flags & TMP_MARK) {
+			*pp = p->next;
 			continue;
+		}
 		parent->object.flags |= TMP_MARK;
-		*pp = p;
 		pp = &p->next;
 	}
 	/* ... and clear the temporary mark */
