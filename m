From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Sat, 13 Feb 2016 11:57:23 -0500
Message-ID: <20160213165722.GA30144@sigill.intra.peff.net>
References: <56B32953.2010908@gmail.com>
 <20160204111307.GA30495@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602041216240.2964@virtualbox>
 <20160213002122.Horde.mxoPmZIuCikpV2PO97l11AI@webmail.informatik.kit.edu>
 <20160212234041.GA15688@sigill.intra.peff.net>
 <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 13 17:57:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUdVi-0006HY-Jg
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 17:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbcBMQ50 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2016 11:57:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:41516 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750980AbcBMQ5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 11:57:25 -0500
Received: (qmail 8051 invoked by uid 102); 13 Feb 2016 16:57:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 11:57:25 -0500
Received: (qmail 26740 invoked by uid 107); 13 Feb 2016 16:57:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 11:57:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 11:57:23 -0500
Content-Disposition: inline
In-Reply-To: <20160213020712.Horde.SM-rQbc5Jx1UwdYxdvNFNJx@webmail.informatik.kit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286115>

On Sat, Feb 13, 2016 at 02:07:12AM +0100, SZEDER G=C3=A1bor wrote:

> >So I think switching to :strip is an improvement in both correctness
> >_and_ performance.
>=20
> Right.  I was more worried about __git_refs(), because it asks for
> everything under refs/heads/, refs/tags/ and refs/remotes/, and its
> output is used in a lot more places and fed to a lot more commands th=
an
> the output of __git_heads() (or __git_tags(), for that matter).  But =
I
> thought that a branch-tag ambiguity would cause git to error out
> complaining, just like in the case of ref-path ambiguity.  Successful=
ly
> avoiding ambiguous refs for many years, I wasn't aware that 'git
> rev-parse' doesn't barf, but only warns and resolves the ambiguity in
> favor of the tag.

Yeah, switching to :strip would arguably be a regression when completin=
g
all refs. Right now, you'd get "heads/foo" and "tags/foo" as part of
your completion (but _not_ just "foo"), and either works as a
non-ambiguous ref.

With :strip, you'd just get "foo" twice, and if you use the result of
the completion, it will always point to the tag.

So it is arguably worse. I still think it is worth trading off for
performance, but it is worth acknowledging in the commit message there
that it is a tradeoff.

> >I think it does already, since 4917e1e (Makefile: promote wildmatch =
to
> >be the default fnmatch implementation, 2013-05-30).
>=20
> Things are looking up!
> [...vast improvement in times...]

Very cool. I look forward to seeing the final patch. :)

I have noticed in my pathological 10-million-ref bare repositories
(don't ask) that the __git_ps1() prompt is quite slow, too. And I
wondered if it could be related.

But I don't think it is. It's just literally that painful to look at th=
e
packed-refs at all, and "git rev-parse HEAD" has to look at them to
resolve.

-Peff
