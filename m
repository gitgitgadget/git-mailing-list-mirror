From: Ari Entlich <lmage11@twcny.rr.com>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 01:55:48 -0400
Message-ID: <1192859748.13347.146.camel@g4mdd.entnet>
References: <c594999b2337.2337c594999b@nyroc.rr.com>
	 <20071019015419.GV14735@spearce.org>
	 <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu>
	 <20071019031959.GE14735@spearce.org>
	 <20071019032407.GA10622@coredump.intra.peff.net>
	 <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU>
	 <20071019033500.GB10697@coredump.intra.peff.net>
	 <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU>
	 <20071019034704.GB11095@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 07:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7Jl-0007hi-0L
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 07:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbXJTFz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 01:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbXJTFz7
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 01:55:59 -0400
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:63884 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657AbXJTFz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 01:55:58 -0400
Received: from [192.168.123.196] (cpe-24-59-99-35.twcny.res.rr.com [24.59.99.35])
	by ms-smtp-05.nyroc.rr.com (8.13.6/8.13.6) with ESMTP id l9K5tpUv024980;
	Sat, 20 Oct 2007 01:55:52 -0400 (EDT)
In-Reply-To: <20071019034704.GB11095@coredump.intra.peff.net>
X-Mailer: Evolution 2.10.3 
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61786>

On Thu, 2007-10-18 at 23:47 -0400, Jeff King wrote: 
> On Thu, Oct 18, 2007 at 11:40:47PM -0400, Michael Witten wrote:
> 
> > Anyway, succinctly:
> >
> >> What you want to happen is the following:
> >> 	
> >> 	git show HEAD:A.txt > path/B.txt
> >> 	git add path/B.txt
> >> 	mv A.txt B.txt
> >> 	git rm A.txt

The one above is not only "worse" than the one below, it's wrong. See
Wincent's message and my response to it.

> >
> > Better:
> >
> >>  	mv A.txt path/B.txt
> >> 	Point the index entry for A.txt to path/B.txt
> >
> > I hope that's right.
> 
> Hrm. So you _do_ want to do an index-only move of A to B, in which case
> the suggestion of a "git-mv --cached" seems sensible. Though I'm curious
> why you want that.

Well, I also want to move the working directory file so that the index
and the working directory still match up and so that their differences
are preserved. Therefore, --cached isn't quite right (see Shawn's
messages and my response to them).

> The only workflow I can think of is: 
> 1. you modify a.c
>   2. your boss comes in and tells you to make some unrelated change,
>      which involves moving a.c to b.c
>   3. You don't want to commit your changes, so you git-mv in the index
>      only without involving your dirty working tree file.
>   4. You commit the index (which doesn't have your changes from (1)
> 
> I think that is sort of a bogus workflow, though, since you will never
> have actually compiled or tested the changes in (2). You are much better
> to git-stash your current work, fulfill the boss's request, then
> unstash.

Hmm, that's an interesting point. Are you talking about situations in
which your changes after (1) leave the program in an uncompilable state?
In this situation, I could imagine git stash being a better solution. In
my situation, however, the project was compilable. The reason I didn't
want to commit the changes was because I wasn't entirely satisfied with
how I implemented the change I was trying to make; I thought there might
be a better way to do it. I wanted to get some comparatively
straightforward changes out of the way before I tackled it.

On some level, the reason I want this change isn't entirely because it's
preventing me from doing something I want to do. I've come to really
like git and how the index can be used to separate all of the changes
you have made from the changes that you want to commit in individual
commits. I've come to really like how much access to the lower-level
interfaces git provides. It seems to me that people should support this
simply because it provides more power to the user. If the user wants
their unstaged changes to be staged, they can explicitly do it with git
update-index or some such command.

If the issue is whether this would be the default, that's a completely
separate issue, and one which I don't really have a strong opinion on.
If it were up to me, I'd probably choose to make it the default, but
this might break some people's expectations. I want to keep git
accessible to as many people as possible, not force it into the mold
that I feel is the only correct one. If the functionality is available
but only used when you want it, what's the harm in including it?

I don't really see why you're analyzing the situations in which this
would be used. I think it should be obvious from my descriptions of my
situation that there is an application for this functionality. Unless
you're going to start calling my process bogus (as you did to the one
involving a boss), which I would not appreciate, I'd argue that the same
mentality should be applied to this that is applied to kernel drivers -
if it's useful to even only one person, it should be supported. This
functionality of git wouldn't even be that extreme an example, though -
there's no telling whether somebody might be in a situation like mine
and find that they want to do what I want to do.

But... that's not even the point I was going to make. I think the
questions you should be asking are things like "Does this fit with the
overall architecture?", "Does this or doesn't this provide power and
flexibility to the user?", etc. Is git being made for "the 80%" that use
Subversion and need to be supported by a cushy GUI, or "the 20%" that
thrive on power and are in touch with future trends?

So... yeah. Sorry, I know this got to sounding incredibly
propagandistic, but this is what propaganda's for, right? :)

Sorry if anything I've said here sounded confrontational; that was not
not my intent at all. I'm just raising some points I think are
important. I don't want any flame wars...

On Thu, 2007-10-18 at 23:58 -0400, Jeff King wrote:
> On Thu, Oct 18, 2007 at 11:53:05PM -0400, Michael Witten wrote:
> > It's not unreasonable.
> 
> I guess. I really think git-stash is your friend here. But you can
> still do step (3) with git-update-index (I'll leave the exact details
> as an exercise for the reader).

See my response to Wincent's message for my opinion on using git stash.
I seems to me that using it is more of a workaround than a fix.

Thanks,
	Ari
