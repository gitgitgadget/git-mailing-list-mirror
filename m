From: Junio C Hamano <junkio@cox.net>
Subject: Re: getting rid of extra directories
Date: Sat, 15 Oct 2005 15:34:29 -0700
Message-ID: <7v8xwummtm.fsf@assigned-by-dhcp.cox.net>
References: <20051015174103.GA2609@tumblerings.org>
	<7vu0fimzhn.fsf@assigned-by-dhcp.cox.net>
	<20051015192720.GA11364@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 00:34:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQuc1-0000Pi-JJ
	for gcvg-git@gmane.org; Sun, 16 Oct 2005 00:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbVJOWeb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 18:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbVJOWeb
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 18:34:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56048 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751248AbVJOWeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 18:34:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051015223422.CPLB16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Oct 2005 18:34:22 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20051015192720.GA11364@tumblerings.org> (Zack Brown's message of
	"Sat, 15 Oct 2005 12:27:20 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10150>

Zack Brown <zbrown@tumblerings.org> writes:

>> I do not know exactly what Cogito "seek back and forth" does,
>
> It means to "cg-seek" back to an earlier state of the repo, and forward to a
> more recent state of the repo. "seeking back and forth" means doing a lot of
> "cg-seek" commands. Sorry that wasn't clear.
>
>> but updating to git-core "master" branch may help.
>
> I already use that branch.

I usually do not use Cogito, so I updated to the latest and
tried it myself.  No wonder.

cg-seek does not use "git-read-tree -m -u $old $new", which was
updated by that commit I mentioned to remove the empty
directories. It does "git-read-tree -m $new" and does the
removal part manually by reading from diff-tree $old $new.  I
suspect the code was there before the two-tree read-tree was
invented.

A similar sequence as you did, in pure git, would remove empty
directory d/ when switching branches between.

    $ mkdir junkproj
    $ cd junkproj
    $ git-init-db
    $ ls >a
    $ git-add a
    $ git-commit -a -m 'Add a'
    $ git-checkout -b adddir
    $ mkdir d
    $ mv a d/a
    $ git-add d
    $ git-commit -a -m 'Move a to d/a'

    $ git-checkout master

I suspect cg-Xlib::tree_timewarp, which currently does
"git-read-tree -m $branch" followed by diff-tree piped to xargs,
can be taught to use "git-read-tree -m -u $base $branch" (and
lose the git-checkout-index -f -a immediately after that while
we are at it), but I do not do Porcelain, so...
