From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Is there a way to exclude user-specified files or directories
 from  participating in merges?
Date: Thu, 19 Feb 2009 13:37:56 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngpqo5k.j03.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
 <slrngpo3hp.boq.sitaramc@sitaramc.homelinux.net>
 <7v3aeby3eh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 19 14:40:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La97r-00034I-DZ
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 14:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbZBSNiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 08:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZBSNiL
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 08:38:11 -0500
Received: from main.gmane.org ([80.91.229.2]:53622 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbZBSNiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 08:38:09 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1La96N-0000Yw-JK
	for git@vger.kernel.org; Thu, 19 Feb 2009 13:38:07 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 13:38:07 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Feb 2009 13:38:07 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110697>

On 2009-02-18, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
> > Let me explain where I'm coming from: this is very often needed when you
> > maintain customer specific branches, and the workflows in both your
> > posts in this thread so far are too complex for, err, me <sheepish grin>
> > :-)
> >
> > Would it not be easier to do something like this?  (I suck at 2-d
> > drawing, even line... but this should still be understandable)
> 
> What you drew is a detailed discussion on a technique to use to group
> together common part and customer specific part, and I think it is Ok to
> do whatever you feel comfortable with.  It is essentially the same as my
> "in real life, 'git diff >P.diff' is not how I would do this" example,
> just going into more detail on what you would do to sift 'common only' vs
> 'specific to work branch' apart, and I think what you are doing is sane.

Thanks -- I mainly wanted confirmation that one does *not*
have to do diff/patch/apply or plumbing commands to achieve
what the original poster was asking.

> But if you wrote it as a draft of a document to explain how-to to new
> people, I think you need to clarify a few things.

> It is unclear in your description how the "common" branch progressed in
> the whole process, and how the resulting history looks.  I can guess that
> you meant commits marked with alphabet letters are of common kind and
> numbers are of work kind, but you do not want to force readers to guess.

> It also is not quite clear that you are using a temporary branch in
> addition to common and work, and where in your sequence you are doing "git
> checkout" to switch branches.

I did not write it in that light then, but I will do so now,
and if you have a few minutes to critique it that would be
great.  If it's crap, sorry for the noise.

----->8-----

The following document explains how to maintain a 'common'
branch, with one or more 'customer specific' branches that
hang off of the common branch.  The inspiration was a
question about maintaining 'work' and 'home' configurations
which differ perhaps slightly from a 'common' configuration,
which leads to the same sort of situation.

The basic rules are best described by Junio in
http://permalink.gmane.org/gmane.comp.version-control.git/110489

>  - You make edits to common files only on the common branch.
>  - You merge from common to deployment, never the other way.

This is one way to follow those rules.

We use the following terminology:

'common' is the branch representing the base product.  All
regular customers get this version.

'special' is a special branch for a specific customer.  This
customer needs changes unique to his environment, which
should not be merged back into the common branch.  However,
this branch must regularly get the benefit of changes in the
mainline 'common' branch.  (This is the genesis of the two
rules above).

If you have more than one special customer the same logic
will apply for each of them separately, although if you have
too many such customers you may also want to look at "Never
merging back" (http://gitster.livejournal.com/26540.html)
for an additional tip on this.

Also, we assume the actual development and testing needs to
be done on one branch, so you will have a mix of 'common'
and 'special' changes all together.

The history looks like this in the beginning:

    -----o          <- special branch (current)
        /
    ---o            <- common branch

Before you start, make a temporary branch TEMP from
'special'; leave special where it was.

    git checkout -b TEMP special

You now make some changes for the special customer, which
also involve some 'common' changes that need to be ported
back to the common branch.  The topology now looks like
this, where A, B, C, are changes that logically belong on
'common', and 1, 2, 3, are changes that are specific to this
customer.

Notice that the 2 sets of changes are intermixed because
that is how the development happened, and that there is even
one commit where common and special changes are mixed
(perhaps you realised this only later).

    -----o--A--B1--2--3--C          <- "TEMP" branch (current)
        /
    ---o                            <- common

Meanwhile, just to make things interesting, the common
branch has also had some other, unrelated changes which you
eventually want on the special branch as well.

    -----o--A--B1--2--3--C          <- "TEMP" branch (current)
        /                                            
    ---o--X--Y                      <- common

The first thing to do is to tease the tangled commits apart
using rebase.

Using 'git rebase -i special', get the topology into this
shape.  Note that we have split the "B1" commit into B and 1
separately.  'git help rebase' has a very simple and clear
section on splitting commits, so I will not detail that
here.

    -----o--A--B--C--1--2--3        <- "TEMP" branch (current)
        /                                              
    ---o--X--Y                      <- common

At this point you may want to retest, just to be sure.

Now switch to the 'common' branch and cherry pick the
changes that belong on 'common'.  The simplest way to cherry
pick is gitk.

    git checkout common
    gitk
    # and cherry pick first A, then B, then C, in order

    -----o--A--B--C--1--2--3        <- "TEMP" branch
        /                                              
    ---o--X--Y--A'--B'--C'          <- common (current)

Now merge from 'common' to 'special'

    git checkout special
    git merge common

           A--B--C--1--2--3     <- TEMP
          /
     ----o-----------------o    <- special (current)
        /                 /
    ---o--X--Y--A'--B'--C'

Now all we need is to get commits 1, 2, and 3 onto
'special'; this is easiest done by rebasing TEMP first...

    git rebase special TEMP

                             1'--2'--3'     <- TEMP (current)
                            /
     ----o-----------------o    <- special
        /                 /
    ---o--X--Y--A'--B'--C'

...and then making special equal to TEMP

    git checkout special
    git merge TEMP

                             1'--2'--3'     <- special (current)
                            /
     ----o-----------------o
        /                 /
    ---o--X--Y--A'--B'--C'

Now you don't need TEMP anymore, and can delete it:

    git branch -d TEMP
