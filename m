X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: v2.6.11 tag in kernel tree
Date: Wed, 29 Nov 2006 20:22:37 -0800
Message-ID: <7v7ixdlg1e.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910611292002o289dc4d1u7bde2d457fa97d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 04:22:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <9e4733910611292002o289dc4d1u7bde2d457fa97d73@mail.gmail.com>
	(Jon Smirl's message of "Wed, 29 Nov 2006 23:02:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32702>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpdRc-0000jX-Vs for gcvg-git@gmane.org; Thu, 30 Nov
 2006 05:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933385AbWK3EWj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 23:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759008AbWK3EWj
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 23:22:39 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:42691 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1759005AbWK3EWi
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 23:22:38 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061130042238.IQPJ20330.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 29
 Nov 2006 23:22:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id ssN41V00J1kojtg0000000; Wed, 29 Nov 2006
 23:22:05 -0500
To: "Jon Smirl" <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

"Jon Smirl" <jonsmirl@gmail.com> writes:

> I'm trying to check out v2.6.11 so that I can figure out the changes a
> vendor made to it.
>
> jonsmirl@jonsmirl:/extra/linux$ git checkout -b microcross v2.6.11
> Cannot switch branch to a non-commit.

Sorry, you cannot check it out directly, and there is no easy
way to start a new branch from a bare tree.

I would create a temporary branch from any commit and reset the
working tree with it.

	git checkout -b temp master
        git read-tree -m -u v2.6.11-tree

One BIG caveat is that this in state, only your index and the
working tree can be trusted.  The history of temp branch does
not have anything to do with v2.6.11 -- a bare tree object does
not have any history behind it (or on top of it, for that
matter).

A slightly more elaborate way would be

        $ git checkout -b v2.6.11-phoney $(echo 'phoney v2.6.11' |
	        git commit-tree v2.6.11-tree^{tree})

to create a parentless commit that has v2.6.11-tree, and make
that your current branch.  But again this commit does not have
any relationship in history with the development line that leads
to v2.6.19 just released.

You could graft it as the parent of v2.6.12-rc2 (the first
commit in git era) after doing the above:

	$ parent=$(git-rev-parse v2.6.11-phoney^0)
        $ commit=$(git-rev-parse v2.6.12-rc2^0)
	$ echo $commit $parent >>.git/info/grafts

and pretend as if v2.6.12-rc2 is a child of v2.6.11-phoney.

