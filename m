From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [MinGW PATCH] Rework quote_arg()
Date: Sat, 27 Oct 2007 20:30:40 +0700
Message-ID: <20071027133040.GA32312@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sat Oct 27 15:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Illko-0006rX-IS
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 15:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907AbXJ0Nay convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2007 09:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753749AbXJ0Nay
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 09:30:54 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:7865 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbXJ0Nax (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 09:30:53 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1072561rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 06:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        bh=iChvT2DIGFXCfaSZJWMbm61c0V6ALNH2hj3OA6S0XAs=;
        b=W43E+0Jf+CHwb+/wBlJnpBLLYikPaxy81zaBdHl5rbQ95YLXXeHWILqGlYiqJB5CC1DPo+upTB3G+plwkhd8x9dv6HzRFFxivAlpUVOFsBPlxMIkWvMIgy5Bre0fT94NsNWbWXCRlADe1kEj1JZrRFKHkZNBGWMeeXZrLwyiLV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:content-transfer-encoding:user-agent;
        b=kUhPlMlC5ihiqclzgcduqSEHRR0yUrY6n2cUPiU1NIcenQPrntW0ChnOla46hE9Z8CpOe9jxl8BbBxU9A6wBVzT+hhrujKogw5z72s/SS1xHTbj3OXPSga8QbhIaAwqhYGjMjDeNpM5/gfYNu2O98IzaTbDjwO7Sm39Z7mNRVHc=
Received: by 10.141.34.12 with SMTP id m12mr2011264rvj.1193491853255;
        Sat, 27 Oct 2007 06:30:53 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.6])
        by mx.google.com with ESMTPS id g6sm7578367rvb.2007.10.27.06.30.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 06:30:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Oct 2007 20:30:40 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62494>

MS Windows command line is handled in a weird way. This patch addresses=
:
 - Quote empty arguments
 - Only escape backslashes and double quotation marks inside quoted arg=
uments
 - Quote arguments if they have asterisk or question marks to prevent e=
xpansion

The last one is not documented in the link provided in the patch. I enc=
ountered
that behavior on cmd.exe, Windows XP. MSYS not tested.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 compat/mingw.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 22b5e10..90dc080 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -303,6 +303,7 @@ void openlog(const char *ident, int option, int fac=
ility)
 {
 }
=20
+/* See http://msdn2.microsoft.com/en-us/library/17w5ykft(vs.71).aspx (=
Parsing C++ Command-Line Arguments */
 static const char *quote_arg(const char *arg)
 {
 	/* count chars to quote */
@@ -310,11 +311,23 @@ static const char *quote_arg(const char *arg)
 	int force_quotes =3D 0;
 	char *q, *d;
 	const char *p =3D arg;
+	if (!*p) force_quotes =3D 1;
 	while (*p) {
-		if (isspace(*p))
+		if (isspace(*p) || *p =3D=3D '*' || *p =3D=3D '?')
 			force_quotes =3D 1;
-		else if (*p =3D=3D '"' || *p =3D=3D '\\')
+		else if (*p =3D=3D '"')
 			n++;
+		else if (*p =3D=3D '\\') {
+			int count =3D 0;
+			while (*p =3D=3D '\\') {
+				count++;
+				p++;
+				len++;
+			}
+			if (*p =3D=3D '"')
+				n +=3D count*2 + 1;
+			continue;
+		}
 		len++;
 		p++;
 	}
@@ -325,8 +338,20 @@ static const char *quote_arg(const char *arg)
 	d =3D q =3D xmalloc(len+n+3);
 	*d++ =3D '"';
 	while (*arg) {
-		if (*arg =3D=3D '"' || *arg =3D=3D '\\')
+		if (*arg =3D=3D '"')
 			*d++ =3D '\\';
+		else if (*arg =3D=3D '\\') {
+			int count =3D 0;
+			while (*arg =3D=3D '\\') {
+				count++;
+				*d++ =3D *arg++;
+			}
+			if (*arg =3D=3D '"') {
+				while (count-- > 0)
+					*d++ =3D '\\';
+				*d++ =3D '\\';
+			}
+		}
 		*d++ =3D *arg++;
 	}
 	*d++ =3D '"';
--=20
1.5.3.rc4.3.gab089
