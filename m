From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list --bisect: limit list before bisecting.
Date: Fri, 14 Apr 2006 15:40:13 -0700
Message-ID: <7vhd4vok6q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 00:40:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUWxg-0004KZ-F7
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 00:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbWDNWkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWDNWkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 18:40:16 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63472 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751293AbWDNWkP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 18:40:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060414224014.HWUR18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Apr 2006 18:40:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18707>

I noticed bisect does not work well without both good and bad.
Running this script in git.git repository would give you quite
different results:

	#!/bin/sh
        initial=e83c5163316f89bfbde7d9ab23ca2e25604af290

        mid0=`git rev-list --bisect ^$initial --all`

        git rev-list $mid0 | wc -l
        git rev-list ^$mid0 --all | wc -l

        mid1=`git rev-list --bisect --all`

        git rev-list $mid1 | wc -l
        git rev-list ^$mid1 --all | wc -l

The $initial commit is the very first commit you made.  The
first midpoint bisects things evenly as designed, but the latter
does not.

The reason I got interested in this was because I was wondering
if something like the following would help people converting a
huge repository from foreign SCM, or preparing a repository to
be fetched over plain dumb HTTP only:

        #!/bin/sh

        N=4
        P=.git/objects/pack
        bottom=

        while test 0 \< $N
        do
                N=$((N-1))
                if test -z "$bottom"
                then
                        newbottom=`git rev-list --bisect --all`
                else
                        newbottom=`git rev-list --bisect ^$bottom --all`
                fi
                if test -z "$bottom"
                then
                        rev_list="$newbottom"
                elif test 0 = $N
                then
                        rev_list="^$bottom --all"
                else
                        rev_list="^$bottom $newbottom"
                fi
                p=$(git rev-list --unpacked --objects $rev_list |
                    git pack-objects $P/pack)
                git show-index <$P/pack-$p.idx | wc -l
                bottom=$newbottom
        done

The idea is to pack older half of the history to one pack, then
older half of the remaining history to another, to continue a
few times, using finer granularity as we get closer to the tip.

This may not matter, since for a truly huge history, running
bisect number of times could be quite time consuming, and we
might be better off running "git rev-list --all" once into a
temporary file, and manually pick cut-off points from the
resulting list of commits.  After all we are talking about
"approximately half" for such an usage, and older history does
not matter much.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 rev-list.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/rev-list.c b/rev-list.c
index 963707a..cb67b39 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -371,6 +371,8 @@ int main(int argc, const char **argv)
 
 	save_commit_buffer = verbose_header;
 	track_object_refs = 0;
+	if (bisect_list)
+		revs.limited = 1;
 
 	prepare_revision_walk(&revs);
 	if (revs.tree_objects)
