From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug in git-fsck-cache?
Date: Wed, 31 Aug 2005 13:13:56 -0700
Message-ID: <7v4q959857.fsf@assigned-by-dhcp.cox.net>
References: <20050831161529.327a7957.git@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 22:15:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAYy9-0001x7-E5
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 22:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964933AbVHaUN7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 16:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVHaUN7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 16:13:59 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:9652 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964933AbVHaUN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 16:13:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050831201358.WMLL8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 Aug 2005 16:13:58 -0400
To: Stephen Rothwell <git@ozlabs.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7985>

Stephen Rothwell <git@ozlabs.org> writes:

> The commit c594adad5653491813959277fb87a2fef54c4e05 is shown as
> "connected" (in Linus' tree, not one of my patches) by gitk, so I am happy
> that git prune did not get rid of it, but why does fsck-cache report it as
> dangling?

Hmph.  You ran fsck-cache by hand without --full (i.e. you told
it not to worry about objects already in packs); 'git prune'
runs it with '--full' to do the full connectivity analysis.  I
think that's where the difference comes from.

Is that commit reachable from any of the refs hanging under your
$GIT_DIR/refs/?  For example, do you have the Linus tip of the
master branch in $GIT_DIR/refs/heads/origin?

If an object is already in a pack and later became unreachable
from any of your refs, there is no way to remove that object
from the pack, so dangling commits in a pack will be left
dangling even after 'git prune'.

Originally, the distinction between with and without --full was
made so that once you fsck and repack, you do not have to spend
time doing full object integrity analysis (I think it still does
full reachability analysis, but I have to check).  It might be
better to remove '--full' option from fsck-cache and make the
default ot do full integrity, and introduce '--fast' option to
skip it, that is, to default on the safe side.
