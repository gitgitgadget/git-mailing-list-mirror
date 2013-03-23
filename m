From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [regression?] trailing slash required in .gitattributes
Date: Sat, 23 Mar 2013 11:18:24 +0700
Message-ID: <20130323041824.GA11142@lanh>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <20130319181042.GA14295@sigill.intra.peff.net>
 <20130322222438.GA13207@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 23 05:18:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJFuw-0003O4-Bh
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 05:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab3CWES1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Mar 2013 00:18:27 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:54370 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab3CWES0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 00:18:26 -0400
Received: by mail-pd0-f174.google.com with SMTP id z11so367318pdj.5
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 21:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+KK/a8pzymCuAs1YhHbl4q/4NS4TLD2PnpM0AyqdWhQ=;
        b=I1TkItYq/25Afm/hjP7YDy4+RSYmCr6WONhVoYbOpBXeyhoSAt+iX0LbVt4L0ptqa3
         PwPpJzFBfWD8E2D0TGGv4vGrMuIPAyniHhyCgLnAUJOR/XP3zP+MSgsV3aO0k5+IGz09
         QaZpJ9L2gdwd5EVCYpB5hjIP0l9Odnopw1LOPwUHQgRr/KxKp/qZiHXglEmS/muezJb+
         ji/XLkNyNTgoAznJNPMVehKFFygPgjnfdj5T+AH4rBVOnUejcxK+LyWCwkBVn+CqBPHy
         xRz0xADedD07ENDNFjhleK1YUKE1Guyk/xC4UgEKXx30RUh9IFoL0SCW7MRmPKiahQAI
         rAmA==
X-Received: by 10.66.252.202 with SMTP id zu10mr6858365pac.75.1364012305779;
        Fri, 22 Mar 2013 21:18:25 -0700 (PDT)
Received: from lanh ([115.74.37.60])
        by mx.google.com with ESMTPS id jk1sm2824395pbb.14.2013.03.22.21.18.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 21:18:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 23 Mar 2013 11:18:24 +0700
Content-Disposition: inline
In-Reply-To: <20130322222438.GA13207@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218884>

On Fri, Mar 22, 2013 at 06:24:39PM -0400, Jeff King wrote:
> I'm having trouble figuring out the right solution for this.

Thanks for looking into this. It was on my todo list, but you beat me
to it :)

> But then here we'll end up feeding "foo/" to be compared with "foo",
> which we don't want. For a pattern "foo", we want to match _either_
> "foo/" or "foo". So you'd think something like:
>=20
>   if (pathlen && pathname[pathlen-1] =3D=3D '/')
>           pathlen--;
>=20
> would work. But it seems that match_basename, despite taking the leng=
th
> of all of the strings we pass it, will happily use NUL-terminated
> functions like strcmp or fnmatch. Converting the former to check leng=
ths
> should be pretty straightforward. But there is no version of fnmatch
> that does what we want. I wonder if we using wildmatch can get around
> this limitation.

You can use nwildmatch() from this patch. I tested it lightly with
t3070-wildmatch.sh, feeding the strings with no terminating NUL. It
seems to work ok.

-- 8< --
Subject: [PATCH] wildmatch: do not require "text" to be NUL-terminated

This may be helpful when we just want to match a part of "text".
nwildmatch can be used for this purpose.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 wildmatch.c | 25 +++++++++++++------------
 wildmatch.h | 11 +++++++++--
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/wildmatch.c b/wildmatch.c
index 7192bdc..f97ae2a 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -52,7 +52,8 @@ typedef unsigned char uchar;
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
=20
 /* Match pattern "p" against "text" */
-static int dowild(const uchar *p, const uchar *text, unsigned int flag=
s)
+static int dowild(const uchar *p, const uchar *text,
+		  const uchar *textend, unsigned int flags)
 {
 	uchar p_ch;
 	const uchar *pattern =3D p;
@@ -60,8 +61,9 @@ static int dowild(const uchar *p, const uchar *text, =
unsigned int flags)
 	for ( ; (p_ch =3D *p) !=3D '\0'; text++, p++) {
 		int matched, match_slash, negated;
 		uchar t_ch, prev_ch;
-		if ((t_ch =3D *text) =3D=3D '\0' && p_ch !=3D '*')
+		if (text >=3D textend && p_ch !=3D '*')
 			return WM_ABORT_ALL;
+		t_ch =3D *text;
 		if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 			t_ch =3D tolower(t_ch);
 		if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
@@ -101,7 +103,7 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 					 * both foo/bar and foo/a/bar.
 					 */
 					if (p[0] =3D=3D '/' &&
-					    dowild(p + 1, text, flags) =3D=3D WM_MATCH)
+					    dowild(p + 1, text, textend, flags) =3D=3D WM_MATCH)
 						return WM_MATCH;
 					match_slash =3D 1;
 				} else
@@ -130,9 +132,7 @@ static int dowild(const uchar *p, const uchar *text=
, unsigned int flags)
 				/* the slash is consumed by the top-level for loop */
 				break;
 			}
-			while (1) {
-				if (t_ch =3D=3D '\0')
-					break;
+			while (text < textend) {
 				/*
 				 * Try to advance faster when an asterisk is
 				 * followed by a literal. We know in this case
@@ -145,18 +145,18 @@ static int dowild(const uchar *p, const uchar *te=
xt, unsigned int flags)
 					p_ch =3D *p;
 					if ((flags & WM_CASEFOLD) && ISUPPER(p_ch))
 						p_ch =3D tolower(p_ch);
-					while ((t_ch =3D *text) !=3D '\0' &&
+					while (text < textend &&
 					       (match_slash || t_ch !=3D '/')) {
 						if ((flags & WM_CASEFOLD) && ISUPPER(t_ch))
 							t_ch =3D tolower(t_ch);
 						if (t_ch =3D=3D p_ch)
 							break;
-						text++;
+						t_ch =3D *++text;
 					}
 					if (t_ch !=3D p_ch)
 						return WM_NOMATCH;
 				}
-				if ((matched =3D dowild(p, text, flags)) !=3D WM_NOMATCH) {
+				if ((matched =3D dowild(p, text, textend, flags)) !=3D WM_NOMATCH)=
 {
 					if (!match_slash || matched !=3D WM_ABORT_TO_STARSTAR)
 						return matched;
 				} else if (!match_slash && t_ch =3D=3D '/')
@@ -261,12 +261,13 @@ static int dowild(const uchar *p, const uchar *te=
xt, unsigned int flags)
 		}
 	}
=20
-	return *text ? WM_NOMATCH : WM_MATCH;
+	return text < textend ? WM_NOMATCH : WM_MATCH;
 }
=20
 /* Match the "pattern" against the "text" string. */
-int wildmatch(const char *pattern, const char *text,
+int nwildmatch(const char *pattern, const char *text, int textlen,
 	      unsigned int flags, struct wildopts *wo)
 {
-	return dowild((const uchar*)pattern, (const uchar*)text, flags);
+	return dowild((const uchar*)pattern, (const uchar*)text,
+		      (const uchar*)text + textlen, flags);
 }
diff --git a/wildmatch.h b/wildmatch.h
index 4090c8f..cdd7544 100644
--- a/wildmatch.h
+++ b/wildmatch.h
@@ -12,7 +12,14 @@
=20
 struct wildopts;
=20
-int wildmatch(const char *pattern, const char *text,
-	      unsigned int flags,
+int nwildmatch(const char *pattern, const char *text,
+	      int len, unsigned int flags,
 	      struct wildopts *wo);
+
+/* Match the "pattern" against the "text" string. */
+static inline int wildmatch(const char *pattern, const char *text,
+	      unsigned int flags, struct wildopts *wo)
+{
+	return nwildmatch(pattern, text, strlen(text), flags, wo);
+}
 #endif
--=20
1.8.2.83.gc99314b

-- 8< --
