From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Thu, 10 Nov 2011 16:14:12 +0100
Message-ID: <20111110151412.GA11479@goldbirke>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
	<CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
	<7vehxgu0fy.fsf@alter.siamese.dyndns.org>
	<4EBB78C7.101@viscovery.net>
	<CAPXHQbP4yCzZ96WEKuHsV_8Pny0MRzcLOY7qi5W3_L_5CnY0vA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Nathan Broadbent <nathan.f77@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 10 16:14:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROWKe-0005wO-Rb
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 16:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757705Ab1KJPOT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 10:14:19 -0500
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:37678 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308Ab1KJPOT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 10:14:19 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 10 Nov
 2011 16:20:49 +0100
Received: from localhost6.localdomain6 (141.21.50.31) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.339.1; Thu, 10 Nov
 2011 16:14:15 +0100
Content-Disposition: inline
In-Reply-To: <CAPXHQbP4yCzZ96WEKuHsV_8Pny0MRzcLOY7qi5W3_L_5CnY0vA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185232>

Hi,

=20
[Please don't top-post.]

> On Thu, Nov 10, 2011 at 3:09 PM, Johannes Sixt <j.sixt@viscovery.net>=
 wrote:
> >
> > Am 11/10/2011 4:21, schrieb Junio C Hamano:
> > > Nathan Broadbent <nathan.f77@gmail.com> writes:
> > >
> > >> Dear git mailing list,
> > >>
> > >> I'm assigning the `_git_fetch` bash tab completion to the alias =
`gf`,
> > >> with the following command:
> > >>
> > >> =A0 =A0 complete -o default -o nospace -F _git_fetch gf

I assume you have an

  alias gf=3D"git fetch"

somewhere, right?

> > >> The tab completion then works fine in git 1.7.0.4, but breaks on=
 git
> > >> 1.7.7.1, with the following error:

I didn't actually tried, but I guess this is a side-effect of da4902a7
(completion: remove unnecessary _get_comp_words_by_ref() invocations,
2011-04-28), which was in v1.7.6.  Since the clean-up in that commit
we only call _get_comp_words_by_ref() in the top-level completion
functions _git() and _gitk() to populate completion-related variables
($cur, $prev, $words, $cword), so invoking any _git_<cmd>() completion
function directly causes an error or wrong behavior, because all those
variables are empty.

Calling a completion function directly was not an issue earlier,
because every _git_<cmd>() completion function invoked
_get_comp_words_by_ref() to populate those variables, or in the
pre-_get_comp_words_by_ref() times they just accessed the
completion-related bash variables $COMP_WORDS and $COMP_CWORD
directly.


On Thu, Nov 10, 2011 at 04:52:33PM +0800, Nathan Broadbent wrote:
> So, this is a feature, not a bug... Tab completion for aliases is
> really useful. It's important enough to me that I won't stop until
> I've found a solution.
> I can appreciate that _git_fetch is not currently meant to be called
> directly, but we found a way to utilize it when it previously worked.
> Perhaps the scope of these completion functions could be expanded to
> allow for aliases? I'll attempt to submit a patch if someone can give
> me approval.

The quickest way would be to just revert da4902a7, but it would be the
dirtiest, too: it would bring back a lot of redundant calls to
_get_comp_words_by_ref() and it might have side-effects under zsh (but
I didn't think this through).

It would be a bit more clever to revert only parts of da4902a7, i.e.
to bring back _get_comp_words_by_ref() calls in _git_<cmd> completion
functions but not in __git_<whatever>() helper functions.  This way
_git_<cmd>() functions would have their completion-related variables
initialized even when called directly instead through _git(), and
_get_comp_words_by_ref() would be called "only" twice during a single
completion.  But that's still one too many, and again: there can be
issues with zsh.

Alternatively, you could easily create your own wrapper function
around _git_fetch(), like this:

_gf () {
	local cur prev words cword
	_get_comp_words_by_ref -n =3D: cur prev words cword
	_git_fetch
}


However.

Having said all that, I'd like to point out that even if _git_fetch()
didn't error out when called for the 'gf' alias, it still wouldn't
work properly.  After 'gf origin <TAB>' it offers the list of remotes
again and it never offers refspecs, because it calls
__git_complete_remote_or_refspec(), which

 - depends on the fact that there must be at least two words ('git'
   and 'fetch') on the command line before the remote, and

 - needs to know the git command (i.e. fetch, pull, or push) to offer
   the proper refspecs, but it can't find that out from your alias.


Best,
G=E1bor
