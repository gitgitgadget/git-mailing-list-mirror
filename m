From: Jeff King <peff@peff.net>
Subject: Re: config-file includes
Date: Mon, 26 Sep 2011 22:38:45 -0400
Message-ID: <20110927023845.GC6920@sigill.intra.peff.net>
References: <20110923195829.GA27677@sigill.intra.peff.net>
 <CACsJy8BAVRAct=sxTpZ+b-ft1OjbY9oZG6uEXrcsTXw3CXnwSg@mail.gmail.com>
 <20110926192126.GA55743@gmail.com>
 <20110926200553.GA492@sigill.intra.peff.net>
 <CAG+J_Dw3B0qReTevph725sPatpKDzikC=W0XTvKo4GsYLVcL4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 04:38:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8NZN-0005Hh-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 04:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056Ab1I0Cis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 22:38:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44956
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000Ab1I0Cis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 22:38:48 -0400
Received: (qmail 19358 invoked by uid 107); 27 Sep 2011 02:43:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Sep 2011 22:43:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2011 22:38:45 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_Dw3B0qReTevph725sPatpKDzikC=W0XTvKo4GsYLVcL4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182204>

On Mon, Sep 26, 2011 at 10:13:44PM -0400, Jay Soffian wrote:

> > We could allow arbitrary shell code like:
> >
> > =C2=A0[include-if "test `uname -s` -eq Darwin"]
> >
> > Very flexible, though it makes me think we are getting a little
> > overboard. =C2=A0And it's an extra shell invocation whenever we rea=
d the
> > config, which is ugly.
>=20
> I would think git could just learn a few useful defines at the time o=
f
> compile, such as e.g. OS_Darwin would be more than sufficient.

Yeah, I think that is probably more sane. We don't collect the
information now, but it probably wouldn't be that hard (at the very
worst, it would probably just involve running "uname" at build time).

> I can also give you another use use case. I keep all my work repos
> under ~Work/ and I want my user.email on all those to be my work emai=
l
> addy, and all other repos on my system I want to use my personal emai=
l
> address. So my ~/.gitconfig has my personal email address and then 99=
%
> of the time I forget to configure the repos under ~/Work correctly.
> That said, I'm not sure how the config include would help this...

You would need to provide git with some condition about which address
should be used. It sounds like the repo directory is the best bet. So
maybe something like:

  [include-ifrepo "/home/jsoffian/Work/*"]

or something. Maybe that's too gross. I dunno.

=46WIW, this hack would work even with current git:

  cat >bin/git <<\EOF
  #!/bin/sh
  case "`git rev-parse --show-toplevel`" in
  "$HOME/Work/*")
          set -- -c user.email=3Dwhatever "$@"
          ;;
  esac
  exec /path/to/real/git "$@"
  EOF

which would actually work with most of the conditionals that have been
mentioned in this thread. But it's kind of nasty.

-Peff
