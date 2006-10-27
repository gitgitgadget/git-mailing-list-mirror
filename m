X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: fetching packs and storing them as packs
Date: Thu, 26 Oct 2006 23:57:13 -0700
Message-ID: <7viri6i6uu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
	<4540CA0C.6030300@tromer.org>
	<Pine.LNX.4.64.0610261105200.12418@xanadu.home>
	<45413209.2000905@tromer.org>
	<Pine.LNX.4.64.0610262038320.11384@xanadu.home>
	<20061027014229.GA28407@spearce.org>
	<BAYC1-PASMTP10C050A5FAA4C70AD57679AE040@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 06:57:23 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Nicolas Pitre <nico@cam.org>,
	Eran Tromer <git2eran@tromer.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <BAYC1-PASMTP10C050A5FAA4C70AD57679AE040@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 26 Oct 2006 22:38:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30295>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdLeY-0001yx-FT for gcvg-git@gmane.org; Fri, 27 Oct
 2006 08:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946034AbWJ0G5P (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 02:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946048AbWJ0G5P
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 02:57:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53397 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1946034AbWJ0G5O
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 02:57:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027065714.LEPN22977.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Fri, 27
 Oct 2006 02:57:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fJxH1V00t1kojtg0000000 Fri, 27 Oct 2006
 02:57:18 -0400
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> writes:

> On Thu, 26 Oct 2006 21:42:29 -0400
> Shawn Pearce <spearce@spearce.org> wrote:
>
>> This is an issue for "central" repositories that people push into
>> and which might be getting repacked according to a cronjob.
>> 
>> Unfortunately I don't have a solution.  I tried to come up with
>> one but didn't.  :-)
>
> What about creating a temporary ref before pushing, and then removing
> it only after the HEAD has been updated?

That won't work.  If repack is faster than index-pack, repack
would fail to find necessary objects, barf, and would not remove
the existing or new pack, and then index-pack would eventually
succeed and when it does at least your repository is complete
even though it may still have redundant objects in packs.

So in that sense, it is not a disaster, so it might be a good
enough solution.

I'd almost say "heavy repository-wide operations like 'repack -a
-d' and 'prune' should operate under a single repository lock",
but historically we've avoided locks and instead tried to do
things optimistically and used compare-and-swap to detect
conflicts, so maybe that avenue might be worth pursuing.

How about (I'm thinking aloud and I'm sure there will be
holes -- I won't think about prune for now)...

* "repack -a -d":

 (1) initially run show-ref (or "ls-remote .") and store the
     result in .git/$ref_pack_lock_file;

 (2) enumerate existing packs;

 (3) do the usual "rev-list --all | pack-objects" thing; this
     may end up including more objects than what are reachable
     from the result of (1) if somebody else updates refs in the
     meantime;

 (4) enumerate existing packs; if there is difference from (2)
     other than what (3) created, that means somebody else added
     a pack in the meantime; stop and do not do the "-d" part;

 (5) run "ls-remote ." again and compare it with what it got in
     (1); if different, somebody else updated a ref in the
     meantime; stop and do not do the "-d" part;

 (6) do the "-d" part as usual by removing packs we saw in (2)
     but do not remove the pack we created in (3);

 (7) remove .git/$ref_pack_lock_file.

* "fetch --thin" and "index-pack --stdin":

 (1) check the .git/$ref_pack_lock_file, and refuse to operate
    if there is such (this is not strictly needed for
    correctness but only to give an early exit);

 (2) create a new pack under a temporary name, and when
     complete, make the pack/index pair .pack and .idx;

 (3) update the refs.

