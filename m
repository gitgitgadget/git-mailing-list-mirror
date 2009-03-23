From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Add the --merged option to goto
Date: Mon, 23 Mar 2009 09:45:07 +0100
Message-ID: <20090323084507.GA6447@diana.vm.bytemark.co.uk>
References: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 09:47:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlfoM-00071k-QW
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 09:47:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbZCWIpU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 04:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753499AbZCWIpR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 04:45:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:52666 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755460AbZCWIpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 04:45:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LlfmN-0001kD-00; Mon, 23 Mar 2009 08:45:07 +0000
Content-Disposition: inline
In-Reply-To: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114266>

On 2009-03-20 16:15:45 +0000, Catalin Marinas wrote:

> This patch adds support for checking which patches were already
> merged upstream. This checking is done by trying to reverse-apply
> the patches in the index before pushing them onto the stack. The
> trivial merge cases in Index.merge() are ignored when performing
> this operation otherwise the results could be wrong (e.g. a patch
> adding a hunk and a subsequent patch canceling the previous change
> would both be considered merged).
>
> Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
> ---
>
> This is in preparation for the updating of the push command where we
> have this functionality (I think we had it for goto as well but was
> lost with the update to stgit.lib). Test cases with --merged are
> already done for the push command, so I haven't added any for goto
> (but I'll push this patch only after push is updated).

Looks good, except for a few things:

> @@ -732,7 +732,7 @@ class Index(RunWithEnv):
>          # to use --binary.
>          self.apply(self.__repository.diff_tree(tree1, tree2, ['--ful=
l-index']),
>                     quiet)
> -    def merge(self, base, ours, theirs, current =3D None):
> +    def merge(self, base, ours, theirs, current =3D None, check_triv=
ial =3D True):
>          """Use the index (and only the index) to do a 3-way merge of=
 the
>          L{Tree}s C{base}, C{ours} and C{theirs}. The merge will eith=
er
>          succeed (in which case the first half of the return value is

Please update the documentation with your new option. :-)

> @@ -752,12 +752,13 @@ class Index(RunWithEnv):
>          assert current =3D=3D None or isinstance(current, Tree)
> =20
>          # Take care of the really trivial cases.
> -        if base =3D=3D ours:
> -            return (theirs, current)
> -        if base =3D=3D theirs:
> -            return (ours, current)
> -        if ours =3D=3D theirs:
> -            return (ours, current)
> +        if check_trivial:
> +            if base =3D=3D ours:
> +                return (theirs, current)
> +            if base =3D=3D theirs:
> +                return (ours, current)
> +            if ours =3D=3D theirs:
> +                return (ours, current)

Uh, what? What's the point of not doing this unconditionally?

> @@ -379,3 +385,25 @@ class StackTransaction(object):
>          assert set(self.unapplied + self.hidden) =3D=3D set(unapplie=
d + hidden)
>          self.unapplied =3D unapplied
>          self.hidden =3D hidden
> +
> +    def check_merged(self, patches):
> +        """Return a subset of patches already merged."""
> +        merged =3D []
> +        temp_index =3D self.__stack.repository.temp_index()
> +        temp_index_tree =3D None

There's no need to create a new temp index here. The transaction
object already has one.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
