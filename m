From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: [PATCH] Add --author match to git-rev-list and git-rev-tree.
Date: Sat, 14 May 2005 09:02:13 -0700
Message-ID: <20050514160213.GF14184@tumblerings.org>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514150607.GA14184@tumblerings.org> <20050514155257.GR3905@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 18:07:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWzAj-0000CN-GY
	for gcvg-git@gmane.org; Sat, 14 May 2005 18:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVENQHY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 12:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVENQHX
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 12:07:23 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:16275 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261440AbVENQHJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 12:07:09 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DWz5h-0003dm-4T; Sat, 14 May 2005 09:02:13 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050514155257.GR3905@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, May 14, 2005 at 05:52:57PM +0200, Petr Baudis wrote:
> Dear diary, on Sat, May 14, 2005 at 05:06:07PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > On Sat, May 14, 2005 at 02:50:24AM -0700, Junio C Hamano wrote:
> > > Zack Brown wondered if handling author match at core GIT level
> > > would make cg-log -u go faster (JIT also can use this in jit-log
> > > --author).  Here is a patch to implement it.
> > > 
> > > I considered adding author and committer strings to commit
> > > objects for general use as commit objects are parsed, but I was
> > > unsure about the lifetime rules of the commit objects (nobody
> > > seems to free them in the current code), so refrained from doing
> > > so for the time being.  The code instead re-reads the commit
> > > object when it needs to filter them by the author.
> > 
> > I applied this, but can't figure out the change to make to cg-log in order to
> > actually test it.
> > 
> > - git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
> > + git-cat-file --author $user commit $commit || continue
> > 
> > sure didn't work.
> 
> You throw that whole thing away and pass the --author parameter directly
> to git-rev-(list|tree).

You mean like this?

Be well,
Zack


Use git-rev-(list|tree) --author to cg-log

Signed-off-by: Zack Brown <zbrown@tumblerings.org>

--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-log  (mode:100755)
+++ uncommitted/cg-log  (mode:100755)
@@ -112,12 +112,20 @@
 if [ "$log_end" ]; then
        id1="$(commit-id $log_start)" || exit 1
        id2="$(commit-id $log_end)" || exit 1
-       revls="git-rev-tree $id2 ^$id1"
+       if [ "$user" ]; then
+               revls="git-rev-tree --author $user $id2 ^$id1"
+       else
+               revls="git-rev-tree $id2 ^$id1"
+       fi
        revsort="sort -rn"
        revfmt="git-rev-tree"
 else
        id1="$(commit-id $log_start)" || exit 1
-       revls="git-rev-list $id1"
+       if [ "$user" ]; then
+               revls="git-rev-list --author $user $id1"
+       else
+               revls="git-rev-list $id1"
+       fi
        revsort="cat"
        revfmt="git-rev-list"
 fi
@@ -131,9 +139,6 @@
                parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
                [ "$parent" ] && [ "$(git-diff-tree -r $commit $parent "$@")" ] || continue
        fi
-       if [ "$user" ]; then
-               git-cat-file commit $commit | grep -e '^author ' -e '^committer ' | grep -qi "$user" || continue
-       fi
        echo $colheader""commit ${commit%:*} $coldefault;
        git-cat-file commit $commit | \
                while read key rest; do

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
