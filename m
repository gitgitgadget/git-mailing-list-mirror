From: Jeff King <peff@peff.net>
Subject: Re: Using really empty start prefixes for git-format-patch numbered
 patches?
Date: Mon, 30 May 2011 10:19:05 -0400
Message-ID: <20110530141905.GA31490@sigill.intra.peff.net>
References: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Delanoy <frederic.delanoy@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 16:19:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3JN-0005YU-UT
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab1E3OTK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 10:19:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39021
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab1E3OTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 10:19:09 -0400
Received: (qmail 15135 invoked by uid 107); 30 May 2011 14:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 10:19:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 10:19:05 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikVQWN2kZ4gc8kd-kJWZhLXgkvTAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174746>

On Sat, May 28, 2011 at 11:57:01PM +0200, Fr=C3=A9d=C3=A9ric Delanoy wr=
ote:

> I'm trying to generate numbered patches using git-format-patch such
> that I get e.g. [1/2] instead of [PATCH 1/2]
>=20
> However, if I use an empty string as prefix, for instance in
>=20
> git-format-patch --subject-prefix=3D"" -2
>=20
> an extraneous space is inserted, and I get [ 1/2] instead of desired
> [1/2] in the Subject line
>=20
> (I also tried using a single backspace char as prefix, but that didn'=
t
> change anything, as might have been expected)
>=20
> Is there a way to get rid of this space? IMO the space should only be
> added if the prefix is non-empty

I don't think there is currently a way to do what you want short of
post-processing the output of format-patch. You can use "-k" to preserv=
e
the subject, but then you don't get the "1/2" that you want.

So I think we should do this:

-- >8 --
Subject: [PATCH] format-patch: make zero-length subject prefixes pretti=
er

If you give a zero-length subject prefix to format-patch
(e.g., "format-patch --subject-prefix=3D"), we will print the
ugly:

  Subject: [ 1/2] your subject here

because we always insert a space between the prefix and
numbering. Requiring the user to provide the space in their
prefix would be more flexible, but would break existing
usage. This patch provides a DWIM and suppresses the space
for zero-length prefixes, under the assumption that nobody
actually wants "[ 1/2]".

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c              |    3 ++-
 t/t4014-format-patch.sh |   18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2a1e3a9..296f417 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -294,8 +294,9 @@ void log_write_email_headers(struct rev_info *opt, =
struct commit *commit,
 	if (opt->total > 0) {
 		static char buffer[64];
 		snprintf(buffer, sizeof(buffer),
-			 "Subject: [%s %0*d/%d] ",
+			 "Subject: [%s%s%0*d/%d] ",
 			 opt->subject_prefix,
+			 *opt->subject_prefix ? " " : "",
 			 digits_in_number(opt->total),
 			 opt->nr, opt->total);
 		subject =3D buffer;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 045cee3..92248d2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -851,4 +851,22 @@ test_expect_success 'subject lines do not have 822=
 atom-quoting' '
 	test_cmp expect actual
 '
=20
+cat >expect <<'EOF'
+Subject: [PREFIX 1/1] header with . in it
+EOF
+test_expect_success 'subject prefixes have space prepended' '
+	git format-patch -n -1 --stdout --subject-prefix=3DPREFIX >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<'EOF'
+Subject: [1/1] header with . in it
+EOF
+test_expect_success 'empty subject prefix does not have extra space' '
+	git format-patch -n -1 --stdout --subject-prefix=3D >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.5.3.12.g99e25
