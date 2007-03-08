From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-branch: rename nor delete should not work when HEAD is detached.
Date: Thu, 08 Mar 2007 14:10:51 -0800
Message-ID: <7virdb8jys.fsf_-_@assigned-by-dhcp.cox.net>
References: <45EFB205.4000604@lu.unisi.ch>
	<7vzm6o9ie1.fsf@assigned-by-dhcp.cox.net>
	<45EFDE4B.3010408@lu.unisi.ch>
	<7vabyo9gr6.fsf@assigned-by-dhcp.cox.net>
	<7vr6rz8khv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	bonzini@gnu.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 23:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPQp8-00068L-7w
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 23:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030761AbXCHWKy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 17:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030762AbXCHWKx
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 17:10:53 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35333 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030761AbXCHWKw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 17:10:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308221052.LEHD26279.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Mar 2007 17:10:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YNAr1W00Q1kojtg0000000; Thu, 08 Mar 2007 17:10:52 -0500
In-Reply-To: <7vr6rz8khv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 08 Mar 2007 13:59:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41775>

While reviewing the latest round of 'branch --track' changes, I
noticed that we do not do anything special when renaming or
deleting a detached HEAD.  We do not have anything to rename nor
delete in this case, so instead of attempting to rename/delete
refs/heads/HEAD, we should error out.

---
 * CC'ed are not guilty parties, but people who might know the
   code better than others.

diff --git a/builtin-branch.c b/builtin-branch.c
index 06d8a8c..28d4b71 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -483,6 +483,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		die("Failed to resolve HEAD as a valid ref.");
 	if (!strcmp(head, "HEAD")) {
 		detached = 1;
+		if (rename || delete)
+			die("Cannot rename nor delete a detached HEAD");
 	}
 	else {
 		if (prefixcmp(head, "refs/heads/"))
