From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] rev-list: add "--full-objects" flag.
Date: Sun, 10 Jul 2005 15:36:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507101517370.17536@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
 <20050707144501.GG19781@pasky.ji.cz> <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> <20050707221443.GB7151@pasky.ji.cz>
 <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <7vll4ifbq8.fsf_-_@assigned-by-dhcp.cox.net>
 <7vfyuqfa6r.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071657140.25104@g5.osdl.org>
 <7vvf3mds9c.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071841010.25104@g5.osdl.org>
 <7vy88ica8e.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507071928220.25104@g5.osdl.org>
 <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 00:40:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrkTC-0006Bk-09
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 00:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVGJWjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 18:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262147AbVGJWgu
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 18:36:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40587 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261966AbVGJWgI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jul 2005 18:36:08 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6AMa3jA019691
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 10 Jul 2005 15:36:03 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6AMa1Rd004932;
	Sun, 10 Jul 2005 15:36:02 -0700
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1pstrr8k1.fsf@ebiederm.dsl.xmission.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 9 Jul 2005, Eric W. Biederman wrote:
> 
> The current intelligent fetch currently has a problem that it cannot
> be used to bootstrap a repository.  If you don't have an ancestor
> of what you are fetching you can't fetch it.

Sure you can.

See the current "git clone". It's actually quite good, it's a pleasure to 
use now that it gives updates on how much it has done.

Just do

	git clone src dest

to try it out. It starts out silent (for big repositories) because it 
takes a while to get the whole rev list, but once it gets going it's quite 
nice and gives a nice progress report..

It uses the exact same server side code that "git-fetch-pack" does (ie it
just starts "git-upload-pack" on the server).

Now, one thing you cannot do is to start a totally new _project_ on the
server side. In order to do a "git-send-pack", you need to first create a
directory and do a "git-init-db" on the remote side.

So to create a new project, what you need to do is

	src$ ssh target

	target$ mkdir new-project
	target$ cd new-project
	target$ git-init-db
	target$ exit

	src$ git-send-pack target:new-project master

and you've now sent your "master" branch to the new project at 
"target:new-project".

You can even populate multiple branches at a time: just list them all (you
do have to list them, because by default "git-send-pack" will update the
_common_ branches, and since the other end is empty, there obviously are
no common branches to start with).

Ahh, you should even be able to automate the sending of all branches by
doing

	git-send-pack target:new-project $(cd .git ; find refs -type f)

I think - that will end up being equivalent to a "reverse clone".

The smart clients are doing pretty damn well, I think.

			Linus
