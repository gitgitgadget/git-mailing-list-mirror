From: "Adam J. Richter" <adam@yggdrasil.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Sat, 30 Apr 2005 07:44:17 -0700
Message-ID: <200504301444.j3UEiHN05686@adam.yggdrasil.com>
Cc: git@vger.kernel.org, mpm@selenic.com
X-From: git-owner@vger.kernel.org Sat Apr 30 17:50:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRuEh-00045q-Bv
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVD3P4G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 11:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbVD3P4F
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 11:56:05 -0400
Received: from [61.149.23.245] ([61.149.23.245]:35831 "EHLO adam.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261266AbVD3Pyp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 11:54:45 -0400
Received: (from adam@localhost)
	by adam.yggdrasil.com (8.11.7/8.11.7) id j3UEiHN05686;
	Sat, 30 Apr 2005 07:44:17 -0700
To: andrea@suse.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 2005-04-30, Andrea Arcangeli wrote:
>On a bit more technical side, one thing I'm wondering about is the
>compression. If I change mercurial like this:
>
>--- revlog.py.~1~       2005-04-29 01:33:14.000000000 +0200
>+++ revlog.py   2005-04-30 03:54:12.000000000 +0200
>@@ -11,9 +11,11 @@
> import zlib, struct, mdiff, sha, binascii, os, tempfile
> 
> def compress(text):
>+    return text
>     return zlib.compress(text)
> 
> def decompress(bin):
>+    return text
>     return zlib.decompress(bin)
> 
> def hash(text):
>
>
>the .hg directory sizes changes from 167M to 302M _BUT_ the _compressed_
>size of the .hg directory (i.e. like in a full network transfer with
>rsync -z or a tar.gz backup) changes from 55M to 38M:
>
>andrea@opteron:~/devel/kernel> du -sm hg-orig hg-aa hg-orig.tar.bz2 hg-aa.tar.bz2 
>167     hg-orig
>302     hg-aa
>55      hg-orig.tar.bz2
>38      hg-aa.tar.bz2
>^^^^^^^^^^^^^^^^^^^^^ 38M backup and network transfer is what I want
>
>So I don't really see an huge benefit in compression, other than to
>slowdown the checkins measurably [i.e. what Linus doesn't want] (the
>time of compression is a lot higher than the time of python runtime during
>checkin, so it's hard to believe your 100% boost with psyco in the hg file,
>sometime psyco doesn't make any difference infact, I'd rather prefer people to
>work on the real thing of generating native bytecode at compile time, rather
>than at runtime, like some haskell compiler can do).
>
>mercurial is already good at decreasing the entropy by using an efficient
>storage format, it doesn't need to cheat by putting compression on each blob
>that can only leads to bad ratios when doing backups and while transferring
>more than one blob through the network.

	I'd like to mention a couple of possible optimizations
for both the with and without compression approaches.

	If you remove the gzip compression, then I imagine you could
do much of the IO of checking out files via sendfile, without
ever copying data to program space or even changing the program's
memory map.  There apparently exists a python sendfile module.

	If this mercurial were written in C, much of the rest of
the IO could be optimized with mmap (to reduce copies) and writev
in the absense of a compression pass.  I don't know enough about
python to know if these optimizations are available.

	On the other hand, if you recognize that there is a
duplication of the work of matching common substrings in
attepmting to store files as differences and in most compression
algorithms, including zlib or bzip2, then you might want to
consider storing the files in a format like zdelta or vcdiff, where
differential storage and compression are combined by describing
a file in terms of copy operations both from other files and
_earlier byte ranges of itself_.

	zdelta is a modification of zlib for this purpose, but
I see no permission grants associated with the author's copyright,
and I thought that zlib only looked at the previous 32kB of data.

	Also, if you go this route, you might want to skip the
last phases of these compressors where they convert individual
characters into a more compact representation, which I think
would defeat inter-file pattern matching if you try to make
a compressed tar of the repository, and would preclude the
sendfile/mmap optimization (although they might not be worth
it at this level of granularity).  Then again, since you're
naming your files by sha1 hashes, it follows that related files
will not be farther apart as the repository grows, so the
compression opportunities for larger repositories might be
less anyhow.

                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
