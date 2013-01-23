From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/8] archive-tar: use parse_config_key when parsing config
Date: Wed, 23 Jan 2013 01:23:27 -0500
Message-ID: <20130123062327.GB5036@sigill.intra.peff.net>
References: <20130123062132.GA2038@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Joachim Schmitz <jojo@schmitz-digital.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 07:23:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxtkV-0006je-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 07:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184Ab3AWGXb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jan 2013 01:23:31 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44596 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751855Ab3AWGXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 01:23:30 -0500
Received: (qmail 1254 invoked by uid 107); 23 Jan 2013 06:24:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jan 2013 01:24:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jan 2013 01:23:27 -0500
Content-Disposition: inline
In-Reply-To: <20130123062132.GA2038@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214283>

This is fewer lines of code, but more importantly, fixes a
bogus pointer offset. We are looking for "tar." in the
section, but later assume that the dot we found is at offset
9, not 3. This is a holdover from an earlier iteration of
767cf45 which called the section "tarfilter".

As a result, we could erroneously reject some filters with
dots in their name, as well as read uninitialized memory.

Reported by (and test by) Ren=C3=A9 Scharfe.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c       | 10 +---------
 t/t5000-tar-tree.sh |  3 ++-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index d1cce46..719b629 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -327,20 +327,12 @@ static int tar_filter_config(const char *var, con=
st char *value, void *data)
 static int tar_filter_config(const char *var, const char *value, void =
*data)
 {
 	struct archiver *ar;
-	const char *dot;
 	const char *name;
 	const char *type;
 	int namelen;
=20
-	if (prefixcmp(var, "tar."))
+	if (parse_config_key(var, "tar", &name, &namelen, &type) < 0 || !name=
)
 		return 0;
-	dot =3D strrchr(var, '.');
-	if (dot =3D=3D var + 9)
-		return 0;
-
-	name =3D var + 4;
-	namelen =3D dot - name;
-	type =3D dot + 1;
=20
 	ar =3D find_tar_filter(name, namelen);
 	if (!ar) {
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index e7c240f..3fbd366 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -212,7 +212,8 @@ test_expect_success 'setup tar filters' '
 test_expect_success 'setup tar filters' '
 	git config tar.tar.foo.command "tr ab ba" &&
 	git config tar.bar.command "tr ab ba" &&
-	git config tar.bar.remote true
+	git config tar.bar.remote true &&
+	git config tar.invalid baz
 '
=20
 test_expect_success 'archive --list mentions user filter' '
--=20
1.8.0.2.15.g815dc66
