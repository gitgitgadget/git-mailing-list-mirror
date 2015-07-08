From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 8/9] diffcore-pickaxe: "share" regex error handling code
Date: Wed,  8 Jul 2015 17:38:38 +0700
Message-ID: <1436351919-2520-9-git-send-email-pclouds@gmail.com>
References: <1436186551-32544-1-git-send-email-pclouds@gmail.com>
 <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: plamen.totev@abv.bg, l.s.r@web.de,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 12:39:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCmkl-0006zv-Q8
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 12:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbbGHKiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 06:38:54 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33766 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964821AbbGHKiu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 06:38:50 -0400
Received: by pdbqm3 with SMTP id qm3so319681pdb.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rZ/HNevCvjEho/0Hqk2q9EZXaypfraVihWDkEkA0KmY=;
        b=hxiFolJE49mk/7mCc577jF4O84kYNoqQigUyCInZVDZeRbO4/tVkDvZiYYrhh5zjZC
         /s7Vn2L+GdCpnHBNiojH9zhxWLWN5D63Oy26lI1HtaOYIHpqVCbEsqvyQj+UYXqqYpZw
         AqcbnXilfHP4VMthg70g5MLKL4yeFUdtZ5XsPRfD+h5HCVAuguML0lCU1D0lTTDHpP+s
         9R9Nb3NWg1DUCKMny0GVhpJ9ZRXJIar6/cz9hYIEyqgkuf7S3SHTjrcB7cvq0WSdUj57
         WttRSIwLGF+PwSFbCjWdjpMuymGbhuOOBZ3V0budyYpO9g3UuypvNRnjJv5q/bpAe9UI
         wokA==
X-Received: by 10.66.250.12 with SMTP id yy12mr19018219pac.43.1436351930322;
        Wed, 08 Jul 2015 03:38:50 -0700 (PDT)
Received: from lanh ([115.73.45.219])
        by smtp.gmail.com with ESMTPSA id ry2sm2031283pbb.83.2015.07.08.03.38.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2015 03:38:49 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Jul 2015 17:39:35 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1436351919-2520-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273666>

There's another regcomp code block coming in this function. By moving
the error handling code out of this block, we don't have to add the
same error handling code in the new block.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-pickaxe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 185f86b..7a718fc 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -204,20 +204,13 @@ void diffcore_pickaxe(struct diff_options *o)
 	int opts =3D o->pickaxe_opts;
 	regex_t regex, *regexp =3D NULL;
 	kwset_t kws =3D NULL;
+	int err =3D 0;
=20
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
-		int err;
 		int cflags =3D REG_EXTENDED | REG_NEWLINE;
 		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
 			cflags |=3D REG_ICASE;
 		err =3D regcomp(&regex, needle, cflags);
-		if (err) {
-			/* The POSIX.2 people are surely sick */
-			char errbuf[1024];
-			regerror(err, &regex, errbuf, 1024);
-			regfree(&regex);
-			die("invalid regex: %s", errbuf);
-		}
 		regexp =3D &regex;
 	} else {
 		kws =3D kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
@@ -225,6 +218,13 @@ void diffcore_pickaxe(struct diff_options *o)
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
 	}
+	if (err) {
+		/* The POSIX.2 people are surely sick */
+		char errbuf[1024];
+		regerror(err, &regex, errbuf, 1024);
+		regfree(&regex);
+		die("invalid regex: %s", errbuf);
+	}
=20
 	/* Might want to warn when both S and G are on; I don't care... */
 	pickaxe(&diff_queued_diff, o, regexp, kws,
--=20
2.3.0.rc1.137.g477eb31
