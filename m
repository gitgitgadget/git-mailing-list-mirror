From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix embarrassing "git log --follow" bug
Date: Mon, 8 Oct 2007 13:42:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710081337490.4964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 22:43:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IezRK-0005Bz-Ve
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 22:42:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbXJHUmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbXJHUms
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 16:42:48 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42978 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158AbXJHUms (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Oct 2007 16:42:48 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98KggJN002051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 8 Oct 2007 13:42:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l98Kgf0U018622;
	Mon, 8 Oct 2007 13:42:41 -0700
X-Spam-Status: No, hits=-2.738 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60336>


It turns out that I completely broke "git log --follow" with my recent 
patch to revision.c ("Fix revision log diff setup, avoid unnecessary diff 
generation", commit b7bb760d5ed4881422673d32f869d140221d3564).

Why? Because --follow obviously requires the diff machinery to function, 
exactly the same way pickaxe does.

So everybody is away right now, but considering that nobody even noticed 
this bug, I don't think it matters. But for the record, here's the trivial 
one-liner fix (well, two, since I also fixed the comment).

Because of the nature of the bug, if you ask for patches when following 
(which is one of the things I normally do), the bug is hidden, because 
then the request for diff output will automatically also enable the diffs 
themselves.

So while "git log --follow <filename>" didn't work, adding a "-p" 
magically made it work again even without this fix.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 revision.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 5d294be..e76da0d 100644
--- a/revision.c
+++ b/revision.c
@@ -1241,8 +1241,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
 		revs->diff = 1;
 
-	/* Pickaxe needs diffs */
-	if (revs->diffopt.pickaxe)
+	/* Pickaxe and rename following needs diffs */
+	if (revs->diffopt.pickaxe || revs->diffopt.follow_renames)
 		revs->diff = 1;
 
 	if (revs->topo_order)
