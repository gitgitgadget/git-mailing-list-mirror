From: Jeff King <peff@peff.net>
Subject: [PATCH] parse_color: fix return value for numeric color values 0-8
Date: Tue, 20 Jan 2015 17:14:48 -0500
Message-ID: <20150120221447.GB18778@peff.net>
References: <xmqqmw5n5z8i.fsf@gitster.dls.corp.google.com>
 <CACBZZX5s1rZ3exktbisseJSjF8-0=8ByMpBpARy6h+=iP7wEyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 23:14:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDh4Y-0000HM-IF
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 23:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbbATWOu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jan 2015 17:14:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:36577 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750727AbbATWOt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 17:14:49 -0500
Received: (qmail 15514 invoked by uid 102); 20 Jan 2015 22:14:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 16:14:49 -0600
Received: (qmail 24484 invoked by uid 107); 20 Jan 2015 22:15:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 20 Jan 2015 17:15:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Jan 2015 17:14:48 -0500
Content-Disposition: inline
In-Reply-To: <CACBZZX5s1rZ3exktbisseJSjF8-0=8ByMpBpARy6h+=iP7wEyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262699>

On Tue, Jan 20, 2015 at 10:49:32PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> I've had this in my .gitconfig since 2010 which was broken by Jeff's
> v2.1.3-24-g695d95d:
>=20
>     ;; Don't be so invasive about coloring ^M when I'm editing files
> that
>     ;; are supposed to have \r\n.
>     [color "diff"]
>        whitespace =3D 0
>
> [...]
> Maybe breaking this is OK (but I can't find what the replacement is),
> but the config or the the changelog doesn't mention breaking existing
> config settings.

Eek. Definitely an unintended regression. The fix is below. Thanks for
reporting (and especially for catching during the -rc period!).

You should not need it, but for reference, using "0" is the same as
"black" (both in old git and new).

-- >8 --
When commit 695d95d refactored the color parsing, it missed
a "return 0" when parsing literal numbers 0-8 (which
represent basic ANSI colors), leading us to report these
colors as an error.

Signed-off-by: Jeff King <peff@peff.net>
---
 color.c          | 1 +
 t/t4026-color.sh | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/color.c b/color.c
index 809b359..9027352 100644
--- a/color.c
+++ b/color.c
@@ -112,6 +112,7 @@ static int parse_color(struct color *out, const cha=
r *name, int len)
 		} else if (val < 8) {
 			out->type =3D COLOR_ANSI;
 			out->value =3D val;
+			return 0;
 		} else if (val < 256) {
 			out->type =3D COLOR_256;
 			out->value =3D val;
diff --git a/t/t4026-color.sh b/t/t4026-color.sh
index 267c43b..4d20fea 100755
--- a/t/t4026-color.sh
+++ b/t/t4026-color.sh
@@ -60,6 +60,10 @@ test_expect_success 'absurdly long color specificati=
on' '
 	  "[1;2;4;5;7;22;24;25;27;38;2;255;255;255;48;2;255;255;255m"
 '
=20
+test_expect_success '0-7 are aliases for basic ANSI color names' '
+	color "0 7" "[30;47m"
+'
+
 test_expect_success '256 colors' '
 	color "254 bold 255" "[1;38;5;254;48;5;255m"
 '
--=20
2.2.1.425.g441bb3c
