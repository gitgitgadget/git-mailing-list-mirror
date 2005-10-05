From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [PATCH] Enable and fix support for base less merges.
Date: Wed, 5 Oct 2005 22:32:30 +0200
Message-ID: <20051005203230.GB1833@c165.ib.student.liu.se>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net> <4340A01F.7040901@gmail.com> <7vfyrjw8qb.fsf@assigned-by-dhcp.cox.net> <20051003061309.GA1712@c165.ib.student.liu.se> <46a038f90510022334k63884c6x377104e7eca29c48@mail.gmail.com> <20051004060755.GA1687@c165.ib.student.liu.se> <46a038f90510032322t6623c8d4y969e4e00bf4dfe26@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 22:34:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENFwQ-0007CY-RU
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 22:32:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVJEUci (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVJEUci
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 16:32:38 -0400
Received: from [85.8.31.11] ([85.8.31.11]:63421 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030379AbVJEUch (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 16:32:37 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 04D644114; Wed,  5 Oct 2005 22:38:53 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ENFwE-0000v2-00; Wed, 05 Oct 2005 22:32:30 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510032322t6623c8d4y969e4e00bf4dfe26@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9731>

On Tue, Oct 04, 2005 at 07:22:04PM +1300, Martin Langhoff wrote:
> On 10/4/05, Fredrik Kuivinen <freku045@student.liu.se> wrote:
> > I don't really understand what you mean. In what way could git-apply
> > use this? Is there a specific use case you are thinking about?
> 
> Hmmm, perhaps I'm not understanding what a 'base less' merge is.
>

A base less merge is a merge of two branches which do not have a
common ancestor. That is, git-merge-base --all branch-A branch-B will
not return any results.

> Lately, I've been doing some "merges" where there was no common
> ancestor (known to git) and doing some lightweight cherrypicking by
> using `git-format-patch --mbox -o tmpdir` and then using
> git-applymbox. This is very useful to "replay" history against a
> different git repo (or branch) that doesn't share a common ancestor.
>
> But this has no support from the new smart merging mechanisms, which
> could potentially help by applying a patch to a renamed file. I'm not
> sure whether the "recursive" strategy needs 2 parents to figure this
> out, but if it doesn't, this'd be interesting to have. But at the time
> git-apply is cold, limited and unhelpful.

A base less merge is handled exactly as if there was a common ancestor
for the two branches with an empty tree. Renames are detected by
executing git-diff-tree -M --diff-filter=R -r <common ancestor>
<branch-A> and the analogous command for <branch-B>. Hence, if <common
ancestor> corresponds to an empty tree no renames will be detected.

I guess the major difference between cherrypicking with
git-format-patch and merging is that a merge is pretty much an all or
nothing thing. If you merge a branch you will get every commit from
that branch (and if you don't merge you will obviously not get any
commits at all).

> If baseless merges support what I am doing without resorting to
> patches, I'd be a really happy camper. Using mbox patchruns sucks,
> thank you very much for asking, because they don't support binary
> files.

It's unfortunate that binary files aren't supported. I have been
thinking about doing something about it, there isn't any code yet
though.

Anyway, the idea I have thought about is to use (probably
base64-encoded) xdelta diffs for the binary files. With this approach
git diffs could look like:

diff --git --xdelta a/foo b/foo
<base64-encoded xdelta data>

Is this approach reasonable?

- Fredrik
