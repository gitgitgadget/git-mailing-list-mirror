From: Andrew Morton <akpm@osdl.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 11:56:09 -0700
Message-ID: <20050426115609.0481401b.akpm@osdl.org>
References: <20050425214326.512b006e.davem@davemloft.net>
	<20050426005725.6bfe6135.akpm@osdl.org>
	<20050426183350.GB13224@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: davem@davemloft.net, torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:51:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQV9o-0004Jd-TV
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVDZS4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261734AbVDZS4w
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:56:52 -0400
Received: from fire.osdl.org ([65.172.181.4]:38037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261732AbVDZS4f (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:56:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QIuUs4014087
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 11:56:30 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3QIuT3P001199;
	Tue, 26 Apr 2005 11:56:29 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050426183350.GB13224@pasky.ji.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote:
>
>  > d) To generate davem's tree (patch against linus's current tree (ie: patch
>  >    against 2.6.12-rc3+linus.patch)):
>  > 
>  > 	git pull git-net
>  > 	MERGE_BASE=$(merge-base $(cat .git/heads/origin ) $(cat .git/heads/git-net))
>  > 	git diff -r $MERGE_BASE:$(cat .git/heads/git-net) > ../25/patches/git-net.patch
> 
>  This is the bad way; I think this suffers of basically the same problems
>  as my ancient merging by "forward-patching". You should probably do a
>  regular merge:
> 
>  	git pull git-net
>  	git merge git-net
>  	git diff -p
> 
>  The last command will show diff between current tree and the first
>  parent; that amounts the merged patch in this case.

Bear in mind that there will be 20 or 30 different trees which I'll need
the diffs for, not just the one git-net.

I don't know if it'll be successful continually merging all those trees
together.  The way I did this with bk was to have a separate repo for each
tree, but I don't think I'll want 30-40 separate git trees.

My little methodology worked nicely for git-ia64.

Jan Harkes has pointed out that the problem here is that Linus and Dave
both applied the same patch from Al and that interdiff was able to fix it
up:

$ git diff -r 25ee7e3832951cf5896b194f6cd929a44863f419:b453257f057b834fdf9f4a6ad6133598b79bd982 > git-linus.patch
$ git diff -r 25ee7e3832951cf5896b194f6cd929a44863f419:5523662c4cd585b892811d7bb3e25d9a787e19b3 > git-net.patch
$ interdiff --no-revert-omitted -p1 git-linus.patch git-net.patch | diffstat
drivers/net/tg3.c                            |   73 ++++++++++++++-------------
net/ipv4/ip_output.c                         |    2
net/ipv4/netfilter/ip_conntrack_ftp.c        |    4 -
net/ipv4/netfilter/ip_conntrack_standalone.c |    7 --
net/ipv4/tcp_input.c                         |    1 
net/sched/simple.c                           |   18 ------
6 files changed, 46 insertions(+), 59 deletions(-)

So hm.  I guess git did what it was supposed to do here, and that a `git
merge' would have removed the common patch.  But if I take the approach of
merging all those subsystem trees I do wonder if things will come
unstuck...
