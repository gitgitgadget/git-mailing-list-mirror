From: =?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>
Subject: [PATCH] git config: Don't rely on regexec() returning 1 on non-match
Date: Wed,  5 Dec 2007 16:11:24 +0100
Message-ID: <1196867484-22188-1-git-send-email-B.Steinbrink@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?q?Bj=C3=B6rn=20Steinbrink?= <B.Steinbrink@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 16:11:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izvuj-000443-BG
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 16:11:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbXLEPL2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 10:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXLEPL2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 10:11:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:47105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751613AbXLEPL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 10:11:27 -0500
Received: (qmail invoked by alias); 05 Dec 2007 15:11:25 -0000
Received: from i577AD074.versanet.de (EHLO localhost) [87.122.208.116]
  by mail.gmx.net (mp034) with SMTP; 05 Dec 2007 16:11:25 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+5P/Rr4O252/bZpPMsIkxoHQn5U3m8DIxdMthwBB
	9lDFKOTz3mLi6K
X-Mailer: git-send-email 1.5.3.GIT
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67156>

Some systems don't return 1 from regexec() when the pattern does not
match (notably HP-UX which returns 20). Fortunately, there's the
REG_NOMATCH constant, which we can use as the expected return value
and test for that instead of "1 XOR retval".

Bug identified by Dscho and H.Merijn Brand.

Signed-off-by: Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de>
Tested-by: H.Merijn Brand <h.m.brand@xs4all.nl>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-config.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 4c9ded3..9fda4e4 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -11,7 +11,7 @@ static regex_t *regexp;
 static int show_keys;
 static int use_key_regexp;
 static int do_all;
-static int do_not_match;
+static int expected_regexec_result;
 static int seen;
 static char delim =3D '=3D';
 static char key_delim =3D ' ';
@@ -38,7 +38,7 @@ static int show_config(const char* key_, const char* =
value_)
 	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
 		return 0;
 	if (regexp !=3D NULL &&
-			 (do_not_match ^
+			 (expected_regexec_result !=3D
 			  regexec(regexp, (value_?value_:""), 0, NULL, 0)))
 		return 0;
=20
@@ -101,7 +101,7 @@ static int get_value(const char* key_, const char* =
regex_)
=20
 	if (regex_) {
 		if (regex_[0] =3D=3D '!') {
-			do_not_match =3D 1;
+			expected_regexec_result =3D REG_NOMATCH;
 			regex_++;
 		}
=20
--=20
1.5.3.GIT
