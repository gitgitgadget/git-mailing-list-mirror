From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] config: Keep inner whitespace verbatim
Date: Thu, 30 Jul 2009 13:41:57 +0200
Message-ID: <20090730114157.GA5560@atjola.homenet>
References: <47ade73f0907291752k62c66903lc2617a16ec0973bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John te Bokkel / Tempus <tanj.tanj@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 13:42:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWU1b-00052P-85
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 13:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbZG3LmI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 07:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753181AbZG3LmH
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 07:42:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:44505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751642AbZG3LmG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 07:42:06 -0400
Received: (qmail invoked by alias); 30 Jul 2009 11:42:05 -0000
Received: from i59F57884.versanet.de (EHLO atjola.homenet) [89.245.120.132]
  by mail.gmx.net (mp071) with SMTP; 30 Jul 2009 13:42:05 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/Pka8oEDDPGZDA2HTm58uDK6Q+tKDjeFarSF537Q
	7dU1VZCILmCIax
Content-Disposition: inline
In-Reply-To: <47ade73f0907291752k62c66903lc2617a16ec0973bd@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124458>

Configuration values are expected to be quoted when they have leading o=
r
trailing whitespace, but inner whitespace should be kept verbatim even =
if
the value is not quoted. This is already documented in git-config(1), b=
ut
the code caused inner whitespace to be collapsed to a single space,
breaking, for example, clones from a path that has two consecutive spac=
es
in it, as future fetches would only see a single space.

Reported-by: John te Bokkel <tanj.tanj@gmail.com>
Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
 config.c               |    6 +++---
 t/t1300-repo-config.sh |    5 +++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 738b244..e25b7d6 100644
--- a/config.c
+++ b/config.c
@@ -62,7 +62,8 @@ static char *parse_value(void)
 		if (comment)
 			continue;
 		if (isspace(c) && !quote) {
-			space =3D 1;
+			if (len)
+				space++;
 			continue;
 		}
 		if (!quote) {
@@ -72,9 +73,8 @@ static char *parse_value(void)
 			}
 		}
 		if (space) {
-			if (len)
+			for (; space; --space)
 				value[len++] =3D ' ';
-			space =3D 0;
 		}
 		if (c =3D=3D '\\') {
 			c =3D get_next_char();
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 8c43dcd..83b7294 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -755,6 +755,11 @@ echo >>result
=20
 test_expect_success '--null --get-regexp' 'cmp result expect'
=20
+test_expect_success 'inner whitespace kept verbatim' '
+	git config section.val "foo 	  bar" &&
+	test "z$(git config section.val)" =3D "zfoo 	  bar"
+'
+
 test_expect_success SYMLINKS 'symlinked configuration' '
=20
 	ln -s notyet myconfig &&
--=20
1.6.3.GIT
