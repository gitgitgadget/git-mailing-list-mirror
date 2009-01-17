From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] expand --pretty=format color options
Date: Sat, 17 Jan 2009 10:38:46 -0500
Message-ID: <20090117153846.GB27071@coredump.intra.peff.net>
References: <20090117152108.GA24899@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 17 16:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LODHS-0007pL-6h
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 16:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760091AbZAQPiu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jan 2009 10:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758992AbZAQPit
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 10:38:49 -0500
Received: from peff.net ([208.65.91.99]:45489 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759577AbZAQPis convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jan 2009 10:38:48 -0500
Received: (qmail 31694 invoked by uid 107); 17 Jan 2009 15:38:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Jan 2009 10:38:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Jan 2009 10:38:46 -0500
Content-Disposition: inline
In-Reply-To: <20090117152108.GA24899@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106062>

Currently, the only colors available to --pretty=3Dformat
users are red, green, and blue. Rather than expand it with a
few new colors, this patch makes the usual config color
syntax available, including more colors, backgrounds, and
attributes.

Because colors are no longer bounded to a single word (e.g.,
%Cred), this uses a more advanced syntax that features a
beginning and end delimiter (but the old syntax still
works). So you can now do:

  git log --pretty=3Dtformat:'%C(yellow)%h%C(reset) %s'

to emulate --pretty=3Doneline, or even

  git log --pretty=3Dtformat:'%C(cyan magenta bold)%s%C(reset)'

if you want to relive the awesomeness of 4-color CGA.

Signed-off-by: Jeff King <peff@peff.net>
---
Ren=C3=A9: I saw you mention an end goal of implementing the other --pr=
etty
formats in terms of --pretty=3Dformat:. So maybe this will help just a
little.

 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   12 ++++++++++++
 t/t6006-rev-list-format.sh       |    9 ++++++++-
 3 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index 0a8a948..3d87d3e 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -124,6 +124,7 @@ The placeholders are:
 - '%Cgreen': switch color to green
 - '%Cblue': switch color to blue
 - '%Creset': reset color
+- '%C(...)': color specification, as described in color.branch.* confi=
g option
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%x00': print a byte from a hex code
diff --git a/pretty.c b/pretty.c
index 343dca5..b1b8620 100644
--- a/pretty.c
+++ b/pretty.c
@@ -6,6 +6,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "log-tree.h"
+#include "color.h"
=20
 static char *user_format;
=20
@@ -554,6 +555,17 @@ static size_t format_commit_item(struct strbuf *sb=
, const char *placeholder,
 	/* these are independent of the commit */
 	switch (placeholder[0]) {
 	case 'C':
+		if (placeholder[1] =3D=3D '(') {
+			const char *end =3D strchr(placeholder + 2, ')');
+			char color[COLOR_MAXLEN];
+			if (!end)
+				return 0;
+			color_parse_mem(placeholder + 2,
+					end - (placeholder + 2),
+					"--pretty format", color);
+			strbuf_addstr(sb, color);
+			return end - placeholder + 1;
+		}
 		if (!prefixcmp(placeholder + 1, "red")) {
 			strbuf_addstr(sb, "\033[31m");
 			return 4;
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 86bf7e1..59d1f62 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -14,7 +14,7 @@ touch foo && git add foo && git commit -m "added foo"=
 &&
 test_format() {
 	cat >expect.$1
 	test_expect_success "format $1" "
-git rev-list --pretty=3Dformat:$2 master >output.$1 &&
+git rev-list --pretty=3Dformat:'$2' master >output.$1 &&
 test_cmp expect.$1 output.$1
 "
 }
@@ -101,6 +101,13 @@ commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
 =1B[31mfoo=1B[32mbar=1B[34mbaz=1B[mxyzzy
 EOF
=20
+test_format advanced-colors '%C(red yellow bold)foo%C(reset)' <<'EOF'
+commit 131a310eb913d107dd3c09a65d1651175898735d
+=1B[1;31;43mfoo=1B[m
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+=1B[1;31;43mfoo=1B[m
+EOF
+
 cat >commit-msg <<'EOF'
 Test printing of complex bodies
=20
--=20
1.6.1.238.g32268.dirty
