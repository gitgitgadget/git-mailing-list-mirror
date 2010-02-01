From: Jeff King <peff@peff.net>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 1 Feb 2010 06:32:13 -0500
Message-ID: <20100201113213.GA22663@coredump.intra.peff.net>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?RWxsacOp?= Computing Open Source Program 
	<opensource@elliecomputing.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 12:32:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbuW1-0005yY-W3
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 12:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab0BALcS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 06:32:18 -0500
Received: from peff.net ([208.65.91.99]:33493 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023Ab0BALcR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 06:32:17 -0500
Received: (qmail 24633 invoked by uid 107); 1 Feb 2010 11:32:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 06:32:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 06:32:13 -0500
Content-Disposition: inline
In-Reply-To: <7E88665723814E46BCBA1A39E84C27A5@elrond>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138601>

On Mon, Feb 01, 2010 at 11:48:29AM +0100, Elli=C3=A9 Computing Open Sou=
rce Program wrote:

> C:\temp\scc-tests\git>git ls-tree -r HEAD "caract=C3=A8re sp=C3=A9cia=
l"
> 100644 blob bf10a8b39e72c754ee1872fcdb13662cba6a8880    "caract\350re
> sp\351cial/\272plouf.txt"
>=20
> Note the spurious \272 which comes in the listing :(
> Trying again the same commands may give other spurious characters
> (each time we tried we get different _bad_ responses)

Looks like a bug. I was able to replicate it here, and valgrind notices
it, too:

  =3D=3D22720=3D=3D Invalid read of size 1
  =3D=3D22720=3D=3D    at 0x80E77FF: next_quote_pos (quote.c:174)
  =3D=3D22720=3D=3D    by 0x80E783A: quote_c_style_counted (quote.c:215=
)
  =3D=3D22720=3D=3D    by 0x80E7D14: write_name_quotedpfx (quote.c:286)
  =3D=3D22720=3D=3D    by 0x80808F3: show_tree (builtin-ls-tree.c:114)
  =3D=3D22720=3D=3D    by 0x811000D: read_tree_recursive (tree.c:114)
  =3D=3D22720=3D=3D    by 0x81100E7: read_tree_recursive (tree.c:131)
  =3D=3D22720=3D=3D    by 0x8080CC2: cmd_ls_tree (builtin-ls-tree.c:173=
)
  =3D=3D22720=3D=3D    by 0x804B7FA: run_builtin (git.c:257)
  =3D=3D22720=3D=3D    by 0x804B958: handle_internal_command (git.c:412=
)
  =3D=3D22720=3D=3D    by 0x804BA2F: run_argv (git.c:454)
  =3D=3D22720=3D=3D    by 0x804BB97: main (git.c:525)
  =3D=3D22720=3D=3D  Address 0x43405b4 is 0 bytes after a block of size=
 20 alloc'd
  =3D=3D22720=3D=3D    at 0x4024C4C: malloc (vg_replace_malloc.c:195)
  =3D=3D22720=3D=3D    by 0x8115739: xmalloc (wrapper.c:20)
  =3D=3D22720=3D=3D    by 0x811005E: read_tree_recursive (tree.c:127)
  =3D=3D22720=3D=3D    by 0x8080CC2: cmd_ls_tree (builtin-ls-tree.c:173=
)
  =3D=3D22720=3D=3D    by 0x804B7FA: run_builtin (git.c:257)
  =3D=3D22720=3D=3D    by 0x804B958: handle_internal_command (git.c:412=
)
  =3D=3D22720=3D=3D    by 0x804BA2F: run_argv (git.c:454)
  =3D=3D22720=3D=3D    by 0x804BB97: main (git.c:525)

The patch below fixes it for me. This is the first time I've ever looke=
d
at this code, though, so an extra set of eyes is appreciated. I'm also
not sure of the "!p[len]" termination that the loop uses (quoted in the
context below). The string is explicitly not NUL-terminated, so why
would that matter? I think that may have been covering up the bug in
some cases.

-- >8 --
Subject: [PATCH] fix invalid read in quote_c_style_counted

We progress through a length-bounded string, looking for
characters in need of quoting. After each character is
found, we output everything up until that character
literally, then the quoted character. We then advance our
string and look again.  However, we never actually
decremented the length, meaning we ended up looking at
whatever random junk was stored after the string.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/quote.c b/quote.c
index acb6bf9..392006d 100644
--- a/quote.c
+++ b/quote.c
@@ -216,20 +216,21 @@ static size_t quote_c_style_counted(const char *n=
ame, ssize_t maxlen,
 		if (len =3D=3D maxlen || !p[len])
 			break;
=20
 		if (!no_dq && p =3D=3D name)
 			EMIT('"');
=20
 		EMITBUF(p, len);
 		EMIT('\\');
 		p +=3D len;
 		ch =3D (unsigned char)*p++;
+		maxlen -=3D len + 1;
 		if (sq_lookup[ch] >=3D ' ') {
 			EMIT(sq_lookup[ch]);
 		} else {
 			EMIT(((ch >> 6) & 03) + '0');
 			EMIT(((ch >> 3) & 07) + '0');
 			EMIT(((ch >> 0) & 07) + '0');
 		}
 	}
=20
 	EMITBUF(p, len);
--=20
1.7.0.rc1.16.g21332.dirty
