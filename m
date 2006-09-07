From: Junio C Hamano <junkio@cox.net>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 07 Sep 2006 10:40:02 -0700
Message-ID: <7v4pvj1sp9.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609070557jd8cfc57nd4f7a8973b69f6ed@mail.gmail.com>
	<20060907133456.24226.qmail@science.horizon.com>
	<loom.20060907T163036-849@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux@horizon.com
X-From: git-owner@vger.kernel.org Thu Sep 07 19:40:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLNrI-0001sl-5A
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 19:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422683AbWIGRkF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 13:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWIGRkF
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 13:40:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:27881 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1422683AbWIGRkC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 13:40:02 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907174001.ZLHY6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 13:40:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KVfn1V00j1kojtg0000000
	Thu, 07 Sep 2006 13:39:54 -0400
To: Richard Curnow <rc@rc0.org.uk>
In-Reply-To: <loom.20060907T163036-849@post.gmane.org> (Richard Curnow's
	message of "Thu, 7 Sep 2006 14:39:39 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26648>

Richard Curnow <rc@rc0.org.uk> writes:

>  <linux <at> horizon.com> writes:
>
>> For regular packs, such objects wouldn't even be present, because
>> all base objects are in the pack itself.
>
> It would actually be useful if this restriction were lifted.

The primary reason why we require the base object to be present
in the same pack is because our assumption has always been we
mmap a pack as a whole, and we assumed that we can make sure
that the address space of a process to be enough to mmap at
least one pack (otherwise the user will be given a way to keep
size of each pack down to a size that is a mmapable piece) but
not necessarily more than one.  In other words, while unpacking
one object that is deltified, we wanted to make sure everything
that is necessary is availble in memory.  Otherwise, when
multiple packs are needed to reconstitute a single object
because the object is a delta in one pack and its base is in the
other pack, we might not be able to mmap both of them into the
address space at the same time.

The "mmap only parts of a huge packfile into map windows" update
Shawn Pearce is working on would lift that worry, so it would be
less of a reason.

Having said that, people must realize that keeping thin packs on
disk, indexed, is a major undertaking.  It can be made to work,
but it will be painful.

People can grab a thin pack via rsync or http without realizing
it is thin, try to use it and then later (possibly much later,
when a delta that is against a missing object happens to be
needed) discover some of the pack data is unusable.  To avoid
this, the dumb transports need to walk the ancestry chains of
commits and their associated objects while fetching as they do
right now, but also need to walk the delta chains to make sure
their base objects are available.

I like the proposal by Linus to have stub objects that records
what the missing base object is in the thin pack stream.  It
simplifies things for the offset representation of bases.  But
if we were to do so, I suspect indexing such a thing would need
more surgery to the .idx format.  The question is if we should
record the stub object in the .idx file.

Right now we record the beginning of data for each object
(either base or delta) without storing anything to say about
where it ends -- the pack is assumed to be dense, so the point
where next object begins should be where the current one ends.
This means that we need to build a reverse index to list the
objects in the pack in offset order, when we want to find the
end of each object efficiently.

We work this around when using a pack by not doing the full
verification.  We start decoding the header from the beginning
and in either base or delta the deflated stream sits at the end.
We inflate that deflated stream until zlib says it got enough,
and we do not check if that "enough" point stepped into the
location that is supposed to be inside the "next" object (if it
did so then it is an error in the packfile we missed to detect).
If things inflate well and delta applies cleanly, we are happy.

But pack-objects, when reusing the data from an existing pack,
wants to be careful, so it _does_ build a reverse index itself
and makes sure that inflate() ends at the location we expect it
to.  For that process to remain the correct way to determine
where each object ends, the .idx file must record the presense
of stub objects.

However, if we write the names of stub objects in the .idx file,
we have another problem.  Currently, the existence of an object
name in the .idx means that such an object exists in the
corresponding .pack; this will not hold true anymore.

So if we were to do this, we need to give one extra bit to each
of the .idx entries to mark which ones are stub and which ones
are not.  This would allow the reverse index to properly notice
where each object ends, and allow the dumb transports to walk
the .idx for missing base objects efficiently.  The code that
looks at .idx at runtime to determine which pack has needed
object needs to notice this bit.

Again, all of this can be made to work, but it will be painful.
