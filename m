From: Jeff King <peff@peff.net>
Subject: Re: 1e633418479926bc85ed21a4f91c845a3dd3ad66 breaks on OSX
Date: Tue, 5 Oct 2010 17:34:02 -0400
Message-ID: <20101005213401.GA22845@sigill.intra.peff.net>
References: <86r5g42wo8.fsf@red.stonehenge.com>
 <AANLkTinq7haFRs6h8W+ycDy5MzFgjty6LaD8syL+KnHX@mail.gmail.com>
 <86iq1g2vhq.fsf@red.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 23:33:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3F8t-0005xy-3T
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 23:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565Ab0JEVdm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 17:33:42 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49172 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751042Ab0JEVdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 17:33:41 -0400
Received: (qmail 3723 invoked by uid 111); 5 Oct 2010 21:33:40 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 05 Oct 2010 21:33:40 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Oct 2010 17:34:02 -0400
Content-Disposition: inline
In-Reply-To: <86iq1g2vhq.fsf@red.stonehenge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158251>

On Tue, Oct 05, 2010 at 02:13:53PM -0700, Randal L. Schwartz wrote:

> >>>>> "=C3=86var" =3D=3D =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> writes:
>=20
> =C3=86var> 1e63341 is a merge commit, and none of the merged things (=
in the
> =C3=86var> commit message) seem to have anything to do with the Perl =
makefile
> =C3=86var> process.
>=20
> =C3=86var> Can you run:
>=20
> =C3=86var>     make -j 1 V=3D1
>=20
> =C3=86var> And report what output you get?
>=20
> Oddly enough, just rerunning the make again *worked*.
>=20
> That's scary.
>=20
> And therefore also not bisectable. :(
>=20
> I imagine there's some heisenbug in there, that we'll probably trip o=
ver
> later.

This has come up before, but nobody has managed to track it down. I did
some looking at it in the past, but this is all I could find:

  http://article.gmane.org/gmane.comp.version-control.git/117710

If my analysis there is right, we could probably protect against it wit=
h
something like:

diff --git a/Makefile b/Makefile
index 25f94b0..aaef528 100644
--- a/Makefile
+++ b/Makefile
@@ -1596,6 +1596,10 @@ ifndef NO_PYTHON
 endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) SHELL_PATH=3D'$(SHELL_PATH=
_SQ)' PERL_PATH=3D'$(PERL_PATH_SQ)'
=20
+ifndef NO_PERL
+all:: perl/perl.mak
+endif
+
 please_set_SHELL_PATH_to_a_more_modern_shell:
 	@$$(:)
=20

But of course it's hard to test.

-Peff
