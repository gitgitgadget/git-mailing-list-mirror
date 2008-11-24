From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Stgit and refresh-temp
Date: Mon, 24 Nov 2008 12:16:35 +0100
Message-ID: <20081124111635.GA31986@diana.vm.bytemark.co.uk>
References: <9e4733910811040537p4e88c09an94370154eca12778@mail.gmail.com> <20081107054419.GA27146@diana.vm.bytemark.co.uk> <b0943d9e0811110959t4eb236bvd648fbca5e482911@mail.gmail.com> <20081112080103.GA25454@diana.vm.bytemark.co.uk> <b0943d9e0811120202wae88381j9fbc9f919b49dce5@mail.gmail.com> <20081112101439.GA27469@diana.vm.bytemark.co.uk> <b0943d9e0811231320s804eff0k5aecbac84cb2ffe7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 12:18:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4ZSC-0003Of-IB
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 12:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbYKXLQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Nov 2008 06:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYKXLQw
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Nov 2008 06:16:52 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3218 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442AbYKXLQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2008 06:16:51 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1L4ZQh-0008Qt-00; Mon, 24 Nov 2008 11:16:35 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0811231320s804eff0k5aecbac84cb2ffe7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101600>

On 2008-11-23 21:20:59 +0000, Catalin Marinas wrote:

> 2008/11/12 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-11-12 10:02:10 +0000, Catalin Marinas wrote:
> >
> > > I think it's just a matter of updating HEAD on the
> > > "merge_conflict" path but I'm still not fully confident in
> > > modifying the new lib infrastructure.
> >
> > You're probably right.
>
> The simple patch below seems to fix it the goto issue. Could you
> please confirm its correctness (the patch might be wrapped by the web
> interface)?
>
> diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
> index 6623645..0f414d8 100644
> --- a/stgit/lib/transaction.py
> +++ b/stgit/lib/transaction.py
> @@ -321,6 +321,7 @@ class StackTransaction(object):
>          if any(getattr(cd, a) !=3D getattr(orig_cd, a) for a in
>                 ['parent', 'tree', 'author', 'message']):
>              comm =3D self.__stack.repository.commit(cd)
> +            self.head =3D comm
>          else:
>              comm =3D None
>              s =3D ' (unmodified)'

OK, so I just took a quick look, and my understanding of the problem
(without having had time to actually run any code to confirm) is that
the following happens:

  1. In push_patch(), we delay the final stack update (the update()
     function) since we want to record the state just before the
     conflict in the stack log.

  2. In run(), we update the branch head before running the delayed
     stack update (self.__conflicting_push()).

Your patch works around this problem by explicitly specifying what the
branch head should be; this mechanism is used by undo etc. to be able
to set the branch head to something that isn't the stack top.

At first I thought it was something of a hack, and that the run()
function should probably be modified to do something clever when
self.__conflicting_push !=3D None, such as writing the branch head
later. But there's a reason the checkout is done first in run(): it's
the one and only thing that can go wrong, in which case we have to
roll back. So I guess your solution is indeed at least as right and
proper as anything I would have come up with.

But I would recommend a big fat comment just before the line you
insert that explains why we have to set self.head hard in this case
(namely, that the update() function is run _after_ checkout in run()).

With that comment,

Acked-by: Karl Hasselstr=F6m <kha@treskal.com>

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
