From: Jeff King <peff@peff.net>
Subject: Re: Problems with git 1.8.5.3 on HP-UX 11.11
Date: Fri, 28 Mar 2014 15:01:56 -0400
Message-ID: <20140328190156.GA30739@sigill.intra.peff.net>
References: <9D24AD27564FAE4CB8D0C15D080DEFCB0106A89226@m4ukex08.intranet.macro4.com>
 <8FDD21D28EC16844948E2A773083574A03363EBC@m4ukex08.intranet.macro4.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gerhard Grimm <gerhard.grimm@detec.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:02:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTc2W-00045M-GD
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaC1TB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Mar 2014 15:01:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:49526 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751782AbaC1TB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:01:58 -0400
Received: (qmail 597 invoked by uid 102); 28 Mar 2014 19:01:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 14:01:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 15:01:56 -0400
Content-Disposition: inline
In-Reply-To: <8FDD21D28EC16844948E2A773083574A03363EBC@m4ukex08.intranet.macro4.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245414>

On Fri, Mar 28, 2014 at 11:09:14AM -0000, Gerhard Grimm wrote:

> So I examined the git source package and found that the author of the
> HP-UX port forgot to set
>=20
> PTHREAD_CFLAGS=3D-mt
>=20
> in config.mak.autogen to enable threading.

You probably want to place such manual settings in config.mak. If you
use the "./configure" script, it will overwrite config.mak.autogen.

> git submodule init
>=20
> fails with the output
>=20
> =C2=A0=C2=A0=C2=A0 Assertion failed: err =3D=3D REG_ESPACE, file comp=
at/regex/regexec.c, line 1096
> =C2=A0=C2=A0=C2=A0 No submodule mapping found in .gitmodules for path=
 'module'
>=20
> and the stacktrace of the resulting core dump is
>=20
> #0=C2=A0 0xc020ced0 in kill+0x10 () from /usr/lib/libc.2
> #1=C2=A0 0xc01a7f84 in raise+0x24 () from /usr/lib/libc.2
> #2=C2=A0 0xc01e9308 in abort_C+0x160 () from /usr/lib/libc.2
> #3=C2=A0 0xc01e9364 in abort+0x1c () from /usr/lib/libc.2
> #4=C2=A0 0xc0176998 in _assert+0x178 () from /usr/lib/libc.2
> #5=C2=A0 0x205fa0 in check_matching+0x290 ()
> #6=C2=A0 0x2053b8 in re_search_internal+0x128 ()
> #7=C2=A0 0x204ac0 in regexec+0xc8 ()
> #8=C2=A0 0x4da40 in collect_config+0x60 ()
> #9=C2=A0 0x108b30 in get_value+0xd8 ()
> [...]

The regexes we use here are not particularly complicated. So either
there is a bug (but nobody else has reported anything on any other
platform) or your system regex library has some problem with what we ar=
e
feeding it. The simplest solution may be to compile with:

  NO_REGEX=3DYesPlease

which will build and use the glibc implementation in compat/regex
instead.

-Peff
