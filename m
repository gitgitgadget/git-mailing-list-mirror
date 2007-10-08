From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 16:40:17 +0400
Message-ID: <20071008124017.GA22129@potapov>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234346.GA29433@potapov> <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com> <20071008010648.GB29433@potapov> <4709F805.8050704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, Alex Riesen <raa.lkml@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 08 14:46:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ies0E-0002er-7J
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 14:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbXJHMqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 08:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755113AbXJHMqS
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 08:46:18 -0400
Received: from smtp01.mtu.ru ([62.5.255.48]:58025 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755577AbXJHMqS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 08:46:18 -0400
Received: from potapov.private (ppp85-140-171-99.pppoe.mtu-net.ru [85.140.171.99])
	by smtp01.mtu.ru (Postfix) with ESMTP id 12BF6A5D1B1;
	Mon,  8 Oct 2007 16:46:08 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l98CeHh9023089;
	Mon, 8 Oct 2007 16:40:17 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l98CeHYL023088;
	Mon, 8 Oct 2007 16:40:17 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <4709F805.8050704@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60315>

On Mon, Oct 08, 2007 at 11:27:33AM +0200, Andreas Ericsson wrote:
> Dmitry Potapov wrote:
> >OTOH, if you want to have a clean repository immediately, I believe
> >'git clone' is a better option. After you made a local clone using
> >it, 'git gc' should remove old garbage.
> >
> 
> A clone only fetches revs reachable from a ref, so pruning immediately
> after a clone is completely pointless.

Not true. git-clone copies the whole pack, so it can contain unreachable
objects. Here is a simple script that demonstrates that without garbage
collection the size of the cloned repository will be the same as the
original one.

===========================================
# Make a small repo
mkdir test
cd test
git init
echo hi > there
git add there
git commit -m 'Small repo'

# Add a random 10M binary file
dd if=/dev/urandom of=testme.txt count=10 bs=1M
git add testme.txt
git commit -m 'Add big binary file'

# Remove the 10M binary file
git rm testme.txt
git commit -m 'Remove big binary file'

# Compress the repo, see how big the repo is
git gc --aggressive --prune
du -ks .                       # 10348
du -ks .git                    # 10344

git-whatchanged

# Try to rewrite history to remove the binary file
git-filter-branch --tree-filter 'rm -f testme.txt' HEAD
git reset --hard

# Remove original refs
rm .git/refs/original/refs/heads/master

# Remove back
cd ..

# Clone repository
git-clone -l test/.git test2

cd test2
du -ks .git # 10360

# Now run garbage collection
git gc
du -ks .git # 96

===========================================

Dmitry
