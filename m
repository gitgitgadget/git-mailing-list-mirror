From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "git-push $URL" without refspecs pushes only matching branches
Date: Sun, 01 Jul 2007 19:00:08 -0700
Message-ID: <7v7ipj1s5z.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
	<alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
	<200706121007.17044.andyparkins@gmail.com>
	<alpine.LFD.0.98.0706120800430.14121@woody.linux-foundation.org>
	<7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, plexq@plexq.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 04:00:31 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5BDJ-0000xL-DB
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 04:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbXGBCAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 22:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755660AbXGBCAL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 22:00:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34563 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbXGBCAK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 22:00:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070702020008.UUK6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 22:00:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JS081X0051kojtg0000000; Sun, 01 Jul 2007 22:00:08 -0400
In-Reply-To: <7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Tue, 12 Jun 2007 10:00:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51334>

When "git push" is run without any refspec (neither on the
command line nor in the config), we used to push "matching refs"
in the sense that anything under refs/ hierarchy that exist on
both ends were updated.  This used to be a sane default for
publishing your repository to another back when we did not have
refs/remotes/ hierarchy, but it does not make much sense these
days.

This changes the semantics to push only "matching branches".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Junio C Hamano <gitster@pobox.com> writes:

 > Probably we should not do push anything other than refs/heads/
 > when we do "matching refs"
 >
 > I think what we might want to do around this area are:
 >
 >  - Don't change anything, if the command line says refspec, or
 >    the remote has push refspec specified.
 >
 >  - When doing 'matching refs', do it only under refs/heads/.
 >
 >  - Ship with a receive-pack hook that attempts a 3-way merge
 >    update when the currently checked out branch is updated.
 >
 > Additionally we can give an option to "git clone" (or "git
 > remote add") to arrange the cross-push configuration for
 > mothership-satellite Andy showed in the clone's .git/config;
 > but I think that is a separate issue.

 remote.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 500ca4d..cf98a44 100644
--- a/remote.c
+++ b/remote.c
@@ -544,6 +544,13 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			if (!pat)
 				continue;
 		}
+		else if (prefixcmp(src->name, "refs/heads/"))
+			/*
+			 * "matching refs"; traditionally we pushed everything
+			 * including refs outside refs/heads/ hierarchy, but
+			 * that does not make much sense these days.
+			 */
+			continue;
 
 		if (pat) {
 			const char *dst_side = pat->dst ? pat->dst : pat->src;
