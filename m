From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: git status: small difference between stating whole repository and small subdirectory
Date: Wed, 22 Feb 2012 14:17:13 +0100
Message-ID: <878vjvxb1i.fsf@thomas.inf.ethz.ch>
References: <20120215190318.GA5992@sigill.intra.peff.net>
	<CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
	<20120216192001.GB4348@sigill.intra.peff.net>
	<CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
	<20120217203755.GA30114@sigill.intra.peff.net>
	<7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
	<20120217222912.GC31830@sigill.intra.peff.net>
	<CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
	<20120220140653.GC5131@sigill.intra.peff.net>
	<87ty2l38ay.fsf@thomas.inf.ethz.ch> <20120220143644.GA13938@do>
	<CACsJy8DE86qzA1=GiKZFRCt5aH8X4iMyDvfrhnqwmbq52szhHg@mail.gmail.com>
	<7v8vjwgfoq.fsf@alter.siamese.dyndns.org>
	<CACsJy8C3Myqs4=GvURWqCTxGp0R1RWotdiHGnnvBSaxyTteujw@mail.gmail.com>
	<7v7gzfefw1.fsf@alter.siamese.dyndns.org>
	<CACsJy8BZyokLSpbA=C6YEO1JajyemT9vLG=C9W4E4coA5OfszQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 14:17:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0C4e-0000KZ-I2
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 14:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab2BVNRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 08:17:17 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:23049 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971Ab2BVNRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 08:17:16 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 14:17:12 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 14:17:13 +0100
In-Reply-To: <CACsJy8BZyokLSpbA=C6YEO1JajyemT9vLG=C9W4E4coA5OfszQ@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Wed, 22 Feb 2012 19:54:03 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191255>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sat, Feb 18, 2012 at 5:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> That being said, we do have an index extension to store the tree sha1 of
>>> whole directories (i.e., we populate it when we write a whole tree or
>>> subtree into the index from the object db, and it becomes invalidated
>>> when a file becomes modified). This optimization is used by things like
>>> "git commit" to avoid having to recreate the same sub-trees over and
>>> over when creating tree objects from the index. But we could also use it
>>> here to avoid having to even read the sub-tree objects from the object
>>> db.
>>
>> Like b65982b (Optimize "diff-index --cached" using cache-tree, 2009-05-20)
>> perhaps?
>
> This optimizes the case when a cached tree matches entirely.I wonder
> whether it's faster if we switch to tree-tree diff whenever we find
> valid cached trees. If cache-tree is fully valid, "git diff --cached
> foo" would be equivalent to "git diff HEAD foo".

Not necessarily; the cache-tree is valid if it faithfully represents
what is in the index.  It does not have any direct relation to HEAD.

> I tried "git diff --raw HEAD HEAD~100" (where HEAD was
> v3.1-rc1-272-g73e0881 on linux-2.6) and "git diff --cached --raw
> HEAD~100" with no cache-tree. The former is a little bit faster than
> the latter (177ms vs 275ms). On gentoo-x86, 70k worktree files, it's
> 4.33s vs 4.45s. But in tree-tree diff we pay high in cold cache case
> for loading trees from "HEAD". So no, probably not worth more code
> changes. Your optimization is good enough.

I'm still wondering about using mincore() to good effect.  I tried it
for git-grep, but it ended up slowing things down.  However, it irks me
that in some cases a clueful use of one form over the other can really
make a huge performance difference, e.g.,

  git grep stuff
  git grep HEAD stuff

If I am in a big repository that I haven't used in a while, the HEAD
form will be much faster as the worktree search would fault many files.
OTOH if I am in a heavily-used repository (and perhaps just said 'make'
minutes ago) the worktree version will avoid the pack decompression
effort.

Sadly this also has the problem that we must first determine whether
substituting HEAD for the worktree (or vice versa) is valid at all.  For
grep perhaps there could be a "just do a fast search somewhere" option
since usually you are looking for something that hasn't changed in ages.

Ok, that was almost completely beside the point of this thread.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
