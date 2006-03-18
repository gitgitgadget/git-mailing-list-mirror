From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to find a revision's branch name
Date: Fri, 17 Mar 2006 22:37:46 -0800
Message-ID: <7vfylgz29x.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550603172202ia4b69f2he5562b826e491426@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 07:38:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKV4Y-00067Y-J8
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 07:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWCRGhs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 01:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbWCRGhs
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 01:37:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:48102 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751498AbWCRGhr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 01:37:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060318063409.ZFCO17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Mar 2006 01:34:09 -0500
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603172202ia4b69f2he5562b826e491426@mail.gmail.com>
	(Marco Costalba's message of "Sat, 18 Mar 2006 07:02:22 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17685>

Marco Costalba <mcostalba@gmail.com> writes:

> Is it possible to get branch name from a revision sha?
> Something like
>
> $ git branch b14e2494b8a70737066f4ade4df1b5559e81b44b
> todo

That is in general impossible.

        $ git show-branch master~1 next pu
        ! [master~1] blame: Nicer output
         ! [next] Merge branch 'jc/cvsimport' into next
          ! [pu] Merge branch 'jc/cvsimport' into next
        ---
         -- [next] Merge branch 'jc/cvsimport' into next
         ++ [next^2] cvsimport: honor -i and non -i upon subsequent
         imports
         -- [next^] Merge branch 'jc/fetch' into next
         ++ [next^^2] fetch: exit non-zero when fast-forward check
         fails.
         -- [next~2] Merge branch 'ew/abbrev' into next
         ++ [next~2^2] ls-files: add --abbrev[=<n>] option
         ++ [next~2^2^] ls-tree: add --abbrev[=<n>] option
         ++ [next^2^] blame: Fix git-blame <directory>
        +++ [master~1] blame: Nicer output
        $ git rev-parse --verify master~1
        88a8b7955666ed8fa5924fadbb3bb58984eaa6af

Now what should this command say?

        $ git branch --tell 88a8b7955666ed8fa5924fadbb3bb58984eaa6af

It is not head of any branch.  Should it say master~1?
next^2~1?  pu^2~1?

The closest thing is name-rev, which tries to give you the
simplest.  It may or may not match what you want:

        $ git name-rev 88a8b7955666ed8fa5924fadbb3bb58984eaa6af
        88a8b7955666ed8fa5924fadbb3bb58984eaa6af master~1
        $ git name-rev `git rev-parse --verify b14e24`
        b14e2494b8a70737066f4ade4df1b5559e81b44b todo~16

However.

> I need this to correctly annotate files not in HEAD
> tree. Currently qgit runs git-rev-list --header --topo-order
> --parents --remove-empty HEAD -- <path>
>
> to get a file history. But this fails if <path> is not found
> in HEAD. The right command to run in our case should be:
> git-rev-list --header --topo-order --parents --remove-empty
> todo -- <path>

... I wonder why you care.  Wouldn't this work just as well?

	$ git rev-list --header --topo-order --parents --remove-empty \
	  --all -- <path>

It lists 70 commits at the moment.
