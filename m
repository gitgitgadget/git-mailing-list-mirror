From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 14:29:56 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804191422480.2779@woody.linux-foundation.org>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl> <alpine.LFD.1.10.0804191341210.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Apr 19 23:30:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnKeA-00015x-7d
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 23:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762807AbYDSVaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 17:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762795AbYDSVaF
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 17:30:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49140 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762793AbYDSVaE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2008 17:30:04 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JLTvF9027797
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 19 Apr 2008 14:29:58 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3JLTuTt001126;
	Sat, 19 Apr 2008 14:29:56 -0700
In-Reply-To: <alpine.LFD.1.10.0804191341210.2779@woody.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79922>



On Sat, 19 Apr 2008, Linus Torvalds wrote:
> 
> Notice how this patch doesn' actually change the fundamental O(n^2) 
> behaviour, but it makes it much cheaper by generally avoiding the 
> expensive 'fnmatch' and 'strlen/strncmp' when they are obviously not 
> needed.

Side note: on the kenrel tree, it makes the (insane!) operation 

	git add $(git ls-files)

go from 49 seconds down to 17 sec. So it does make a huge difference for 
me, but I also want to point out that this really isn't a sane operation 
to do (I also think that 17 sec is totally unacceptable, but I cannot find 
it in me to care, since I don't think this is an operation that anybody 
should ever do!)

The optimization is probably worth doing just to avoid the bad worst case, 
but we should teach people not to do "git add *" (or that insane ls-files 
thing), and instead do "git add ." and "git add -u".

But in the absense of teaching people that, the patch should at least 
makes that bad pattern behavior be slightly more acceptable for git, even 
if it's still not very nice.

(Btw, we need to stop using "fnmatch()" entirely some day, if only because 
we can't ever use it for case-insensitive stuff. That patch doesn't help 
us with that, but it doesn't hurt either, and conceptually it's moving in 
the direction of doing more in "native" git code than in "fnmatch()")

				Linus
