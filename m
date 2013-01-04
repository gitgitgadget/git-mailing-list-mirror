From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] attr: allow pattern escape using backslashes
Date: Fri,  4 Jan 2013 21:46:49 +0700
Message-ID: <1357310809-4771-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 04 15:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tr8Y6-0006QR-0g
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 15:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754791Ab3ADOqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Jan 2013 09:46:46 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:60783 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754763Ab3ADOqo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 09:46:44 -0500
Received: by mail-pa0-f44.google.com with SMTP id hz11so9313494pad.31
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 06:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=k1Npkoxk3G4Xk+OAcuq3NqwH2FhpyzxlR8wk2EjoVqY=;
        b=fMmO7JhlImKV/mJSK47XXZjwNZC7UyG2mgilAwX///AI5AYPj7gRfi4y/UEa6sGpjA
         e6qfbBD+rGb44tFh2oO/8kF9ICi83JOo5J1mWTGM59hsUmoQOfnUQ55zAADmmtloKhgV
         dQOikgMBS52UbfOi6tOKT/KjuQtgtQlemyvTc/q9FmmsDSZOaM1PWzDaJj8ZBaqI2VLa
         Szhi30tz7cRV8iGR37dKIWbD1fsrPLFO9FgERAJoNswDTXjoDQZ9EB7wdtg75hshUdLO
         H6rbcitSFenaHoHjWACEvg50g9541Rj8FbrRQLy7WxLSFe6MlYMtqurKPlwE/qaJzKp2
         VMtA==
X-Received: by 10.66.85.101 with SMTP id g5mr155042467paz.17.1357310803674;
        Fri, 04 Jan 2013 06:46:43 -0800 (PST)
Received: from lanh ([115.74.34.31])
        by mx.google.com with ESMTPS id qt3sm32350450pbb.32.2013.01.04.06.46.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 06:46:42 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 04 Jan 2013 21:46:50 +0700
X-Mailer: git-send-email 1.8.0.rc2.23.g1fb49df
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212631>

Patterns in .gitattributes are separated by whitespaces, which makes
it impossible to specify exact spaces in the pattern. '?' can be used
as a workaround, but it matches other characters too. This patch makes
a space following a backslash part of the pattern, not a pattern
separator.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 A similar patch was posted twice (during freeze time iirc). I think
 this is a good change, so I will keep reposting until someone turns
 it down.

 We could use wildmatch for parsing here, which would support patterns
 like "Hello[ ]world". But that's not going to happen until wildmatch
 graduates and somebody brings it up again.

 Documentation/gitattributes.txt | 6 +++---
 attr.c                          | 8 +++++++-
 t/t0003-attributes.sh           | 5 +++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 2698f63..113b1f8 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -20,9 +20,9 @@ Each line in `gitattributes` file is of form:
=20
 	pattern	attr1 attr2 ...
=20
-That is, a pattern followed by an attributes list,
-separated by whitespaces.  When the pattern matches the
-path in question, the attributes listed on the line are given to
+That is, a pattern followed by an attributes list, separated by
+whitespaces that are not quoted by a backslash. When the pattern match=
es
+the path in question, the attributes listed on the line are given to
 the path.
=20
 Each attribute can be in one of these states for a given path:
diff --git a/attr.c b/attr.c
index 097ae87..776f34e 100644
--- a/attr.c
+++ b/attr.c
@@ -209,7 +209,13 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 	if (!*cp || *cp =3D=3D '#')
 		return NULL;
 	name =3D cp;
-	namelen =3D strcspn(name, blank);
+	namelen =3D 0;
+	while (name[namelen] !=3D '\0' && !strchr(blank, name[namelen])) {
+		if (name[namelen] =3D=3D '\\' && name[namelen + 1] !=3D '\0')
+			namelen +=3D 2;
+		else
+			namelen++;
+	}
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    !prefixcmp(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 807b8b8..6a5d8ab 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -24,6 +24,7 @@ test_expect_success 'setup' '
 		echo "offon -test test"
 		echo "no notest"
 		echo "A/e/F test=3DA/e/F"
+		echo "A\\ b test=3Dspace"
 	) >.gitattributes &&
 	(
 		echo "g test=3Da/g" &&
@@ -196,6 +197,10 @@ test_expect_success 'root subdir attribute test' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success 'quoting in pattern' '
+	attr_check "A b" space
+'
+
 test_expect_success 'negative patterns' '
 	echo "!f test=3Dbar" >.gitattributes &&
 	test_must_fail git check-attr test -- f
--=20
1.8.0.rc2.23.g1fb49df
