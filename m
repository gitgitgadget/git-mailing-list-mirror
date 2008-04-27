From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: my git problem
Date: Sun, 27 Apr 2008 12:15:27 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0804271204510.3119@woody.linux-foundation.org>
References: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 21:16:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqCMh-0001wb-SS
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 21:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760343AbYD0TP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 15:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760469AbYD0TP6
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 15:15:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57387 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759709AbYD0TP5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2008 15:15:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3RJFRt5010393
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 27 Apr 2008 12:15:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3RJFRNv020677;
	Sun, 27 Apr 2008 12:15:27 -0700
In-Reply-To: <20080427112938.4dbe8e2a.akpm@linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.457 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80478>



On Sun, 27 Apr 2008, Andrew Morton wrote:
> 
> Now, I want to generate a plain patch against mainline which will add the
> patches which are in git-ia64 and which aren't in mainline.  ie: when that
> patch is applied to mainline, we get git-ia64.  Sounds simple.
> 
> A naive
> 
> 	git-diff origin git-ia64

Don't do that.

That will diff between the two branches, and if they both contain stuff 
(which they obviously do), you'll get all the things that are in origin 
(but not git-ia64) as a reversed diff.

What you _want_ is the diff from the last common point, aka the "merge 
base".

With git, you could do that as

	merge_base=$(git merge-base origin git-ia64)
	git diff $merge_base git-ia64

but there is a convenient shorthand for that, which is to use "a...b" 
(three dots!), so

	git diff -p --stat origin...git-ia64

should generally get you what you want.

I say *generally*, because there might be multiple merge-bases if there 
are crossing merges between the two branches and there is no well-defined 
single common point. But that criss-cross case almost never happens for 
the kernel, because I've been pretty good at trying to teach maintainers 
to not generate that kind of complex history (it doesn't just obfuscate 
the above kind of situation, it also makes gitk output harder-to-read than 
it otherwise would be).

That said, your script (that does a merge) should have been able to get 
the diff too, and in fact handle even the criss-cross case. It's written a 
bit strangely (like having that really old-fashioned way of using git 
merge, passing in HEAD explicitly etc).

			Linus
