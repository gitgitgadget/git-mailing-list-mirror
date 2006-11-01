X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 01 Nov 2006 10:28:13 -0800
Message-ID: <7vpsc710oy.fsf@assigned-by-dhcp.cox.net>
References: <200610261641.11239.andyparkins@gmail.com>
	<200611010839.35436.andyparkins@gmail.com>
	<7v4ptj7dfg.fsf@assigned-by-dhcp.cox.net>
	<200611010953.57360.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 18:28:42 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30649>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfKpC-0001TL-VK for gcvg-git@gmane.org; Wed, 01 Nov
 2006 19:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992706AbWKAS2Q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 13:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992701AbWKAS2Q
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 13:28:16 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1705 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S2992706AbWKAS2P
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 13:28:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101182814.JYUW12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 13:28:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hWUJ1V00Z1kojtg0000000 Wed, 01 Nov 2006
 13:28:19 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> As I mentioned in my original email, I was wishing for 
>
>  git-reset --mixed HEAD oops/file1
>
> But of course, that doesn't make any sense in the context of of git-reset, 
> which is really only a HEAD manipulator with extras.

Well, reset historically is _not_ HEAD manipulator.  It is the
primarily Porcelain-ish to recover the index and/or the working
tree that is in an undesired state.

So from that point of view, the above commandline perfectly
makes sense.  However, giving anything but HEAD with path makes
us go "Huh?"  It is unclear what this should mean:

	git-reset [--hard | --mixed] HEAD^ oops/file1

Checkout is a working tree manipulator Porcelain, and as a side
effect it has always updated the index.  So it might make sense
to give --index-only there:

	git checkout --index-only HEAD -- paths...

But from UI and workflow point of view, I think the situation
under discussion is that the user wishes to _recover_ from an
earlier update-index that he did not want to do.  Although
update-index is not designed as a UI but as a plumbing, it has
been used as such (and git-status output even suggests use of
it), so maybe it is not such a bad idea to bite the bullet and
declare that it now _is_ a Porcelain-ish.  Then we can do what
you suggested (with missing <commit> defaulting to HEAD):

	git update-index --reset [<commit>] -- paths...

I am not enthused by this avenue, though.  I'd like to keep low
level plumbing as "tool to do only one thing and one thing well"
and update-index is as low level as you would get.

On the other hand, we already have --again, so maybe we have
already passed the point of no return.  So I am inclined to
agree with your "update-index --reset" approach, unless somebody
else injects sanity into me.


