From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Improved three-way blob merging code
Date: Thu, 29 Jun 2006 10:45:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291028010.12404@g5.osdl.org>
References: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org>
 <81b0412b0606290043s15e19b9fl853627e815f009ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 19:45:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw0a5-0001br-5k
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 19:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWF2Rpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWF2Rpa
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 13:45:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751105AbWF2Rp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 13:45:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5THjMnW008630
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 10:45:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5THjK6s032582;
	Thu, 29 Jun 2006 10:45:21 -0700
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0606290043s15e19b9fl853627e815f009ff@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22875>



On Thu, 29 Jun 2006, Alex Riesen wrote:
>
> On 6/29/06, Linus Torvalds <torvalds@osdl.org> wrote:
> > +static void *three_way_filemerge(mmfile_t *base, mmfile_t *our, mmfile_t
> > *their, unsigned long *size)
> > +{
> ...
> > +       if (t1 && t2 && t3) {
> > +               int code = run_command("merge", t2, t1, t3, NULL);
> 
> This does not use the labels of merge(1) and the merged file will contain
> the names of temporary files at conflict places, which is very confusing if
> you happen to loose context while doing a merge with lots of conflicts.

Yes. 

I was really really _really_ just hoping that I could do the nasty core 
code that others might feel uncomfortable with, and get it working from a 
_technical_ level well enough that others (hint hint) would decide that 
they can fix up the details.

Getting the first version working is often the hardest. When you reach the 
point of "it works, but I want to extend it to do X", you've usually 
already gotten pretty far.

Anyway, all of this was really just preparatory work to show what 
git-merge-tree does. A few more improvements to git-merge-tree, and 
hopefully it can start being useful - perhaps not initially for actually 
merging, but for doing a tree-level three-way diff between two branches.

In other words, my current goal is really do make it possible to get good 
diffs out of git from two branches that aren't directly related. You and 
Dscho seem to be doing well on the git-merge-recursive front, so my 
personal goal is actually to be able to get a saner diff than what

	git diff mine..theirs

gives you.

The above "git diff" is a perfectly fine thing to do, but it's usually not 
what you actually _want_. Almost always, what you want a diff between two 
branches, what you want is actually the diff after a merge of the 
branches, not the raw _current_ differences.

For example, look at our current 

	Documentation/howto/using-topic-branches.txt

file, and realize that the current scripts it suggests are actually 
broken:

	To create diffstat and shortlog summaries of changes to include in 
	a "pleasepull" request to Linus you can use:

	 $ git-whatchanged -p release ^linus | diffstat -p1
	and
	 $ git-whatchanged release ^linus | git-shortlog

where that "git-whatchanged -p release ^linus | diffstat -p1" won't 
actually be what I see when I merge (although it will hopefully be close 
enough). Also, there's no indication that the merge will fail when I pull, 
something that _would_ be very useful.

IOW, what I'd like git-merge-tree to do is to be able to at a minimum say:

 - will a merge succeed cleanly, and if not, show me where the problem 
   spots are.
 - what will the result of the merge look like.

because that's actually what a downstream developer wants to do. He'd just 
do

	git fetch linus
	git show-changes linus..my-branch

which would basically be the preparatory thing for sending me an email 
saying "please merge 'my-branch', and you'll see this".

Now, obviously, I think that there's a _lot_ of overlap between doing this 
and actually doing the merge itself, so hopefully the things I do will at 
least have some things in common and perhaps help you do the proper 
recursive merger.

But one thing I was actually hoping to do was to literally be able to do 
this without either tree being checked out, exactly so that you can check 
the status of a branch that you may not even _be_ on (eg that "my-branch" 
in the example above may not even be your current HEAD: you might be on 
your development branch when you actually ask me to pull from your stable 
branch).

So the "show differences" has a lot in common with "merge them", but there 
are literally a few stages missing. One thing missing in just showing 
differences is that you can't actually fix up the merge clashes: if you 
don't have a checked-out tree, you're not going to be able to do a real 
merge. But you can see what a merge would _look_ like, and whether there 
are any clashes that you will have to fix..

		Linus
