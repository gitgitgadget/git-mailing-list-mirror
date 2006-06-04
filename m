From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 4 Jun 2006 09:08:24 +0200
Message-ID: <e5bfff550606040008m4dbf02bdga4f4e6bc2d2fe9d@mail.gmail.com>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	 <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	 <17538.16015.53244.876090@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 04 09:08:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmmiq-000765-SB
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 09:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWFDHI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 03:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWFDHI0
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 03:08:26 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:65078 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932140AbWFDHIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 03:08:25 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1134473wri
        for <git@vger.kernel.org>; Sun, 04 Jun 2006 00:08:25 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=skfHYO8jMQLyf+4se+UpEfneqP5nCw1Q0D9A3rV+4anpwCZqqqByYt+/e0vTwjDoK+gQOBC3JYeKCiyehBiv10WGuYTHCn/rk0Lta3Us/GXTW9HKzEGgG5QuG4edlcbXIAhQLksLIO1LVMRHi7ikHlVEMDf8cdnMAVF9B1R8X4I=
Received: by 10.65.215.12 with SMTP id s12mr2764816qbq;
        Sun, 04 Jun 2006 00:08:24 -0700 (PDT)
Received: by 10.65.210.17 with HTTP; Sun, 4 Jun 2006 00:08:24 -0700 (PDT)
To: "Paul Mackerras" <paulus@samba.org>
In-Reply-To: <17538.16015.53244.876090@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21249>

On 6/4/06, Paul Mackerras <paulus@samba.org> wrote:
> Marco Costalba writes:
>
> > If I have understood correctly the patch runs a 'git rev-list --all
> > --topo-order --parents'
> > and then does a tree walking.
>
> Yes, that's right.  It means that gitk can show the nearest tags even
> if they aren't included in the current view.
>
> > I am wandering if there exist any native git way to found the previous tag.
>
> I don't know of any.  Doing the tree walking in Tcl turned out to be
> not too much of an overhead, though; it does the whole kernel
> repository in 1.5 seconds on my G5.
>
> > As example given a selected revision with id <sha> is it possible to
> > do something like this to fond the ancestor?
> >
> > 1) get the tag list with git-peek-remote or something similar if tags
> > are not already loaded
> >
> > 2) given the tagList vector with n elements run
> >
> >     git-rev-list  --topo-order <sha> ^tagList[0]  ^tagList[1]   ....
> >   ^tagList[n-1]
> >
> > 3) take the last sha spit out by git-rev-list, be it <lastSha>.
> >
> > 4) Previous nearest tag is the parent of lastSha
> >
> > I've missed something?
>
> I'm not sure exactly what that would do, but gitk can show more than
> one tag (the term "nearest tag" is only a shorthand approximation for
> what it does).  For example, if you have two tagged commits where
> neither is an ancestor of the other, and do a merge of the two, gitk
> will show both tags when you select the merge.

What you suggest we need it's a kind of history of tags.

Currently we can run

git-rev-list --top-order --parents HEAD -- foo.c

and we get an history of file foo.c *with modified parents*

Junio, could be possible have something like

git-rev-list --top-order --parents --tags

with the history of tags ?

And, according to Paul suggestions, not only tags, but merge revisions
between tags.

A more general and IMHO very powerful tool could be something like

git-rev-list --top-order --parents --selected-only HEAD -- <sha 1>
<sha 2> .....  <sha n>

Where git rev list gives the history, with modified parents, of the
given revisions _only_ plus the merging revisions among them.

This could be used for tags (got from git-peek-remote), for branches
and in general for a given set of interesting revisions.

Once we have the history of tags, perhaps requested once at startup,
we can get the previous tags of a given revision, our original
problem, with

git-rev-list  --topo-order <sha> ^tagList[0]  ^tagList[1]   ....
^tagList[n-1] ^merge[0] ... ^merge[k]

And have one or more tags according if results is a rev in tagList or
mergeList. Having the tag history it's easy to look up _all_ the tag
ancestors.

       Marco

P.S: another use of

git-rev-list --top-order --parents --selected-only HEAD -- <sha 1>
<sha 2> .....  <sha n>

could be this:

Currently both qgit and gitk can filter revisions with a given set of
filter rules, but the results are shown together with the other
revisions or as a list of matching revisions with no useful graph
information.
We could feed git-rev-list --top-order --parents --selected-only with
the list of matching revisions and have a pretty and sensible graph
too.
