X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] avoid accessing _all_ loose refs in git-show-ref
Date: Sat, 16 Dec 2006 05:12:32 -0800
Message-ID: <7vk60sf0hr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612161335140.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 13:12:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612161335140.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 16 Dec 2006 13:36:43 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34612>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvZLJ-0002UK-QT for gcvg-git@gmane.org; Sat, 16 Dec
 2006 14:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753648AbWLPNMe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 08:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753656AbWLPNMe
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 08:12:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58608 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753648AbWLPNMe (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 08:12:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216131232.KXEY15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 08:12:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zRBs1V00P1kojtg0000000; Sat, 16 Dec 2006
 08:11:53 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	This is kind of quick and dirty.

Maybe I am blind, but why don't you just do a resolve_ref()
regardless of packedness?  It only builds the packed refs list
when it is not found as a loose ref, and never builds the loose
refs list.  You probably would want to reject the ones that says
REF_ISSYMREF.

> 	An alternative would be to pack the tags _per default_. I once
> 	argued for that, but it appears nobody liked that idea. I even
> 	proposed to pack _all_ refs, and I still think this would be
> 	a good idea.

I do not think packing all refs is such a good idea.  Branches
are meant to be worked on and extended so the packed ones
would become stale quickly.  Packing all tags by default is
something we would want when everybody knows how to handle
them.

> 	Isn't it a bug that --verify succeeds, if only _one_ ref passed to 
> 	the command exists?

I think --verify should insist a single parameter, just like
rev-parse.

So wouldn't the code be like:

	if (verify) {
		int flag;
        	if (pattern[1])
                	die("Eh?");
		if (resolve_ref(pattern[0], sha1, 1, &flag) &&
                	(flag & REF_ISSYMREF) == 0) {
                		printf("%s %s\n",
                                	sha1_to_hex(sha1), pattern[0]);
				exit(0);
		} else
                	die("no match");
	}

???
