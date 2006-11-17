X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: multi-project repos
Date: Fri, 17 Nov 2006 12:24:36 -0800
Message-ID: <7vhcwxlt2z.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl>
	<Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
	<455C94FA.3050903@xs4all.nl>
	<Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
	<455CA2A8.5010700@xs4all.nl>
	<Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611161039160.3349@woody.osdl.org>
	<20061117162605.GA32597@spearce.org> <87bqn6qav2.wl%cworth@cworth.org>
	<20061117171532.GE32597@spearce.org> <455DF676.3090001@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 20:24:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455DF676.3090001@gmx.net> (Marko Macek's message of "Fri, 17 Nov
	2006 18:50:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31726>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlAGY-0005vn-HE for gcvg-git@gmane.org; Fri, 17 Nov
 2006 21:24:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755848AbWKQUYi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 15:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbWKQUYi
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 15:24:38 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:21408 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1755848AbWKQUYh
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 15:24:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117202437.EZKU18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 15:24:37 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nwQj1V0171kojtg0000000; Fri, 17 Nov 2006
 15:24:44 -0500
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

Marko Macek <marko.macek@gmx.net> writes:

> Shawn Pearce wrote:
>...
>> I have:
>>
>> 	git repo-config --global core.logAllRefUpdates true
>>
>> especially since Junio fixed it to only create logs for heads and
>> not tags.  That way its on by default for me.  But I think it should
>> be on by default in the next version of Git.
>
> Why is it not useful for tags for having logs?

When I make a tag that says "this is the v1.2.0 release", it is
expected it won't change in the future, ever.  I _can_ make
mistake and tag a wrong commit under v1.2.0 name, in which case
I may have to replace it with another corrected tag, but
recoding that mistake does not really add value.  So most of the
time ref-log for a tag would contain only one entry per file, its
creation, but that creation time is already recorded in the tag
object itself anyway.

At times, it may be useful to have some floating tag that point
at the "latest", or "today's", but that use is a minority.  For
these minority cases, you can manually create an empty file
under .git/logs/ directory to record their updates.

The configuration mechanism only kicks in when there is no such
existing file to prime the process, and not creating ref-log for
tags by default is the sensible thing to do.

> I also have a question:
>
> Does git-fsck-objects/prune check the ref logs?

They deliberately ignore ref-log for the same reason lost-found
does not drop found refs under .git/refs hierarchy.

This only matters if you somehow rewind an existing branch in
order to lose part of its history, using "reset --hard HEAD~n"
or "rebase".  If the updates to your branch tips always build on
top of the previous (either by commiting on top of the current,
merging on top of the current, or fast-forwarding), and if you
never rewind the branch, the commits recorded in the ref-log for
the branch are always ancestors of the tip of the branch, so
checking ref-log does not give you anything other than slowing
the operation down.

However, if you rewind the tip of a branch, the story changes.
Until the next "prune", objects reachable from the ref-log of
the branch but not reachable from the tip of the branch are
still available in your object store and in a pinch you can
recover them, but after a "prune" they will be lost forever if
they do not have any other references.  So it might seem that
they should be protected from pruning.

But if you did so, you can never remove cruft from your object
store once you make a mistake.  You can clean up your history by
a reset and/or a rebase, and cleaning up to _lose_ part of the
history was the reason you rewound the branch in the first
place.

In other words, running 'prune' is a conscious act of saying "I
know I am not in the middle of something; I thought over what
I've done recently, salvaged necessary bits from what I
discarded earlier, and there is nothing that need to be salvaged
later anymore -- I have refs to what I need.  Now go clean up
the cruft from my object store".



