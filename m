From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach diff-tree to report unmodified paths for -C option.
Date: Sat, 21 May 2005 03:11:49 -0700
Message-ID: <7vpsvkj3bu.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7vzmuokjhg.fsf@assigned-by-dhcp.cox.net>
	<7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 12:10:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZQwT-0006TE-2A
	for gcvg-git@gmane.org; Sat, 21 May 2005 12:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbVEUKLz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 06:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbVEUKLz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 06:11:55 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:33968 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261721AbVEUKLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2005 06:11:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050521101150.NRWY23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 May 2005 06:11:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfywgkj90.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 21 May 2005 02:42:35 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus, I have a bit of design issue that there is no way for the
diff-core layer to affect the behaviour of the caller.  It is
not too big a problem with others, but for diff-tree the effect
is prominent.

If you do this:

  ./git-rev-list HEAD | ./git-diff-tree -Sdiff-tree-helper --stdin -M

you will get many uninteresting headers from git-diff-tree,
until you hit something "interesting".  What I want to see in
this case is probably to omit the header and commit information
diff-tree usually gives while "pickaxe" filters everything out
(i.e. nothing interesting to report), and teach diff-tree to do
the header thing only when diff-core says there is something
interesting.  So far I haven't found a good way to do this.

Another useless comment.  For obvious reasons, there is nothing
we can do about the diff-helper to add "the other half of copy
detection information", because what it can tell diff-core is
limited to its input, which usually is just differences prepared
by somebody else, and it cannot know anything about unchanged
files.  When I started pushing '-p' flag to diff-tree family, I
remember that your reaction was neutral to moderately negative
("I'd tolerate, although I think it is redundant and you are not
even generating diff yourself anyway" as opposed to "That's just
great").  I think now you would thank me for shoving the diff
interface into them ;-).

I did not touch diff-tree for full-scale -C option in the last
series, but if you want to have it, it is easy.

This one is untested but it should just work (TM).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
# - HEAD: Diff overhaul, adding the other half of copy detection.
# + (working tree)
diff --git a/diff-tree.c b/diff-tree.c
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -117,7 +117,7 @@ static int compare_tree_entry(void *tree
 		show_file("+", tree2, size2, base);
 		return 1;
 	}
-	if (!memcmp(sha1, sha2, 20) && mode1 == mode2)
+	if (!memcmp(sha1, sha2, 20) && mode1 == mode2 && detect_rename < 2)
 		return 0;
 
 	/*


