From: Junio C Hamano <junkio@cox.net>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 07 Sep 2006 11:50:37 -0700
Message-ID: <7virjzy0hu.fsf@assigned-by-dhcp.cox.net>
References: <44FF41F4.1090906@gmail.com>
	<9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
	<Pine.LNX.4.64.0609062037560.18635@xanadu.home>
	<20060907043300.GA31376@spearce.org>
	<7vslj4455z.fsf@assigned-by-dhcp.cox.net>
	<20060907054651.GD31580@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 20:54:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLOxv-00050D-81
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 20:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWIGSu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 14:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWIGSu4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 14:50:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:16552 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750924AbWIGSuv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 14:50:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907185051.SJJH27846.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 14:50:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KWqX1V0041kojtg0000000
	Thu, 07 Sep 2006 14:50:43 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060907054651.GD31580@spearce.org> (Shawn Pearce's message of
	"Thu, 7 Sep 2006 01:46:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26649>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Shawn Pearce <spearce@spearce.org> writes:
>> 
>> > And I'm half-way done with the 64 bit mmap sliding window.  You,
>> > Junio and I are all hacking on the same tiny bit of core code for
>> > different reasons.  :-)
>> 
>> Which makes me quite nervous, actually.
>
> What order do you want the patches in then?
>
> I'm willing to go before or after Nico's offset changes, and before
> or after your 64 bit index changes.
>
> Either way two of us are going to have to redo our work on top of
> the others.  I'm finding that I'm basically rewriting the sliding
> window code onto your 64 bit version - there's no easy merge here.
> And Nico's got the same problem, he's in unpack_delta_entry too.

While 64-bit offset exercise was a good way for me to see where
the <pack_base+offset> assumption lies in the current code, and
while it would have been the right way to do so in the ideal
world, I realize that it may not be the best way to do things in
the real world for a few reasons:

 - Always doing u64 arithmetic would be expensive, especially on
   32-bit architectures, and doing so conditionally is quite an
   extra complexity.

 - Not necessarily everybody has large file offsets, so asking
   to mmap 8MB at file offset at 6GB may not be possible.  Even
   on systems with large file offsets, truly huge single file is
   cumbersome to manage than a handful files under 32-bit offset
   (e.g. using a DVD-RW to back up your packs).

 - Mozilla may not be the largest project in the world, but it
   certainly is on the larger side than majority of our target
   audience, and even its entire history, 450MB, comfortably
   fits in 32-bit space.

So while I merged the 64-bit offset change in "next" branch, I
am quite doubtful that it was a good change.  As long as we
devise an easy way to keep each packfile under manageable size,
the current 32-bit arrangement would be more beneficial and
practical than doing everything internally in 64-bit.  Larger
projects, if needed, can use multiple packs, and even a project
that _could_ pack everything under 450MB would definitely want
to use multiple packs anyway (i.e. one or more huge historical
packs and one active pack) to avoid repacking and incremental
update cost.  Your "mmap parts into windows" update is of a far
more practical value than the idx with 64-bit offsets.  So I am
very inclined to revert my 64-bit offset change from "next".

Before declaring it a failure, in order to keep the window open
for the future, we would need to make sure that we can change
things as needed to do everything we want with 32-bit offset
packs.  The changes we would need I can think of are in the
following areas:

 - "git repack" needs to be taught to limit the resulting packs
   under 32-bit offset.  I think this is a given, and we would
   need some updates to the command because it needs to be
   taught not to touch "huge historical packs" anyway.

 - "git send-pack" and "git fetch-pack" are Ok -- the receiving
   end explodes the pack that comes over the wire using
   unpack-objects into loose objects, and there is no offset
   involved during the process.  Note that pack-objects may need
   to keep the offset in the stream in u64 if we were to do the
   offset encoding of the base object, but that is pretty much
   an independent issue.

 - "git fetch-pack -k" has a problem.  The daemon or sending
   side runs rev-list piped to pack-objects and there is no
   limit in the size of the pack generated in the pipeline.
   Worse yet, the protocol does not allow more than one packs to
   be sent, so we would need a protocol update to say "the data
   you asked would result in a pack that is more than 4GB, so
   I'll send more than one packs -- here is one, here is
   another, that's all folks".  The receiving end needs to be
   taught to handle this.

Note: I am not proposing to do any of the above right now, until
there is no need for this by any real project.  We just need to
be sure that when need arises there is a way out.

The only case that can be problematic is when a single object is
larger than 4GB deflated, and at that point we would hit a very
hard wall of 32-bit offset.  But handling such a huge object
would have other problems [*1*] anyway, so I think it is Ok to
declare that there is a hard limit on deflated object size, at
least for now.

[*1*]

For example, we tend to do everything in core, but doing diffs
or anything on such a huge blob should probably be done by
swapping in only parts of it at a time).

Also we give the whole deflated size to zlib as avail_in, which
is "uInt", so on architectures where int is shorter than 64-bit
we lose (my 64-bit index patch does not deal with this).  This
however is something your "mmap parts into windows" update would
solve if it were updated to deal with the internal 64-bit
offsets.
