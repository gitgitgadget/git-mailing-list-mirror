From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 13:14:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905191307320.3301@localhost.localdomain>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain> <4A13030D.8000000@nortel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Chris Friesen <cfriesen@nortel.com>
X-From: git-owner@vger.kernel.org Tue May 19 22:14:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Vhu-0005Sw-FS
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 22:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZESUOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 16:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbZESUO3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 16:14:29 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53401 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751051AbZESUO3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 16:14:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JKENmL007441
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 May 2009 13:14:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4JKEMo7032691;
	Tue, 19 May 2009 13:14:22 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A13030D.8000000@nortel.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119565>



On Tue, 19 May 2009, Chris Friesen wrote:
> 
> This is all in the same local repository, but with target-specific branches
> containing arch-specific changes on top of a common codebase.  The
> arch-specific stuff often comes from board vendors and such, and they're
> never going to be merged back into the common codebase.
> 
> I'm looking for some way to conceptually tag the current head of each
> branch to indicate "this commit was used to build product version FOO" so
> that later on when we find a bug in our code we can tell which product
> version(s) contain the bug and need to be patched in the field.

Oh. Yes, in that case, you do need to just tag each head.

> The brute-force way to do this would be to manually loop through each branch
> and create a tag of the form "$branch_$version" to ensure unique tags.  But I was
> hoping there was a more elegant way.

Well, I would suggest that you do it fundamentally differently.

Instead of tagging each build, I would suggest just associating each build 
with the commit SHA1 of the time. That's what Linux does (if you enable 
CONFIG_LOCALVERSION_AUTO), and it's _way_ superior to lots of crazy tags.

So for example, I can do

	[torvalds@nehalem ~]$ uname -r
	2.6.30-rc6-00302-g72357d5-dirty

and it tells me exactly what kernel version I'm running (well, the "dirty"
part means that it's not exact and has some additional patches that 
weren't committed, but that's as close as you can get). It's very useful.

Now, with some other build, you might want to just encode the SHA1 
revision in your binary. For example, a simple build-time rule like a 
Makefile addition that does something like

   version.c:
	echo 'const char git_build_version = "'$(git describe)'";" > version.c

and then you just force version.o to be linked into your build.

Trust me, something like the above is _much_ better than tagging each 
branchthat you build. Partly because it means that you can do the builds 
in a distributed manner, and they'll all get the version built in, rather 
than having to rely on everybody tagging everything and then trying to 
match up the tag to some random binary.

			Linus
