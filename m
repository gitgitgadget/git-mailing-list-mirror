From: Junio C Hamano <junkio@cox.net>
Subject: Re: Clone a repository with only the objects needed for a single tag
Date: Tue, 01 Nov 2005 23:01:41 -0800
Message-ID: <7vy847y1m2.fsf@assigned-by-dhcp.cox.net>
References: <43681E47.4010203@ust.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 08:02:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXCd3-0007v3-GT
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 08:01:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932589AbVKBHBo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 02:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbVKBHBo
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 02:01:44 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:35229 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932505AbVKBHBn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 02:01:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102070049.TLTZ24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 02:00:49 -0500
To: Ben Lau <benlau@ust.hk>
In-Reply-To: <43681E47.4010203@ust.hk> (Ben Lau's message of "Wed, 02 Nov 2005
	10:02:47 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11002>

Ben Lau <benlau@ust.hk> writes:

>   Is there any method to clone/copy a repository with only the
> objects needed for a single tag in order to save disk space?
>   For example, if I want to start a new project based on a
> specific version of kernel like v2.6.14. I would run
> `git-clone` and then checkout a new branch based on the tag.

Depends on what you want to do in that shallow copy.

If the only thing you would want to do is to build it, then you
could 'git-tar-tree v2.6.14' and extract that on your notebook.
The output is just a tar so there will no history, though.

If you want to develop while on the road, but do not
particularly need to be able to inspect the history beyond the
point you started, you could create a deliberately broken
repository, using the git-shallow-clone script (attached), like
this:

    $ git clone -n $mothership satellite
    $ cd satellite
    $ git-shallow-pack --all
    $ rm -f .git/objects/pack/pack-*
    $ mv pack-* .git/objects/pack/.

If the original repository you are cloning from is local, you
could instead do:

    $ git clone -l -s -n $mothership satellite
    $ cd satellite
    $ git-shallow-pack --all
    $ rm .git/objects/info/alternates
    $ mv pack-* .git/objects/pack/.

You could develop in this repository, even build up your own
commit chains, and when you come back you could push from this
repository back to your 'mothership' repository.  In essense,
any operation that does not require you to have full history
should work.

One important thing that would not always work would be to pull
into this repository over git-aware protocols, although pulling
from your 'mothership' repository would probably work most of
the time.

One case that would probably break is if the mothership side
reverted a commit beyond this shallow-pack boundary and then you
try to pull from there.  After the revert, the trees and blobs
in that new commit you will be pulling from the mothership are
likely to be the same as the ones contained in commits before
the shallow clone is made.  Because your satellite repo would
claim to have everything that is reachable from the tip (as of
the time the clone was made) of the branch, you cannot complain
if the mothership side assumes you must have those blobs and
trees and did not send them to you when you pull.

---
#!/bin/sh
# git-shallow-pack

git-rev-parse --revs-only --no-flags --default HEAD "$@" |
while read sha1
do
	echo "$sha1"
	while type=`git-cat-file -t "$sha1"` &&
	      case "$type" in tag) ;; *) break ;; esac
	do
		next=`git-cat-file tag "$sha1" |
			sed -ne 's/^object //p' -e q`
		echo "$next"
		sha1="$next"
	done
	git-rev-parse --verify "$sha1^{tree}" 2>/dev/null &&
	git-ls-tree -r "$sha1" | sed -e 's/^[0-7]* [^ ]* //'
done |
sort -k 1,1 -u |
git-pack-objects pack
