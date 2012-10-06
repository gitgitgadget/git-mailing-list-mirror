From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] attr: allow pattern escape using backslash
Date: Sat,  6 Oct 2012 14:22:05 +0700
Message-ID: <1349508125-24775-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 06 09:29:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKOpH-0002Rk-Mp
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 09:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab2JFH3V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Oct 2012 03:29:21 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:51923 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2JFH3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 03:29:21 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so658031dak.19
        for <git@vger.kernel.org>; Sat, 06 Oct 2012 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=V3OA9nVxy+c8sfTwIwqL2Qz21xJ2I5R0OJT3U0lFMxo=;
        b=v6DgltKRLI9X8FEGQ796PvzcwTm4IIiMQBoI3MgucVzgCe+2xeR1z1DCNi1ihGpsE3
         xZYaqJpurNx8CTSfHrZ6V88hXkrFwkMek2pSoHrQEzBxbzGxwxCfpV5y8TrmbtRmvo9M
         ws6c+ag0EkSQhH5TmJ+A2uLKeLQov2jGMrZOPONT8rc6ZtJP0gb33srO1hGmrWJonu+v
         gMcHdFx8rRnhhOrmSeIWfznpimB+Zz7lqh1DIwUYs6myyCOc6+RMFeGEiR1rg5YiWjmt
         ghCd0iRNFRNwhaxaMygXBdvCvshXTM/4TC58L99l/Hn01aV9k0hISC7fZpUYjj6Oik/2
         8dZQ==
Received: by 10.66.75.162 with SMTP id d2mr27531215paw.27.1349508560598;
        Sat, 06 Oct 2012 00:29:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.54.82])
        by mx.google.com with ESMTPS id pv9sm7281089pbb.67.2012.10.06.00.29.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Oct 2012 00:29:19 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 06 Oct 2012 14:22:18 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207135>

=2Egitattributes pattern syntax is supposed to be the same as .gitignor=
e
(except a few things that do not make sense in attr context, but
that's a different issue). .gitignore uses fnmatch() as the matching
machinery and "\" is accepted as an escape code. In theory the pattern
'foo\ bar' should match path 'foo bar' in .gitignore. Granted, no one
would write 'foo\ bar' in .gitignore when 'foo bar' should
suffice.

Regardless, 'foo\ bar attr' does not (but should) attach "attr" to
path "foo bar" because pattern/attr parse code does not understand
backslash escape. It parses the line as path 'foo\' and attributes
'bar' and 'attr'. This patch teaches attr code to recognize the
backslash in patterns (not macro names) and pass 'foo\ bar' down to
fnmatch().

This changes the attr behavior. "foo\ attr", if exists in the field,
would match nothing because path "foo\" is invalid in UNIX and is a
directory in Windows, which we do not accept attaching attributes
to. With this patch, that line becomes invalid and is rejected. So
it's not really bad (i.e. no silent changes in behavior).

Other subtle behavioral changes may happen. Still, I think we should
do this as it seems like a correct thing to do.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 We discussed the "spaces in path names in attr" before and I remember
 using quotes or double quotes, even substituting spaces with
 dots, were raised. I don't remember if backslashes were mentioned.

 attr.c                | 12 +++++++++++-
 t/t0003-attributes.sh |  5 +++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 887a9ae..173d51d 100644
--- a/attr.c
+++ b/attr.c
@@ -221,8 +221,18 @@ static struct match_attr *parse_attr_line(const ch=
ar *line, const char *src,
 			return NULL;
 		}
 	}
-	else
+	else {
 		is_macro =3D 0;
+		namelen =3D 0;
+		while (name[namelen] !=3D '\0' &&
+		       !strchr(blank, name[namelen])) {
+			if (name[namelen] =3D=3D '\\' &&
+			    name[namelen + 1] !=3D '\0')
+				namelen +=3D 2;
+			else
+				namelen++;
+		}
+	}
=20
 	states =3D name + namelen;
 	states +=3D strspn(states, blank);
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index febc45c..16b419e 100755
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
 test_expect_success 'setup bare' '
 	git clone --bare . bare.git &&
 	cd bare.git
--=20
1.7.12.1.406.g6ab07c4
