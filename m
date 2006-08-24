From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] adding support for md5
Date: Thu, 24 Aug 2006 03:34:22 -0700
Message-ID: <7vmz9ua0cx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
	<Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
	<20060821204430.GA2700@tuatara.stupidest.org>
	<7vr6z9s376.fsf@assigned-by-dhcp.cox.net>
	<20060823041453.GA25796@spearce.org>
	<7v3bbojbzj.fsf@assigned-by-dhcp.cox.net>
	<20060823064900.GA26340@spearce.org>
	<7vac5ubn57.fsf@assigned-by-dhcp.cox.net>
	<20060824080807.GG25247@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 24 12:34:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGCXa-0007et-F1
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 12:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWHXKeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 06:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751066AbWHXKeW
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 06:34:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14783 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751063AbWHXKeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 06:34:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060824103421.MFVO12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 Aug 2006 06:34:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DmaL1V0094Noztg0000000
	Thu, 24 Aug 2006 06:34:21 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060824080807.GG25247@spearce.org> (Shawn Pearce's message of
	"Thu, 24 Aug 2006 04:08:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25953>

Shawn Pearce <spearce@spearce.org> writes:

>> Except some minor nits, yes.
>> 
>>  * I would have preferred two patches, one for "master" and one
>>    for the C merge-recursive topic (or at least "next").
>
> Doh.  I didn't realize this was something you were interested in
> pulling into master.

Applying them directly to "master" does not have much to do with
this.

Of course, if something is obviously the right thing to do, then
I often apply them straight to "master" (or apply them to
"maint" and pull the result into "master").  In other cases, I
prefer to fork off a new series from the tip of the "master"
into a new topic branch.  Then merge that into either "pu" (if I
have suspicion that it is not ready for even testing yet) or
"next", and cook there for a while until it is ready.

While being cooked in "next", what happens is that changes to
that specific topic are applied to the tip of the topic branch,
and then pulled into "next", over and over.  Many topic branches
are cooked simultaneously that way.  So the development history
of "next" is, eh, messy.

I usually test "next", in other words, multiple topics cooking
together.  But when some changes are applied to "master" that
might interfere with an older but still not in "master", I pull
"master" into the topic and test that topic alone in isolation.

That way, when a topic matures, we can be reasonably sure that
it can be pulled into "master" without breaking things.

A single patch on top of "next" depends on all existing topics
that may or may not turn out to be useful.  That makes such a
patch less useful than otherwise be.

So if a series affects things in "master" and some other things
still not in "master", a preferred way, from my workflow point
of view, is to have at least two patches: one for "master" and
another for the rest.  Then what I would do is to fork one topic
off from "master" and apply the former, pull that into "next"
and cook that.  That part of the topic can graduate to "master"
without waiting for other topics in "next".

What happens to the rest is a bit more involved.  In the case of
the hashcpy() patch, one thing that only exists in "next" was
merge-recursive.c, but the story would be the same if "next" had
more places that used memcpy(a, b, 20) than "master" in a file
that are common in two branches.  Ideally, the remainder will be
broken into pieces and applied as a fixup on top of existing
topics (in this case, C merge-recursive topic) and then merged
into "next".  This can be either done by applying the remainder
directly on top of the affected topic, or forking a subtopic off
of the affected topic (the latter is useful if the new series
might turn out to be dud -- the original topic will not be
contaminated by bad changes and can graduate to "master" more
easily).

In any case, I've done a split myself and the parts that can be
applied to "master" is now sitting in gl/cleanup topic and the
remainder is sitting in gl/cleanup-next topic which was forked
off from C merge-recursive topic (you can tell where their tips
are by looking at "gitk next" output) and both are merged into
"next".
