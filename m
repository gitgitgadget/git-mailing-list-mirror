From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] archive-tar: use match_config_key when parsing config
Date: Mon, 14 Jan 2013 07:02:56 -0800
Message-ID: <20130114150256.GB16828@sigill.intra.peff.net>
References: <20130114145845.GA16497@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 16:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TulZK-0006KS-Rs
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 16:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756198Ab3ANPDB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jan 2013 10:03:01 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32902 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3ANPDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 10:03:00 -0500
Received: (qmail 19851 invoked by uid 107); 14 Jan 2013 15:04:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.144.179.211)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Jan 2013 10:04:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2013 07:02:56 -0800
Content-Disposition: inline
In-Reply-To: <20130114145845.GA16497@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213492>

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
This obviously replaces Ren=C3=A9's patch. It might make more sense to =
just
put his patch onto maint, and build this on top; then this patch can ge=
t
squashed into the next one (which just updates the uninteresting
callsites).

 archive-tar.c       | 10 +---------
 t/t5000-tar-tree.sh |  3 ++-
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 0ba3f25..68dbe59 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -325,20 +325,12 @@ static int tar_filter_config(const char *var, con=
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
+	if (match_config_key(var, "tar", &name, &namelen, &type) < 0 || !name=
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
index ecf00ed..517ae04 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -283,7 +283,8 @@ test_expect_success 'setup tar filters' '
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
1.8.1.rc1.10.g7d71f7b
