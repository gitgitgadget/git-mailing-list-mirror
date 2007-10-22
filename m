From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH, take 2] Linear-time/space rename logic (exact renames
 only)
Date: Mon, 22 Oct 2007 12:44:48 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710221241560.30120@woody.linux-foundation.org>
References: <alpine.LFD.0.999.0710211603200.10525@woody.linux-foundation.org>
 <20071022070750.GM1179MdfPADPa@greensroom.kotnet.org>
 <alpine.LFD.0.999.0710220932150.10525@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710221009580.10525@woody.linux-foundation.org>
 <alpine.LFD.0.999.0710221207300.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
	Sven Verdoolaege <skimo@liacs.nl>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 21:45:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ik3Dn-0005uk-3J
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 21:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbXJVTpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 15:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbXJVTpW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 15:45:22 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:36399 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755402AbXJVTpU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Oct 2007 15:45:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MJipxj031651
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 22 Oct 2007 12:44:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9MJimsq010321;
	Mon, 22 Oct 2007 12:44:48 -0700
In-Reply-To: <alpine.LFD.0.999.0710221207300.30120@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.223 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62040>



On Mon, 22 Oct 2007, Linus Torvalds wrote:
> 
> I'm sure there's more to come..

One more detail.. The updated comment explains the issue: if we broke a 
file apart, and rename detection joined it back together, the result is 
neither a rename nor a copy, it's a regular modification (and all 
remaining renames will be copies of the original, so don't bother 
decrementing the "rename_used" count).

		Linus

---
 diff.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 2e74cb3..e839f59 100644
--- a/diff.c
+++ b/diff.c
@@ -2636,13 +2636,19 @@ static void diff_resolve_rename_copy(void)
 		 * either in-place edit or rename/copy edit.
 		 */
 		else if (DIFF_PAIR_RENAME(p)) {
-			/* See if there is some other filepair that
-			 * copies from the same source as us.  If so
-			 * we are a copy.  Otherwise we are either a
-			 * copy if the path stays, or a rename if it
-			 * does not, but we already handled "stays" case.
+			/*
+			 * A rename might have re-connected a broken
+			 * pair up, causing the pathnames to be the
+			 * same again. If so, that's not a rename at
+			 * all, just a modification..
+			 *
+			 * Otherwise, see if this source was used for
+			 * multiple renames, in which case we decrement
+			 * the count, and call it a copy.
 			 */
-			if (--p->one->rename_used > 0)
+			if (!strcmp(p->one->path, p->two->path))
+				p->status = DIFF_STATUS_MODIFIED;
+			else if (--p->one->rename_used > 0)
 				p->status = DIFF_STATUS_COPIED;
 			else
 				p->status = DIFF_STATUS_RENAMED;
