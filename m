X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Push and remote refs
Date: Sun, 05 Nov 2006 13:31:54 -0800
Message-ID: <7vveltoa0l.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611051333210.9789@iabervon.org>
	<7vhcxdu1ln.fsf@assigned-by-dhcp.cox.net>
	<20061105210607.GA28320@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 21:32:26 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061105210607.GA28320@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 5 Nov 2006 16:06:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30984>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggpay-0005rK-As for gcvg-git@gmane.org; Sun, 05 Nov
 2006 22:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422691AbWKEVb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 5 Nov 2006
 16:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbWKEVb5
 (ORCPT <rfc822;git-outgoing>); Sun, 5 Nov 2006 16:31:57 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:25825 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1422694AbWKEVb4
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Nov 2006 16:31:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061105213155.JMLD18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sun, 5
 Nov 2006 16:31:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id j9Y01V00G1kojtg0000000 Sun, 05 Nov 2006
 16:32:00 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Nov 05, 2006 at 11:37:08AM -0800, Junio C Hamano wrote:
>
>> I recall discussing this exact behaviour with Pasky when he
>> added it to Cogito.  I think we concluded that it is a very
>> sensible thing to pretend we fetched immediately after we
>> successfully pushed and got the same thing back, and there is no
>> risk of data loss or user confusion, as long as we catch failure
>> from the push and refrain from doing this update, which Cogito
>> did implement correctly when we discussed this.
>
> Is it possible for hooks on the receiving side to change the tip commit
> in some way? For example, the 'update' hook could do some markup on the
> commit message or contents, creating a new commit and using it instead
> of the pushed one; in this case, the sending side ends up with an
> incorrect (and unrelated) SHA1. Is this simply too insane to worry
> about?

I do not think it is sane for the update hook to muck with tips
in any way (they are meant for making policy decision whether to
allow the push -- we do not enforce this, partly because the
majorly lockless nature of git makes it impossible to, but then
update hook is free to invoke "rm -rf $GIT_DIR" and nobody
prevents it from doing so.  It is the same kind of user shooting
at his foot).

The post-update hook is free to do anything what it wants.  But
that does not make the Cogito's "pretend we have fetched
immediately after we pushed" semantics invalid.  If the
post-update hook rewinds the tip we just pushed, it is the same
thing as in the case where the post-update hook did not do
anything but somebody else, a human user, did the equivalent
rewinding of the branch, and the pretended fetch happened
between the time the push successfull finished and the time that
somebody else did the rewinding, so this is nothing new.  The
next push would notice that the tip does not fast forward in
either case.
