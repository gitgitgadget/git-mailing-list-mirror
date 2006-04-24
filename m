From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 5/4] Minimum fixups to cache-tree
Date: Sun, 23 Apr 2006 20:03:27 -0700
Message-ID: <7v8xpvd69s.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
	<7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 05:03:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXrMN-0003h4-QT
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 05:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWDXDDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 23:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbWDXDDa
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 23:03:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4531 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751498AbWDXDD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 23:03:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424030329.MFO16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 23:03:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vodyrdas9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 23 Apr 2006 18:25:58 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19084>

The first hunk is the repeat of the previous "oops".  The second
is a real fix.

With this applied, 100-patch series (going from present to past
at the Linux 2.6 kernel tip) applies correctly with the
following stats:

Trying w/o the patch...
24.57user 4.48system 0:34.47elapsed 84%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+322156minor)pagefaults 0swaps
Trying w/ the patch...
15.81user 3.00system 0:20.84elapsed 90%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+252063minor)pagefaults 0swaps

So there definitely is an improvement.  *Grin*.

The script used to bench this is attached at the end.  "linus" is the tracking
branch and currently it points at v2.6.17-rc2-g6b426e7
$HOME/git-master/bin is where I installed the "master" version,
and $J (aka ../git.junio/) is the freshly compiled area with the
patch series applied (all five of four ;-).

-- >8 --
Minimum fixups to make things usable.

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
 
diff --git a/cache-tree.c b/cache-tree.c
index 4dbdb65..f6d1dd1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -348,10 +348,7 @@ #endif
 	}
 	for (i = 0; i < it->subtree_nr; i++) {
 		struct cache_tree_sub *down = it->down[i];
-		int len = pathlen + down->namelen;
-		memcpy(path + pathlen, down->name, down->namelen);
-		path[len] = '/';
-		buffer = write_one(down->cache_tree, path, len+1,
+		buffer = write_one(down->cache_tree, down->name, down->namelen,
 				   buffer, size, offset);
 	}
 	return buffer;

--

#!/bin/sh
J=../git.junio
M=$HOME/git-master/bin
export J M

git reset --hard linus

previous=
git rev-list -n 100 HEAD |
while read commit
do
	if test -n "$previous"
	then
		git-diff-tree -p "$previous" "$commit" >"$commit-$previous"
		echo "$commit $previous"
	fi
	previous="$commit"
done >series

git reset --hard linus
echo "Trying w/o the patch..."
/usr/bin/time sh -c '
	while read commit previous
	do
		$M/git-apply --whitespace=nowarn --index "$commit-$previous"
		$M/git-write-tree
	done <series
' >out-1
tree1=`git write-tree`

git reset --hard linus
echo "Trying w/ the patch..."
$J/git-write-tree
/usr/bin/time sh -c '
	while read commit previous
	do
		$J/git-apply --whitespace=nowarn --index "$commit-$previous"
		$J/git-write-tree
	done <series
' >out-2
tree2=`git write-tree`
test "$tree1" = "$tree2" || exit 1
cmp out-1 out-2
