From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/6] Teach diff-tree-helper to handle unmerged paths.
Date: Tue, 26 Apr 2005 23:27:28 -0700
Message-ID: <7vk6moivjj.fsf@assigned-by-dhcp.cox.net>
References: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 08:23:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQfw7-0000Ik-3Z
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 08:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbVD0G1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 02:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVD0G1d
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 02:27:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:22771 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261678AbVD0G13 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 02:27:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050427062727.JAZD550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 27 Apr 2005 02:27:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vekcwkagr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 26 Apr 2005 23:19:48 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This patch teaches diff-tree-helper to call diff_unmrege() so
that it can report unmerged paths to GIT_EXTERNAL_DIFF, instead
of consuming it on its own.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff-tree-helper.c |    2 +-
1 files changed, 1 insertion(+), 1 deletion(-)

To be tested with the following:

    GIT_INDEX_FILE=junk
    export GIT_INDEX_FILE
    read-tree $(cat .git/HEAD)
    t1=$(write-tree)
    date >trash ; update-cache --add trash
    t2=$(write-tree)
    read-tree -m $(cat .git/HEAD) $t1 $t2
    update-cache --refresh
    ./show-diff | GIT_EXTERNAL_DIFF=echo ./diff-tree-helper

--- k/diff-tree-helper.c
+++ l/diff-tree-helper.c
@@ -56,7 +56,7 @@ static int parse_diff_tree_output(const 
 
 	switch (*cp++) {
 	case 'U':
-		fprintf(stderr, "warning: unmerged path %s\n", cp+1);
+		diff_unmerge(cp + 1);
 		return WARNED_OURSELVES;
 	case '+':
 		old->file_valid = 0;

