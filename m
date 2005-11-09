From: Junio C Hamano <junkio@cox.net>
Subject: Re: Regarding: git-lost+found
Date: Wed, 09 Nov 2005 13:25:24 -0800
Message-ID: <7vvez1bjjv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 22:30:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZxRi-0003pp-Of
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 22:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKIVZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 16:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVKIVZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 16:25:27 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62438 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750713AbVKIVZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2005 16:25:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109212456.OVNB9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Nov 2005 16:24:56 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11414>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I think this is a valuable addition to the "Now what?" part of git. 
> However, I'd like to see the results stored into .git/refs/lost+found/ 
> rather than .git/lost+found/, so that it is possible to inspect them 
> easily with gitk or git-show-branch.

I've thought about it, but on the other hand, having them under
refs/ hierarchy means fsck-objects would think they are relevant
and prune would never be able to remove them anymore.

The scenario that git-lost+found would be useful is after you
did 'git branch -D', 'git tag -d', or 'git tag -f' and removed
something you did not mean to by accident.  You would find what
you want with git-lost+found and perhaps with help from gitk,
and then reconnect them.  At that point, it is very likely that
you would forget to clean the remainder afterwards.  Later, you
probably forget you have ever run git-lost+found, and would
start wondering why git-prune would not remove any leftover
anymore.

Maybe we could use .git/lost+found/{commit,other}/?{40} and hang
committish under one directory and the rest in another?  Then we
could do this:

          $ gitk $(cd .git/lost+found/commit && echo ??*)

After you find what you want, you would do 'git tag' or 'git
branch' to reconnect them, but we can reasonably expect that is
to happen soon after you ran lost+found and before the next time
you run prune, because that was why you ran git-lost+found in
the first place.

Prune will remove the objects reachable only from lost+found, so
the above gitk command line would fail if run after you did
git-lost+found and then git-prune in this order, but that is an
unlikely sequence.

So, based on the above reasoning, how about this one?

-- >8 -- cut here -- >8 --
[PATCH] lost+found: make it a bit more useful with gitk

This separates the committish from others when resurrecting
dangling objects to .git/lost+found/ hierarchy.  After running
git-lost+found command, you could:

          $ gitk $(cd .git/lost+found/commit && echo ??*)

to see how these branches came about from known old tags.

---
diff --git a/git-lost+found.sh b/git-lost+found.sh
index bc1e988..b6b2616 100755
--- a/git-lost+found.sh
+++ b/git-lost+found.sh
@@ -3,18 +3,21 @@
 . git-sh-setup || die "Not a git archive."
 
 laf="$GIT_DIR/lost+found"
-mkdir -p "$laf" || exit
+rm -fr "$laf" && mkdir -p "$laf/commit" "$laf/other" || exit
 
 git fsck-objects |
 while read dangling type sha1
 do
 	case "$dangling" in
 	dangling)
-		echo "$sha1" >"$laf/$sha1"
-		case "$type" in
-		commit | tag)
-			git-show-branch "$sha1" ;;
-		esac
+		if git-rev-parse --verify "$sha1^0" >/dev/null 2>/dev/null
+		then
+			dir="$laf/commit"
+			git-show-branch "$sha1"
+		else
+			dir="$laf/other"
+		fi
+		echo "$sha1" >"$dir/$sha1"
 		;;
 	esac
 done
