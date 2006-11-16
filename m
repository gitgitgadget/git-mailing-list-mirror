X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Is cp -al safe with git?
Date: Thu, 16 Nov 2006 11:19:57 -0800
Message-ID: <7v7ixv9p2a.fsf@assigned-by-dhcp.cox.net>
References: <ejibnp$mmq$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 19:20:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <ejibnp$mmq$1@sea.gmane.org> (Johannes Sixt's message of "Thu, 16
	Nov 2006 19:47:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31620>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkmmJ-0001nZ-GD for gcvg-git@gmane.org; Thu, 16 Nov
 2006 20:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424218AbWKPTT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 14:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424375AbWKPTT7
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 14:19:59 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:13184 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1424218AbWKPTT6
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 14:19:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061116191958.YUTY97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 14:19:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id nXL41V00R1kojtg0000000; Thu, 16 Nov 2006
 14:20:04 -0500
To: Johannes Sixt <johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org

Johannes Sixt <johannes.sixt@telecom.at> writes:

> For one reason or another I would like to "clone" a local repo including the
> checked-out working tree with cp -al instead of cg-clone/git-clone, i.e.
> have all files hard-linked instead of copied.
>
> Can the copies be worked on independently without interference (with the git
> tool set)?
>
> One thing I noticed is that git-reset or probably git-checkout-index breaks
> links of files that need not be changed by the reset. Example:
>
> # make 2 files, commit
> $ mkdir orig && cd orig
> $ git-init-db 
> defaulting to local storage area
> $ echo foo > a && cp a b && git-add a b && git-commit -a -m 1
> Committing initial tree 99b876dbe094cb7d3850f1abe12b4c5426bb63ea
>
> # 2nd commit modifies only one file:
> $ echo bar > a && git-commit -a -m 2
>
> # create the copy:
> $ cd ..
> $ cp -al orig copy
> $ cd copy
>
> # working files are hard-linked:
> $ ls -l
> total 8
> -rw-r--r-- 2 jsixt users 4 Nov 16 19:24 a
> -rw-r--r-- 2 jsixt users 4 Nov 16 19:23 b
>
> # nuke a commit:
> $ git-reset --hard HEAD^
> $ ls -l
> total 8
> -rw-r--r-- 1 jsixt users 4 Nov 16 19:24 a
> -rw-r--r-- 1 jsixt users 4 Nov 16 19:24 b
>
> I'd have expected that the hard-link of b remained and only a's link were
> broken. Does it mean that git-reset writes every single file also for large
> trees like the kernel? I cannot believe this. Can someone scratch the
> tomatoes off my eyes please?

Most likely you didn't run "update-index --refresh" after "cp -l"?
Not just in the new copied repository but in the original
repository I would suspect you would see this.  This is because
the index caches ctime and making a new hardlink manipulates the
files' inodes, thus making the cached information stale.

