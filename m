From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git push .git/branches shorthand
Date: Mon, 08 Aug 2005 19:48:09 -0700
Message-ID: <7vd5onzuza.fsf@assigned-by-dhcp.cox.net>
References: <7viryhgdo5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508081106580.26210@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 04:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2KA2-0006r2-0n
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 04:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVHICsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 22:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVHICsL
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 22:48:11 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8132 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932416AbVHICsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 22:48:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050809024810.LLHS17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 22:48:10 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I'd prefer $GIT_DIR/remotes/. And I propose another extension: Since the 
> files stored therein right now contain only one <remote> string, it should 
> be possible to add the default head(s) to the file.

That makes sense.  Currently my arrangement is:

    $ cd .git/branches && grep . public-*
    public-master:http://www.kernel.org/pub/scm/git/git.git/
    public-pu:http://www.kernel.org/pub/scm/git/git.git/#pu
    public-rc:http://www.kernel.org/pub/scm/git/git.git/#rc

and in order to get the references on the public server to make
sure people are seeing what I want them to see, I say:

    $ for h in master pu rc
      do
        echo $h
        git fetch public-$h
        git-rev-parse $h public-$h
      done

Instead, I should be able to say:

    $ cat .git/remotes/public
    http://www.kernel.org/pub/scm/git/git.git/#pu:public-pu,rc:public-rc

to mean that the following two are equivalent:

$ git fetch public
$ git fetch public pu:public-pu rc:public-rc

that is, fetch pu there and store it in refs/heads/public-pu
(same for rc).  When I want to fetch only pu from there:

    $ git fetch public pu:public-pu

or even

    $ git fetch public pu

should work.  If I happen to want to fetch pu one-shot but not
want to update my local refs/heads/public-pu, then I should be
able to say

    $ git fetch public pu:

Another thing I need to worry about is that I would want to use
this remotes information for pushing as well, but probably the
reference mappings are different when fetching and pushing.

With something like this:

    $ cat .git/remotes/ko
    kernel.org:/pub/scm/git/git.git/#master:ko-master,pu:ko-pu,rc:ko-rc
    $ git fetch ko rc

I would fetch the remote ref "rc" and store it in
refs/heads/ko-rc, which is fine, but after that I would do my
work in the local repository, merge things up and update my
local "rc" (not ko-rc, which to me is a "reference only"
branch), and eventually when pushing I would want to store my
"rc" (again not ko-rc) in "rc" over there.

This means the reference mapping in these two shorthand
notations should be flexible enough to allow me to do:

    $ git fetch ko rc ;# get rc from there store it under ko-rc here

which is equivalent to 

    $ git fetch ko rc:ko-rc

and

    $ git push ko rc  ;# push rc here to rc there

which is equivalent to 

$ git push ko rc:rc

Maybe its time to do a file format that is a bit more flexible.
For example:

    $ cat .git/remotes/ko
    URL: kernel.org:/pub/scm/git/git.git/
    Fetch-Reference: master:ko-master pu:ko-pu rc:ko-rc
    Push-Reference: master pu rc

Note that I do not mean "Push-Reference" can not do the rename.
I could have written "master:master" but I did not because I do
_not_ want renaming push in this example.

People who do not need different mappings for fetch/push should
be able to say:

    $ cat .git/remotes/public
    URL: http://www.kernel.org/pub/scm/git/git.git/
    Reference: pu:public-pu rc:public-rc

Another thing I should mention is that Fetch-Reference mapping
is <remote>:<local>, while Push-Reference is <local>:<remote>.
This is only because I feel always using <src>:<dst> is easy to
remember, is the way it works for the command line refs for git
push already, and is the way I plan to enhance fetch to grok.

My current thinking is Reference should take <remote>:<local>
because fetching/pulling is probably more common than pushing,
but I need to think a bit more about it.

Johannes, sorry for doing my design work in an e-mail buffer
to you ;-).
