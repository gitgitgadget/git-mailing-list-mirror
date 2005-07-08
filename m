From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Thu, 7 Jul 2005 19:39:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 04:40:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqimD-0005u4-MD
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 04:39:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVGHCjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 22:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVGHCjb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 22:39:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19091 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261347AbVGHCja (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 22:39:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j682dOjA004454
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 19:39:25 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j682dNwR009214;
	Thu, 7 Jul 2005 19:39:24 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy88ica8e.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Junio C Hamano wrote:
> 
> However it does not automatically mean that the avenue I have
> been pursuing would not work; the server side preparation needs
> to be a bit more careful than what I sent, which unconditionally
> runs "prune-packed".  It instead should leave the files that
> "--whole-trees" would have packed as plain SHA1 files, so that
> the bulk is obtained by statically generated packs and the rest
> can be handled in the commit-chain walker as before.

I really think the commit-chain walker needs to run locally (ie at the 
server end, or after fetching all the objects from the server).

I don't know how much you've tried out the git-http-pull and git-ssh-pull 
things, but their performance was quite horrid for anything half-way 
bigger, because of the totally synchronized IO.

The "fetch one object, parse it, fetch the next one, parse that.." 
approach is just horrible.

I ended up preferring the "rsync" thing even though rsync sucked badly on
big object stores too, if only because when rsync got working, it at least
nicely pipelined the transfers, and would transfer things ten times faster
than git-ssh-pull did (maybe I'm exaggerating, but I don't think so, it
really felt that way).

And the thing is, if you purely follow one tree (which is likely the
common case for a lot of users), then you are actually always likely
better off with the "mirror it" model. Which is _not_ a good model for
developers (for example, me rsync'ing from Jeff's kernel repository always
got me hundreds of useless objects), but it's fine for somebody who
actually just wants to track somebody else.

And then you really can use just rsync or wget or ncftpget or anything
else that has a "fetch recursively, optimizing existing objects" mode.

Now, re-packing ends up causing some double transmissions, but I bet the
cost of those are going to be less than the cost of the "ping-pong for
each object" approach. Especially as most of the repacked objects will be 
deltas if the repacking is done properly.

		Linus
