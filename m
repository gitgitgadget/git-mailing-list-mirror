From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 16:14:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
References: <1151949764.4723.51.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 01:14:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxXcd-00086M-1T
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 01:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWGCXO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 19:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWGCXO2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 19:14:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750875AbWGCXO1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 19:14:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63NEBnW002308
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 16:14:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63NEAHh005992;
	Mon, 3 Jul 2006 16:14:11 -0700
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1151949764.4723.51.camel@neko.keithp.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23224>



On Mon, 3 Jul 2006, Keith Packard wrote:
> 
> With git, we'd prefer to use the git protocol instead of rsync for the
> usual pack-related reasons, but that is limited to a single repository
> at a time.

Well, you could use multiple branches in the same repository, even if they 
are totally unrealated. That would allow you to fetch them all in one go.

One way to do that is to just name the branches hierarcially have one 
repo, but then call the branches something like

	libXrandr/master
	libXrandr/develop
	Xorg/master
	Xorg/develop
	..

> And, it's painfully slow, even when the repository is up to
> date:
> 
> $ cd lib/libXrandr
> $ time git-fetch origin
> ...
> 
> real    0m17.035s
> user    0m2.584s
> sys     0m0.576s

That's _seriously_ wrong. If everything is up-to-date, a fetch should be 
basically zero-cost. That's especially true with the anonymous git 
protocol, which doesn't have any connection validation overhead (for the 
ssh protocol, the cost is usually the ssh login).

But there may well be some bug there.

Look at this:

	[torvalds@g5 git]$ time git fetch git://git.kernel.org/pub/scm/git/git.git 
	
	real    0m0.431s
	user    0m0.036s
	sys     0m0.024s

and that's over my DSL line, not some studly network thing. 

Basically, a repo that is up-to-date should do a "git fetch" about as 
quickly as it does a "git ls-remote". Which in turn really shouldn't be 
doing much anything at all, apart from the connect itself:

	[torvalds@g5 git]$ time git ls-remote master.kernel.org:/pub/scm/git/git.git > /dev/null 
	
	real    0m1.758s
	user    0m0.188s
	sys     0m0.024s
	[torvalds@g5 git]$ time git ls-remote git://git.kernel.org/pub/scm/git/git.git > /dev/null 
	
	real    0m0.431s
	user    0m0.056s
	sys     0m0.016s

(note how the ssh connection is much slower - it actually ends up doing 
all the ssh back-and-forth).

Can you try from different hosts? One problem may be the remote end 
just trying to do reverse DNS lookups for xinetd or whatever?

Also, one thing to try is to just do

	strace -Ttt git-peek-remote ...

which shows where the time is going (I selected "git-peek-remote", because 
that's a simple program).

		Linus
