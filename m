From: Scott Bronson <bronson@rinspin.com>
Subject: Re: Bash tab completion for _git_fetch alias is broken on Git 1.7.7.1
Date: Sat, 12 Nov 2011 09:50:08 -0800
Message-ID: <CAKmUPx67GMmF=dbFvYGq4x3NdfhWDE++dSSzbCqL9LYAF+j9ww@mail.gmail.com>
References: <CAPXHQbPgepSFHX63F+Nt8TJ+znAaVqzzmSZmJqxj2mekhStO-g@mail.gmail.com>
	<CAPXHQbND61TyU21ckHwRyMYH=P=H7+GZR5KNY8m+qaMEEhEZKQ@mail.gmail.com>
	<7vehxgu0fy.fsf@alter.siamese.dyndns.org>
	<4EBB78C7.101@viscovery.net>
	<CAPXHQbP4yCzZ96WEKuHsV_8Pny0MRzcLOY7qi5W3_L_5CnY0vA@mail.gmail.com>
	<20111110151412.GA11479@goldbirke>
	<CAKmUPx6TpbLL2GZq6G1nWPPBe=_SsqJmqXs1o9x5BxqR8y9h2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nathan Broadbent <nathan.f77@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Nov 12 18:50:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPHie-0000ko-Na
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 18:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab1KLRuJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Nov 2011 12:50:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab1KLRuI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2011 12:50:08 -0500
Received: by iage36 with SMTP id e36so5349764iag.19
        for <git@vger.kernel.org>; Sat, 12 Nov 2011 09:50:08 -0800 (PST)
Received: by 10.42.161.69 with SMTP id s5mr16748047icx.23.1321120208165; Sat,
 12 Nov 2011 09:50:08 -0800 (PST)
Received: by 10.42.221.4 with HTTP; Sat, 12 Nov 2011 09:50:08 -0800 (PST)
In-Reply-To: <CAKmUPx6TpbLL2GZq6G1nWPPBe=_SsqJmqXs1o9x5BxqR8y9h2Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185309>

2011/11/12 Scott Bronson <bronson@rinspin.com>:
> 2011/11/10 SZEDER G=E1bor <szeder@ira.uka.de>
>> > On Thu, Nov 10, 2011 at 3:09 PM, Johannes Sixt <j.sixt@viscovery.n=
et> wrote:
>> > > Am 11/10/2011 4:21, schrieb Junio C Hamano:
>> > > > Nathan Broadbent <nathan.f77@gmail.com> writes:
>> > > >> Dear git mailing list,
>> > > >> I'm assigning the `_git_fetch` bash tab completion to the ali=
as `gf`,
>> > > >> with the following command:
>> > > >> =A0 =A0 complete -o default -o nospace -F _git_fetch gf
>> > > >> The tab completion then works fine in git 1.7.0.4, but breaks=
 on git
>> > > >> 1.7.7.1, with the following error:
>> I didn't actually tried, but I guess this is a side-effect of da4902=
a7
>> (completion: remove unnecessary _get_comp_words_by_ref() invocations=
,
>> ...
>> Alternatively, you could easily create your own wrapper function
>> around _git_fetch(), like this:
> Very true. =A0But if you tweak the completion variables, you can fool
> _git_fetch into working perfectly:
> * If I had more time, I'd be tempted to write a function that
> would define all the wrapper functions.

I couldn't stop thinking about it last night, I had to try it.  Here's =
the
result, seems to work great:


    __define_git_completion () {
    eval "
        _git_$2_shortcut () {
            COMP_LINE=3D\"git $2\${COMP_LINE#$1}\"
            let COMP_POINT+=3D$((4+${#2}-${#1}))
            COMP_WORDS=3D(git $2 \"\${COMP_WORDS[@]:1}\")
            let COMP_CWORD+=3D1

            local cur words cword prev
            _get_comp_words_by_ref -n =3D: cur words cword prev
            _git_$2
        }
    "
    }

    __git_shortcut () {
        type _git_$2_shortcut &>/dev/null || __define_git_completion $1=
 $2
        alias $1=3D"git $2 $3"
        complete -o default -o nospace -F _git_$2_shortcut $1
    }

    __git_shortcut  ga    add
    __git_shortcut  gb    branch
    __git_shortcut  gba   branch -a
    __git_shortcut  gco   checkout
    __git_shortcut  gci   commit -v
    __git_shortcut  gcia  commit '-a -v'
    __git_shortcut  gd    diff
    __git_shortcut  gdc   diff --cached
    __git_shortcut  gds   diff --stat
    __git_shortcut  gf    fetch
    __git_shortcut  gl    log
    __git_shortcut  glp   log -p
    __git_shortcut  gls   log --stat


On Github:
https://github.com/bronson/dotfiles/blob/731bfd951be68f395247982ba1fb74=
5fbed2455c/.bashrc#L81

It would be nice to see the __define_git_completion function merged
upstram. Possible?

    - Scott
