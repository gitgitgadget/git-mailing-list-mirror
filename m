From: Scott Bronson <bronson@rinspin.com>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Sat, 12 Nov 2011 00:08:59 -0800
Message-ID: <CAKmUPx6TpbLL2GZq6G1nWPPBe=_SsqJmqXs1o9x5BxqR8y9h2Q@mail.gmail.com>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
	<CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
	<7vehxgu0fy.fsf@alter.siamese.dyndns.org>
	<4EBB78C7.101@viscovery.net>
	<CAPXHQbP4yCzZ96WEKuHsV_8Pny0MRzcLOY7qi5W3_L_5CnY0vA@mail.gmail.com>
	<20111110151412.GA11479@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Broadbent <nathan.f77@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 12 09:11:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP8fz-0001d0-U7
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 09:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab1KLIJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Nov 2011 03:09:00 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37223 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1KLIJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 03:09:00 -0500
Received: by iage36 with SMTP id e36so4968179iag.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 00:08:59 -0800 (PST)
Received: by 10.42.72.135 with SMTP id o7mr15541852icj.45.1321085339539; Sat,
 12 Nov 2011 00:08:59 -0800 (PST)
Received: by 10.42.229.200 with HTTP; Sat, 12 Nov 2011 00:08:59 -0800 (PST)
In-Reply-To: <20111110151412.GA11479@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185303>

2011/11/10 SZEDER G=E1bor <szeder@ira.uka.de>
> > On Thu, Nov 10, 2011 at 3:09 PM, Johannes Sixt <j.sixt@viscovery.ne=
t> wrote:
> > > Am 11/10/2011 4:21, schrieb Junio C Hamano:
> > > > Nathan Broadbent <nathan.f77@gmail.com> writes:
> > > >> Dear git mailing list,
> > > >> I'm assigning the `_git_fetch` bash tab completion to the alia=
s `gf`,
> > > >> with the following command:
> > > >> =A0 =A0 complete -o default -o nospace -F _git_fetch gf
> > > >> The tab completion then works fine in git 1.7.0.4, but breaks =
on git
> > > >> 1.7.7.1, with the following error:
>
> I didn't actually tried, but I guess this is a side-effect of da4902a=
7
> (completion: remove unnecessary _get_comp_words_by_ref() invocations,

I looked into it and this is exactly right.


> Alternatively, you could easily create your own wrapper function
> around _git_fetch(), like this:
>
> _gf () {
> =A0 =A0 =A0 =A0local cur prev words cword
> =A0 =A0 =A0 =A0_get_comp_words_by_ref -n =3D: cur prev words cword
> =A0 =A0 =A0 =A0_git_fetch
> }
>
>
> However.
>
> Having said all that, I'd like to point out that even if _git_fetch()
> didn't error out when called for the 'gf' alias, it still wouldn't
> work properly. =A0After 'gf origin <TAB>' it offers the list of remot=
es
> again and it never offers refspecs, because it calls
> __git_complete_remote_or_refspec(), which
>
> =A0- depends on the fact that there must be at least two words ('git'
> =A0 and 'fetch') on the command line before the remote, and
>
> =A0- needs to know the git command (i.e. fetch, pull, or push) to off=
er
> =A0 the proper refspecs, but it can't find that out from your alias.

Very true.  But if you tweak the completion variables, you can fool
_git_fetch into working perfectly:

  _gf () {
      COMP_LINE=3D"git fetch${COMP_LINE#gf}"
      let COMP_POINT+=3D7  # strlen('git fetch') - strlen('gf')
      COMP_WORDS=3D(git fetch "${COMP_WORDS[@]:1}")
      let COMP_CWORD+=3D1

      local cur words cword prev
      _get_comp_words_by_ref -n =3D: cur words cword prev
      _git_fetch
  }

Can anyone find a place where this would fail?

It would be pretty easy to write similar wrappers for _git_add,
_git_branch, and all the rest. [*]

Is there any possibility for a full set of wrappers (with better
names) to be merged into the git completions?  A number of
peopl are disappointed that abbreviation completion doesn't
work anymore, myself included:
  https://github.com/bobthecow/git-flow-completion/issues/2
  https://github.com/ndbroadbent/scm_breeze/issues/11

I'm happy to write them if there's a chance they'd be merged.
Thank you for all the work you've done on the completions G=E1bor!

    - Scott


* If I had more time, I'd be tempted to write a function that
would define all the wrapper functions.

    define_wrapper add, ga
    define_wrapper branch, gb
    define_wrapper fetch, gf
    ...

Nothing a little eval metaprogramming can't solve.  :)
