From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 13:34:07 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907211324220.19335@localhost.localdomain>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain> <7v7hy1g7vg.fsf@alter.siamese.dyndns.org> <7vd47tes2y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:35:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTM3C-0007Nj-NP
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 22:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbZGUUez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 16:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754342AbZGUUez
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 16:34:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44866 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693AbZGUUez (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 16:34:55 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LKY7Nk029529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Jul 2009 13:34:08 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LKY798026844;
	Tue, 21 Jul 2009 13:34:07 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vd47tes2y.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123710>



On Tue, 21 Jul 2009, Junio C Hamano wrote:
> 
> Here is a patch to do that.  I haven't tested it yet though.

Well, it seems to work.

It turned the 85+ minute thing (which I eventually just killed) into 
something that took 1.4 _seconds_. Of course, I didn't check that the end 
result was identical, since I never had the patience to wait for the 
original case.

Now sadly, my fixed test (which took 45 seconds before) didn't much 
improve (it doesn't have nearly as many removed lines, since I checked in 
the _right_ file that is a much closer version to the parent files).

But what is intriguing is that it it gets different results. So I suspect 
this one actually changed behavior some way:

	[torvalds@nehalem git-merge]$ time git show --color HEAD | wc
	  22671   63302  672234
	
	real	0m44.024s
	user	0m43.879s
	sys	0m0.148s

	[torvalds@nehalem git-merge]$ time ~/git/git show --color HEAD | wc
	  22596   63122  671076
	
	real	0m43.553s
	user	0m43.435s
	sys	0m0.128s

and notice how the git version with your change gives different line 
numbers.

Now, this is a diff, and different answers are possibly _both_ valid, so 
who knows. But I suspect that you _intended_ for the patch to be a 
semantic no-op, and it doesn't seem to be.

			Linus
