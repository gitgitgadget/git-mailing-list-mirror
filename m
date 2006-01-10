From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Tue, 10 Jan 2006 12:11:02 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601101151090.4939@g5.osdl.org>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
 <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> <99D82C29-4F19-4DD3-A961-698C3FC0631D@mac.com>
 <46a038f90601092238r3476556apf948bfe5247da484@mail.gmail.com>
 <252A408D-0B42-49F3-92BC-B80F94F19F40@mac.com> <Pine.LNX.4.64.0601101015260.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601101938420.26999@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601101048440.4939@g5.osdl.org>
 <Pine.LNX.4.63.0601102010100.27199@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 21:11:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwPpt-00059Z-88
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 21:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbWAJULJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 15:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWAJULJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 15:11:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28830 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932530AbWAJULH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2006 15:11:07 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k0AKB3DZ030504
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Jan 2006 12:11:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k0AKB226012216;
	Tue, 10 Jan 2006 12:11:03 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601102010100.27199@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14444>



On Tue, 10 Jan 2006, Johannes Schindelin wrote:
> 
> Those commits not reachable from the good commit are of no interest. Let's 
> just ignore them.

Note that to avoid confusion, start talking about -multiple- good commits 
early.

So we have a list of "known good islands" in the git-space. And yes, we 
want to ignore anything that is reachable from them.

And here the magic part of"git-bisect.sh" is around line 133:

	... --not $(cd "$GIT_DIR" && ls refs/bisect/good-*) ...

It tells git-rev-parse to generate a list of commits that we're _not_ 
interested in, and that list will be one of the most critical parts of the 
stuff we give to "git-rev-list --bisect".

So that part of the script is literally the part that says "ignore all of 
git space that is reachable from the good commits", because we've listed 
all the good commits as refs named "refs/bisect/good-*".

> > You need to have a _set of points_ to separate the good from the bad. You 
> > can think of it as a line that bisects the surface: if you were to print 
> > out the development graph, the set of points literally _do_ form a virtual 
> > line across the development surface.
> 
> Okay, so there is a cut: Every directed path from good to bad has a single 
> commit which is the first bad. Let's call the set of all such bad commits 
> the cut set.

This set is uninteresting for two reasons:
 - it's hard to calculate
 - it's not the answer we want.

We want the _single_ commit that is the one that generates your "cut set".

Your "cut set" is really the "reachability border" from the single bad 
commit we're interested in to all the possible development lines.

In practice, the "cut set" is just the "bad commit" plus all the merges 
that merge that bad commit with somethign that wasn't reacable from it in 
the first place.

So the "cut set" isn't interesting.

> git-bisect is not capable of identifying the cut set, but pretends that 
> there really is only one bad commit (see bisect_bad()).

Not quite.

It could keep track of all bad commits (in fact, it does so in the log 
file), but the fact is, none but the lastest bad commit we have found 
matters.

By definition, "git bisect" is always going to test a commit that is 
reachable from the previously known bad commit. Agreed? Anything else 
would be insane - we know that we had a bad stat, and we're interested in 
finding out how _that_ bad state happened, so we're only ever interested 
in commits that are ancestors to that bad state.

So our search-space is _literally_ defined by two things:

 - the surface of "known good" commits (which defines the commits that 
   aren't interesting). 

   This is the "--not refs/bisect/good-*" part

 - the last "known bad" commit.

We'll always search the git commit space defined by these two knowns, 
agreed?

Now, realize that if we find a new bad commit, since that bad commit was 
by definition reachable from the _old_ bad commit (since we didn't even 
search outside its reachability), then equally by definition the 
reachability from that new bad commit is a strict superset of the 
reachability of the old bad commit.

So when we find a new bad commit, the old bad commit is no longer 
interesting.

So when you say "pretends that there really is only one bad commit", you 
didn't realize that it's not about "pretending". It's very fundamental: 
there is only ever _one_ bad commit that is interesting. It's the last one 
we found.

Even if we started out with two bad commits (ie some person reported two 
different versions as being bad), we're _still_ not interested in using 
them both. We should pick one of them, because the reachability area 
defined by two bad commits is always a superset of the reachability of 
either one.

So having multiple bad commits is _never_ interesting.

> But I see two problems with that:
> 
> - a problem can be introduced independently in two different branches, and
>   occur in both of them before the merge (in which case bisect only 
>   catches one of the commits), and

This is fine. Depending on whatever random factors, we'll test one of them 
first, and eventually find _one_ of the commits that fix it. If the exact 
same bug was introduced somewhere else, and merged, then undoing just the 
"one" bug will obviously undo the other one too.

If a _different_ bug was introduced (even if it had the same effects), 
yes, you now have two separate bugs. And bisecting two bugs is hard. You 
need to separate them out some way.

> - AFAICT if the cut set is one merge and one regular commit, bisect could
>   identify the merge by error.

It will never identify a commit without having done a full bisection, so 
if it ever had the choice of a "merge" and the "commit leading up to the 
merge", it will always have tried the "commit leading up to the merge", 
and decided that it was fundamentally more recent (had "smaller 
reachability") that the merge, and pinpoint it.

> BTW I think there is a thinko in git-rev-list.txt:
> 
> > Thus, if 'git-rev-list --bisect foo ^bar ^baz' outputs 'midpoint', the 
> > output of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint ^bar 
>              ^ this should be
> 	'git-rev-list foo ^midpoint ^bar ^baz'
> > ^baz' would be of roughly the same length

Yes.

			Linus
