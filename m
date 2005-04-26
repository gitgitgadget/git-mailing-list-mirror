From: Andrew Morton <akpm@osdl.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 00:57:25 -0700
Message-ID: <20050426005725.6bfe6135.akpm@osdl.org>
References: <20050425214326.512b006e.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:54:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQKsy-00026s-Ie
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 09:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVDZH6n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 03:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVDZH6n
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 03:58:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:47490 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261381AbVDZH5t (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 03:57:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q7vks4019563
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 00:57:47 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3Q7vjm5002503;
	Tue, 26 Apr 2005 00:57:46 -0700
To: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050425214326.512b006e.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> Linus, please pull from:
> 
>  	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git

So I tried to apply my new get-mm-patches-from-git methodology on this and
came unstuck.

-mm kernels consist of a series of patches against the most recent release
(2.6.12-rc3 today):

	linus.patch		(Linus' changes since 2.6.12-rc3)
	git-net.patch		(Davem's changes wrt Linus's latest tree)
	etc...

The algorithm is:


a) Set up the git repo

	mkdir git26
	git init rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

	(Futz around in `git log' output to identify the v2.6.12-rc3 commit, do
	 `git tag v2.6.12-rc3 a2755a80f40e5794ddc20e00f781af9d6320fafb')

b) Add davem's repo:

	git addremote git-net rsync://rsync.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.git

c) To generate -mm's linus.patch (patch against 2.6.12-rc3):

	git pull origin
	git diff -r v2.6.12-rc3 > ../25/patches/linus.patch

d) To generate davem's tree (patch against linus's current tree (ie: patch
   against 2.6.12-rc3+linus.patch)):

	git pull git-net
	MERGE_BASE=$(merge-base $(cat .git/heads/origin ) $(cat .git/heads/git-net))
	git diff -r $MERGE_BASE:$(cat .git/heads/git-net) > ../25/patches/git-net.patch

e) Repeat d) for all known git trees.



But git-net.patch has a bunch of bluetooth stuff in it which is already in
Linus's tree.  And git-net.patch modifies net/sched/simple.c, which doesn't
appear in either 2.6.12-rc3 or in current -linus.


Doing step d) by hand:


	bix:/usr/src/git26> cat .git/heads/origin
	b453257f057b834fdf9f4a6ad6133598b79bd982
	bix:/usr/src/git26> cat .git/heads/git-net
	5523662c4cd585b892811d7bb3e25d9a787e19b3
	bix:/usr/src/git26> merge-base b453257f057b834fdf9f4a6ad6133598b79bd982 5523662c4cd585b892811d7bb3e25d9a787e19b3
	25ee7e3832951cf5896b194f6cd929a44863f419

	bix:/usr/src/git26> cat-file commit 25ee7e3832951cf5896b194f6cd929a44863f419
	tree 5b6486ded5188e41ac9bc81ad4a5e2bd746f7ede
	parent 056de2fa12febe02597f971eb6ea8f2cc9c9b06e
	author Adrian Bunk <bunk@stusta.de> 1114442294 -0700
	committer Linus Torvalds <torvalds@ppc970.osdl.org> 1114442294 -0700

	[PATCH] fs/aio.c: make some code static

	This patch makes some needlessly global code static.

	Signed-off-by: Adrian Bunk <bunk@stusta.de>
	Acked-by: Benjamin LaHaise <bcrl@kvack.org>
	Signed-off-by: Linus Torvalds <torvalds@osdl.org>


That seems to be a reasonable gca.  It's the last thing which Linus added
prior to merging the ARM patches, which presumably weren't in Dave's tree.

So let's try to grab davem's diff wrt that gca:

bix:/usr/src/git26> git diff -r 25ee7e3832951cf5896b194f6cd929a44863f419:5523662c4cd585b892811d7bb3e25d9a787e19b3 | diffstat
 drivers/net/tg3.c                            |   73 ++++++++++++++-------------
 net/bluetooth/af_bluetooth.c                 |    1 
 net/bluetooth/bnep/sock.c                    |    1 
 net/bluetooth/cmtp/capi.c                    |    1 
 net/bluetooth/cmtp/core.c                    |    1 
 net/bluetooth/cmtp/sock.c                    |    1 
 net/bluetooth/hci_conn.c                     |    1 
 net/bluetooth/hci_core.c                     |    1 
 net/bluetooth/hci_event.c                    |    1 
 net/bluetooth/hci_sock.c                     |    1 
 net/bluetooth/hidp/core.c                    |    1 
 net/bluetooth/hidp/sock.c                    |    1 
 net/bluetooth/l2cap.c                        |    1 
 net/bluetooth/rfcomm/sock.c                  |    1 
 net/bluetooth/sco.c                          |    1 
 net/core/rtnetlink.c                         |    1 
 net/core/scm.c                               |    1 
 net/core/sock.c                              |    1 
 net/ipv4/af_inet.c                           |    1 
 net/ipv4/ip_output.c                         |    2 
 net/ipv4/netfilter/ip_conntrack_ftp.c        |    4 -
 net/ipv4/netfilter/ip_conntrack_standalone.c |    7 --
 net/ipv4/tcp_input.c                         |    1 
 net/ipv6/af_inet6.c                          |    1 
 net/netlink/af_netlink.c                     |    1 
 net/sched/simple.c                           |   18 ------
 net/unix/af_unix.c                           |    1 
 27 files changed, 46 insertions(+), 80 deletions(-)

And that's the bad patch.

What did I do wrong?

Can someone suggest a better approach?

Thanks.

