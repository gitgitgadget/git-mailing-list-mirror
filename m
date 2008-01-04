From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: git-pull several branches merge conflict resolved
Date: Fri, 4 Jan 2008 12:03:22 +0300
Message-ID: <20080104090322.GD6310@cvg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: GIT-LIST <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 04 10:04:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAiTE-0006Z5-JP
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 10:04:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbYADJDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 04:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYADJDi
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 04:03:38 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:20407 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752910AbYADJDd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 04:03:33 -0500
Received: by fk-out-0910.google.com with SMTP id z23so7077126fkz.5
        for <git@vger.kernel.org>; Fri, 04 Jan 2008 01:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        bh=SlLvbW0KzDokx34HqWvUWZ969WZjIV9fc5RGShR+csk=;
        b=nALuyt3nA3jS5kEGCIlxxB32WluzyrOw7X7X5vg5UdH4Rj4XHSKGpCJwEIlfkY/qg2vjVVJgpD4X0tDcj84FiTj3wcWY9Tkp2Vq0qMpO6iOl+G82v/H6g04YP5RZ92Yp0dwN1GvU8FS4RivR6Bv86i7Xh1SiqiqQLHszC3VyLzo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=jOgNlK1Hi+bYk5iyYFIksb43+o8RUxzbazCPnSq1bJIlk4fUUarVN4jzBF/3DF34ZC7WId2YPYcpGbm7DPc6Cae/21wpPNBu8ZBsPcFS85EN3Ab2Sxeol/UwZn2ciUrtERlxVwDt8Juu6/QZTYvXTT1iTOiYl4Q8jB9LxB0dUE0=
Received: by 10.82.157.6 with SMTP id f6mr29347390bue.1.1199437411174;
        Fri, 04 Jan 2008 01:03:31 -0800 (PST)
Received: from gorcunov ( [91.122.85.216])
        by mx.google.com with ESMTPS id z33sm25391146ikz.0.2008.01.04.01.03.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2008 01:03:30 -0800 (PST)
Received: by gorcunov (Postfix, from userid 1000)
	id B15BB259A4; Fri,  4 Jan 2008 12:03:22 +0300 (MSK)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69568>

this message is just an attempt to summarize a problem and its decision
graciously explained by Junio C Hamano in hope it would help someone else
who trip on the same problem

lets start ;)


--- the problem ---

i'm keeping Linus's kernel git tree on my local harddrive so i update it from time to
time using git-pull command with explicitly defined URL:

	git-pull git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

for some reasons i wish to track changes from Ingo's repository so i made a special
branch for it

	git-checkout -b x86

this branch i'm trying to keep up to date with

	git-pull --force git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git mm

after some point (as only Linus has his tree updated) i could not update Ingo's branch
without merge conflicts

so Junio explained what is going on there


--- the decision ---

Here is what is happening.

 (0) Ingo has this:

                      A---B (== I)
                     /
    ----o---o---o---L

     where L is the tip of Linus at some point, I is his changes
     for x86.  You pull and get the same thing.  Your local x86
     tip points at commit B.

 (1) Then Linus advances and Ingo rebases.  Updated Linus's tip
     is at L' and Ingo has old patches rebased (A' and B') while
     he added more changes (C and D).  His tip is at I'.

                      A---B (==I) A'--B'--C---D (==I')
                     /           /
    ----o---o---o---L---o---o---L'

 (2) You pull.  What is involved is:

     * git-pull is just "git fetch" followed by "git merge", and
       in your repository "git fetch" can be configured to use a
       remote tracking branch to keep track of Ingo's progress
       (but I suspect you don't).  Your "git branch" output
       shows your local branches, and "git branch -r" would show
       these remote tracking branches.

     * The remote tracking is typically configured in
       .git/config and would look like this:

        [remote "mingo"]
        url = git://git.kernel.org/pub/...
        fetch = refs/heads/*:refs/remotes/mingo/*

        Although I _suspect_ you do not have it (your $ipull
        script pulls with explicit URL without using configured
        information).

     The above (for normal people who have the tracking set up)
     fetches the branch tip's from Ingo, and store them in
     corresponding places in .git/refs/remotes/mingo/;  his 'mm'
     branch will be stored in .git/refs/remotes/mingo/mm.

     But remote.mingo.fetch configuration above does not start
     with '+' (e.g. "+refs/heads/*:refs/remotes/mingo/*", which
     means "do allow non-fast-forward").  For people with such
     configuration, "git pull" from him will fail because
     remotes/mingo/mm points at commit B before you initiated
     the fetch and now it points at D which is _NOT_ a
     descendant of B.

     His recommendation about --force applies _ONLY_ to override
     this, and allow your remote tracking branch that used to
     point at B to be replaced to point at D.  I suspect it does
     not even apply to you as I do not think you are using
     remote tracking branch at all.

     In any case, once "git fetch" completes, "git merge"
     happens.  --force does not affect this step at all.

     What's merged?

     Your 'x86' branch is still at B and you try to merge D into
     it.

                            .-------------------*
                           /                   / 
                      A---B       A'--B'--C---D
                     /           /
    ----o---o---o---L---o---o---L'

     Because Ingo's tree was rebased, the resulting merge wants
     to have both versions of A and B (the original and the
     rebased).  As corresponding patches (say A and A') would
     want to touch same parts of the code, and Ingo may have
     improved the latter while all of this has been happening
     (i.e. A and A' may not be literal rebase but can do things
     differently), it will inevitably conflict with each other.

Even though the conflict resolution would be trivial (you would
basically want to pick what's from A' over A), this is not what
you would typically want to happen.  When dealing with a
rebasing upstream, you often do not want to merge but instead
rebase yourself.

So backing up a bit, here is how people would follow rebasing
upstream:

 (0) Ingo has this:

                      A---B (== I)
                     /
    ----o---o---o---L

     where L is the tip of Linus at some point, I is his changes
     for x86.  You pull and get the same thing.  Your local x86
     tip points at commit B.

 (1) You develop on top of Ingo (although you hinted in your
     description that you are strictly following, that is just a
     degenerated case of this where (X,Y,Z) is empty in this
     picture):

                            X---Y---Z
                           /
                      A---B (== I)
                     /
    ----o---o---o---L

 (2) Then Linus advances and Ingo rebases.  Updated Linus's tip
     is at L' and Ingo has old patches rebased (A' and B') while
     he added more changes (C and D).  His tip is at I'.

                      A---B (==I) A'--B'--C---D (==I')
                     /           /
    ----o---o---o---L---o---o---L'

 (3) You do not pull but instead fetch from Ingo to get what
     happened outside your tree.

                            X---Y---Z
                           /
                      A---B (==I) A'--B'--C---D (==I')
                     /           /
    ----o---o---o---L---o---o---L'

    Note that your 'x86' is at Z and Ingo's tip is now at D.

 (4) You rebase on top of Ingo's updated tip.

                                                X'--Y'--Z'
                                               /
                      A---B (==I) A'--B'--C---D (==I')
                     /           /
    ----o---o---o---L---o---o---L'


I was told that our user manual is very good these days covering
both workflows based on merges and workflows based on rebases.
You may want to check it and also git-rebase(1).

--- end ---

Thanks you very much, Junio!

		- Cyrill -
