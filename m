From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Invalidate cache-tree entries for touched paths in git-apply.
Date: Sun, 23 Apr 2006 18:25:58 -0700
Message-ID: <7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 03:26:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXpq0-0006fl-Na
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 03:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWDXB0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 21:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWDXB0A
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 21:26:00 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11185 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751476AbWDXBZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 21:25:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424012559.OIWS24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 21:25:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 23 Apr 2006 16:52:52 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19080>

Junio C Hamano <junkio@cox.net> writes:

>  * ... then the big rock falls.  With this, I tried to apply and
>    then write-tree "diff-tree -p $commit^1 $commit" on top of
>    "$commit^1" for the last 20 or so commits in the kernel tree.
>    The "master" version takes 0.15 second per patch on my Duron
>    750 with 700MB, while this one does that in 0.06 second.
>    This also helps the memory pressure because we do not have to
>    regenerate unchanged trees.  810 minor faults with the patch
>    vs 2150 minor faults without.

Sorry, but not really.  The patch is wrong and the measurement
was flawed.

It was doing unnecessarily more work in git-apply, which made
git-write-tree a no-op, and I was measuring only git-write-tree.

The following goes on top of the series to remove that
unnecessary work from git-apply.  Unfortunately this makes the
overall combination a bit slower than before X-<.

But I have not optimized cache-tree.c for speed; for example,
its subtree lists are not even sorted.  Once that is done we may
get decent speedups from the combo.

---
diff --git a/apply.c b/apply.c
index 5fa2c1e..e283df3 100644
--- a/apply.c
+++ b/apply.c
@@ -1935,8 +1935,6 @@ static int apply_patch(int fd, const cha
 				  active_cache_sha1) ||
 		    commit_index_file(&cache_file))
 			die("Unable to write new cachefile");
-		cache_tree_update(active_cache_tree,
-				  active_cache, active_nr, 1);
 		write_cache_tree(active_cache_sha1, active_cache_tree);
 	}
 
