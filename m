From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Yet another base64 patch
Date: Mon, 18 Apr 2005 12:42:13 -0400 (EDT)
Message-ID: <E1DNZK9-0003c7-3r@fenris.runbox.com>
References: <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org>
 <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com>
 <20050414214756.GA31249@outpost.ds9a.nl>
 <Pine.LNX.4.58.0504141743360.7211@ppc970.osdl.org>
 <425F13C9.5090109@zytor.com> <20050414205831.01039ee8.pj@engr.sgi.com>
 <4261DDBC.3050706@dwheeler.com> <20050416210513.1ba26967.pj@sgi.com>
 <42620452.4080809@dwheeler.com> <20050417181935.GD1461@pasky.ji.cz>
 <426341FC.7090600@dwheeler.com> <4263AF41.1070806@qualitycode.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 18:39:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNZGb-0007CQ-JC
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 18:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVDRQm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 12:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262087AbVDRQm0
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 12:42:26 -0400
Received: from cujo.runbox.com ([193.71.199.138]:50368 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S262106AbVDRQmP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 12:42:15 -0400
Received: from [10.9.9.130] (helo=fenris.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNZK9-0001L8-5B; Mon, 18 Apr 2005 18:42:13 +0200
Received: from mail by fenris.runbox.com with local (Exim 4.50)
	id 1DNZK9-0003c7-3r; Mon, 18 Apr 2005 18:42:13 +0200
Content-Disposition: inline
Received: from [129.246.254.14] by secure.runbox.com with http
 (uid:258406) (RMM 4.0); Mon, 18 Apr 2005 16:42:13 GMT
To: yarcs@qualitycode.com
X-Sender: 258406@vger.kernel.org
X-Mailer: RMM
In-Reply-To: <4263AF41.1070806@qualitycode.com>
X-Sender: unknown@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I asked:
> > Does anyone know of any other issues in how git data is stored that
> > might cause problems for some situations? ...

Kevin said:
> If git is retaining hex naming, and not moving to base64, then I don't
> think what I am about to say is relevant. However, if base64 file naming
> is still being considered, then vfat32 compatibility may be a concern
> (I'm not sure about NTFS).

I can't speak for the git developers. However, I think the current
naming scheme for the object database as used in git-pasky
is actually a very good one and should be left as-is
(SHA-1 hex values, directory of 2-char prefixes,
filenames with the rest of the value).

As far as I can tell from various calculations (& supported by the
performance measurements done by others), the hex values
with one level of directory turns out to work pretty well!
It's easily understood, works with non-massive projects on stupid
filesystems, and it has good performance on good filesystems
even with massive projects with huge histories.  You could
tune it further, but a single approach that works "everywhere"
is a whole lot simpler.  So I'd recommend keeping that
approach.

As far as base64/32 vs. hex names, I think there
are many reasons to stay with the hex names.
Using hex names is a good idea for the simple reason that
normally SHA-1 hashes are presented as hex values;
you'll work WITH instead of AGAINST other tools, and
humans who deal with this stuff will "see what they expect".
It takes a few more characters, but not many, and it's not
like base64 is any more comprehensible to humans.
And the fact that hex values don't allow "all" legal values
means that some errors are trivially detectable.

You're right, base64 eliminates many bits of differentiation,
and in a very non-obvious way (I _hate_ weird surprises like
that, they cause lots of trouble).  I think there's another
problem too that's more insideous. Although the _filesystem_
is case-preserving, I suspect some _tools_ on Windows don't take
care to preserve case.  If that's so, it'd be easily possible for a
Windows user to use some tools that screw up a Unix/Linux user
once they were imported, causing all sorts of "extraneous" files &
files that mysteriously disappeared (they were only accessible
from Windows). Ugh.
This can even happen on Unix/Linux systems if they use
a fileserver with NTFS semantics. In contrast,
if a hex value has its case changed, it's easy to fix locally.

By choosing the more traditional hex representation, you
eliminate lots of problems, and it's easier to explain too.

Kevin added:
> I'll take this opportunity to support David's position that it would be
> fantastic if git could end up being valuable for a wide range of
> projects, rather than just the kernel. I also fully understand that the
> kernel is the primary target, but when there are opportunities to make
> the data structures more generally useful without causing problems for
> the kernel project, I hope they are taken.

Thanks for the vote of confidence!

--- David A. Wheeler
