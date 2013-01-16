From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Wed, 16 Jan 2013 09:09:01 +0700
Message-ID: <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:09:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIRi-0007H3-6s
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab3APCJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 21:09:21 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55105 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818Ab3APCJU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:09:20 -0500
Received: by mail-pa0-f42.google.com with SMTP id rl6so481311pac.15
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ZEZM3y/+2wPMXGrKzh8NPJ8kOQezEqRT/41jfgnFvAM=;
        b=E1Mu+23W8GSFfKmbE94naG+k2LKA/pvWcMYYzTgW+pdK5Obx7Q25/Mp4GQ+5yC0Gsi
         hQlnSsic3jFeekayqZo51FGXHGsIva4Ek9ZER+J06Lj/2x0tU9ZnO/VgKVYwTQKau2tH
         S0Pw6OeI2wWcTHhr2pezZ7L7ZHjMFfq8o8xVDYXg1k/Z9Dfpjjh/W8ARTwCd2Er/3TYr
         cELXcosG73uMx+T1r+DaeLjElheCCSn8Vt4AHfsd86QpE5/1Q3OWp/XZAhkvOzzNwxIu
         IfBWC+zJE7oQBtjXiXighGTMSrfkdi02Q0QYu2i2OLisT9UNcqIe42VR1ybT973t1PJ5
         /yJw==
X-Received: by 10.68.191.5 with SMTP id gu5mr270969555pbc.145.1358302160543;
        Tue, 15 Jan 2013 18:09:20 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id x2sm11930490paw.8.2013.01.15.18.09.16
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:09:19 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 Jan 2013 09:09:01 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213703>

On Wed, Jan 16, 2013 at 08:08:03AM +0700, Duy Nguyen wrote:
> Actually I'd like to remove that function.

This is what I had in mind:

-- 8< --
Subject: [PATCH] attr: avoid calling find_basename() twice per path

find_basename() is only used inside collect_all_attrs(), called once
in prepare_attr_stack, then again after prepare_attr_stack()
returns. Both calls return exact same value. Reorder the code to do it
once.

While at it, make use of "pathlen" to stop searching early if
possible.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/attr.c b/attr.c
index cfc6748..04cb9a0 100644
--- a/attr.c
+++ b/attr.c
@@ -564,32 +564,12 @@ static void bootstrap_attr_stack(void)
 	attr_stack =3D elem;
 }
=20
-static const char *find_basename(const char *path)
-{
-	const char *cp, *last_slash =3D NULL;
-
-	for (cp =3D path; *cp; cp++) {
-		if (*cp =3D=3D '/' && cp[1])
-			last_slash =3D cp;
-	}
-	return last_slash ? last_slash + 1 : path;
-}
-
-static void prepare_attr_stack(const char *path)
+static void prepare_attr_stack(const char *path, int dirlen)
 {
 	struct attr_stack *elem, *info;
-	int dirlen, len;
+	int len;
 	const char *cp;
=20
-	dirlen =3D find_basename(path) - path;
-
-	/*
-	 * find_basename() includes the trailing slash, but we do
-	 * _not_ want it.
-	 */
-	if (dirlen)
-		dirlen--;
-
 	/*
 	 * At the bottom of the attribute stack is the built-in
 	 * set of attribute definitions, followed by the contents
@@ -769,15 +749,27 @@ static int macroexpand_one(int attr_nr, int rem)
 static void collect_all_attrs(const char *path)
 {
 	struct attr_stack *stk;
-	int i, pathlen, rem;
-	const char *basename;
+	int i, pathlen, rem, dirlen =3D 0;
+	const char *basename =3D path, *cp;
=20
-	prepare_attr_stack(path);
+	pathlen =3D strlen(path);
+
+	/*
+	 * This loop is similar to strrchr(path, '/') except that the
+	 * trailing slash is skipped.
+	 */
+	for (cp =3D path + pathlen - 2; cp >=3D path; cp--) {
+		if (*cp =3D=3D '/') {
+			basename =3D cp + 1;
+			dirlen =3D cp - path;
+			break;
+		}
+	}
+
+	prepare_attr_stack(path, dirlen);
 	for (i =3D 0; i < attr_nr; i++)
 		check_all_attr[i].value =3D ATTR__UNKNOWN;
=20
-	basename =3D find_basename(path);
-	pathlen =3D strlen(path);
 	rem =3D attr_nr;
 	for (stk =3D attr_stack; 0 < rem && stk; stk =3D stk->prev)
 		rem =3D fill(path, pathlen, basename, stk, rem);
--=20
1.8.0.rc3.18.g0d9b108

-- 8< --
