From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length
 calculation
Date: Wed, 16 Jan 2013 13:02:38 +0700
Message-ID: <20130116060238.GA29523@duynguyen-vnpc.dek-tpc.internal>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com>
 <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
 <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal>
 <7vbocp26xa.fsf@alter.siamese.dyndns.org>
 <CACsJy8C2uEgwozpWBfowYJea3XRB72rhzjsSFuG9Ud0afuQy6w@mail.gmail.com>
 <7vtxqhzo4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 07:03:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvM5p-0005YM-Dh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 07:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610Ab3APGDA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2013 01:03:00 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:44609 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab3APGC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 01:02:59 -0500
Received: by mail-pb0-f54.google.com with SMTP id wz12so527887pbc.41
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 22:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OhyFAOTJhbR8ZTKAAKEVcqx/d1AAc9MeM+ziyBTG27s=;
        b=kUjq/0HVLo1w1tmqC7qsbsYoxiLBkkdS64qe3sj5eDLNmqIzjcv4PeQWHs3ufEAUn7
         0xMrCtNum42ZXjsjvp5t8tlHxZqf3cmeUCNxYBwOsM3VkAuZWoOSGOgiBekl7Hgf8kV3
         Xhkb85v6y9MZXCsEKp8/2/bIyq5As/Ysm9WCaSRVl4wYuVYdhEPa0Ql+LGWs4Y6QVERM
         ocVzMj+gL1xov6JcgGnACixOwrWYXf6N2p4pccdIplqj30pDN+XXgRLmWvymZcxGW30o
         1FeqUf+It/Wyso7/C3z2Es/zjHY17c6b3Xv4O9qyhEwNgRY7Xo9SaC4rP7lpr1noW7F+
         x1LA==
X-Received: by 10.66.83.232 with SMTP id t8mr741295pay.73.1358316178923;
        Tue, 15 Jan 2013 22:02:58 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id nf9sm11648780pbc.17.2013.01.15.22.02.55
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 22:02:58 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 16 Jan 2013 13:02:38 +0700
Content-Disposition: inline
In-Reply-To: <7vtxqhzo4m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213729>

On Tue, Jan 15, 2013 at 09:35:21PM -0800, Junio C Hamano wrote:
> >> Also the original only
> >> scanned the string from the beginning once (instead of letting
> >> strlen() to scan once and go back).
> >
> > But we do need to strlen() anyway in collect_all_attrs().
>=20
> That is exactly my point, isn't it?

OK I get your point now. Something like this?

-- 8< --
Subject: [PATCH] attr: avoid calling find_basename() twice per path

find_basename() is only used inside collect_all_attrs(), called once
in prepare_attr_stack, then again after prepare_attr_stack()
returns. Both calls return exact same value. Reorder the code to do
the same task once. Also avoid strlen() because we knows the length
after finding basename.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 attr.c | 45 ++++++++++++++++++---------------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/attr.c b/attr.c
index cfc6748..880f862 100644
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
@@ -769,15 +749,26 @@ static int macroexpand_one(int attr_nr, int rem)
 static void collect_all_attrs(const char *path)
 {
 	struct attr_stack *stk;
-	int i, pathlen, rem;
-	const char *basename;
+	int i, pathlen, rem, dirlen;
+	const char *basename, *cp, *last_slash =3D NULL;
+
+	for (cp =3D path; *cp; cp++) {
+		if (*cp =3D=3D '/' && cp[1])
+			last_slash =3D cp;
+	}
+	pathlen =3D cp - path;
+	if (last_slash) {
+		basename =3D last_slash + 1;
+		dirlen =3D last_slash - path;
+	} else {
+		basename =3D path;
+		dirlen =3D 0;
+	}
=20
-	prepare_attr_stack(path);
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
