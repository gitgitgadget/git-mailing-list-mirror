From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 10:50:39 -0700
Message-ID: <7vfxezzms0.fsf@alter.siamese.dyndns.org>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 19:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6pwG-0007HB-DY
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 19:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756115AbZETRuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 13:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756047AbZETRuk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 13:50:40 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63280 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbZETRuj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 13:50:39 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090520175039.MAIR17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 20 May 2009 13:50:39 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id ttqf1b00T4aMwMQ04tqfMr; Wed, 20 May 2009 13:50:39 -0400
X-Authority-Analysis: v=1.0 c=1 a=PKzvZo6CAAAA:8 a=cnnJsRojmAWpMKd6SCsA:9
 a=YpKVo--xYovhgiOxw0oA:7 a=YN7Cc1nk5kGKPRU6fLvhqjcuEdQA:4 a=OdWmie4EkE0A:10
 a=LBjP2LwXQ-a1lOoo:21 a=VQjUuRu1ZZsCKrof:21
X-CM-Score: 0.00
In-Reply-To: <20090520032139.GB10212@coredump.intra.peff.net> (Jeff King's message of "Tue\, 19 May 2009 23\:21\:39 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119622>

Jeff King <peff@peff.net> writes:

> Related to this, I have wondered if it might be useful to have an "index
> reflog". If I do something like this:
>
>   $ git add foo
>   $ hack hack hack
>   $ git add foo
>
> Then the first added state of "foo" is available in the object database,
> but it is not connected to the name "foo" in any way, which makes it
> much harder to find. If we had a reflog pointing to trees representing
> the index state after each change, then it would be simple (you could
> look at "INDEX@{1}:foo" or similar).
>
> I don't know if the performance is an issue. We are writing an extra
> tree every time we touch the index, but in many cases you are already
> writing a blob.

It is not just "an extra tree every time".  For example, in the kernel
repository, one of the path that is deepest [*1*] (i.e. whose modification
affects the most number of trees) is:

    arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_reg_space_asm.h

If you modify this file and then "git add", and if you write-tree the
index at that point, you need to write a tree object for ".", arch/,
arch/cris, ..., arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm, 10
trees in total (if I am counting them right ;-).

If your cache-tree is fresh (and if you "git write-tree" every time you
"git add", that will make it stay fresh), you do not have to recompute
object names of other 1728 tree objects (they are unchanged) [*2*], which
should help somewhat, but the majority of time is spent in the I/O (and
perhaps slow fsync on ext3 ;-) of writing these 10 tree objects [*3*].

People like Shawn who work with Java projects, where the tree hierarchy
tends to be (unnecessary) deep with prefixes like org/spearce/jgit due to
the namespace issues will have bigger overhead than a relatively shallow
project like git.git itself.

[Footnotes]

*1* You can find it out yourself with...

git ls-files "$(
    git ls-files |
    sed -e 's|[^/]||g' |
    sort -u |
    tail -n 1 |
    sed -e 's|/|*/|g' -e 's/$/*/'
)" | head -n 1

*2* The total number of tree objects in a commit is...

echo $(git ls-tree -r -d HEAD | wc -l) 1 + p | dc

*3* write-tree with or without help from cache-tree in the kernel
repository with a hot cache (we are talking about running "git write-tree"
every time you do "git add" so the cold cache case does not matter) looks
like this:

$ l=arch/cris/include/arch-v32/mach-a3/mach/hwregs/iop/asm/iop_reg_space_asm.h
$ echo >>$l && git add $l
$ /usr/bin/time git write-tree
04bc92c40a5d0f0d44e162e140cb00964a52046b
0.02user 0.01system 0:00.03elapsed 102%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+6387minor)pagefaults 0swaps

$ git reset --hard

$ echo >>$l && git add $l
$ /usr/bin/time git write-tree --ignore-cache-tree
04bc92c40a5d0f0d44e162e140cb00964a52046b
0.13user 0.04system 0:00.17elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+5336outputs (0major+17141minor)pagefaults 0swaps

(The numbers are from my Athlon(tm) 64 X2 3800+ with slow IDE disks).
