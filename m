From: Jeff Garzik <jgarzik@pobox.com>
Subject: [doc][git] playing with git, and netdev/libata-dev trees
Followup-To: gmane.linux.kernel
Date: Thu, 26 May 2005 01:26:15 -0400
Message-ID: <42955DF7.4000805@pobox.com>
Reply-To: Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-ide-owner@vger.kernel.org Thu May 26 07:25:31 2005
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbArt-00040h-SB
	for lnx-linux-ide@gmane.org; Thu, 26 May 2005 07:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEZF04 (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Thu, 26 May 2005 01:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbVEZF04
	(ORCPT <rfc822;linux-ide-outgoing>); Thu, 26 May 2005 01:26:56 -0400
Received: from mail.dvmed.net ([216.237.124.58]:3544 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261204AbVEZF0T (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 May 2005 01:26:19 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DbAsr-0002iW-Vo; Thu, 26 May 2005 05:26:18 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Netdev <netdev@oss.sgi.com>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org


Hopefully, this email can quick-start some people on git.

One of the things Linus's new 'git' tool allows me to do is make public 
the 50+ repositories that were previously only available on my local 
workstation.  This should make it a lot easier for developers to see 
precisely what I have merged, and makes generating follow-up patches a 
whole lot easier.

When I merge a patch for drivers/net/forcedeth.c, I merge it into a 
brand new 'forcedeth' repository, a peer to the 40+ other such 
repository.  Under BitKeeper, I made these repositories available merged 
together into one big "netdev-2.6" repository because it was too time 
consuming to make the individual 50+ trees publicly available.  With 
git, developers have direct access to the individual trees.

I thought I would write up a quick guide describing how to mess around 
with the netdev and libata-dev trees, and with git in general.


1) installing git

git requires bootstrapping, since you must have git installed in order 
to check out git.git (git repo), and linux-2.6.git (kernel repo).  I 
have put together a bootstrap tarball of today's git repository.

Download tarball from:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-20050526.tar.bz2

tarball build-deps:  zlib, libcurl

install tarball:  unpack && make && sudo make prefix=/usr/local install

jgarzik helper scripts, not in official git distribution:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-switch-tree
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-new-branch
http://www.kernel.org/pub/linux/kernel/people/jgarzik/git-changes-script

After reading the rest of this document, come back and update your copy 
of git to the latest:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git.git


2) download a linux kernel tree for the very first time

mkdir -p linux-2.6/.git
cd linux-2.6
rsync -a --delete --verbose --stats --progress \ 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
\          <- word-wrapped backslash; sigh
    .git/


3) download latest changes to on-disk local tree

cd linux-2.6
git-pull-script \
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git


4) check out files from the git repository into the working directory

cd linux-2.6
git-read-tree -m HEAD && git-checkout-cache -q -f -u -a


5) check in your own modifications (e.g. apply a patch)

# go to repo
cd linux-2.6

# make some modifications
patch -sp1 < /tmp/my.patch
diffstat -p1 < /tmp/my.patch

# NOTE: add '--add' and/or '--remove' if files were added or removed
git-update-cache <list of all files changed>

# commit changes
GIT_AUTHOR_NAME="John Doe"		\
    GIT_AUTHOR_EMAIL="jdoe@foo.com"	\
    GIT_COMMITTER_NAME="Jeff Garzik"	\
    GIT_COMMITTER_EMAIL="jgarzik@pobox.com"	\
    git-commit-tree `git-write-tree`	\
    -p $(cat .git/HEAD )			\
    < changelog.txt			\
    > .git/HEAD


6) List all changes in working dir, in diff format.

git-diff-cache -p HEAD


7) List all changesets (i.e. show each cset's description text) in local 
tree that are not present in remote tree.

cd my-kernel-tree-2.6
git-changes-script -L ../linux-2.6 | less


8) List all changesets:

git-whatchanged


9) apply all patches in a Berkeley mbox-format file

First, download and add to your PATH Linus's git tools:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/git-tools.git

cd my-kernel-tree-2.6
dotest /path/to/mbox  # yes, Linus has no taste in naming useful scripts


10) don't forget to download tags from time to time.

git-pull-script only downloads sha1-indexed object data, and the 
requested remote head.  This misses updates to the .git/refs/tags/ and 
.git/refs/heads directories.  It is advisable to update your kernel .git 
directories periodically with a full rsync command, to make sure you got 
everything:

cd linux-2.6
rsync -a --delete --verbose --stats --progress \ 
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ 
\          <- word-wrapped backslash; sigh
    .git/


11) [jg-specific] list all branches found in netdev-2.6 or libata-dev trees.

Download
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
	or
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git


cd netdev-2.6
ls .git/refs/heads/

{ these are the current netdev-2.6 branches }
> 8139cp       forcedeth    master     qeth           smc91x         we18
> 8139too-iomap  for-linus    natsemi      r8169      smc91x-eeprom  wifi
> airo           hdlc         ns83820      register-netdev  starfire
> atmel          ieee80211    orinoco      remove-drivers   tlan
> chelsio        iff-running  orinoco-hch  sis900           veth
> dm9000         janitor      ppp          skge             viro



12) [jg-specific] make desired branch current in working directory

git-switch-tree $branch


13) [jg-specific] create a new branch, and make it current

git-new-branch $branch


14) [jg-specific] examine which branch is current

ls -l .git/HEAD


15) undo all local modifications (same as checkout):

git-read-tree -m HEAD && git-checkout-cache -q -f -u -a



