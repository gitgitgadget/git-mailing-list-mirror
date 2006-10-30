X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: WARNING: THIS PATCH CAN BREAK YOUR REPO, was Re: [PATCH 2/3] Only repack active packs by skipping over kept packs.
Date: Mon, 30 Oct 2006 13:48:24 -0800
Message-ID: <7v7iyhwk47.fsf@assigned-by-dhcp.cox.net>
References: <20061029093754.GD3847@spearce.org>
	<Pine.LNX.4.64.0610301332440.11384@xanadu.home>
	<20061030202611.GA5775@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 21:54:04 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30530>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geezd-00086x-QT for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:48:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161520AbWJ3Vs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161521AbWJ3Vs1
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:48:27 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56229 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1161520AbWJ3Vs0
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:48:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030214825.FJRZ2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 16:48:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id glo51V00V1kojtg0000000 Mon, 30 Oct 2006
 16:48:06 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Do the above so you have everything in one pack.  Now use rev-list
> to simulate the object list construction in pack-objects as though
> we were doing a 'git repack -a -d':
>
>   git-rev-list --objects --all \
>     --unpacked=.git/objects/pack/pack-*.pack \
> 	| wc -l
>
> gives me 102 (WRONG WRONG WRONG WRONG!!!!!!)

Now I think I know what is going on.

The meaning of "unpacked" (with or without the "pretend as if
all objects in this pack are loose") has always been to stop
traversing once we hit a packed object, not "do not include
already packed object".

So --unpacked=pretend-this-is-loose was wrong to begin with; it
probably should have been --incremental=pretend-this-is-loose.

How about reverting the following:

commit ce8590748b918687abc4c7cd2d432dd23f07ae40
Author: Shawn Pearce <spearce@spearce.org>

    Only repack active packs by skipping over kept packs.


commit 106d710bc13f34aec1a15c4cff80f062f384edf6
Author: Junio C Hamano <junkio@cox.net>

    pack-objects --unpacked=<existing pack> option.


