X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 20 Nov 2006 23:36:55 -0800
Message-ID: <7vr6vxxnc8.fsf@assigned-by-dhcp.cox.net>
References: <20061120215116.GA20736@admingilde.org>
	<ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611201501230.3338@woody.osdl.org>
	<7v4pstzmk5.fsf@assigned-by-dhcp.cox.net>
	<20061121062753.GG20736@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 07:37:31 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31976>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmQBz-000878-9h for gcvg-git@gmane.org; Tue, 21 Nov
 2006 08:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934216AbWKUHg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 02:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934262AbWKUHg5
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 02:36:57 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:53731 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S934216AbWKUHg4
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 02:36:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061121073656.URGK5465.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 21
 Nov 2006 02:36:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pKd31V0011kojtg0000000; Tue, 21 Nov 2006
 02:37:03 -0500
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

Martin Waitz <tali@admingilde.org> writes:

> On Mon, Nov 20, 2006 at 04:10:50PM -0800, Junio C Hamano wrote:
>
>> However, if I recall correctly, it was rather nightmarish to
>> make this also work for reachability traversal necessary for
>> pack generation.  It was painful enough even when the bind was
>> at the commit level (which was way simpler to handle), but to do
>> this the right way, the bind needs to be done at the tree level,
>> and "rev-list --objects foo..bar" would need some way to limit
>> the commit ancestry chain of subproject at the same time, by
>> computing the commit ancestry of the embedded commits in the
>> trees.
>
> This at least seems to work already.
> The UNINTERESTING flag is recursively set for the submodule
> commits while walking the object chain.

I think that is fine as long as we somehow enforce the topology
of submodule to be similar to the toplevel topology.  Otherwise
I suspect it leads to unintuitive behaviour.

Suppose that the ancestry chain for the toplevel are A, A~1, A~2
and you asked for "A~2..A".  A submodule is bound at tree "sub/"
and suppose A:sub/ == B, A~1:sub/ == C, and A~2:sub/ == D.

Now further suppose the ancestry chain for B, C and D are like
this:

              o---C
             /     \
     ...o---o---D---B

A naive implementation of "--objects A~2..A" would propagate
UNINTERESTING to D and mark B and C unmarked.  Would it however
be reasonable to include commits marked as 'o'?

I am not trying to be negative here, but just raising things
that I did not think through when I tried to tackle it the last
time...
