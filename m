From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: Autocompletion - commands no longer work as stand alone
Date: Wed, 25 Jan 2012 00:26:58 +0100
Message-ID: <20120124232658.GD2256@goldbirke>
References: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
	<CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com>
	<7vwr8mdvo8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nathan Bullock <nathanbullock@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 00:27:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpplh-0007XZ-KP
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 00:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab2AXX1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jan 2012 18:27:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:54072 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab2AXX1G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 18:27:06 -0500
Received: from localhost6.localdomain6 (p5B130119.dip0.t-ipconnect.de [91.19.1.25])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MV5B7-1S8GN813EL-00YSnL; Wed, 25 Jan 2012 00:27:03 +0100
Content-Disposition: inline
In-Reply-To: <7vwr8mdvo8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:BfssBCzE0OtK2AL7AzbAA4F/qsxTFg9R30wfcHB3SWq
 KnDvX97gIUlsil+e72AlZVrDj+bO8Z2q/u+FKiNixaNEhQ1OUX
 Wo8UZT/iS/PRyTMF24rLS2H6WfLo6czJPv8g1PkMyr7ad9oVra
 FldoGBmFp9RFfUh/SurVYyreir/fQtQZkJQn9uCqStFX+IKPG7
 aBBL4FhylWQrqhCXedPX71ngq0d2kIhyy1/3nK8D/VQPn6Fn+M
 SVnAsxb2dIGL/5C3PdHdJxWeBUPZmZKdmFvQ3OqfT+q/i+idaL
 EPheW4tXfOWOCESwQA4/APD3PAGRKZxd/yLmM8cwCl8CVV3xo9
 1+7ZCkwYdXP6faqQB6Pc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189087>

Hi,


> Nathan Bullock <nathanbullock@gmail.com> writes:
>=20
> > I have for a number of years had the following in my .bashrc
> >
> > alias br=3D"git branch"
> > complete -F _git_branch br
> >
> > As well as similar commands for co and log.
> >
> > Recently though this broke, now when I type something like "br
> > mas<command completion>" it will occasionally complain with message=
s
> > like:
> > bash: [: 1: unary operator expected
> >
> > From digging through the source it looks like this was broken back =
in
> > April. (The commit is show at the bottom of this email.)
> >
> > So my questions are:
> > 1. Is it reasonable for things like _git_branch to work as a
> > standalone autocompletion function instead of having to go through
> > _git? I certainly like it to work as a standalone function. I also =
use
> > it to add autocompletion to other bash scripts that I use frequentl=
y.
> >
> > 2. If I add code that verifies that the variable cword exists at th=
e
> > start of these functions and only if not call something like
> > _get_comp_words_by_ref -n =3D: cur words cword prev. Would that be
> > reasonable?

That would be too fragile, it will break if $cword is set in the
environment from which you invoke _git_<cmd>() completion functions
directly (i.e. not though _git()).

> > I think this should address the performance concerns that
> > caused these to be removed in the first place, but it may make the
> > code uglier.

Actually it was not a performance problem, but a cleanup in a patch
series to fix a zsh-related bug.  Without this cleanup the bugfix
would have been much more intrusive.

  http://thread.gmane.org/gmane.comp.version-control.git/172142/focus=3D=
172369


> > I have already added wrapper functions in my bashrc so that this is=
 no
> > longer a problem for me, but there may be other people who start
> > hitting this as well once they start using newer versions of git.

This issue was reported earlier, so it seems there are people who
would like to use it.  But getting $cur, $cword, etc. variables right
in _git_<cmd>() completion functions is just part of the problem,
there are other issues, as mentioned in the previous thread:

  http://thread.gmane.org/gmane.comp.version-control.git/185184/focus=3D=
185232

Unfortunately, I couldn't come up with a solution yet that doesn't
introduce too much code churn and doesn't cause yet another
inconsistency between bash and zsh.  I also haven't looked whether
there are other issues similar to that with _git_fetch() mentioned on
the above link.


Best,
G=E1bor
