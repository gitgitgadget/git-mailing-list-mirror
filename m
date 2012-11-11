From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH/RFC] attr: allow pattern escape using backslash
Date: Sun, 11 Nov 2012 17:32:22 +0700
Message-ID: <20121111103222.GA6029@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 11:32:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXUqG-00077E-HL
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 11:32:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031Ab2KKKcY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2012 05:32:24 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:35979 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab2KKKcX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 05:32:23 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2314862dak.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 02:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=0k7dSqU15q0K8kACFmezMNbSoDBrWzkTzu+WpeofL4E=;
        b=X4Co0Rp42oOiktduzXQCzKKqXB1gNYXlvlxt5q9f3sv1lfoV6ooq7h4DnREwKnXvIU
         9WgNraz4EbdWB1CoV7FzrYx+ncyo0E47Et58pvDrgaz1Ds7eht66ZkTzEL4P9AF3JPvM
         wKLik22owkICXseLVf2JSO7gYKxbDaDYGIfMGPRHpxlaDwbv00d/sUY8YV4szy3kTQej
         jZzUMgyW9YXRUZqmBrdQAlwl5orWO2DWqyk1yHYYf4Zj0u5Cr20n2YBlspQDi3M8ZaEb
         NWBN9ijLGbaya409THP8TewVXVCqyhmxlkhK3ES2KoII/fhBUqT5bocmkPNI89iGl86J
         qRmA==
Received: by 10.66.72.134 with SMTP id d6mr46307492pav.13.1352629943583;
        Sun, 11 Nov 2012 02:32:23 -0800 (PST)
Received: from lanh ([115.74.37.170])
        by mx.google.com with ESMTPS id qt3sm2345302pbb.32.2012.11.11.02.32.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 02:32:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 11 Nov 2012 17:32:22 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209331>

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
 It was posted [1] during rc cycles (I think) and initial feedback
 from Junio was "not utterly wrong". I still think this is worth
 doing, hence this resend for discussion.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/207135

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
