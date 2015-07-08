From: Jeff King <peff@peff.net>
Subject: [PATCH] check_and_freshen_file: fix reversed success-check
Date: Wed, 8 Jul 2015 14:33:31 -0400
Message-ID: <20150708183331.GA16138@peff.net>
References: <DUB120-W5049F72955243F44BB2511F6920@phx.gbl>
 <20150707141305.GA629@peff.net>
 <DUB120-W36B78FEE6DC80BDCB05D7FF6920@phx.gbl>
 <20150707194956.GA13792@peff.net>
 <559D60DC.4010304@kdbg.org>
 <20150708180539.GA12353@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	X H <music_is_live_lg@hotmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jul 08 20:33:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCuAC-0001E2-ND
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 20:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758264AbbGHSdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 14:33:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:57705 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751621AbbGHSde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 14:33:34 -0400
Received: (qmail 26428 invoked by uid 102); 8 Jul 2015 18:33:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 13:33:34 -0500
Received: (qmail 23312 invoked by uid 107); 8 Jul 2015 18:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jul 2015 14:33:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jul 2015 14:33:31 -0400
Content-Disposition: inline
In-Reply-To: <20150708180539.GA12353@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273700>

On Wed, Jul 08, 2015 at 02:05:39PM -0400, Jeff King wrote:

> The code path should be unpack-objects.c:write_object, which calls
> sha1_file.cwrite_sha1_file, which then checks has_sha1_file(). These
> days it uses the freshen_* functions instead of the latter, which doe=
s a
> similar check.  But it does report failure if we cannot call utime() =
on
> the file, preferring to write it out instead (this is the safer choic=
e
> from a preventing-prune-corruption perspective).
>=20
> So it's possible that the sequence is:
>=20
>   - unpack-objects tries to write object 1234abcd...
>=20
>   - write_sha1_file calls freshen_loose_object
>=20
>   - we call access("12/34abcd...", F_OK) and see that it does indeed
>     exist
>=20
>   - we call utime("12/34abcd...") which fails (presumably due to EPER=
M);
>     we return failure and assume we must write out the object

=2E..or maybe in the utime() step there is actually a bug, and we repor=
t
failure for no good reason. Ugh.

-- >8 --
Subject: check_and_freshen_file: fix reversed success-check

When we want to write out a loose object file, we have
always first made sure we don't already have the object
somewhere. Since 33d4221 (write_sha1_file: freshen existing
objects, 2014-10-15), we also update the timestamp on the
file, so that a simultaneous prune knows somebody is
likely to reference it soon.

If our utime() call fails, we treat this the same as not
having the object in the first place; the safe thing to do
is write out another copy. However, the loose-object check
accidentally inverst the utime() check; it returns failure
_only_ when the utime() call actually succeeded. Thus it was
failing to protect us there, and in the normal case where
utime() succeeds, it caused us to pointlessly write out and
link the object.

This passed our freshening tests, because writing out the
new object is certainly _one_ way of updating its utime. So
the normal case of a successful utime() was inefficient, but
not wrong.

Signed-off-by: Jeff King <peff@peff.net>
---
The worst part of this is that I had the _same_ bug in the pack code
path when I initially posted what became 33d4221. Ren=C3=A9 noticed dur=
ing
review, and my fix was to invert the return value from freshen_file to
match the other functions. But of course doing that without fixing the
other caller meant I introduced the same bug there.

I'll be curious if this fixes the problem the OP is seeing. If not, the=
n
we can dig deeper into the weird EPERM problems around this particular
object database.

 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 77cd81d..721eadc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -454,7 +454,7 @@ static int check_and_freshen_file(const char *fn, i=
nt freshen)
 {
 	if (access(fn, F_OK))
 		return 0;
-	if (freshen && freshen_file(fn))
+	if (freshen && !freshen_file(fn))
 		return 0;
 	return 1;
 }
--=20
2.5.0.rc1.340.ge59e3eb
