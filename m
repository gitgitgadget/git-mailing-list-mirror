From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH 2/2] fill_textconv(): Don't get/put cache if sha1 is not valid
Date: Sat, 18 Dec 2010 17:54:12 +0300
Message-ID: <14308c2dd50037246e319649944d308b9f32fc39.1292681111.git.kirr@landau.phys.spbu.ru>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20Poulain?= 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 16:22:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTybn-0000dC-LE
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 16:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751Ab0LRPWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Dec 2010 10:22:00 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:34767 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179Ab0LRPV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 10:21:59 -0500
X-Greylist: delayed 1758 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Dec 2010 10:21:58 EST
Received: by landau.phys.spbu.ru (Postfix, from userid 506)
	id E1A517F1B; Sat, 18 Dec 2010 17:52:51 +0300 (MSK)
Received: from kirr by mini.zxlink with local (Exim 4.72)
	(envelope-from <kirr@mini.zxlink>)
	id 1PTyBE-0001X7-0K; Sat, 18 Dec 2010 17:54:40 +0300
X-Mailer: git-send-email 1.7.3.4.570.g14308
In-Reply-To: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
In-Reply-To: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
References: <b714f1939ef4fc73cb5f55c1d7784a08a34d3c3d.1292681111.git.kirr@landau.phys.spbu.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163913>

It turned out, under blame there are requests to fill_textconv() with
sha1=3D0000000000000000000000000000000000000000 and sha1_valid=3D0.

As the code did not analyzed sha1 validity, we ended up putting 000000
into textconv cache which was fooling later blames to discover lots of
lines in 'Not Yet Committed' state.

=46ix it.

Cc: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
Cc: Cl=C3=A9ment Poulain <clement.poulain@ensimag.imag.fr>
Cc: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Cc: Jeff King <peff@peff.net>
Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
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
