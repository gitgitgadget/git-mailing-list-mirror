From: tboegi@web.de
Subject: [PATCH v4 5/6] convert.c: refactor crlf_action
Date: Wed, 10 Feb 2016 17:24:41 +0100
Message-ID: <1455121481-16429-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 17:23:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTXY8-0000im-M8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 17:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbcBJQXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2016 11:23:24 -0500
Received: from mout.web.de ([212.227.15.14]:58100 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115AbcBJQXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 11:23:21 -0500
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MdpWf-1afKAH0713-00Pf8j; Wed, 10 Feb 2016 17:23:20
 +0100
X-Mailer: git-send-email 2.7.0.303.g2c4f448.dirty
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
In-Reply-To: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
References: <Message-Id=1453558101-6858-1-git-send-email-tboegi@web.de>
X-Provags-ID: V03:K0:nlVN2bfNbppHSN1GunObIRNEB1LrhXokj89ptYWNBKc2gpwk310
 uM8ya5WOb4ATFstuYxYJM9tC/yp1Zc+V5EuFMxildUar9Yp2sTMKG2zurt4G3YA0p3BsKCS
 0NmTIKBujru/IJ7kpjxxc9JZTSuPPSagqEtogUXPGAPfMBu8dUQZdKMiNJMw2yH7C9SdrSm
 HE/vgXWp7BA2PNtv08YQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g7XbQtzB0Ns=:8GdtdRZHAAu6um2iulAiTN
 DJOEd/fgubfZQ7mvP54TeKk9ApY2Ok/rY3S7+G2XDqPyBZssBL+rfnev5yFU/OYo3T5XnPGWj
 MrtiIjnL0v+xJW0ReatVa48QcvG9Md9lzu7tn4OaL0b7VvUnq5zUxGb8hz28ImQ8yz2T/tyaU
 UllKR5K0cUGe6Q9iypFWg1adEs0ieaeCPyaHtNRxp5Ok/3ByzhQVPu2YVM62ePLBc96EWjRl0
 y+7LCwdmV4JP/++zdVG9796AxrHezyGlLOxFpZvWt3njNcWaueT65MxqWAJu+HyusND5NAJvY
 V5xwt27cd+Ue5Cw+eW4ooZIFtubUFs0LzE2exiPt+i7OObnJpZ+a3PkKFaY/k5iZi805ne4hM
 nV4cT/deCUp/n5NbFY/xMl5TDq1S4iQViN2LuGC8AW3JPheEdEcpRJmsrrBEB14MbhWRcdi4R
 hXDSM476g4Bx819E1aceH9TpwEE73s74m8QIPfhtd5+c/G5J6PsohY6kxaqpLwuO6J00P8HYk
 NXT4/BSIMxzusSOnCbVilfgBV2wT1uHBOs8c+jzmuz30rk450JHMnJbexv1wCyDUE87wP6trH
 mChHrA8jzYFwQmb4QayEVGGTFFrzhpmgoPWZzsBPpQhmUwfWnDgXqgB1dvJ+fLDq2TffzPYhm
 LIzqBl5BlCKXtNWF+juAQ88V5IrJ1V1m4hAXURbM+8S1EOZ8P4QpZIZJSwVXNAOBLj61QTv5d
 r4cjHqcKiLyX8vVxBLTapo29LoyYTKtt8EtCVhK8SosqzqCY+DgOVnMKEWiirG2XW3gOLRrO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285913>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

Refactor the determination and usage of crlf_action.
Today, when no "crlf" attribute are set on a file, crlf_action is set t=
o
CRLF_GUESS. Use CRLF_UNDEFINED instead, and search for "text" or "eol" =
as
before.
After searching for line ending attributes, save the value in
struct conv_attrs.crlf_action attr_action,
so that get_convert_attr_ascii() is able report the attributes.

Replace the old CRLF_GUESS usage:
CRLF_GUESS && core.autocrlf=3Dtrue -> CRLF_AUTO_CRLF
CRLF_GUESS && core.autocrlf=3Dfalse -> CRLF_BINARY
CRLF_GUESS && core.autocrlf=3Dinput -> CRLF_AUTO_INPUT

Save the action in conv_attrs.crlf_action (as before) and change
all callers.

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
- CRLF_AUTO_INPUT: core.autocrlf=3Dinput (no attributes)
- CRLF_AUTO_CRLF : core.autocrlf=3Dtrue  (no attributes)

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 77 ++++++++++++++++++++++++++++++++++++++-----------------=
--------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/convert.c b/convert.c
index 557e574..e4e2877 100644
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
@@ -235,7 +238,6 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	char *dst;
=20
 	if (crlf_action =3D=3D CRLF_BINARY ||
-	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E) ||
 	    (src && !len))
 		return 0;
=20
@@ -248,11 +250,11 @@ static int crlf_to_git(const char *path, const ch=
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
@@ -279,7 +281,7 @@ static int crlf_to_git(const char *path, const char=
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
@@ -320,8 +322,8 @@ static int crlf_to_worktree(const char *path, const=
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
@@ -709,16 +711,16 @@ static enum crlf_action git_path_check_crlf(struc=
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
@@ -781,7 +783,7 @@ static void convert_attrs(struct conv_attrs *ca, co=
nst char *path)
 	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
 		enum eol eol_attr;
 		ca->crlf_action =3D git_path_check_crlf(ccheck + 4);
-		if (ca->crlf_action =3D=3D CRLF_GUESS)
+		if (ca->crlf_action =3D=3D CRLF_UNDEFINED)
 			ca->crlf_action =3D git_path_check_crlf(ccheck + 0);
 		ca->attr_action =3D ca->crlf_action;
 		ca->ident =3D git_path_check_ident(ccheck + 1);
@@ -790,14 +792,22 @@ static void convert_attrs(struct conv_attrs *ca, =
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
+	if (ca->crlf_action =3D=3D CRLF_TEXT)
+		ca->crlf_action =3D text_eol_is_crlf() ? CRLF_TEXT_CRLF : CRLF_TEXT_=
INPUT;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_FALSE)
+		ca->crlf_action =3D CRLF_BINARY;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_TRUE)
+		ca->crlf_action =3D CRLF_AUTO_CRLF;
+	if (ca->crlf_action =3D=3D CRLF_UNDEFINED && auto_crlf =3D=3D AUTO_CR=
LF_INPUT)
+		ca->crlf_action =3D CRLF_AUTO_INPUT;
 }
=20
 int would_convert_to_git_filter_fd(const char *path)
@@ -825,18 +835,22 @@ const char *get_convert_attr_ascii(const char *pa=
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
@@ -1382,12 +1396,13 @@ struct stream_filter *get_stream_filter(const c=
har *path, const unsigned char *s
=20
 	crlf_action =3D ca.crlf_action;
=20
-	if ((crlf_action =3D=3D CRLF_BINARY) || (crlf_action =3D=3D CRLF_INPU=
T) ||
-	    (crlf_action =3D=3D CRLF_GUESS && auto_crlf =3D=3D AUTO_CRLF_FALS=
E))
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
