From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Fri, 12 Feb 2016 18:40:42 -0500
Message-ID: <20160212234041.GA15688@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
 <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 00:40:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUNKS-00019z-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 00:40:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbcBLXkp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2016 18:40:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:41294 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbcBLXko (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 18:40:44 -0500
Received: (qmail 26316 invoked by uid 102); 12 Feb 2016 23:40:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 18:40:44 -0500
Received: (qmail 20954 invoked by uid 107); 12 Feb 2016 23:40:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 18:40:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 18:40:42 -0500
Content-Disposition: inline
In-Reply-To: <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286095>

On Sat, Feb 13, 2016 at 12:21:22AM +0100, SZEDER G=C3=A1bor wrote:

> I think in this case we should opt for performance instead of correct=
ness,
> and use Peff's 'refname:strip=3D2'.  Ambiguous refs will only hurt yo=
u, if,
> well, your repo actually has ambiguous refs AND you happen to want to=
 do
> something with one of those refs.  I suspect that's rather uncommon, =
and
> even then you could simply rename one of those refs.  OTOH, as shown =
in
> the ticket, you don't need that many refs to make refs completion
> unacceptably slow on Windows, and it will bite every time you attempt=
 to
> complete a ref.

I'm not even sure that this is a correctness tradeoff at all. For
example, in the function __git_heads(), we are asking for-each-ref to
tell us about everything under refs/heads/. If you have a refs/heads/fo=
o
and refs/tags/foo, we don't care; we are trying to print the unqualifie=
d
branch names. And in fact having refname:short print "heads/foo" in thi=
s
case may be actively wrong. For instance, in _git_branch(), you cannot
use the resulting completion of "heads/foo", as that command wants
unqualified names in "refs/heads/", and you do not have
"refs/heads/heads/foo".

So I think switching to :strip is an improvement in both correctness
_and_ performance.

> Now, if 'git for-each-ref' could understand '**' globbing, not just
> fnmatch...

I think it does already, since 4917e1e (Makefile: promote wildmatch to
be the default fnmatch implementation, 2013-05-30).

-Peff
