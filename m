From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 3/5] Add automatic git-mergetool invocation to the new infrastructure
Date: Fri, 13 Mar 2009 03:17:51 +0100
Message-ID: <20090313021751.GC15393@diana.vm.bytemark.co.uk>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com> <20090312120907.2992.81035.stgit@pc1117.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 03:19:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhwzf-0000GR-AQ
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 03:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbZCMCR7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 22:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbZCMCR6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 22:17:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37822 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZCMCR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 22:17:57 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Lhwy7-0004FV-00; Fri, 13 Mar 2009 02:17:51 +0000
Content-Disposition: inline
In-Reply-To: <20090312120907.2992.81035.stgit@pc1117.cambridge.arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113136>

On 2009-03-12 12:09:07 +0000, Catalin Marinas wrote:

> This patch adds the IndexAndWorktree.mergetool() function responsible
> for calling 'git mergetool' to interactively solve conflicts. The
> function may also be called from IndexAndWorktree.merge() if the
> standard 'git merge-recursive' fails and 'interactive =3D=3D True'. T=
he
> 'allow_interactive' parameter is passed to Transaction.push_patch() f=
rom
> the functions allowing interactive merging.

Nicely done with the "interactive" and "allow_interactive" arguments;
the policy and the implementation end up at the right levels.

>                  # There were conflicts
> -                conflicts =3D [l for l in output if l.startswith('CO=
NFLICT')]
> -                raise MergeConflictException(conflicts)
> +                if interactive:
> +                    self.mergetool()
> +                else:
> +                    conflicts =3D [l for l in output if l.startswith=
('CONFLICT')]
> +                    raise MergeConflictException(conflicts)

Does the merge tool always resolve all conflicts? If it doesn't, the
two lines in the "else" branch should probably be run unconditionally.

>          except run.RunException, e:
>              raise MergeException('Index/worktree dirty')
> +    def mergetool(self, files =3D ()):
> +        """Invoke 'git mergetool' on the current IndexAndWorktree to=
 resolve
> +        any outstanding conflicts. If 'not files', all the files in =
an
> +        unmerged state will be processed."""
> +        err =3D os.system('git mergetool %s' % ' '.join(files))

Look at how the surrounding code calls git. os.system() will do nasty
things with filenames that require quoting, such as for example
"; rm -rf ~/".

> +        # check for unmerged entries (prepend 'CONFLICT ' for consis=
tency with
> +        # merge())
> +        conflicts =3D ['CONFLICT ' + f for f in self.index.conflicts=
()]
> +        if conflicts:
> +            raise MergeConflictException(conflicts)
> +        elif err:
> +            raise MergeException('"git mergetool" failed, exit code:=
 %d' % err)

Ah, you take care of conflicts here too. Hmm. I guess that's fine too,
though there is some code duplication. Maybe a helper function that
takes output as a parameter, and raises MergeConflictException if
necessary?

> +                interactive =3D allow_interactive and \
> +                        config.get('stgit.autoimerge') =3D=3D 'yes'

Small style nit: backslash line continuations are ugly. :-)

If you put parentheses around the expression, you can break the line
without a backslash.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
