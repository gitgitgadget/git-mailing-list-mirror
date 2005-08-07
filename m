From: Junio C Hamano <junkio@cox.net>
Subject: use of temporary refs in resolve
Date: Sun, 07 Aug 2005 12:44:35 -0700
Message-ID: <7v3bplwmzg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 21:46:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1r4n-0005kR-Iw
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 21:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbVHGToi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 15:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbVHGToi
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 15:44:38 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50834 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1752642AbVHGToh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 15:44:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807194434.BMCI1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 15:44:34 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As promised I was looking into the fetching side today, but I
ended up trying to figure out the current operation of resolve
first.

Here is my understanding of various "temporary heads" left
directly underneath $GIT_DIR:

    HEAD      : updated only after successful auto merge.

    ORIG_HEAD : records the head value before resolve started.
                if automerge fails, this is the same as HEAD,
                but after successful automerge, this can be used
                to see what the previous head was.  This is the
                first parent of the resulting commit.

    MERGE_HEAD: present if auto merge is unsuccessful and
		records the other head being merged.

    LAST_MERGE: present if merge is unsuccessful or impossible and
		records the other head being merged.

Whenever resolve fails, LAST_MERGE would be there, while
MERGE_HEAD exists only when we attempted and failed an
automerge.  I would propose to change this to leave LAST_MERGE
only when we did not even attempt to automerge.

Also ORIG_HEAD is probably redundant.  After a successful
automerge, the same information can be had by HEAD^1, and after
a failure, it is HEAD.  We do not use the existence of that file
to detect if we are in a middle of the merge (MERGE_HEAD is used
for that purpose by git-commit).  We may want stop writing to it
in git-resolve.

What do you think?

Another thing I was thinking was to give git-resolve an ability
to take more than two commits to do octopus ;-).  Instead of
using the third argument as a merge commit message, we would say
(for backward compatibilities' sake) the last one is the
message.  When we fail halfway, things would probably become messy,
so this needs be postponed until some more thought.
