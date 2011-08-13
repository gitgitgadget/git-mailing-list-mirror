From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Sat, 13 Aug 2011 12:45:37 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1108131215170.2056@iabervon.org>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com> <1313088705-32222-6-git-send-email-artagnon@gmail.com> <20110811215650.GA13839@elie.gateway.2wire.net> <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1644199299-1313253937=:2056"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 19:03:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsHcg-0007eR-8m
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 19:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666Ab1HMRDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Aug 2011 13:03:41 -0400
Received: from iabervon.org ([66.92.72.58]:44173 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201Ab1HMRDl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2011 13:03:41 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Aug 2011 13:03:40 EDT
Received: (qmail 18482 invoked by uid 1000); 13 Aug 2011 16:45:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Aug 2011 16:45:37 -0000
In-Reply-To: <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179281>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1644199299-1313253937=:2056
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 13 Aug 2011, Ramkumar Ramachandra wrote:

> Hi again,
> 
> Jonathan Nieder writes:
> > Another thought.  I wonder if it's possible to leave
> > sequencer_parse_args() private to builtin/revert.c, making the split
> > a little more logical:
> 
> Yes, I'd like this too.  However, there are two new issues:
> revert_or_cherry_pick_usage and action_name.  The former has two
> callsites: one in prepare_revs (in sequencer.c) and another in
> parse_args (in builtin/revert.c).  Unfortunately, action_name is even
> more complicated to get rid of: the information from it is used all
> over the place.

One thing to consider is that sequencer.c will be used by all sorts of 
different builtins, which are each implementing instructions given 
differently by the user. Just because a message makes sense as output from 
revert.c doesn't mean it will make sense from (for example) bisect*.

> Attempting to attack the problems one by one:
> 1. Make prepare_revs and walk_revs_populate_todo return errors to be
> handled by callers.  This is a fairly small patch that can come before
> the big "code moving patch".

This makes sense. If you type "git log --stat=foo", you don't get a 
diff usage message, even though it's an error parsing options that were 
originally part of diff.

> 2. Duplicate action_name in both files.  I don't think it's too
> serious, and we can fix this later.

This is actually probably even a good idea, because the two functions 
might actually want to give different results. Maybe revert.c will end up 
doing different sequencer operations depending on whether the commit is a 
merge, but if revert.c has to give an error, it would call it the same 
thing either way, because the difference doesn't matter at the level of 
detail the revert.c works at; on the other hand, sequencer.c would want to 
distinguish the cases so that it is explaining exactly what it's trying to 
do in this step because it matters to how the issue would be resolved.

Of course, at the point where you move the code, you only have one piece 
of code that you're starting from, so they'll be the same. But you might 
want to name them differently.

> It has been enormously annoying to work with this "code moving patch":
> everytime I make some changes to the earlier patches, I have to
> recreate this one by hand; rebase offers no help whatsoever.  After
> throwing away code based on this patch several times, I learnt my
> lesson and restricted my series to avoid building on this patch.  I
> consider this a very serious glitch and I'm interested in fixing it.
> Thoughts?

It's a hard problem, although likely worthwhile to solve. But only when 
you're not doing anything else, because it's complicated and will take you 
far afield. Essentially, what you need to do is implement a diff algorithm 
that can detect reorganization (or copying) of sections; this isn't 
something you can represent in unified diff output, but that's okay 
because you're not going to output it. You merge two of these results and 
apply the result to the base, which gives you a file (potentially with 
conflicts, which is another interesting issue because you have to 
represent and explain them somehow).

*: bisect could be using sequencer in order to handle the situation where 
the user has said "commit A is good, commit B is bad, commit C breaks my 
system in a way that's unrelated"; the system should then be able to check 
out a maybe-bad commit and revert C from it, but it would be doing this in 
response to an instruction from the user: "give me something to test 
next", and would have to present errors differently.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1644199299-1313253937=:2056--
