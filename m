From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] dir.c: make match_{base,path}name respect {basename,path}len
Date: Mon, 25 Mar 2013 13:05:09 +0700
Message-ID: <1364191510-8900-4-git-send-email-pclouds@gmail.com>
References: <20130319175756.GA13760@sigill.intra.peff.net>
 <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, avila.jn@gmail.com,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 25 07:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UK0Xy-0002DF-Ul
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 07:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101Ab3CYGFv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Mar 2013 02:05:51 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33306 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757630Ab3CYGFv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 02:05:51 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz10so844578pad.35
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 23:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=LoN9fDKz1TfII2Ap1eo50XEwcOr8UDfGCf1zxHrhtus=;
        b=nzbbANZC3PuykyNsuYj7EQOnY2lbBH8dLDq7EeTCJnb5g6XBV9eJENuVAPb7K9AjOm
         /Emzymt7bGMvJYpVWmRrTX7yrhcP4GG6jxpPxbwY72y3Bq6RumDqYfT23sVyIJVjEwCY
         Oqs3Xhj5+WBR0JVUd1lZFx9ZvIC7xsbZYYh9l09pCvtlErejlV7HrCNPoJHVHM8YVv9V
         YLcysIrlcOwtPD4Lq1XB2KQENAFIsAco+mQp9GhA6d+SDXyqrqxdFB551eSp5DJI8mcO
         Go57yBLqQX86GI1DhfrSHxtwGTE5UP//RjBjAYR5hpGEcverqTyGpVcMH42jD7MwkdPd
         pqdg==
X-Received: by 10.68.213.231 with SMTP id nv7mr16039464pbc.85.1364191550845;
        Sun, 24 Mar 2013 23:05:50 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id wl14sm13467739pac.18.2013.03.24.23.05.46
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 24 Mar 2013 23:05:50 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 25 Mar 2013 13:05:42 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1364191510-8900-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219009>

When match_basename was split out of excluded_from_list in 593cb88
(exclude: split basename matching code into a separate function -
2012-10-15), it took basenamelen only as a hint. basename was required
to be NUL-terminated at the given length.

This was fine until match_basename had a new caller (from attr.c) and
therefore was no longer excluded_from_list's internal business. Make
match_basename stop relying on the NUL assumption above.

Do the same for match_pathname. From now on, only pattern is required
to be NUL-terminated at the specified patternlen for both
match_{base,path}name.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 57394e4..30f5241 100644
--- a/dir.c
+++ b/dir.c
@@ -626,15 +626,18 @@ int match_basename(const char *basename, int base=
namelen,
 		   int flags)
 {
 	if (prefix =3D=3D patternlen) {
-		if (!strcmp_icase(pattern, basename))
+		if (patternlen =3D=3D basenamelen &&
+		    !strncmp_icase(pattern, basename, basenamelen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <=3D basenamelen &&
-		    !strcmp_icase(pattern + 1,
-				  basename + basenamelen - patternlen + 1))
+		    !strncmp_icase(pattern + 1,
+				   basename + basenamelen - patternlen + 1,
+				   patternlen - 1))
 			return 1;
 	} else {
-		if (fnmatch_icase(pattern, basename, 0) =3D=3D 0)
+		if (nwildmatch(pattern, basename, basenamelen,
+			       ignore_case ? WM_CASEFOLD : 0, NULL) =3D=3D 0)
 			return 1;
 	}
 	return 0;
@@ -684,7 +687,7 @@ int match_pathname(const char *pathname, int pathle=
n,
 		namelen -=3D prefix;
 	}
=20
-	return wildmatch(pattern, name,
+	return nwildmatch(pattern, name, namelen,
 			 WM_PATHNAME | (ignore_case ? WM_CASEFOLD : 0),
 			 NULL) =3D=3D 0;
 }
--=20
1.8.2.82.gc24b958
