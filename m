From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] 'git mv a/fileA b/fileB' causes 'c/fileC' to be deleted
Date: Sun, 01 Oct 2006 22:20:13 -0700
Message-ID: <7vmz8fxpiq.fsf@assigned-by-dhcp.cox.net>
References: <750170aa0610010721p66899ba5pcc7efa13be4cd10a@mail.gmail.com>
	<7vpsdc0wkz.fsf@assigned-by-dhcp.cox.net>
	<750170aa0610011833n39271704q349d86af76832783@mail.gmail.com>
	<7vven3xq7l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 07:20:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUGE1-00043B-3X
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 07:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbWJBFUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 01:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWJBFUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 01:20:16 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12944 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932614AbWJBFUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 01:20:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061002052013.LBEV6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Oct 2006 01:20:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VHL71V00z1kojtg0000000
	Mon, 02 Oct 2006 01:20:08 -0400
To: "Michael Cassar" <m.e.cassar@gmail.com>
In-Reply-To: <7vven3xq7l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 01 Oct 2006 22:05:18 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28217>

Junio C Hamano <junkio@cox.net> writes:

> Thanks.  I see it reproduces.
>
> It is a bug in git-mv that fails to update cache-tree data
> structure properly.  This patch should fix it.

The previous patch was safer but unnecessarily was a bit heavy
handed.  This should fix it nicer.

-- >8 --
git-mv: invalidate the removed path properly in cache-tree

The command updated the cache without invalidating the cache
tree entries while removing an existing entry.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/builtin-mv.c b/builtin-mv.c
index 4d21d88..54dd3bf 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -278,6 +278,7 @@ int cmd_mv(int argc, const char **argv, 
 		for (i = 0; i < deleted.nr; i++) {
 			const char *path = deleted.items[i].path;
 			remove_file_from_cache(path);
+			cache_tree_invalidate_path(active_cache_tree, path);
 		}
 
 		if (active_cache_changed) {
