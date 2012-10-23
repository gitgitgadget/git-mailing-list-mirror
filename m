From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] fix git-config with duplicate variable entries
Date: Tue, 23 Oct 2012 18:35:02 -0400
Message-ID: <20121023223502.GA23194@sigill.intra.peff.net>
References: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
 <20121022211505.GA3301@sigill.intra.peff.net>
 <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:35:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQn4D-0007pT-LX
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 00:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab2JWWfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Oct 2012 18:35:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51668 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab2JWWfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 18:35:06 -0400
Received: (qmail 23175 invoked by uid 107); 23 Oct 2012 22:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 23 Oct 2012 18:35:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Oct 2012 18:35:02 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX5mOb7_i9r8AqNK5V3r-gVnzN+rkeY9xrhecGv1rS-anA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208261>

On Tue, Oct 23, 2012 at 04:13:44PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > It fails a few tests in t1300, but it looks like those tests are te=
sting
> > for the behavior we have identified as wrong, and should be fixed.
>=20
> I think this patch looks good.

Thanks. It had a few minor flaws (like a memory leak). I fixed those,
updated the tests, and split it out into a few more readable commits. I=
n
the process, I managed to uncover and fix a few other memory leaks in
the area. I think this version is much more readable, and writing the
rationale for patch 7 convinced me that it's the right thing to do.
Another round of review would be appreciated.

  [1/8]: t1300: style updates
  [2/8]: t1300: remove redundant test
  [3/8]: t1300: test "git config --get-all" more thoroughly
  [4/8]: git-config: remove memory leak of key regexp
  [5/8]: git-config: fix regexp memory leaks on error conditions
  [6/8]: git-config: collect values instead of immediately printing
  [7/8]: git-config: do not complain about duplicate entries
  [8/8]: git-config: use git_config_with_options

=46or those just joining us, the interesting bit is patch 7, which fixe=
s
some inconsistencies between the "git-config" tool and how the internal
config callbacks work.

> One other thing I think is worth clarifying (and I think should be
> broken) is if you write a configuration like:
>=20
>     [foo]
>         bar =3D one
>     [foo]
>         bar =3D two
>     [foo]
>         bar =3D three
>=20
> "git-{config,var} -l" will both give you:
>=20
>     foo.bar=3Done
>     foo.bar=3Dtwo
>     foo.bar=3Dthree

Yes, that looks right.

> And git config --get foo.bar will give you:
>=20
>     $ git config -f /tmp/test --get foo.bar
>     one
>     error: More than one value for the key foo.bar: two
>     error: More than one value for the key foo.bar: three
>=20
> I think that it would be better if the config mechanism just silently
> overwrote keys that clobbered earlier keys like your patch does.

Right.

> But in addition can we simplify things for the consumers of
> "git-{config,var} -l" by only printing:
>=20
>     foo.bar=3Dthree
>=20
> Or are there too many variables like "include.path" that can
> legitimately appear more than once.

No. Some variables can legitimately appear multiple times. E.g.,
remote.*.fetch, remote.*.push, and remote.*.url. Probably more that I a=
m
forgetting. There are not many, but they do exist.

It's OK to tweak the regular "get" for them, since they are already
broken for that case[1]. You need to use "--get-all" if you expect the
variable to have multiple values.  But when we are listing, we do not
have the hint as to what is expected, and we need to show all entries.

-Peff

[1] So the one useful thing that the current duplicate check is doing i=
s
    flagging errors where you wanted to use --get-all, but forgot to.
    However, it's not really a sufficient safeguard anyway, since it
    would not catch cases where the list was split across multiple
    files (which does work with the internal callbacks that handle
    lists, since they never even see that multiple files are involved).
    It's much more important for git-config to be consistent with the
    internal parsing behavior.
