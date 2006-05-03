From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk highlight feature
Date: Thu, 4 May 2006 09:08:23 +1000
Message-ID: <17497.14311.121872.249120@cargo.ozlabs.ibm.com>
References: <17495.61142.677439.171773@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605021659430.4086@g5.osdl.org>
	<Pine.LNX.4.64.0605021721540.4086@g5.osdl.org>
	<17496.7073.507895.484698@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 01:08:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbQSP-0004nU-NH
	for gcvg-git@gmane.org; Thu, 04 May 2006 01:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWECXIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 19:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWECXIb
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 19:08:31 -0400
Received: from ozlabs.org ([203.10.76.45]:2439 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751385AbWECXIa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 19:08:30 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 1F09967B23; Thu,  4 May 2006 09:08:29 +1000 (EST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605030946260.4086@g5.osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19532>

Linus Torvalds writes:

> So far, what I've wanted to highlight by is:
> 
>  - "does it touch this file/directory/pathspec"
> 
>    This is _close_ to "git-rev-list", and you can (and do) actually 
>    implement it as that, but it's stupid to do it that way. You just spend 
>    extra time. It's literally much better to do
> 
> 	cat commit-list | git-diff-tree -s --stdin -- <pathspec>
> 
>    which is a hell of a lot more efficient, since you already have the 

On my G5:

$ git-rev-list HEAD >all-revs
$ time git-rev-list HEAD -- arch/powerpc >ppc-revs
real    0m2.463s
user    0m2.265s
sys     0m0.191s
$ time git-diff-tree -s --stdin -- arch/powerpc <all-revs >ppc-revs2
real    0m5.269s
user    0m4.794s
sys     0m0.462s
$ wc ppc-revs*
   892    892  36572 ppc-revs
  5875   5875 240875 ppc-revs2

Why does git-diff-tree -s --stdin produce so many more revisions than
git-rev-list?  The git-diff-tree output includes commits such as
6ba815de, which only affects arch/i386/kernel/timers/timer_tsc.c.
Confused.

>    commit-list you're interested in (and, in fact, this allows you to do 
>    things efficiently only for the current _visible_ commits, if you want 
>    to, which might be an important optimization for large views).

I'd have to try it.  The overhead of fork/exec/process startup might
be too much to do every time the user scrolls the window, though.
Maybe what we need is some way to have git-diff-tree run as a helper
process where I can write some commits to it, then write something
that says "that's all for now" and have it finish what it's doing,
write some "end of output" indicator and flush its output buffers -
and still have the process and the pipes to/from it available for
another round later.

>  - "Does the author/committer match xyz*"
> 
>    I ended up using the "search" button for this, and it worked, but the 
>    highlight feature would just have done it much better. Especially if 
>    there was a way to do "go to next highlight", instead of just "go to 
>    next commit"

The "/" and "?" keys go to the next and previous find hit.  It sounds
like the search function is actually what you want for this, since it
does highlight the commits that match, but maybe the problem is that
the yellow highlighting tends to go away too easily.

How about a way to do a search and use the results to create a
bold highlight, which will persist even if you do another search?
Either a separate "find & highlight" button, or a way to transfer the
current find hits to the highlight?

As for "go to next/previous highlight", that sounds useful.  Rusty
wants "go to next/previous commit that is a child/parent of this one"
and "go to next/previous commit that is a descendent/ancestor of this
one and has a ref (tag, head, etc.)".

How about shift-up and shift-down for "go to previous/next highlight"?

Paul.
