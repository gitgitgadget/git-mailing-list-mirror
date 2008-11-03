From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git bisect v2.6.27 v2.6.26 problem/bug
Date: Mon, 3 Nov 2008 10:43:09 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811031035390.3419@nehalem.linux-foundation.org>
References: <20081103173911.GA12363@xs4all.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miquel van Smoorenburg <mikevs@xs4all.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:44:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx4Pn-0002Ix-U0
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 19:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbYKCSnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 13:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYKCSnM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 13:43:12 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52685 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751474AbYKCSnL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 13:43:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3Ih9fu018564
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 3 Nov 2008 10:43:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mA3Ih9PK032678;
	Mon, 3 Nov 2008 10:43:09 -0800
In-Reply-To: <20081103173911.GA12363@xs4all.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.44 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99977>



On Mon, 3 Nov 2008, Miquel van Smoorenburg wrote:
> 
> If at this point I do a 'git bisect good' I end up in a 2.6.26
> branch, which is good, but after a few bisects I end up at
> a version before v2.6.26 (2.6.26-rc5) again, which should be
> impossible right ?

No, not at all.

What is going on is that you are hitting commits that were not merged into 
2.6.26 (so they are _not_ in the "good" part), but they were _developed_ 
before it. So the kernel Makefile says "v2.6.26-rc8" (not quite 2.6.26 
yet), but that's because the version in the Makefile ends up being a 
linear explanation of what the nearest _earlier_ version was, but is not 
at all indicative of the much more complex non-linear development model.

IOW, you have history that looks like

	- A -> B -> C->
	    \     /
	     - D -

And let's say that 'A' is v2.6.26-rc8, while 'B' is the final v2.6.26 
release, and is your 'good', while 'C' is 2.6.27, and is your 'bad'.

What does that make 'D' then?

It is clearly potentially bad, because it is _not_ in the good set (it was 
merged after 2.6.26, and could very well be the source of your bug. But 
think about what 'Makefile' must contain in 'D'. 

The difference between linear history and non-linear history is very 
important, and "git bisect" very much is all about getting it right. It 
does't take a "linear" half-way point, it really does a _set_ operation, 
and it bisects the set of commits. And that set of commits is a DAG, not a 
linear series.

> Anyway - at the end I end up with a 'good' version that is
> 2.6.26-rc<something> which is kind of useless. I know that
> version up to 2.6.26 are good ...

Not at all. It's not "kind of useless", it's very important.

> What am I doing wrong ?

You're not doing anything wrong, you just didn't realize how non-linear 
development works.

			Linus
