From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 09/10] diffcore-pickaxe: "share" regex error handling code
Date: Fri, 21 Aug 2015 19:47:19 +0700
Message-ID: <1440161240-28554-10-git-send-email-pclouds@gmail.com>
References: <1436880280-18194-1-git-send-email-pclouds@gmail.com>
 <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, plamen.totev@abv.bg,
	l.s.r@web.de, Eric Sunshine <sunshine@sunshineco.com>,
	tboegi@web.de,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 21 14:59:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSluo-0004J1-9L
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 14:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753054AbbHUM7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Aug 2015 08:59:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35659 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbbHUM7U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 08:59:20 -0400
Received: by pdob1 with SMTP id b1so26571286pdo.2
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rZ/HNevCvjEho/0Hqk2q9EZXaypfraVihWDkEkA0KmY=;
        b=I7g0U673pYgUjjQfEEucU22WJndlUU12zx2ewkei9ZNLJu2Sl/nBT380v6mMa+Usik
         4V9oVDzuw2VhAZ4M6TYE4JLOCPyNoKLLWgAB1n2SQfd081svGbkgrsfH1NYwQVC0VNWG
         ZFoyxVY9iuRz2ihJKUTVfLzZxidTXXvr+z5FlhkEWDtmqFs9KB1H+4Kk/rs39TCMboI7
         w+/NT3XoR1cXquuLUwMifjATsOZ69pC5vOQ1wm7tD3uua0TV1G/Rc13Az/+4I5i/5sSZ
         VRv9sK2ftaEpY/R86UvyRRqQ0ZLjgq+pgjP5LXOAzXlhu3WVVgL4fljO8wWUt5EUvTab
         G2VA==
X-Received: by 10.70.12.100 with SMTP id x4mr17197652pdb.65.1440161960220;
        Fri, 21 Aug 2015 05:59:20 -0700 (PDT)
Received: from lanh ([171.232.84.126])
        by smtp.gmail.com with ESMTPSA id pu7sm7776148pdb.94.2015.08.21.05.59.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2015 05:59:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 21 Aug 2015 19:59:16 +0700
X-Mailer: git-send-email 2.3.0.rc1.137.g477eb31
In-Reply-To: <1440161240-28554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276297>

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
