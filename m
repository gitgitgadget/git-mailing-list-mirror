X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fetch --reference?
Date: Tue, 14 Nov 2006 17:02:55 -0800
Message-ID: <7vy7qdttc0.fsf@assigned-by-dhcp.cox.net>
References: <f2b55d220611141638k5f4a0aeas1a43301e4b40bf59@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 01:03:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <f2b55d220611141638k5f4a0aeas1a43301e4b40bf59@mail.gmail.com>
	(Michael K. Edwards's message of "Tue, 14 Nov 2006 16:38:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31398>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk9B6-0005a6-Qv for gcvg-git@gmane.org; Wed, 15 Nov
 2006 02:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966584AbWKOBC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 20:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966588AbWKOBC5
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 20:02:57 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:37859 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S966584AbWKOBC5
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 20:02:57 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115010256.KLH7157.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 20:02:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mp321V00V1kojtg0000000; Tue, 14 Nov 2006
 20:03:02 -0500
To: "Michael K. Edwards" <medwards.linux@gmail.com>
Sender: git-owner@vger.kernel.org

"Michael K. Edwards" <medwards.linux@gmail.com> writes:

> When setting up a working area for kernel integration for a new
> embedded target, I generally do a "git clone --reference" so that the
> new area has its own repository (and its own branch structure) but
> most of the blobs come from a local reference copy.  But now that I'm
> integrating bits from several non-trivially divergent trees (mtd-2.6,
> netdev-2.6, linux-2.6.16.y, etc.), it would be nice to avoid
> re-downloading blobs for these additional remote branches, which are
> also available in the local reference copy.  Is it feasible to
> implement "git fetch --reference" for this purpose?  Or is there a
> better way to manage this sort of integration effort?

I am somewhat doubtful that this is common enough to warrant
adding an extra option to "git fetch", but you could add
alternates to these new reference object stores before
initiating the fetch.

For example, if you have pristine linux-2.6/ and your work was
started by cloning with --reference to it into my-2.6/, you
would have something like this:

	$ cd /usr/src
	$ ls -F
        linux-2.6/ linux-2.6.16.y/ netdev-2.6/ my-2.6/
	$ cd my-2.6/
        $ cat .git/objects/info/alternates
	/usr/src/linux-2.6/.git/objects

Then you would (still in my-2.6 repository):

	$ cat >>.git/objects/info/alternates
        /usr/src/linux-2.6.16.y/.git/objects
        /usr/src/netdev-2.6/.git/objects
        $ git pull ../netdev-2.6/ ALL

which would hopefully not download _any_ objects but just gets
the ALL branch and makes a merge commit in your working
repository.

        
