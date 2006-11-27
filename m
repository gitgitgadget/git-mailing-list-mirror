X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sun, 26 Nov 2006 17:21:38 -0800
Message-ID: <7virh1r8f1.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<20061126033433.GD29394@spearce.org>
	<7vvel2yi2u.fsf@assigned-by-dhcp.cox.net>
	<200611270159.14925.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 27 Nov 2006 01:24:27 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611270159.14925.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 27 Nov 2006 01:59:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32377>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoVEO-00081S-3J for gcvg-git@gmane.org; Mon, 27 Nov
 2006 02:24:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755681AbWK0BVk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 20:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755759AbWK0BVk
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 20:21:40 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50589 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1755681AbWK0BVj
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 20:21:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127012139.SRQY18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Sun, 26
 Nov 2006 20:21:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id rdMn1V00P1kojtg0000000; Sun, 26 Nov 2006
 20:21:47 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> I am not so sure about this. IMHO, any user expects to see "pu" branch
> cloned too after cloning git.git (at least me, and a newbie probably too).

I think you are right that we can keep our sanity without
omitting rewinding ones from the tracked set of branches.  In
fact, remotes/origin/* hierarchy are not to be checked out
directly anyway, even after we do the "bare SHA-1 stored in
$GIT_DIR/HEAD" update -- that should give you a read-only
checkout that you cannot commit on top of.  As long as we warn
users who try to merge from these rewinding branches, there is
no reason not to track them.

> As said, the real problem begins when the user tries to branch off her
> own local branch from "pu". At this point, "git branch" or
> "git checkout -b ..." should warn the user that he has to expect troubles
> when branching off from such a branch, and only allow it with a
> "--force" option.

That is true if you make "git branch my-pu remotes/origin/pu" to
somehow set up the default merge source of "my-pu" branch to be
remotes/origin/pu to encourage merging from it.

I am still not convinced it is a valid assumption that a branch
often want to merge from the branch it was forked off of, and
even less so that "git branch" and "git checkout -b" are the
places to do that configuration.

But for the sake of discussion let's pretend for now that it
were a good idea.  If we know remotes/origin/pu is expected to
be rewound, the logic that configures "my-pu" to merge from the
fork origin should be able to notice that situation, and refrain
from doing the configuration, to prevent the user from issuing
"git pull" without saying "from where", which can be done with
your merge.stopsansdefault option in your other message.

