From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 08:22:42 +0200
Message-ID: <20080911062242.GA23070@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 08:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdfaq-00089i-EK
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 08:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYIKGWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 02:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYIKGWo
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 02:22:44 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:51543 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491AbYIKGWn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 02:22:43 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 33C8C5465; Thu, 11 Sep 2008 08:22:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95585>

Linus Torvalds wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

>> - However, if you explicitly pull D, the origin information from A to D can
>>   be used.  People doing a generic clone get all four branches, and
>>   therefore have all the important commits which normally could contain
>>   origin links.  Note that even during a clone, commits pointed to by
>>   origin links are not being transmitted (unless there already are other
>>   reasons to send them along).

>IOW, it's not actually transferring them and saving them, since a simple 

Correct.

>delete of the origin branch will basically make them unreachable.

False.

If you fetch just branches A, B and C, but not D, the origin link from A
to D is dangling.  Once you have fetched D as well, the origin link from
A to D is not dangling anymore.  Subsequently deleting branch D but
keeping branch A will keep everything in branch D up till the commits
the origin link is pointing to alive and prevent those from being
deleted.

>Fine. At least it works the same way as fetch, then. But it's still a huge 
>mistake, because it really does mean that it is technically no different 
>at all to just mentioning the SHA1 in the commit message, the way we 
>already do for backports.

Not quite.

>The "origin" link has no _meaning_ for git, in other words.

Git will keep alive commits based on origin links once you (the fetcher)
has shown interest by fetching the appropriate branches.

As to "meaning" for git, it's there in the form of:
- --topo-order uses the information to order the output (but only if the
  target commits of the link are present in the repository).

>> >No it's not. You can mention the backport explicitly in the commit 
>> >message, and then you get hyperlinks in the graphical viewers. That works 
>> >when people _want_ it to work, instead of in some hidden automatic manner 
>> >that does entirely the wrong thing in all the common cases.

>> Could you spell out one of the common cases where it would do entirely
>> the wrong thing?

>It carries along information that is worthless and meaningless and hidden.

The common cases would be:

a. "hidden": It doesn't need to be hidden.  It can be hidden if you want it
   to be.  We can decide if git hides it sometimes, always or never.
   So this point is moot.

b. "meaningless": Git is all about taking snapshots of sourcetrees and
   linking them in an orderly fashion.  The origin link is all about
   taking snapshots of patches and linking them in an orderly fashion.
   This allows you to see the patch evolve over time, and it allows for
   diffs between patches.  We're not actually storing patches, we merely
   store snapshots.  As it happens, the snapshot of a patch is defined
   by two commit hashes.
   Doesn't sound meaningless to me.  Just as one needs normal history
   between commits in a branch to follow development, there is a history
   of a backport as it "travels" from stable branch to stable branch.

c. "worthless": Without the tracking of a backport through a series of
   well-defined patch-snapshots, it becomes kind of haphazard to
   actually figure out which piece of code came from where.  Having this
   information in the form of a series of origin links increases the
   efficiency of a developer maintaining the backports between branches.
   Maybe you consider that worthless, I consider anything that improves
   code quality because having access to a concise history of how the
   code evolved a Good Thing.  Having history of how code evolved is
   actually one of the main reasons why people use git.  It's just that
   git lacks support in the tracking of backports.  The origin link
   fills that gap.  If you don't do backports in your trees, then fine,
   the origin link will never materialise in your repositories.

>I refuse to touch such an obviously braindamaged design. It has no sane 
>_semantics_. If it doesn't have semantics, it shouldn't exist, certainly 
>not as some architected feature.

It does have sane semantics, quite well defined, actually.  I'm just not
good at explaining them apparently.  Try reading the explanation I gave
above.

>Nobody has shown any actual sane meaning for it. The only ones that have 
>been mentioned have been for things like avoiding re-picking commits 
>during a "git rebase", but (a) the patch SHA1 does that already for things 
>that are truly identical an (b) since that information isn't reliable 
>_anyway_, and since it's apparently a user choice, it's just "random".

Quite frankly I don't see the application for rebase either (yet).
I'm focusing on sane semantics first, any implications that has for
usability by rebase will follow from that.  The origin links track
content (patches), nothing else.  They assist the developer in
understanding how patches evolve, any use cases follow from that.

>I'm sorry, but "good design" is a hell of a lot more important than some 
>made-up use case that isn't even reliable, and doesn't match any actual 
>real problems that anybody can explain.

Please focus on the semantics and on the *non*-made up use case of
development of several stable branches with backports between them.
Discussing made-up use cases is wasting energy at this point.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
