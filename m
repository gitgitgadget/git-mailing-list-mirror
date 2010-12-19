From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not
 valid
Date: Sun, 19 Dec 2010 15:10:59 +0300
Message-ID: <20101219121059.GA10985@landau.phys.spbu.ru>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
 <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
 <20101218161337.GB18643@sigill.intra.peff.net>
 <20101218205514.GA21249@landau.phys.spbu.ru>
 <7vk4j6fnta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Cl??ment Poulain <clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 13:13:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUI91-0000Jk-V2
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 13:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab0LSMLC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Dec 2010 07:11:02 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:53839 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785Ab0LSMLB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 07:11:01 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id 69C9CFF713; Sun, 19 Dec 2010 15:10:59 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7vk4j6fnta.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163957>

On Sat, Dec 18, 2010 at 07:23:29PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>=20
> > Thanks for your ACK and for the explanation.
> >
> > My last patches to git were blame related so semi-intuitively I kne=
w
> > that invalid sha1 are coming from files in worktree. Your descripti=
on
> > makes things much more clear and I'd put it into patch log as well.
> > What is the best practice for this? For me to re-roll, or for Junio=
 to
> > merge texts?
>=20
> Re-rolling to explain changes in your own words is preferred; thanks.

I see, thanks.

I'm not that familiar with git internals involved, so here is updated
patch with added paragraph about "df->sha1_valid=3D0 means files from
worktree with unknown sha1", and appropriate excerpt from Jeff's post.
That's the most reasonable I could come up with.

Thanks,
Kirill

P.S. please don't forget to pick patch 1 which is unchanged.



---- 8< ----

=46rom: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Date: Sat, 18 Dec 2010 16:27:28 +0300
Subject: [PATCH v2 2/2] fill_textconv(): Don't get/put cache if sha1 is=
 not valid
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

It turned out, under blame there are requests to fill_textconv() with
sha1=3D0000000000000000000000000000000000000000 and sha1_valid=3D0.

As the code did not analyzed sha1 validity, we ended up putting 000000
into textconv cache which was fooling later blames to discover lots of
lines in 'Not Yet Committed' state.

In practice df->sha1_valid=3D0 means blame requests to run textconv on =
a
file in worktree whose sha1 is not know yet.

=46ix it.

On Sat, Dec 18, 2010 at 11:13:37AM -0500, Jeff King wrote:
>=20
> In short:
>=20
>   Acked-by: Jeff King <peff@peff.net>
>=20
> But it took some thinking to convince myself, so the long answer is
> below if anyone cares.
>=20
> I was dubious at first that this could be the right solution. We stil=
l
> end up putting the filespec through run_textconv, which didn't seem
> right if it is not valid.
>=20
> But reading into it more, there are two levels of invalidity:
>=20
>   1. !DIFF_FILE_VALID(df) - we are not a valid file at all. I.e., we =
are
>      /dev/null.
>=20
>   2. !df->sha1_valid - we are pointing to a working tree file whose s=
ha1
>      we don't know
>=20
> I think level (2) never happens at all in the regular diff code, whic=
h
> is why this case was completely unhandled. But it is OK in that case
> (required, even) to put the contents through run_textconv.

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=D1=86=E2=95=98ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Acked-by: Jeff King <peff@peff.net>
---
 diff.c                    |    4 ++--
 t/t8006-blame-textconv.sh |    3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 0a43869..5422c43 100644
--- a/diff.c
+++ b/diff.c
@@ -4412,7 +4412,7 @@ size_t fill_textconv(struct userdiff_driver *driv=
er,
 		return df->size;
 	}
=20
-	if (driver->textconv_cache) {
+	if (driver->textconv_cache && df->sha1_valid) {
 		*outbuf =3D notes_cache_get(driver->textconv_cache, df->sha1,
 					  &size);
 		if (*outbuf)
@@ -4423,7 +4423,7 @@ size_t fill_textconv(struct userdiff_driver *driv=
er,
 	if (!*outbuf)
 		die("unable to read files to diff");
=20
-	if (driver->textconv_cache) {
+	if (driver->textconv_cache && df->sha1_valid) {
 		/* ignore errors, as we might be in a readonly repository */
 		notes_cache_put(driver->textconv_cache, df->sha1, *outbuf,
 				size);
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index fe90541..ea64cd8 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -81,8 +81,7 @@ cat >expected_one <<EOF
 (Number2 2010-01-01 20:00:00 +0000 1) converted: test 1 version 2
 EOF
=20
-# one.bin is blamed as 'Not Committed yet'
-test_expect_failure 'blame --textconv works with textconvcache' '
+test_expect_success 'blame --textconv works with textconvcache' '
 	git blame --textconv two.bin >blame &&
 	find_blame <blame >result &&
 	test_cmp expected result &&
--=20
1.7.3.4.570.g14308
