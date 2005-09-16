From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fsck messages - what to do about it?
Date: Fri, 16 Sep 2005 10:02:49 -0700
Message-ID: <7vll1xndxi.fsf@assigned-by-dhcp.cox.net>
References: <tnx3bo59tm8.fsf@arm.com>
	<20050916110310.90115352B7B@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 16 19:03:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGJc7-0005p5-8z
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 19:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbVIPRCv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 13:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbVIPRCv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 13:02:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52873 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1161185AbVIPRCu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 13:02:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050916170250.XJOI6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 16 Sep 2005 13:02:50 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050916110310.90115352B7B@atlas.denx.de> (Wolfgang Denk's
	message of "Fri, 16 Sep 2005 13:03:10 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8694>

Wolfgang Denk <wd@denx.de> writes:

> Ummm.... I hesitate to  do  this  before  understanding  where  these
> messages come from and what sort of data is affected.

Does git-fsck-cache without --unreachable report dangling
commits?  If so I would do something like this (this is my
'git-lost-found' script):

        #!/bin/sh

        . git-sh-setup-script || die "Not a git archive."

        laf="$GIT_DIR/refs/lost-found"
        mkdir -p "$laf" || exit

        git fsck-cache |
        while read dangling type sha1
        do
                case "$dangling" in
                dangling)
                        echo "$sha1" >"$laf/$sha1"
                        case "$type" in
                        commit)
                                git-show-branch "$sha1" ;;
                        esac
                        ;;
                esac
        done

and run 'gitk --all' to see what these dangling commits are, and
where in your commit ancestry mesh they fit in.  

After you understand what they are, do not forget to "rm -f
$GIT_DIR/refs/lost-found/*"; you made them reachable just to
make inspecting them easier, but you probably do not want them.

I can sort of understand dangling blobs can come from manually
resolved merges, but I do not think that would create dangling
commits.

Have you rewound and rebased your history?  'git reset --hard'
obviously throws the tip of the current branch away and 'git
rebase' does it in order to recreate an alternate history.
If that is the case, and if you are satisfied with the history
your repository currently have, then obviously these can be
safely pruned.

Another possibility is what Pasky suggested -- do you have a
symlink .git/objects in another repository that points at the
.git/objects directory of this repository?  These dangling
things may be objects the other repository needs.  If that is
the case you obviously cannot prune them -- you would corrupt
the other repository.
