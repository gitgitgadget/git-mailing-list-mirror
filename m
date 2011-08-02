From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] commit: write out cache-tree information
Date: Wed, 3 Aug 2011 00:01:53 +0200
Message-ID: <201108030001.53476.trast@student.ethz.ch>
References: <9f5e031045b55c4738de8bc9aae290827e128cd3.1312302862.git.trast@student.ethz.ch> <7vmxfrel63.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Carlos =?iso-8859-1?q?Mart=EDn_Nieto?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 00:02:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoN2U-0005vl-3p
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 00:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab1HBWB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 18:01:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16281 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274Ab1HBWBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 18:01:55 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 3 Aug
 2011 00:01:50 +0200
Received: from thomas.inf.ethz.ch (188.155.176.28) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 3 Aug
 2011 00:01:53 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.0-39-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vmxfrel63.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [188.155.176.28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178515>

Junio C Hamano wrote:
> <trast@student.ethz.ch> writes:
>
> > From: Thomas Rast <trast@student.ethz.ch>
> >
> > While write-tree has code to write out the cache-tree information
> > (since we have to compute it anyway if the cache is stale), commit
> > lost this capability when it became a builtin and moved away from
> > using write-tree.
>
> Earlier the code read from the index, made sure that it is not unmerged by
> running cache_tere_update(), before running prepare-commit-msg hook. The
> hook used to see the index that was read in this codepath which is the
> same as what pre-commit left us.
>
> Why run an extra I/O here? The index file could be quite large, and I do
> not want people to writing it out without good reason.

Ok, so let's run some numbers.  With the first test script below I'm
seeing:

  before patch:
    $ time ./commit-in-large-tree.sh
    Initialized empty Git repository in /dev/shm/commit-in-large-tree.tmp/.git/
    6.9M    .git/index

    real    1m31.607s
    user    0m57.604s
    sys     0m29.976s

  after patch: 14% speedup
    $ time ./commit-in-large-tree.sh
    Initialized empty Git repository in /dev/shm/commit-in-large-tree.tmp/.git/
    7.0M    .git/index

    real    1m18.521s
    user    0m53.430s
    sys     0m22.138s

On the other hand if you touch every file as in the second script:

  before patch:
    $ time ./commit-in-large-tree-2.sh 
    Initialized empty Git repository in /dev/shm/commit-in-large-tree.tmp/.git/
    6.9M    .git/index

    real    1m40.910s
    user    0m58.731s
    sys     0m38.011s

  after patch: 5% slowdown
    $ time ./commit-in-large-tree-2.sh 
    Initialized empty Git repository in /dev/shm/commit-in-large-tree.tmp/.git/
    7.0M    .git/index

    real    1m45.465s
    user    1m2.329s
    sys     0m38.849s

I also ran the latter test where it only touches one file in 100
(instead of all 1000) subdirs, and there the patch is still a speedup.

So I guess it depends whether we expect users to mostly modify a small
part or the whole tree.

Regarding your other email

> When we are running a partial commit, the index file you are writing back
> is a temporary index only to build a tree object to record in the commit,
> which we already have done, and the temporary will be discarded.

that's a valid point that I need to address.



-- 8< --   commit-in-large-tree.sh
#!/bin/sh

set -e

git init /dev/shm/commit-in-large-tree.tmp
cd /dev/shm/commit-in-large-tree.tmp
for i in $(seq 1 1000); do
    mkdir $i
    (
	cd $i
	for j in $(seq 1 100); do
	    echo $j > $j
	done
    )
    git add $i
done
git commit -q -m initial
du -h .git/index

for i in $(seq 1 100); do
    echo "$i changed" > $i/$i
    git add $i/$i
    git commit -q -m $i
done

rm -rf /dev/shm/commit-in-large-tree.tmp
-- >8 --

-- 8< --  commit-in-large-tree-2.sh
#!/bin/sh

set -e

git init /dev/shm/commit-in-large-tree.tmp
cd /dev/shm/commit-in-large-tree.tmp
for i in $(seq 1 1000); do
    mkdir $i
    (
	cd $i
	for j in $(seq 1 100); do
	    echo $j > $j
	done
    )
    git add $i
done
git commit -q -m initial
du -h .git/index

for i in $(seq 1 100); do
    for j in $(seq 1 1000); do
	echo "$i changed" > $j/$i
    done
    git add -u
    git commit -q -m $i
done

rm -rf /dev/shm/commit-in-large-tree.tmp
-- >3 --

--
Thomas Rast
trast@{inf,student}.ethz.ch
