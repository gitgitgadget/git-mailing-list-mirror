From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Thu, 17 May 2007 16:57:24 +0200
Message-ID: <20070517145724.GA905@diana.vm.bytemark.co.uk>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515182549.GB17851@diana.vm.bytemark.co.uk> <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com> <20070516071130.GB7453@diana.vm.bytemark.co.uk> <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com> <20070516194002.GA17805@diana.vm.bytemark.co.uk> <20070516204029.GB17805@diana.vm.bytemark.co.uk> <b0943d9e0705170543g4d8c7542p6b44a4e6fa54676a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 17 16:57:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HohQ5-0002R9-3f
	for gcvg-git@gmane.org; Thu, 17 May 2007 16:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390AbXEQO51 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 17 May 2007 10:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754437AbXEQO51
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 10:57:27 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1825 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbXEQO51 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 10:57:27 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HohPw-0000M1-00; Thu, 17 May 2007 15:57:24 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705170543g4d8c7542p6b44a4e6fa54676a@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47529>

On 2007-05-17 13:43:35 +0100, Catalin Marinas wrote:

> I ran 'git repack -a -d' and 'git prune'. There are no other objects
> apart from the generated pack:
>
> $ du -sh .git
> 211M    .git
>
> And then repeatedly 'time stg series > /dev/null':

Hmm, it seems there is a problem then. :-(

> It got smaller after repacking but it is still bigger than yours.
> Maybe the reason is that I have 14 branches with various patches,
> some of them just for historical reasons but going back to 2.6.12.
> There are also several commits generated for the patch logs.

OK. That shouldn't matter, though, since that extra history shouldn't
be examined anyway.

> The CPU is a P4 at 2.5GHz and the 'stg series' operation seems to be
> CPU bound rather than IO. I'm also using Python 2.3 on this PC and
> for this reason I changed 2 generator constructs (x for x in ...)
> with list comprehension (see the attached patch).

I don't think that's the problem, since those lists are both small.

The only possibility I can think of that might explain this is that
some of your unapplied patches are attached to a place in the commit
DAG that's far away from the branch head (e.g. you have rebased to
some entirely different place since you last had them applied), so
that "git-rev-list patch ^branch" outputs a large part of the commit
DAG.

Could you put counters in unapplied_patches() and
sort_applied_patches() to see how many lines each of them reads from
git-rev-list? The expected number (if it had taken just a little time,
like it did for me) is a small constant times the number of patches in
both cases.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
