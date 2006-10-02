From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] 'git mv a/fileA b/fileB' causes 'c/fileC' to be deleted
Date: Sun, 01 Oct 2006 22:05:18 -0700
Message-ID: <7vven3xq7l.fsf@assigned-by-dhcp.cox.net>
References: <750170aa0610010721p66899ba5pcc7efa13be4cd10a@mail.gmail.com>
	<7vpsdc0wkz.fsf@assigned-by-dhcp.cox.net>
	<750170aa0610011833n39271704q349d86af76832783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 02 07:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUFzb-00022u-4n
	for gcvg-git@gmane.org; Mon, 02 Oct 2006 07:05:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932603AbWJBFFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Oct 2006 01:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbWJBFFU
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Oct 2006 01:05:20 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13038 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932603AbWJBFFT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Oct 2006 01:05:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061002050519.WCAT16798.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Mon, 2 Oct 2006 01:05:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VH5D1V00P1kojtg0000000
	Mon, 02 Oct 2006 01:05:14 -0400
To: "Michael Cassar" <m.e.cassar@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28216>

Thanks.  I see it reproduces.

It is a bug in git-mv that fails to update cache-tree data
structure properly.  This patch should fix it.

-- >8 --
git-mv: do not write out a bogus cache-tree in the index

The command updates the cache without invalidating the cache
tree entries.  Since this is not as performance critical as
one-tree and two-tree git-read-tree and git-apply, disable
use of cache-tree entirely.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/builtin-mv.c b/builtin-mv.c
index 4d21d88..9a4e2e0 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -83,6 +83,9 @@ int cmd_mv(int argc, const char **argv, 
 	if (read_cache() < 0)
 		die("index file corrupt");
 
+	/* This does not manage cache-tree properly */
+	cache_tree_free(&active_cache_tree);
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
