From: tboegi@web.de
Subject: [PATCH v3 6/7] convert.c: refactor crlf_action
Date: Fri,  5 Feb 2016 17:13:28 +0100
Message-ID: <1454688808-20910-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 17:12:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRizs-00029f-A5
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 17:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbcBEQM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 11:12:26 -0500
Received: from mout.web.de ([212.227.17.12]:62866 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755566AbcBEQMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 11:12:25 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LyDph-1ZvwvK3wsH-015br2; Fri, 05 Feb 2016 17:12:24
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:aGRat5PTHmLPFj1FVJdjRou5/GoSAggIIrP36wLR1VOar9SMmS8
 g870QglWjzMKhC7GjCCKLRStCiytBXnRVqoUVSBdXxfP6w+iQwu0TP9SbIfnwvpiTIBq/fL
 tZgHbjVa7mTV9PkTUbH5DZwr0nhMHOeIUp1KZY3nYf0SlwrbWbkG08ylhqLwvgfxCdVwsh4
 0grDHUPqKyIT9Yk7AGR6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pxNN2pMdTbQ=:0pKj6Tl0c5cOQzTfKr8H1e
 Ts/mrTkiPwIutnsgeFJUPI5QPgAHuSH6O8zOxpOCFAM4XAzJlVis6kisc4ebq8CtrVKICsq+g
 gTJTbwKMev9Ooxk1DRbIPiPU1QyX+NubK6dKm+/sPAYQ7KHjpImMTmR1jD4mtb6ykPz6GEJLK
 39HTAxa4IQ2ouNEE/FXEtfDT6v9nethxXss9jMaFwfZjGzQc16owptch2SxkRkkNP731z2+66
 R6AQ9m8sFKRPsZzMH07l9cjwvqPkzCtoBsXNdCpmkXaq8PjyYsVCN9g0UCIM2MTWJ2uQrppHq
 V4D6r4Ok+vozThVvovy2l1FMZtPWOIdkq5JTmcnSofu3hNh600VqH9F+o4NG3h6hYoEhqHFvI
 ig0/2Vu4u1ajsqqm8X6ImHOTWzw6HGoj4YtGEI1EA+5wT6zUdS1ePHs/5+sGWzmt6q5zeD7y0
 LMBYWHLgS1+ohjGeyoUZciRTsDV07rzO4MpdRZYpJ9c+6qehy9np/X+uSfz9pfMleoN9kdJMw
 LHEB2zU8gxw8tQwVDFSvW4K+VEIg4Um0zrlx/5FeA8r31DACYZybe8la/IpXkJu0a2xtrb4QC
 liIOZp/ZGFfeOGvZcCcDzeY8/ohAceFH+EZ37oKqPs4Sx0d0+xrOwr0Fx2JBv/dZ2XBTfU5Wt
 9i8KOaLqvC3ObVSMcp+zFPt0BfsYv9zw9x8BoHNmvRceHaITBU/0zwDgKIPEp4nwKo7RfhkjF
 pOTNQjbLxsGdjLnbBwovdapkRxpreObcp5L4fTkT3L0hdVNwG8nqWMYKNTem7Kf0SznccXBV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285582>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Refactor the determination and usage of crlf_action.
Today, when no attributes are set on a file,
crlf_action is set to CRLF_GUESS, and later, CRLF_GUESS is used as an
indication that core.autocrlf is not false and that some automatic eol
conversion is needed.
Make more clear, what is what, by defining:

- CRLF_UNDEFINED : No attributes set. Temparally used, until core.autoc=
rlf
                   and core.eol is evaluated and one of CRLF_BINARY,
                   CRLF_AUTO_INPUT or CRLF_AUTO_CRLF is selected
- CRLF_BINARY    : No processing of line endings.
- CRLF_TEXT      : attribute "text" is set, line endings are processed.
- CRLF_TEXT_INPUT: attribute "input" or "eol=3Dlf" is set. This implies=
 text.
- CRLF_TEXT_CRLF : attribute "eol=3Dcrlf" is set. This implies text.
- CRLF_AUTO      : attribute "auto" is set.
- CRLF_AUTO_INPUT: No attributes, core.autocrlf=3Dinput
- CRLF_AUTO_CRLF : No attributes, core.autocrlf=3Dtrue

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 75 ++++++++++++++++++++++++++++++++++++++-----------------=
--------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/convert.c b/convert.c
index e9c9448..e4e2877 100644
--- a/convert.c
+++ b/convert.c
@@ -19,12 +19,14 @@
 #define CONVERT_STAT_BITS_BIN       0x4
=20
 enum crlf_action {
-	CRLF_GUESS =3D -1,
-	CRLF_BINARY =3D 0,
+	CRLF_UNDEFINED,
+	CRLF_BINARY,
 	CRLF_TEXT,
-	CRLF_INPUT,
-	CRLF_CRLF,
-	CRLF_AUTO
+	CRLF_TEXT_INPUT,
+	CRLF_TEXT_CRLF,
+	CRLF_AUTO,
+	CRLF_AUTO_INPUT,
+	CRLF_AUTO_CRLF
 };
=20
 struct text_stat {
@@ -167,18 +169,19 @@ static enum eol output_eol(enum crlf_action crlf_=
action)
 	switch (crlf_action) {
 	case CRLF_BINARY:
 		return EOL_UNSET;
-	case CRLF_CRLF:
+	case CRLF_TEXT_CRLF:
 		return EOL_CRLF;
-	case CRLF_INPUT:
+	case CRLF_TEXT_INPUT:
 		return EOL_LF;
-	case CRLF_GUESS:
-		if (!auto_crlf)
-			return EOL_UNSET;
-		/* fall through */
+	case CRLF_UNDEFINED:
+	case CRLF_AUTO_CRLF:
+	case CRLF_AUTO_INPUT:
 	case CRLF_TEXT:
 	case CRLF_AUTO:
+		/* fall through */
 		return text_eol_is_crlf() ? EOL_CRLF : EOL_LF;
 	}
+	warning("Illegal crlf_action %d\n", (int)crlf_action);
 	return core_eol;
 }
=20
@@ -247,11 +250,11 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
=20
 	gather_stats(src, len, &stats);
=20
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
+	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		if (convert_is_binary(len, &stats))
 			return 0;
=20
-		if (crlf_action =3D=3D CRLF_GUESS) {
+		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
 			/*
 			 * If the file in the index has any CR in it, do not convert.
 			 * This is the new safer autocrlf handling.
@@ -278,7 +281,7 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
 	dst =3D buf->buf;
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
+	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		/*
 		 * If we guessed, we already know we rejected a file with
 		 * lone CR, and we can strip a CR without looking at what
@@ -319,8 +322,8 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 	if (stats.lf =3D=3D stats.crlf)
 		return 0;
=20
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS) {
-		if (crlf_action =3D=3D CRLF_GUESS) {
+	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
+		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
 			/* If we have any CR or CRLF line endings, we do not touch it */
 			/* This is the new safer autocrlf-handling */
 			if (stats.cr > 0 || stats.crlf > 0)
@@ -708,16 +711,16 @@ static enum crlf_action git_path_check_crlf(struc=
t git_attr_check *check)
 	const char *value =3D check->value;
=20
 	if (ATTR_TRUE(value))
-		return CRLF_TEXT;
+		return text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_INPUT;
 	else if (ATTR_FALSE(value))
 		return CRLF_BINARY;
 	else if (ATTR_UNSET(value))
 		;
 	else if (!strcmp(value, "input"))
-		return CRLF_INPUT;
+		return CRLF_TEXT_INPUT;
 	else if (!strcmp(value, "auto"))
 		return CRLF_AUTO;
-	return CRLF_GUESS;
+	return CRLF_UNDEFINED;
 }
=20
 static enum eol git_path_check_eol(struct git_attr_check *check)
@@ -780,7 +783,7 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
 		enum eol eol_attr;
 		ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
-		if (ca->crlf_action =3D=3D CRLF_GUESS)
+		if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
 			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
 		ca->attr_action =3D ca->crlf_action;
 		ca->ident =3D git_path_check_ident(ccheck + 1);
@@ -789,16 +792,22 @@ static void convert_attrs(struct conv_attrs *ca, =
const char *path)
 			return;
 		eol_attr =3D git_path_check_eol(ccheck + 3);
 		if (eol_attr =3D=3D EOL_LF)
-			ca->crlf_action =3D CRLF_INPUT;
+			ca->crlf_action =3D CRLF_TEXT_INPUT;
 		else if (eol_attr =3D=3D EOL_CRLF)
-			ca->crlf_action =3D CRLF_CRLF;
+			ca->crlf_action =3D CRLF_TEXT_CRLF;
 	} else {
 		ca->drv =3D NULL;
-		ca->crlf_action =3D CRLF_GUESS;
+		ca->crlf_action =3D CRLF_UNDEFINED;
 		ca->ident =3D 0;
 	}
-	if (ca->crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_F=
ALSE)
+	if (ca->crlf_action =3D=3D CRLF_TEXT)
+		ca->crlf_action =3D text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_=
INPUT;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_FALSE)
 		ca->crlf_action =3D CRLF_BINARY;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_TRUE)
+		ca->crlf_action =3D CRLF_AUTO_CRLF;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_INPUT)
+		ca->crlf_action =3D CRLF_AUTO_INPUT;
 }
=20
 int would_convert_to_git_filter_fd(const char *path)
@@ -826,18 +835,22 @@ const char *get_convert_attr_ascii(const char *pa=
th)
=20
 	convert_attrs(&ca, path);
 	switch (ca.attr_action) {
-	case CRLF_GUESS:
+	case CRLF_UNDEFINED:
 		return "";
 	case CRLF_BINARY:
 		return "-text";
 	case CRLF_TEXT:
 		return "text";
-	case CRLF_INPUT:
+	case CRLF_TEXT_INPUT:
 		return "text eol=3Dlf";
-	case CRLF_CRLF:
-		return "text=3Dauto eol=3Dcrlf";
+	case CRLF_TEXT_CRLF:
+		return "text eol=3Dcrlf";
 	case CRLF_AUTO:
 		return "text=3Dauto";
+	case CRLF_AUTO_CRLF:
+		return "text=3Dauto eol=3Dcrlf"; /* This is not supported yet */
+	case CRLF_AUTO_INPUT:
+		return "text=3Dauto eol=3Dlf"; /* This is not supported yet */
 	}
 	return "";
 }
@@ -1383,11 +1396,13 @@ struct stream_filter *get_stream_filter(const c=
har *path, const unsigned char *s
=20
 	crlf_action =3D ca.crlf_action;
=20
-	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T))
+	if ((crlf_action =3D=3D CRLF_BINARY) ||
+			crlf_action =3D=3D CRLF_AUTO_INPUT ||
+			(crlf_action =3D=3D CRLF_TEXT_INPUT))
 		filter =3D cascade_filter(filter, &null_filter_singleton);
=20
 	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
-		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS))
+		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_CRLF=
))
 		filter =3D cascade_filter(filter, lf_to_crlf_filter());
=20
 	return filter;
--=20
2.7.0.303.g2c4f448.dirty
