From: Junio C Hamano <junio@siamese.dyndns.org>
Subject: Re: "GIT_INDEX_FILE" environment variable
Date: Thu, 21 Apr 2005 17:21:10 -0700
Message-ID: <7vis2fbr0p.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 02:22:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOlvi-0001rT-L0
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 02:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVDVAZf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 20:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVDVAYC
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 20:24:02 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38604 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261807AbVDVAVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 20:21:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050422002110.ULOX9923.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 20:21:10 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504211100330.2344@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 21 Apr 2005 11:09:52 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT>   Add support for a "GIT_INDEX_FILE" environment variable.
  
LT>   We use that to specify alternative index files, which can be useful
LT>   if you want to (for example) generate a temporary index file to do
LT>   some specific operation that you don't want to mess with your main
LT>   one with.
  
LT>   It defaults to the regular ".git/index" if it hasn't been specified.

This is all good.  I have a related issue I'd like to hear your
opinion about.

When I am not in the top-level directory, relative to the tree
structure $GIT_INDEX_FILE describes, obviously I cannot just say
"show-diff path-pattern" (or even just "show-diff") without
first chdir'ing to the top.  My current workaround I use in the
jit-show-diff wrapper script is quite ugly:

 - Starting from dir="${PWD-"$(pwd)"}", repeatedly do
   dir=$(dirname dir) until I find a $dir/.git directory.  Call
   the first directory I find that has .git subdirectory
   $GIT_PROJECT_TOP.

 - At the same time, inspect GIT_INDEX_FILE and
   SHA1_FILE_DIRECTORY environment variables.  If they are not
   set, set them to $GIT_PROJECT_TOP/.git/index and
   $GIT_PROJECT_TOP/.git/objects, respectively and export them.

 - Figure out the name of the current working directory relative
   to $GIT_PROJECT_TOP.  I'll call this value $R for brevity in
   the following description.

 - chdir to $GIT_PROJECT_TOP and run "show-diff" with the
   original flags and _all_ the user supplied paths prefixed
   with $R.

To illustrate what I just said:

  $ /bin/ls -aF
  ./  ../  .git/  a/
  $ /bin/ls -aF .git
  .   ../  HEAD   index  objects/ 
  $ cd a
  $ /bin/ls -aF
  .   ../   bar  foo/
  $ show-diff -r foo     ; # of course this does not work.
  $ jit-show-diff -r foo

  The wrapper figures out that .. is the project top to chdir
  to, and $R is "a/".  Using these values, it eventually calls:

    cd .. ; show-diff -r "a/foo"

This is not so hard to arrange in the wrapper, but this is quite
brittle.  The show-diff command happens to take only -r, -z, and
-q flag parameters so the wrapper can prefix $R to all the other
paramters, but for other git core commands when to prefix $R and
when not to soon becomes a maintenance nightmare.

I am thinking about an alternative way of doing the above by
some modifications to the git core.  I think the root of this
problem is that there is no equivalent to GIT_INDEX_FILE and
SHA1_FILE_DIRECTORY that tells the core git where the project
top directory (i.e. the root of the working tree that
corresponds to what $GIT_INDEX_FILE describes) is.

I am wondering if this alternative is acceptable by you before I
spend too much time on it.

 - A new environment variable GIT_WORKING_TREE points at the
   root of the working tree.

 - Each git core command [*1*] that looks at the working tree is
   modified to take the user supplied pathname as a path
   relative to the current working directory, and use
   GIT_WORKING_TREE value to figure out which path the user is
   talking about, relative to the tree structure GIT_INDEX_FILE
   describes.

There is no need for jit-show-diff-wrapper when the above change
happens.  The user (or Cogito) has to set and export
GIT_WORKING_TREE once, and whereever the user happens to be the
core git command would just work as expected.

What do you think?


[Footnotes]

*1* Yes I am aware that there are tons of them that need this
surgery if we wanted to take this approach.

