From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/2] dir.c: make last_exclude_matching_from_list() run til the end
Date: Mon, 21 Sep 2015 16:56:14 +0700
Message-ID: <1442829375-1926-2-git-send-email-pclouds@gmail.com>
References: <1442106945-24080-1-git-send-email-pclouds@gmail.com>
 <1442829375-1926-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 11:56:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdxpQ-0005jL-7N
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 11:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449AbbIUJ4D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Sep 2015 05:56:03 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32974 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbbIUJ4C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 05:56:02 -0400
Received: by pacex6 with SMTP id ex6so112589188pac.0
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 02:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9ePVzZ2QEIhR7F3mPlEfkpk74OZ4J/+qAoEOs+k6MJk=;
        b=diskcN6AFdxIRJTApMt/OpFMicMZX36seLpfks2qp9ymP/tZ3POfpvkDyIRy/UXOGf
         5EbYYhsLAnqe1trePVbvlcUrcp+vNR8EYSxoxR3WibdnPNqXbQ+3LDv05qIFBg+JOr4o
         I8D1CJF5Pmmx3A5oUmgqNmrKlzwo0OFcBwEw0yHoeFDc1y+WjiJ88dZpzXgfDz5KvvHg
         /UhF26wfcP9+R6vaV+wUf3dMzB7xfn8BXEZMLSKjfO4Y9xCB5q4NZdcoGJvTd9lFb9fP
         mhA7jH3Z6uZMqZmDii9yGWWjYO1+GlVsgH43wiP2AnzYLby0PuVAnwMCbGkOXzzVL9bX
         7q9A==
X-Received: by 10.69.19.202 with SMTP id gw10mr24066670pbd.60.1442829361419;
        Mon, 21 Sep 2015 02:56:01 -0700 (PDT)
Received: from lanh ([171.233.227.16])
        by smtp.gmail.com with ESMTPSA id ej3sm23494021pbd.13.2015.09.21.02.55.58
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2015 02:56:00 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 21 Sep 2015 16:56:29 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1442829375-1926-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278293>

The next patch adds some post processing to the result value before it'=
s
returned to the caller. Keep all branches reach the end of the function=
,
so we can do it all in one place.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index c00c7e2..3a7630a 100644
--- a/dir.c
+++ b/dir.c
@@ -901,6 +901,7 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 						       int *dtype,
 						       struct exclude_list *el)
 {
+	struct exclude *exc =3D NULL; /* undecided */
 	int i;
=20
 	if (!el->nr)
@@ -922,18 +923,22 @@ static struct exclude *last_exclude_matching_from=
_list(const char *pathname,
 			if (match_basename(basename,
 					   pathlen - (basename - pathname),
 					   exclude, prefix, x->patternlen,
-					   x->flags))
-				return x;
+					   x->flags)) {
+				exc =3D x;
+				break;
+			}
 			continue;
 		}
=20
 		assert(x->baselen =3D=3D 0 || x->base[x->baselen - 1] =3D=3D '/');
 		if (match_pathname(pathname, pathlen,
 				   x->base, x->baselen ? x->baselen - 1 : 0,
-				   exclude, prefix, x->patternlen, x->flags))
-			return x;
+				   exclude, prefix, x->patternlen, x->flags)) {
+			exc =3D x;
+			break;
+		}
 	}
-	return NULL; /* undecided */
+	return exc;
 }
=20
 /*
--=20
2.3.0.rc1.137.g477eb31
