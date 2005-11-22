From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Wed, 23 Nov 2005 00:00:11 +0100
Message-ID: <20051122230011.GA2916@steel.home>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com> <7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 00:03:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeh8O-0005US-FL
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbVKVXAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 18:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbVKVXAy
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:00:54 -0500
Received: from devrace.com ([198.63.210.113]:28944 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030226AbVKVXAi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 18:00:38 -0500
Received: from tigra.home (p54A0E32F.dip.t-dialin.net [84.160.227.47])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAMN0D0v002633;
	Tue, 22 Nov 2005 17:00:14 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1Eeh7U-0000g8-00; Wed, 23 Nov 2005 00:00:12 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1Eeh7T-0000oB-Uc; Wed, 23 Nov 2005 00:00:11 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12580>

Junio C Hamano, Tue, Nov 22, 2005 21:41:56 +0100:
> > Reuse discarded nodes of llists
> >
> > Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>
> 
> I think making allocation/deallocation to the central place is a
> good cleanup, but I am not sure about the free-nodes reusing.
> Does this make difference in real life?

It definitely does, though nor very much. I have no real numbers at
hand (being home now), but I remember it was 1 min with against 3 min
without the patch on cygwin+fat32, which is already bad enough all by
itself. Very big repository with no redundant packs in it.

> If so, it might be worth doing the slab-like allocation, since
> free-nodes are very small structure and malloc overhead is not
> ignorable there.

Like this?

    if ( free_nodes ) { ... }
    else {
	struct llist_node *slab = malloc(sizeof(*slab) * BLKCNT);
	for ( i =0; i < BLKCNT; ++i ) {
	    slab->next = free_nodes;
	    free_nodes = slab++;
	}
    }
