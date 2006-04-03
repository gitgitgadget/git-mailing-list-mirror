From: Sam Vilain <sam@vilain.net>
Subject: n-heads and patch dependency chains
Date: Mon, 03 Apr 2006 19:48:34 +1200
Message-ID: <4430D352.4010707@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 03 09:49:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQJo2-00039P-ID
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 09:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWDCHsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 03:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWDCHsz
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 03:48:55 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:15761 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932325AbWDCHsy
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 03:48:54 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 5BE6B6099; Mon,  3 Apr 2006 19:48:50 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 7E8DB5EF1
	for <git@vger.kernel.org>; Mon,  3 Apr 2006 19:48:38 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18318>

Hi all,

"Patch dependency chains", the best plain-English term we could find for
the scary sounding darcs term "patch calculus", are said by some to be a
very good reason to use a system like darcs, even to some its
fundamental advantage over systems such as git.

The question is, to what extent is this point true?

To get a feel for the issues involved, I tried applying an example
n-head and patch dependency logic to a "real" project that had a small
enough number of commits to make it feasible to construct everything
manually.

A side-by-side comparison of the commit history with n-head commits
(left pane) and without (right pane) is here:

  http://utsl.gen.nz/git/hydra-vs-regular.png

Some important points to note:

  0. gitk is re-ordering the commits to try to make the graph tidy,
     so don't worry that the commits are in a different order

  1. commits were considered dependent on the last commit(s) that
     delivered the file(s) they modified.  As in, the user specified
     that extra heads be created wherever possible, including
     splitting heads.

  2. the "rolling" n-head was continually discarded.  "n-head" is
     misspelt :) as "hydra-head" in the diagrams.

  3. patches that just added new files were performed by first
     making a new repository, adding those files and committing.
     this is why there are a lot of "starting points" on the tree

I think we can conclude from this:

  - this is not impossible using the current model, and some extra
    useful information can be seen in the tree that shows more real
    dependency information and relationships between individual commits

  - doing automatic n-head creation would probably be madness, as
    far too many useless heads are created (though it is almost
    guaranteed that supporting 'patch commuting' a la darcs would
    make this *even worse* as it would mean that you could potentially
    have even more heads)

  - the current tools make this style of development difficult.

The bugs:

  - git-merge-octopus isn't capable of merging commits where there is
    no common commit, but none was needed as the commits' trees don't
    overlap.

    That is, with "git-pull -s octopus . head1 head2 head3 ..."
    you get the error:

      Unable to find common commit with 42f49cc...

    But pulling the branches individually works fine;

      Merging HEAD with 42f49cc...
      Merging:
        c0805...
        42f49...
      found 1 common ancestor(s):
      1 virtual commit

    That 'branch' was created by setting up a new git repo in another
    path, then using 'git-fetch' to pull it into the local one.

  - for some reason I had to list "-s ours" twice to git-pull when
    manually making the octopus merge nodes

  - `git-pull --no-commit -a' suffers from the same problem

  - some tools (such as the diff window in gitk) produce *very*
    strange output if you try to merge the heads and apply the next
    patch in the same go.

The open questions:

  - would it make a difference if this automatic patch dependency
    information was stored using a different type of relationship?

  - would this be more useful if the initial n-head creation was more
    manual, like topic branches?  And if it did work like this, would
    an n-head pull feature enable the 'pu' development model to work
    seamlessly?

  - how useful are the other benefits of dependent commits?

The IRC log:

17:45 < mugwump> the other suggestions look quite good.  I don't know
                 how I got roped into spending a whole day on this :)
17:46 < mugwump> oh yeah, I remember now.  somebody asked for a
                 comparison between darcs and git
17:46  * ShadeHawk whistles innocently

So there we go, anyway.  If some form of patch dependency system is to
be included in git, then I hope this message helps to explain the
practical problems and give the would-be author a good head start :)

Hot potato into the aether, anyone?

Sam.
