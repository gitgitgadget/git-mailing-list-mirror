From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: new stacked git feature
Date: Fri, 22 Feb 2008 16:19:14 +0100
Message-ID: <20080222151914.GB19172@diana.vm.bytemark.co.uk>
References: <20080111194946.GA7504@redhat.com> <1202834567.14175.68.camel@pc1117.cambridge.arm.com> <20080213000806.GB25839@diana.vm.bytemark.co.uk> <b0943d9e0802131429p76f0981cm6e54a6a07042f229@mail.gmail.com> <20080213235204.GA10335@diana.vm.bytemark.co.uk> <b0943d9e0802201506w353b5c05vece9f99730d7663c@mail.gmail.com> <20080221074543.GB8250@diana.vm.bytemark.co.uk> <b0943d9e0802220554x4c0a6c98q39e8b253bb108f1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jason Baron <jbaron@redhat.com>,
	David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Yann Dirson <ydirson@altern.org>, git <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 16:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSZhb-00077h-RV
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 16:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbYBVPUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 10:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbYBVPUH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 10:20:07 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4753 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbYBVPUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 10:20:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JSZgA-0005Rk-00; Fri, 22 Feb 2008 15:19:14 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802220554x4c0a6c98q39e8b253bb108f1e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74727>

On 2008-02-22 13:54:12 +0000, Catalin Marinas wrote:

> "stg sync" does pretty much the same now but in a more manual way. I
> don't really like the way the conflicts are presented - i.e. you
> don't know which patch was modified afterwards because the patches
> lose this information (they are not topic branches).

This shouldn't be a problem with a per-branch log -- it would have the
state of both ancestors before the merge, and the merged state
afterwards, so nothing should be lost.

> On 21/02/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> >   1. First we push b. The A->X variant applies trivially, but the
> >      B1->C1 variant needs the standard 3-way merge.
>
> 3-way merge with X and B1 as base? This leads to the current "sync"
> issue, you can't tell which patch was original and which was
> modified.

No. First a 3-way merge (A (base), A, X) with result X, and then a
3-way merge (A (base), B1, C1) with a result that has to be computed
by the merge algorithm. Just as if you were pushing both versions of
the patch separately.

The basic algorithm is:

  1. You want to merge patches A->B and C->D. Their closest common
     ancestors are X0->Y0, X1->Y1, ...

  2. Select the base tree K you want to push the patch on. This is
     either another patch, or the bottom of the stack.

  3. For each of A->B, C->D, X0->Y0, X1->Y1, ..., push them separately
     onto K (in parallel, not on top of each other). If there are
     conflicts, just commit the conflict markers. The patches are now
     K->B', K->D', K->Y0', K->Y1', ...

  4. Merge B' and D' with Y0', Y1', ... as bases. In case of
     conflicts, ask the user to resolve them.

Obviously, K may be the same as one or more of A, C, X0, X1, ..., so
that some or all of the pushes are trivial.

> Just a thought (not that I'd like this feature in StGIT). Someone
> tried a project some time ago, similar to StGIT, but using topic
> branches rather than individual commits per patch. The GIT history
> looked very ugly, especially after re-ordering, but the advantage
> was that you can avoid rebasing patches and simply merging changes
> from bottom patches into top ones. This would make synchronisation
> of patches between branches much easier.

I never really liked that approach; it kind of treats patches as
trees, when they are in fact the diff between two trees. It only works
because the boundary between two applied patches is a tree. But the
user thinks she's manipulating patches and not patch boundaries, which
is why the history looks strange.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
