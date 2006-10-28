X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: lockfiles & fork()
Date: Fri, 27 Oct 2006 18:41:46 -0700
Message-ID: <7v64e5cj39.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 01:58:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0610280319250.26682@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 28 Oct 2006 03:21:38 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30356>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GddDe-0006lR-5K for gcvg-git@gmane.org; Sat, 28 Oct
 2006 03:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751539AbWJ1Bls (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 21:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751542AbWJ1Bls
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 21:41:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:443 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1751539AbWJ1Bls
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 21:41:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028014147.NHTW6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Fri, 27
 Oct 2006 21:41:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fdhV1V0061kojtg0000000 Fri, 27 Oct 2006
 21:41:29 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> when you setup a lockfile, and then fork(), you could easily end up with 
> atexit() kicking in to remove the lockfile, before the main process has a 
> chance to commit. (Yes, I need to hold the lock long before the fork()).
>
> Any ideas how to solve the problem?

Depends on the arrangement between the parent and child
regarding who is responsible for unlocking.  If child expects to
work under the safety of the lock the parent prepared, and also
relies on the parent to wait for it and then unlock to ensure
that safety for the child, then I think the problem is simple.

How about defining a function in lockfile.c to assign NULL to
lock_file_list and call that immediately after fork() in the
child?
