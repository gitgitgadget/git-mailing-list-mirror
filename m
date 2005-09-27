From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: shared GIT repos
Date: Tue, 27 Sep 2005 08:21:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509270807580.3308@g5.osdl.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org>
 <20050926133204.GB21019@pasky.or.cz> <pan.2005.09.27.06.35.35.834134@smurf.noris.de>
 <7vu0g70yqg.fsf_-_@assigned-by-dhcp.cox.net> <20050927084513.GU31276@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 17:26:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKHHM-00026q-4W
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 17:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbVI0PV5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 11:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVI0PV5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 11:21:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48082 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964971AbVI0PV4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 11:21:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8RFLK4s022619
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Sep 2005 08:21:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8RFLHfa016767;
	Tue, 27 Sep 2005 08:21:18 -0700
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050927084513.GU31276@kiste.smurf.noris.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9398>



On Tue, 27 Sep 2005, Matthias Urlichs wrote:
> 
> Junio C Hamano:
> > Do you want to guard the repository from malicious users?  Or is
> > it enough to guard a casual/careless user from making mistakes?
> > 
> Well, s/malicious users/somebody who wants to cover up an ugly mistake/
> would be more accurate.

Hmm.

What you _can_ do is to make your object and refs directories sticky.

That automatically means that only the owner of a file can remove it.

Now, people can still cover up their _own_ mistakes in that case, but they 
can't change other peoples branches (since that involves overwriting 
somebody elses ref), and they can't remove objects that somebody else has 
written.

But they can, for example, change their _own_ branch to not have a ref to 
that object, of course.

A more draconian option is to make the git programs setgid to a "git" 
group, and making the object and ref directories only writable by the git 
group. And then you change all the git programs to verify whatever rules 
you have. That requires pretty big changes, though.

For example, you'd have to make all the scripts use the new git-update-ref
thing, and if you want to enforce that any new ref is a proper child of
the old ref, then you'd have to make git-update-ref test that one 
explicitly (instead of leaving it to the scripts).

Quite frankly, I'd rather avoid that.

Oh. One thing you can do: don't allow direct filesystem access at _all_.  
Use ssh to log in (even if it's on the same machine) as a special user
which is the only one that is allowed to touch the repo, and make that
special users login shell only accept git-receive-pack.

I wrote and posted an untested "git-sh" that did that some time ago, 
holler if you want it again.

Add logging, and testing, and it should give you a safe write-only
alternative to "git-daemon" that only allows people to append to the git
history (oh, you'd still have to add some _small_ code to git-receive-pack
to not allow the "ignore old ref contents" case, but that's like two lines
of code).

			Linus
