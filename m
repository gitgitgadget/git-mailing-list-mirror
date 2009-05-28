From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [RFC][StGit PATCH] Add support for merge-friendly branches
Date: Thu, 28 May 2009 14:48:17 +0200
Message-ID: <20090528124817.GA22262@diana.vm.bytemark.co.uk>
References: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 14:48:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9f2Y-0001Bc-I0
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 14:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762717AbZE1Ms3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 08:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762261AbZE1Ms3
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 08:48:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:41381 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762692AbZE1Ms2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 08:48:28 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1M9f1t-0005uO-00; Thu, 28 May 2009 13:48:17 +0100
Content-Disposition: inline
In-Reply-To: <20090528111212.21925.45527.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120187>

On 2009-05-28 12:12:42 +0100, Catalin Marinas wrote:

> The patch proposes a new StGit command called "publish". This
> command allows one to develop patches normally on a StGit branch but
> publish the stack changes to a separate, merge-friendly branch whose
> history is not re-writable.

Hmm, interesting. I don't think I'd want to use a command like this
myself, but I can see how it might be useful.

> +    # check for same tree (already up to date)
> +    if public_tree.sha1 =3D=3D stack.head.data.tree.sha1:
> +        out.info('"%s" already up to date' % public_ref)
> +        return
> +
> +    # check for rebased stack. In this case we emulate a merge with =
the stack
> +    # base by setting two parents.
> +    merge_base =3D repository.get_merge_base(public_head, stack.base=
)
> +    if merge_base.sha1 !=3D stack.base.sha1:
> +        public_head =3D __create_commit(repository, stack.head.data.=
tree,
> +                                      [public_head, stack.base], opt=
ions)
> +        repository.refs.set(public_ref, public_head, 'publish')
> +        out.info('Merged the stack base into "%s"' % public_ref)
> +        return

Hmm. Couldn't the merge base conceivably be higher up in the stack?
Like, right at the beginning, don't we have public_head =3D=3D stack.he=
ad?
That would be caught by the "same tree" check" a bit earlier, but
after adding another patch, don't we have public_head =3D=3D stack.head=
^ ?
Which would give merge_base =3D=3D public_head.

> +    def get_merge_base(self, commit1, commit2):
> +        """Return the merge base of two commits."""
> +        sha1 =3D self.run(['git', 'merge-base',
> +                         commit1.sha1, commit2.sha1]).output_one_lin=
e()
> +        return self.get_commit(sha1)

This funcion should probably return a list of zero or more merge
bases. See the --all flag to git merge-base.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
