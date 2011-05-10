From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array subscript"
Date: Wed, 11 May 2011 00:39:35 +0200
Message-ID: <20110510223935.GA31029@goldbirke>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
	<20110510203101.GG14456@sigill.intra.peff.net>
	<20110510203943.GH14456@sigill.intra.peff.net>
	<BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
	<20110510210116.GA25224@sigill.intra.peff.net>
	<BANLkTin9=7y+2eqUgo_ObcYeGs3TQ7YMGw@mail.gmail.com>
	<20110510211016.GB26231@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 11 00:39:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJvap-0001FN-I5
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 00:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749Ab1EJWjq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 18:39:46 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:64139 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1EJWjp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 18:39:45 -0400
Received: from localhost6.localdomain6 (p5B130BE1.dip0.t-ipconnect.de [91.19.11.225])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MNATs-1QM6Ns1JWK-006brg; Wed, 11 May 2011 00:39:36 +0200
Content-Disposition: inline
In-Reply-To: <20110510211016.GB26231@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:9H3OHxulvTuFOL7O3b6G1j+2SudQeDsfWAFgzA/Gjv4
 jlSQV1mXw5tP5nIw/qDU2wg3XfC0O8yHB0w9/rsvbGvYoi6y0K
 MLgwnAoO52EZntRJ7Q0+ecaNL9tIUy/DyiWbxE2dN/4T1efTeJ
 Qj46RlaNEpEZl7NhMG9aaXVq1zbRuxrxpxi9Qqmolx4id05Sys
 VBbFRfHDASvdjzS6RhcRA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173377>

Hi,


On Tue, May 10, 2011 at 05:10:16PM -0400, Jeff King wrote:
> On Tue, May 10, 2011 at 11:02:53PM +0200, Sverre Rabbelier wrote:
>=20
> > On Tue, May 10, 2011 at 23:01, Jeff King <peff@peff.net> wrote:
> > > Right. Bash calls into our __git() completion function, which cal=
ls the
> > > implementation of _get_comp_words_by_ref from /etc/bash_completio=
n,
> > > which has the bug. If you don't source git completion, then you a=
re just
> > > getting bash's default file completion.
> >=20
> > So should we file this bug with bash's completion people?
>=20
> Probably, but it would be nice to reduce it to a smaller test case (o=
r
> one that happens just with completions shipped by Debian) just to rul=
e
> out anything git is doing.

Thinking a bit more about it, you don't even need to search history to
reproduce.  Try this:

  _foo ()
  {
          local prev
          _get_comp_words_by_ref prev
  }
  complete -F _foo foo

Then type "foo", go back to the very beginning of the command line,
and then press TAB, and the same "bash: words: bad array subscript"
error appears.

So the bug is definitely not git-related.  The fix would be a check
along the lines of the first two hunks of the patch I just sent out.
Oddly enough, the bash-completion folks had a similar check in the now
deprecated _get_pword() function, that didn't made it into
_get_comp_words_by_ref()...


Best,
G=E1bor
