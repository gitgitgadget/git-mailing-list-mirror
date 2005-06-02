From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [SCRIPT] cg-rpush & locking
Date: Thu, 2 Jun 2005 07:50:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506020741480.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506011951150.1876@ppc970.osdl.org>
 <Pine.LNX.4.21.0506020223570.30848-100000@iabervon.org>
 <20050602071453.GA16616@kiste.smurf.noris.de> <20050602073205.GA31482@muru.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 16:48:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddqxe-0000Ko-Of
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 16:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVFBOtP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 10:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVFBOtP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 10:49:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:32414 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbVFBOtE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 10:49:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j52EmRjA014980
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 2 Jun 2005 07:48:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j52EmMIL029955;
	Thu, 2 Jun 2005 07:48:23 -0700
To: Tony Lindgren <tony@atomide.com>
In-Reply-To: <20050602073205.GA31482@muru.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 2 Jun 2005, Tony Lindgren wrote:
> 
> I don't think locking for the duration of the push really is a problem.
> It is unlikely that there would be so many people pushing that it would
> cause inconvenience... Of course it would be nice to optimize it if
> possible.

I don't think the locking is a _huge_ issue - the only real problem I had
with locking with BK was that readers could block a writer (ie I couldn't
push to my public tree if there were people downloading from it), and git
doesn't have that problem. I only push to trees that are my private ones
anyway.

The real reason I'd prefer to not do locking is that _if_ the remote tree
is actually more than just a CVS-like "public repository", ie if somebody
actually does _development_ in the remote tree (hey, it may be crazy, but
git makes this usage pattern possible), then we should eventually plan on
having all of the regular "git-commit-script" and "git-pull-script" etc
_also_ do locking, since they also change HEAD.

And that's going to be a lot easier if we only do a cmp-xchg and fail at
the end (this concurrent change and "remote repo" usage is really quite
wrong, since it basically mean that you consider somebody's development
tree to be "public", and that's not what git is all about, but whatever..)

But this is not a huge issue. The most important thing is to make sure
that the new HEAD is written last, regardless, so that at least local
readers (including things like "fsck" that can take a _loong_ time) always
see consistent state.

> I would assume the biggest problem for most people is how they can push
> through a firewall. From that point of view it would make sense to do
> the push as a cgi script rather than something over ssh. And with a
> cgi script you can of course optimize the locking and use tmp files
> before renaming which are a bit hard to do with rsync.

Me personally, I want ssh as a major option. There are tons of machines 
(every single of my own ones) that I use that don't let anything but ssh 
through.

But having alternatives is good. But ssh should be the first and primary 
one, since it also means that there can't be any new security issues (ie 
you won't be opening up any new holes by installing git on the remote 
machine).

		Linus
