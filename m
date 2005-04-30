From: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Sat, 30 Apr 2005 04:52:11 +0200
Message-ID: <20050430025211.GP17379@opteron.random>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <20050429203027.GK17379@opteron.random> <20050429203959.GC21897@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 04:42:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRhwP-0005M8-Vp
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 04:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbVD3CsY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 22:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbVD3CsY
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 22:48:24 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34373
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S263138AbVD3CrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 22:47:10 -0400
Received: by opteron.random (Postfix, from userid 500)
	id 11C101C15D4; Sat, 30 Apr 2005 04:52:11 +0200 (CEST)
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050429203959.GC21897@waste.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 01:39:59PM -0700, Matt Mackall wrote:
> Mercurial is ammenable to rsync provided you devote a read-only
> repository to it on the client side. In other words, you rsync from
> kernel.org/mercurial/linus to local/linus and then you merge from
> local/linus to your own branch. Mercurial's hashing hierarchy is
> similar to git's (and Monotone's), so you can sign a single hash of
> the tree as well.

Ok fine. It's also interesting how you already enabled partial transfers
through http.

Please apply this patch so it doesn't fail on my setup ;)

--- mercurial-0.4b/hg.~1~	2005-04-29 02:52:52.000000000 +0200
+++ mercurial-0.4b/hg	2005-04-30 00:53:02.000000000 +0200
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python
 #
 # mercurial - a minimal scalable distributed SCM
 # v0.4b "oedipa maas"

On a bit more technical side, one thing I'm wondering about is the
compression. If I change mercurial like this:

--- revlog.py.~1~	2005-04-29 01:33:14.000000000 +0200
+++ revlog.py	2005-04-30 03:54:12.000000000 +0200
@@ -11,9 +11,11 @@
 import zlib, struct, mdiff, sha, binascii, os, tempfile
 
 def compress(text):
+    return text
     return zlib.compress(text)
 
 def decompress(bin):
+    return text
     return zlib.decompress(bin)
 
 def hash(text):


the .hg directory sizes changes from 167M to 302M _BUT_ the _compressed_
size of the .hg directory (i.e. like in a full network transfer with
rsync -z or a tar.gz backup) changes from 55M to 38M:

andrea@opteron:~/devel/kernel> du -sm hg-orig hg-aa hg-orig.tar.bz2 hg-aa.tar.bz2 
167     hg-orig
302     hg-aa
55      hg-orig.tar.bz2
38      hg-aa.tar.bz2
^^^^^^^^^^^^^^^^^^^^^ 38M backup and network transfer is what I want

So I don't really see an huge benefit in compression, other than to
slowdown the checkins measurably [i.e. what Linus doesn't want] (the
time of compression is a lot higher than the time of python runtime during
checkin, so it's hard to believe your 100% boost with psyco in the hg file,
sometime psyco doesn't make any difference infact, I'd rather prefer people to
work on the real thing of generating native bytecode at compile time, rather
than at runtime, like some haskell compiler can do).

mercurial is already good at decreasing the entropy by using an efficient
storage format, it doesn't need to cheat by putting compression on each blob
that can only leads to bad ratios when doing backups and while transferring
more than one blob through the network.

So I suggest to try disabling compression optionally, perhaps it'll be even
faster than git in the initial checkin that way! No need of compressing or
decompressing anything with mercurial (unlike with git that would explode
without control w/o compression).

My time measurements follows:

w/o compression:

	9.52user 73.11system 1:30.49elapsed 91%CPU (0avgtext+0avgdata 0maxresident)k
	^
	0inputs+0outputs (0major+80109minor)pagefaults 0swaps

w/ compression (i.e. official package):

	26.78user 75.90system 1:44.87elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
	^^
	0inputs+0outputs (0major+484522minor)pagefaults 0swaps

The user time is by far the most important reliable number here, 17 seconds of
difference wasted in compression time. The 1:30 time w/o cache didn't fit
completely in cache, but still it was faster (only 14 sec faster instead of 17
sec faster due some minor I/O that happened due the larger pagecache size that
was recycled a bit).

Without compression the time is 90% system time, very little time is spent in
userland, and of course I made sure very little time is spent in I/O.  vmstat
looks like this:

 1  0 107008  61320  31964 546076    0    0     0  7860 1095  1147  5 46 41  9
 1  0 107008  59336  31972 547564    0    0     0     0 1074  1093  6 46 48  0
 1  0 107008  57544  31988 549044    0    0     0     0 1095  1239  5 45 50  0
 1  0 107008  55304  32000 550936    0    0     0     0 1064  1041  5 46 50  0
 1  0 107008  53384  32012 552488    0    0     0     0 1080  1081  5 45 50  0
 1  0 107008  51592  32032 553964    0    0     0  8260 1087  1018  3 48 40 10
 1  0 107008  49144  32040 555180    0    0     0     0 1099  1090  5 48 47  0
 1  0 107008  47432  32048 556532    0    0     0     0 1086  1014  4 46 50  0
 1  0 107008  45632  32060 557676    0    0     0     0 1102  1073  4 47 49  0
 2  0 107008  44032  32068 558892    0    0     0     0 1088  1044  4 46 49  0
 1  0 107008  42864  32116 560204    0    0     8  6672 1136  1265  5 47 41  7
 1  0 107008  41008  32124 561420    0    0     0   484 1182  1078  5 43 49  3

(5 = user, 43 system, 49 idle is the second cpu doing nothing, 3 is io-wait
time)

While with compression (default) the user time goes up, a lot higher than
what python wasted in the above trace:

 1  0 107008 282688  26756 346396    0    0     0 12064 1122   997 20 32 38 12
 1  0 107008 279936  26776 348552    0    0     0     0 1074   938 15 36 50  0
 1  0 107008 277296  26780 350656    0    0     0     0 1087  1070 15 36 50  0
 1  0 107008 274672  26796 352816    0    0     4    28 1060  1021 15 36 49  1
 1  0 107008 272176  26824 354828    0    0     0    52 1092  1082 19 32 50  0
 1  1 107008 269616  26844 356780    0    0     0 10856 1106  1019 16 36 36 13
 1  0 107008 267312  26864 358936    0    0     0     4 1081  1068 27 24 49  0
 1  0 107008 265072  26876 360760    0    0     0     0 1068  1073 23 27 50  0
 1  0 107008 263024  26888 362516    0    0     0  2764 1224  1457 18 29 49  5
 1  0 107008 260928  26900 364408    0    0     0    20 1060   969 21 29 50  0
 1  0 107008 258752  26928 366216    0    0     0  9768 1098   916 18 32 37 12
 1  0 107008 256640  26940 367972    0    0     0     0 1058  1093 13 37 50  0
 1  0 107008 254384  26952 369796    0    0     0     0 1089  1259 18 33 50  0
 1  0 107008 252016  26972 371680    0    0     0     0 1063  1040 29 22 50  0

The difference in time may be even higher than the above since the pass w/o
compression may have done some read I/O too sometime,  since I've 1G and
it didn't fit completely in cache (I made sure the second pass was completely
from cache instead, by running twice and verifying the free memory never went
lower than 100M).

Http is not intended for maximal efficiency, it's there just to make
life easy. special protocol with zlib is required for maximum
efficiency.

My suggestion is to leave compression optional by storing a bit in the .hg
directory (a global bit) to know if the blob is compressed or not... so if
people have problems and runs out of pagecache they can use it, but Linus
definitely must keep compression off to run the checkin at max speed (i.e.
potentially much faster than git, especially on big files). The cost of one
branch in python to know if compression is enabled or not shouldn't be an issue.
Compression should be a parameter to "hg init", perhaps hg -z, so in the future
we can add -j to add bzip2 too.

You also should move the .py into a hg directory, so that they won't
pollute the site-packages.

Matt, very great work with mercurial. The small mercurial size is striking, 1037
lines total excluding the classes you rightfully shared from other python
projects. That's less than 1/7 of the size of cogito (ok perhaps it's not as
mature as cogito but anyway). Great choice for the language too (but
perhaps I'm biased ;).
