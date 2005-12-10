From: Junio C Hamano <junkio@cox.net>
Subject: Re: as promised, docs: git for the confused
Date: Sat, 10 Dec 2005 00:00:40 -0800
Message-ID: <7v7jadwfdj.fsf@assigned-by-dhcp.cox.net>
References: <7vbqzrcmgr.fsf@assigned-by-dhcp.cox.net>
	<20051209054401.4016.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 10 09:01:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekzev-000248-E0
	for gcvg-git@gmane.org; Sat, 10 Dec 2005 09:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVLJIAn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Dec 2005 03:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbVLJIAm
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Dec 2005 03:00:42 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:1266 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751096AbVLJIAm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2005 03:00:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051210080043.DDUG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Dec 2005 03:00:43 -0500
To: linux@horizon.com
In-Reply-To: <20051209054401.4016.qmail@science.horizon.com>
	(linux@horizon.com's message of "9 Dec 2005 00:44:01 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13443>

linux@horizon.com writes:

> Like other version control systems, git has a current version (referred
> to as HEAD) in its object database, you make changes in the working
> directory, and then commit them, which appends a new version and makes
> that the new HEAD.
>
> However, there's also this "index" thing interposed.  As "man git"
> explains, you can have one version of the file in the HEAD, a second
> in the index, and a third in the working directory.  That's weird
> and confusing - why does git allow that?  Why isn't the index just an
> implementation detail that caches the HEAD until you commit a new one?
>
> The answer is merging, which does all its work in the index.  Being a
> toolkit, git has to pass partial merges around between its various
> tools, which means keeping track of multiple files all competing for
> the same name.  Neither the object database nor the working directory
> let you have multiple files with the same name.

I do not necessarily agree with this claim that merging is the
whole story about index.  As the steps in the hello/example
tutorial demonstrate, index is used to build up what you will
commit incrementally, and you can use this facility to view your
changes incrementally.

Your workflow could be like this:

    $ git checkout
    $ hack away
    $ git diff ;# what have I done so far?
    $ git diff HEAD ;# this one shows the same as the above.

    $ git update-index frotz ;# now I am satisfied with my progress so far.
    $ hack away further
    $ git diff ;# what have I done since my last "satisfactory checkpoint"?
    $ git diff HEAD ;# changes since the last commit -- this is
    		     # different from the above, and gives a lot
		     # more output
    $ git update-index nitfol ;# I am happy with what I've done
                               # to this file as well.
    $ hack away further
    $ git diff	    ;# changes since the checkpoint
    $ git update-index frotz nitfol
    $ git diff HEAD ;# final pre-commit review
    $ git commit

You could view updating the index as "checking in" and making a
commit as "casting your cumulative check-ins in stone".  You can
make "check in" as many times as you want, and there is "git
reset --mixed" to uncheckin the index changes.  And by doing
intermediate "checkins" to index file, you can limit what "git
diff" shows only to changes since your last checkpoint, as
opposed to all the changes you have made since your last commit.

This is sometimes very useful, and I suspect your comment about
"commit -a will take care of everything, so you do not need to
know about update-index" is coming from your ignoring this
aspect of update-index.
