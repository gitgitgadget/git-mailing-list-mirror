From: Junio C Hamano <junkio@cox.net>
Subject: Re: bisect gives strange answer
Date: Wed, 03 Aug 2005 23:57:01 -0700
Message-ID: <7v8xzi42bm.fsf@assigned-by-dhcp.cox.net>
References: <E1E0XjN-000102-Un@approximate.corpus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 04 08:57:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0ZfY-0004eJ-By
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 08:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVHDG5J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 02:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVHDG5J
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 02:57:09 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:58361 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261880AbVHDG5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 02:57:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050804065700.MAEK19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 02:57:00 -0400
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk> writes:

> + git bisect bad
> Bisecting: 2 revisions left to test after this
> + cat .git/HEAD
> b4634484815e1879512a23e4f59eef648135c30a
> + git bisect bad
> b4634484815e1879512a23e4f59eef648135c30a is first bad commit
> diff-tree b4634484815e1879512a23e4f59eef648135c30a (from 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737)
> The answer makes no sense since my .config doesn't use the bt87x driver
> (the TP600X uses a snd-cs46xx).  To be sure, I checked the diff with
>
>   git diff 3d3c2ae1101c1f2dff7e2f9d514769779dbd2737..b4634484815e1879512a23e4f59eef648135c30a
>
> The commit changed only sound/pci/bt87x.c
>
> I do believe this line at the end of the bisection:
>
>   b4634484815e1879512a23e4f59eef648135c30a is first bad commit
>...
> I suspect that bisect jumped the gun at the end, and that there are a
> few more revisions to test.

Thank you for a very useful reproduction recipe.  I think this
is my bug.  Could you try this please?

------------
diff --git a/git-bisect-script b/git-bisect-script
--- a/git-bisect-script
+++ b/git-bisect-script
@@ -107,8 +107,8 @@ bisect_next() {
 	rev=$(eval "git-rev-list --bisect $good $bad") || exit
 	nr=$(eval "git-rev-list $rev $good" | wc -l) || exit
 	if [ "$nr" -le "1" ]; then
-	    echo "$bad is first bad commit"
-	    git-diff-tree --pretty $bad
+	    echo "$rev is first bad commit"
+	    git-diff-tree --pretty $rev
 	    exit 0
 	fi
 	echo "Bisecting: $nr revisions left to test after this"
