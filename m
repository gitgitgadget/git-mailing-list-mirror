From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Fri, 30 Jan 2009 16:26:49 +0100
Message-ID: <20090130152649.GA22044@diana.vm.bytemark.co.uk>
References: <20090128231305.16133.29214.stgit@localhost.localdomain> <20090129034512.GD24344@diana.vm.bytemark.co.uk> <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 16:28:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSvI5-0004iq-Pe
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 16:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbZA3P0z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jan 2009 10:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZA3P0z
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 10:26:55 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3495 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbZA3P0z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 10:26:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LSvGb-0005nB-00; Fri, 30 Jan 2009 15:26:49 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0901300601j27ab6ebdq4b38a9f7c0cbe261@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107832>

On 2009-01-30 14:01:20 +0000, Catalin Marinas wrote:

> @@ -706,9 +706,15 @@ class Index(RunWithEnv):
>                      ).output_one_line())
>          except run.RunException:
>              raise MergeException('Conflicting merge')
> -    def is_clean(self):
> +    def is_clean(self, tree =3D None):
> +        """Check whether the index is clean relative to the given tr=
ee."""
> +        if tree:
> +            sha1 =3D tree.sha1
> +        else:
> +            sha1 =3D 'HEAD'
>          try:
> -            self.run(['git', 'update-index', '--refresh']).discard_o=
utput()
> +            self.run(['git', 'diff-index', '--quiet', '--cached', sh=
a1]
> +                    ).discard_output()
>          except run.RunException:
>              return False
>          else:

OK (though I personally would have allowed only Tree objects, with no
defaulting to the current HEAD).

The docstring should say s/tree/treeish/.

> @@ -858,6 +864,15 @@ class IndexAndWorktree(RunWithEnvCwd):
>          cmd =3D ['git', 'update-index', '--remove']
>          self.run(cmd + ['-z', '--stdin']
>                   ).input_nulterm(paths).discard_output()
> +    def worktree_clean(self):
> +        """Check whether the worktree is clean relative and no updat=
es or
> +        merges are needed."""
> +        try:
> +            self.run(['git', 'update-index', '--refresh']).discard_o=
utput()
> +        except run.RunException:
> +            return False
> +        else:
> +            return True

Clean relative to the index.

And what do merges have to do with it?

> +        # Check for not clean index and worktree
> +        if check_clean and iw:
> +            if not iw.worktree_clean():
> +                self.__halt('Repository not clean. Use "refresh" or =
'
> +                            '"status --reset"')
> +            elif not iw.index.is_clean()):
> +                self.__halt('Index and HEAD different. Use "repair" =
to '
> +                            'recover additional commits')

The first message is good, but the second one is misleading -- you'd
be much better off just reusing the same message as for the first
case. (You could recommend refresh --index if you want to get fancy.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
