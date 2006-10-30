X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 14:54:46 -0800
Message-ID: <7vbqntv2h5.fsf@assigned-by-dhcp.cox.net>
References: <20061029093754.GD3847@spearce.org>
	<Pine.LNX.4.64.0610301332440.11384@xanadu.home>
	<20061030202611.GA5775@spearce.org>
	<20061030205200.GA20236@delft.aura.cs.cmu.edu>
	<7v3b95wjmg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 22:55:39 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7v3b95wjmg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 30 Oct 2006 13:59:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30546>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geg1s-0007dg-G3 for gcvg-git@gmane.org; Mon, 30 Oct
 2006 23:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422731AbWJ3Wyt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 17:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422740AbWJ3Wyt
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 17:54:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:20910 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1422731AbWJ3Wys
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 17:54:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030225447.UFCK13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 17:54:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gmuT1V00Z1kojtg0000000 Mon, 30 Oct 2006
 17:54:28 -0500
To: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Jan Harkes <jaharkes@cs.cmu.edu> writes:
>
>> The following patch does fix the problem Nicolas reported, but for some
>> reason I'm still getting only 102 objects (only tags and the commits
>> they refer to?) with your test.
>
> One potential downside of this is that this makes an obscure but
> useful "gitk --unpacked" useless (robs performance).
>
> http://thread.gmane.org/gmane.comp.version-control.git/19197/focus=19207
>
> But other than that, I think it is an Ok change.  The original
> semantics of --unpacked (with or without "pretend as if objects
> in this pack are loose") were, eh, "strange".

I changed my mind.

Even without --unpacked=pretend-this-is-loose nor .keep flag,
the original semantics of --unpacked and git repack do not play
with each other well.  You can have a history where you have a
pack in the middle of the history, and would expect "git repack"
without -a to make your .git/objects/??/ directories empty but
it would not because --unpacked has been defined to mean "stop
traversal when we hit a packed commit".  That would _not_
corrupt the repository, but is very counter-intuitive.

Unfortunately this is a semantic change in the middle of the
road (and it would change the _output_ not just performance of
"gitk --unpacked"), but I think it is a semantic change of a
good kind.

So I'll take Jan's patch as is.  It needs to go all the way down
to "maint", since we have --unpacked= there already.
