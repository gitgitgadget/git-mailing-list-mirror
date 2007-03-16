From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 02:00:33 -0400
Message-ID: <20070316060033.GD31606@spearce.org>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org> <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 16 07:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HS5Uf-0004Rz-GL
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 07:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbXCPGAl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 02:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753422AbXCPGAl
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 02:00:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36316 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420AbXCPGAk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 02:00:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HS5UQ-0005WH-W6; Fri, 16 Mar 2007 02:00:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C2B4B20FBAE; Fri, 16 Mar 2007 02:00:33 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42327>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > On the other hand, many of the variables declared in environment.c
> > are repository specific configuration variables.  These probably
> > should be abstracted into some sort of wrapper, so that multiple
> > repositories can be accessed from within the same process.  Why?
> > a future mod_perl running gitweb.cgi accessing repositories through
> > libgit.a and Perl bindings of course!
> 
> I think if you are abstracting them out, into "struct repo_state",
> the index and object store related variables such as packed_git
> should go there as well, so your recommendation feels very
> inconsistent to me.

I missed packed_git, but you are right, that should definately go
with a struct repo_state.  And maybe you are right that the index
should go with it... but I'm not sure the index should be tied to the
repository at all.  Its strictly convention that the index goes with
the repository; GIT_INDEX_FILE lets you say otherwise at the command
line level, why can't we do otherwise from a library level too?
 
> >>     o Add prefix (eg, git_*) to public API functions
> >
> > Yes.  But which functions shall we expose?  ;-)
> 
> Before going into that topic, a bigger question is if we are
> happy with the current internal API and what the goal of
> libification is.  If the libification is going to say that "this
> is a published API so we are not going to change it", I would
> imagine that it would be very hard to accept in the mainline.

I'm looking at a middleground between our current "moving target"
internal API and our "frozen" plumbing process based API.  There
are a number of places where just being able to get data *out*
of Git easily would be useful, but doing so right now is awkward.
Either you code against our "moving target" internal API by creating
a new builtin (e.g. my builtin-statplog) where its easy to get what
you want, or you code against the plumbing based tools, where its
sometimes not so easy...

Most of the data formats aren't changing; a commit is a commit is
a commit.  It has a tree, parents, author, committer, message.

> Improvements like the earlier sliding mmap() series need to be
> able to change the interfaces without backward compatibility
> wart.

I agree.  But I also think the use_mmap() API is just way too low
level for a public library.  That particular change was pretty
low level.

Think higher, like "struct commit".  That is actually too low still,
as it doesn't really help you with the author and committer.

> In other words, I do not know what idiot ^W ^W who listed the
> libification stuff on the SoC "ideas" page,

I'm the idiot ^W individual responsible.  ;-)

> I would disagree with tying libification and Perl binding this
> way.  If the goal is to get faster gitweb, then that does not
> necessarily have to be libified git.  Let one person who does
> the libification come up with a decent C binding and let others
> worry about Perl bindings.

Yes.  However Perl bindings are often asked for.  And Marco Costalba
might like a working libgit that he could use for revision fetching
in qgit.  I think that if patches for a library started to appear,
another interested party would start to at least play with them.
 
> One big thing you forgot to mention is that whatever form it
> takes, the libification should not impact performance of
> existing plumbing.  These interfaces are "internally" public
> exactly because the callers still honor underlying convention
> such as not having to clean-up the object flags for the last
> invocation.  If you libify in a wrong way, you would end up an
> implementation of the interface that always cleans up (because
> you would not know if you are part of a long-living process so
> you will clean-up just in case you will still be called later),
> which would be unusable from the plumbing point-of-view.

I didn't forget; I just simply did not mention it.  I was considering
writing something to that effect, and probably should have.

This is a really valid point.  Git is insanely fast, partly because
we have a lot of "run once" types of applications and we have
optimized for those.  Any sort of "run many times" reuse needs to
not make the "run once" guy pay for something he will not use.

A good example of this is in git-describe, where we use the object
flags, and only bother to clear them out if there is another commit
remaining to be described.

-- 
Shawn.
