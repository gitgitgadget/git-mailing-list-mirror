From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 03/14] Write to a stack log when stack is modified
Date: Mon, 23 Jun 2008 14:36:31 +0200
Message-ID: <20080623123631.GA18347@diana.vm.bytemark.co.uk>
References: <20080617123138.GA6932@diana.vm.bytemark.co.uk> <b0943d9e0806170711w6da8e841p3ac83a59a81f6577@mail.gmail.com> <20080617153247.GA12520@diana.vm.bytemark.co.uk> <b0943d9e0806180603h59187f7epc5014f36d070cec7@mail.gmail.com> <20080618143633.GB30540@diana.vm.bytemark.co.uk> <b0943d9e0806180916m4af3970ck347408661e95663@mail.gmail.com> <20080618173246.GA1155@diana.vm.bytemark.co.uk> <b0943d9e0806190224v1b6434fesd3a54443422edaeb@mail.gmail.com> <20080619100722.GB14415@diana.vm.bytemark.co.uk> <b0943d9e0806200214j77aef272sc5cfb98b002cae22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 14:37:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAlIe-0007T9-AX
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 14:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbYFWMgk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jun 2008 08:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYFWMgk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 08:36:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1806 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbYFWMgj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 08:36:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KAlHb-0005Aq-00; Mon, 23 Jun 2008 13:36:31 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806200214j77aef272sc5cfb98b002cae22@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85858>

On 2008-06-20 10:14:29 +0100, Catalin Marinas wrote:

> 2008/6/19 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > If we ever want to be able to undo "stg repair", we have to be
> > able to represent an inconsistent state where head !=3D top.
>
> I wouldn't bother with this feature. Why would one want to break the
> stack again after repairing? If they merge patches and git commits,
> they either repair the stack or commit all the patches and continue
> with using Git only.

Sometimes, stg repair isn't what you want. Say e.g. that you've done
git merge. stg repair will in this case stop reading your history once
it sees the merge commit, and consider all your patches unapplied. But
what you really want is to undo the git merge. Or that you've done git
rebase -- in that case, stg repair will realize that your patches are
unapplied, which is correct but probably not what you want.

=46or those of us who know what stg repair does, realizing when not to
run it and what to do instead is easy. But for very little extra
effort in the stack log, we can make the generic "stg undo" able to
fix these mistakes automatically. _And_ give the user assurance that
whatever she does with stg reset and stg undo, it can be undone.

> > I'd actually say the opposite: until we have a good visualizer
> > that doesn't need the simplified log, we need to have the
> > simplified log. If I actually have to look at the diffs in the
> > log, I find gitk indispensible.
>
> And what would the simplified log contain if we decide to go with a
> new scheme? In your proposal, it points to the tree of main log and
> you get the diff of diffs (which also means that the diffs must be
> generated for every modification of a patch). Would this be the
> same? Again, I worry a bit about the overhead to generate the patch
> diff for every push (with refresh I'm OK). It can be optimised as in
> the stable branch where we try git-apply followed by a three-way
> merge (which, BTW, I'd like added before 0.15). If git-apply
> succeeds, there is no need to re-generate the diff.

Yes, I was imagining a simplified log precisely like the one I've
currently implemented (a tree with one blob per patch, which contains
the message, the diff, and some other odds and ends such as the
author). Two optimizations would hopefully make it fast:

  1. If the patch's sha1 hasn't changed, we don't have to regenerate
     the diff.

  2. If the patch's sha1 has changed, but git apply was sufficient
     during the merge stage, we can just reuse that patch. We do have
     to write it to a blob, but we have already generated the diff and
     don't need to do so again. (I've shamelessly stolen your idea
     here.)

In most cases, (1) would make sure that only a small handful of
patches would need to be considered. In the cases where a lot of
patches are touched, such as rebase, (2) would provide a good speedup
(except for the cases where we had to call merge-recursive, and those
are slow anyway).

( By the way: Yes, I agree that we want to try git apply before
  merge-recursive. It's on my TODO list. )

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
