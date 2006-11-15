X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 12:41:49 -0800
Message-ID: <7vejs4l9wy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151315291.2591@xanadu.home>
	<20061115184914.GA24122@spearce.org> <455B64F7.9040506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 20:42:21 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	cworth@cworth.org, pasky@suse.cz
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455B64F7.9040506@gmx.net> (Marko Macek's message of "Wed, 15 Nov
	2006 20:05:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31491>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkRaI-0002xu-3d for gcvg-git@gmane.org; Wed, 15 Nov
 2006 21:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030990AbWKOUmJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 15:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030763AbWKOUmJ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 15:42:09 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:64899 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1030990AbWKOUmG
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 15:42:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115204205.YVXG296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 15:42:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n8iB1V00M1kojtg0000000; Wed, 15 Nov 2006
 15:42:12 -0500
To: Marko Macek <marko.macek@gmx.net>
Sender: git-owner@vger.kernel.org

Marko Macek <marko.macek@gmx.net> writes:

> For people switching from CVS and SVN it would be much better if the
> index was hidden behind the scenes by using different defaults:
>
> git-commit -a
> git-status -a
> git-diff HEAD
>
> BTW, currently there's a minor bug: git-diff HEAD doesn't work before
> you make the first commit. Perhaps this should be special cased.

That's only a _bug_ in your implementation of the synonym for
"svn diff" which blindly used "git diff HEAD".

"git diff HEAD" is not a synonym for "svn diff" when HEAD does
not exist yet, because you are asking "please give me a diff
between the tree in the HEAD commit and my working tree files
through the index".  So if you are doing "git-svnish-diff"
Porcelain script, it should notice that HEAD does not exist yet
and take an appropriate action.  We do something similar in
git-status; the porcelain notices and acts differently when HEAD
is not there yet.

This "there is no HEAD yet" is not related to the index, but I
am skeptical about trying to hide the index from the end user.

You can make some things map more naturally to systems like SVN
and CVS than other things.  For example, Nico's proposal to
always use remote tracking branches and defaulting to use
refs/remotes/ would be a way to match UI of pull/push to another
existing system and that would work well (I am not agreeing to
the change to make 'pull' not to do the merge which would break
existing users -- I am just saying that the result would be self
consistent).  But things that have difference at the concept
level, I suspect no clever mapping to hide the differences would
work well.

The index is quite central to the way git works at the concept
level, and I think it is doing disservice to the end user to try
hiding it forever from them and failing to do so, rather than
being honest and teaching them the concept upfront.

But me thinking so does not necessarily mean you are forbidden
from trying.  Your efforts may result in a system where the
index is totally invisible and the end user never has to know
about it.
