From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Wed, 25 Mar 2009 10:05:41 +0100
Message-ID: <20090325090541.GA24889@diana.vm.bytemark.co.uk>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com> <20090323084507.GA6447@diana.vm.bytemark.co.uk> <b0943d9e0903230933n5b71a53elcfaa13f00883861d@mail.gmail.com> <20090324131640.GB4040@diana.vm.bytemark.co.uk> <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 10:07:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmP4v-0003TD-LI
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 10:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbZCYJFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 05:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZCYJFq
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 05:05:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37451 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362AbZCYJFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 05:05:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LmP3N-0006vS-00; Wed, 25 Mar 2009 09:05:41 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0903240840m3f22b702qd48293caad4187e3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114576>

On 2009-03-24 15:40:10 +0000, Catalin Marinas wrote:

> Anyway, with apply_treedif() there is no need for the
> temp_index_tree. In the updated patch below, I don't even call
> write_tree() as it isn't needed (to my understanding).

Yes. You're not interested in the result of the patch application, you
just want to know if it succeeded or not.

> Whatever is in the index after the check_merged() function doesn't
> correspond to any tree so it would need to be re-read.

It does correspond to _some_ tree, but as we have no particular reason
to expect that it might be a tree that we're going to need again
immediately, we can set temp_index_tree to None to force re-reading,
rather than pay the cost of write_tree.

When pushing patches, on the other hand, we have good reasons to
believe that the next tree we'll need in the index is the same (or at
least very close to) the one produced in the last merge. Consider the
case of popping a few patches, changing the message on the top patch,
and then pushing the patches back, for example.

> +    def check_merged(self, patches):
> +        """Return a subset of patches already merged."""
> +        merged =3D []
> +        self.temp_index.read_tree(self.stack.head.data.tree)
> +        # The self.temp_index is modified by apply_treediff() so for=
ce
> +        # read_tree() the next time merge() is used.
> +        self.temp_index_tree =3D None
> +        for pn in reversed(patches):
> +            # check whether patch changes can be reversed in the cur=
rent index
> +            cd =3D self.patches[pn].data
> +            if cd.is_nochange():
> +                continue
> +            try:
> +                self.temp_index.apply_treediff(cd.tree, cd.parent.da=
ta.tree,
> +                                               quiet =3D True)
> +                merged.append(pn)
> +            except git.MergeException:
> +                pass
> +        return merged

Some points here:

  1. Check if temp_index_tree already contains the tree you want
     instead of doing read_tree unconditionally. That is, change

       self.temp_index.read_tree(self.stack.head.data.tree)

     to

       if self.stack.head.data.tree !=3D self.temp_index_tree:
           self.temp_index.read_tree(self.stack.head.data.tree)
           self.temp_index_tree =3D self.stack.head.data.tree

  2. If apply_treediff fails (raises MergeException), the index wasn't
     modified at all (but I guess you knew that, since your code
     relies on that fact), so there's no reason to set temp_index_tree
     to None in that case. So in order to not clear temp_index_tree
     unnecessarily in case none of the patches reverse-apply (a case I
     personally encounter frequently, since I leave the -m flag on all
     the time), move

       self.temp_index_tree =3D None

     to just after (or just before) "merged.append(pn)".

  3. Why are empty patches considered not merged?

Other than that, this logic looks fine.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
