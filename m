From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Create USE_ST_TIMESPEC and turn it on for Darwin
Date: Sun, 8 Mar 2009 17:21:17 -0400
Message-ID: <70A401B0-C10D-4B4D-9DCC-D0968CE5EAF7@silverinsanity.com>
References: <1236542668-83333-1-git-send-email-benji@silverinsanity.com> <7vhc23kaay.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 08 22:22:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LgQST-0003Ak-2D
	for gcvg-git-2@gmane.org; Sun, 08 Mar 2009 22:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbZCHVVZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Mar 2009 17:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753299AbZCHVVZ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Mar 2009 17:21:25 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:37895 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZCHVVY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Mar 2009 17:21:24 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id AE4D91FFC3FB; Sun,  8 Mar 2009 21:21:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 2124B1FFC043;
	Sun,  8 Mar 2009 21:21:11 +0000 (UTC)
In-Reply-To: <7vhc23kaay.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112645>


On Mar 8, 2009, at 4:51 PM, Junio C Hamano wrote:

> I think this patch moves things in the right direction, but there are
> other uses of "st_[cm]tim.tv_nsec" that do not use the  
> ST_[CM]TIME_NSEC
> macro.
>
> $ git grep -n -e 'st_[cm]tim\.' --cached -- '*.[ch]'
> builtin-fetch-pack.c:810:				|| st.st_mtim.tv_nsec != mtime.nsec
> git-compat-util.h:396:#define ST_CTIME_NSEC(st) ((unsigned int) 
> ((st).st_ctim.tv_nsec))
> git-compat-util.h:397:#define ST_MTIME_NSEC(st) ((unsigned int) 
> ((st).st_mtim.tv_nsec))
> read-cache.c:207:	if (ce->ce_mtime.nsec != (unsigned int)st- 
> >st_mtim.tv_nsec)
> read-cache.c:209:	if (trust_ctime && ce->ce_ctime.nsec != (unsigned  
> int)st->st_ctim.tv_nsec)

Interesting.  I couldn't use git-grep due to other problems, but  
thought any other tim/timespec issues would have stopped my  
compilation.  Looking at the code, this is because everything other  
than the #defines in git-compat-util.h are surrounded by USE_NSEC  
which is not defined on my machine.

However, I noticed another breakage entirely.  Namely, that USE_NSEC  
is not defined anywhere.  There's a comment in the Makefile that says  
"define USE_NSEC below", but there is no code that checks for USE_NSEC  
and sets the appropriate compiler switch.  Trivial patch to follow.

> Probably we should apply the following patch as a fix, and then  
> apply your
> enhancement to support st_[cm]timespec systems?

Your patch looks sane to me.

~~ Brian
