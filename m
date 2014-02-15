From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RESEND] attr: allow pattern escape using backslashes
Date: Sat, 15 Feb 2014 09:05:04 +0700
Message-ID: <1392429904-11559-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 03:05:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEUcs-0007Az-G2
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 03:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbaBOCFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Feb 2014 21:05:00 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:47777 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbaBOCE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 21:04:59 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp16so13118306pbb.20
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 18:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=RwDRC5zspye3AydqXko1kEcCujgb+YwvRT6UMHJb0XU=;
        b=bo7Tcg2JzKA5FpVKqGsNBFDboFBRsQ6m2u3HNiLP86c/2ih15DTtcSkpIMWMXdTjlt
         nyeidZY+aIhU7Lk4ygKrbU+KuOjbpvVhbk6uv91L5MSIMsoNiJFaJTOK7jop10iXDrHS
         ik5PbqOTf+Ut5qPdFUK1eSxraYTw3V3Dk5eTn9jnbAAWY9uk/E3Ojt4PJ7tuzaAaBpe/
         m4pFDgppDyaJEAJlJqZsyKV5sHolu4SaJZXoZRtXtDwfLpmgxl/qEcWM+RU+Vs0BrLee
         ymRLKebTS8oiH2BzsJEPvUYKBt0i70QpNSjalURx7h3pBTXVRaLyQ4xVYcaTq0uIslOr
         HUAw==
X-Received: by 10.66.197.164 with SMTP id iv4mr12817763pac.18.1392429899104;
        Fri, 14 Feb 2014 18:04:59 -0800 (PST)
Received: from lanh ([115.73.215.60])
        by mx.google.com with ESMTPSA id js7sm21840262pbc.35.2014.02.14.18.04.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Feb 2014 18:04:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 15 Feb 2014 09:05:09 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242176>

Patterns in .gitattributes are separated by whitespaces, which makes
it impossible to specify exact spaces in the pattern. '?' can be used
as a workaround, but it matches other characters too. This patch makes
a space following a backslash part of the pattern, not a pattern
separator.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Last discussion is [1] although the thread went off topic, so no
 actual discussion.
=20
 [1] http://thread.gmane.org/gmane.comp.version-control.git/212631

 Documentation/gitattributes.txt | 6 +++---
 attr.c                          | 8 +++++++-
 t/t0003-attributes.sh           | 5 +++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 643c1ba..5d4d386 100644
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
index 8d13d70..699716d 100644
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
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
 		if (!macro_ok) {
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index b9d7947..2f16805 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -23,6 +23,7 @@ test_expect_success 'setup' '
 		echo "offon -test test"
 		echo "no notest"
 		echo "A/e/F test=3DA/e/F"
+		echo "A\\ b test=3Dspace"
 	) >.gitattributes &&
 	(
 		echo "g test=3Da/g" &&
@@ -195,6 +196,10 @@ test_expect_success 'root subdir attribute test' '
 	attr_check subdir/a/i unspecified
 '
=20
+test_expect_success 'quoting in pattern' '
+	attr_check "A b" space
+'
+
 test_expect_success 'negative patterns' '
 	echo "!f test=3Dbar" >.gitattributes &&
 	git check-attr test -- '"'"'!f'"'"' 2>errors &&
--=20
1.8.5.2.240.g8478abd
