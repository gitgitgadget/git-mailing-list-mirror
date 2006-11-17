X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 13:35:04 -0800
Message-ID: <7virhdiwon.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz>
	<87d57pu4qa.wl%cworth@cworth.org> <455E1BF1.1030003@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 21:35:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455E1BF1.1030003@midwinter.com> (Steven Grimm's message of "Fri,
	17 Nov 2006 12:30:41 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31734>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlBMf-0002y5-TT for gcvg-git@gmane.org; Fri, 17 Nov
 2006 22:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753196AbWKQVfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbWKQVfJ
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 16:35:09 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:57086 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1753196AbWKQVfG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 16:35:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117213505.PXZN97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Fri, 17
 Nov 2006 16:35:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nxbB1V00e1kojtg0000000; Fri, 17 Nov 2006
 16:35:12 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> echo foo >> child1/testfile
> perl -pi -e 's/tree/shrub/' child2/testfile
>...
> git-diff --binary > /tmp/patch
> git-reset --hard
> git-pull
> git-apply /tmp/patch
>
> I might have gotten that slightly wrong, but I think I have the
> general idea right.

stg pull would help you in such a situation as well, but I see
what you mean.

Just like we have an explicit -m option to "checkout" to allow
file-level merging of local changes, I think it is reasonable to
hav an option that allows file-level merging of local changes
when doing a pull that you _know_ will not conflict.

When there will be a conflict between your HEAD and MERGE_HEAD
even without your local changes, you somehow need to sort out
the resulting mess that come from conflicts due to the branch
diversion (i.e. log HEAD...MERGE_HEAD) and conflicts between
your local change and what the other branch did.  The resulting
merge commit obviously needs to record resolutions only to the
former and should not even record anything you did locally,
conflicted or not.  Which is a pain for the end user and giving
them a way to revert to the state before this three-and-half
way merge started also needs to be there.

Unfortunately the only way to know if there will be a file-level
conflict is to try one, and stashing away the current state just
in case it conflicted is a performance penalty, so this probably
should stay as an option just like "-m" to the "checkout".

But the basic mechanism to do this three-and-half way merge is
simple and I have no objection if somebody wanted to add such an
option to "git pull".

