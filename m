From: Junio C Hamano <junkio@cox.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 12:28:45 -0800
Message-ID: <7vfy8urngi.fsf@assigned-by-dhcp.cox.net>
References: <45E1E47C.5090908@verizon.net>
	<7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 21:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLPzN-0005Wp-Jb
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 21:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932985AbXBYU2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 15:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932995AbXBYU2r
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 15:28:47 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49113 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932985AbXBYU2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 15:28:46 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070225202845.SGCE2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Feb 2007 15:28:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TwUl1W0061kojtg0000000; Sun, 25 Feb 2007 15:28:45 -0500
In-Reply-To: <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 25 Feb 2007 11:54:36 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40573>

Junio C Hamano <junkio@cox.net> writes:

> Ah, I know what is going on.  "update-index --refresh" notices
> that lstat(2) says the size is different between what is
> recorded in the index, and does not actually compare and refresh
> the entry.
>
> But that is a very important optimization, and I do not think we
> would want to cripple that for autoCRLF.

It might be interesting to try this patch.

Usually we _trust_ the index and say that the path has been
modified if what its length on the filesystem returned by
lstat(2) does not match with what is recorded in the index.

What this patch does is to disable that optimization when
autocrlf is in effect.  The change would make all paths whose
size, read by lstat(2) from the filesystem, does not match what
is recorded in the index to be re-validated by comparing the
data, and if it is found not to have been modified, refresh the
index by updating the size information (and other information
such as mtime).  In other words, this would probably make it
prohibitibly expensive on autocrlf filesystems if you leave many
paths dirty to run update-index --refresh (hence status and
commit).


diff --git a/read-cache.c b/read-cache.c
index 605b352..11b8b56 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -225,11 +225,15 @@ int ce_modified(struct cache_entry *ce, struct stat *st, int really)
 	if (changed & (MODE_CHANGED | TYPE_CHANGED))
 		return changed;
 
-	/* Immediately after read-tree or update-index --cacheinfo,
+	/*
+	 * Immediately after read-tree or update-index --cacheinfo,
 	 * the length field is zero.  For other cases the ce_size
 	 * should match the SHA1 recorded in the index entry.
+	 * However, use of core.autocrlf can screw us up badly.
 	 */
-	if ((changed & DATA_CHANGED) && ce->ce_size != htonl(0))
+	if ((changed & DATA_CHANGED) &&
+	    ce->ce_size != htonl(0) &&
+	    !auto_crlf)
 		return changed;
 
 	changed_fs = ce_modified_check_fs(ce, st);
