From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v6 10/11] diffcore-pickaxe: "share" regex error handling code
Date: Sat,  6 Feb 2016 09:03:09 +0700
Message-ID: <1454724190-14063-11-git-send-email-pclouds@gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 06 03:04:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRsEe-0004Yv-Vv
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 03:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbcBFCEZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 21:04:25 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35872 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbcBFCEY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 21:04:24 -0500
Received: by mail-pa0-f54.google.com with SMTP id yy13so42945664pab.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 18:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PXvfHdRJTWkbnNzkRMExruyoNoc3Ac0XhRKUYFyLbMI=;
        b=LWYfHsd8xStJ2iLGJIWLB7MG6kX17TyzxBtw4i6tHpZfyxgx4JL5OR/abaMFaINeGi
         DjtLBO3RzdkV3lQow5QEIGIoje5DfdLXFMFoW4sIDESGGFuZa+OB4mtvCb3Wigd0ECn8
         bTcVCNMftoc/dFFz+sGj21ARdB2LRHHA8v/chri55meuXJMsOntNCre7Gyxq149Lfk3M
         sWGLeFDPbDvH/VRceV8HosjtO+RfGa7q1roJghgVPDRts7chrC2uv7X67gJVhkaxkeUl
         kT9UwvZ6jSOqauGGVuxQQP9c/+Q6A0AKtUX++l6b1Ohg080J9vc4vlKCFmB1f3s58cHO
         fqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=PXvfHdRJTWkbnNzkRMExruyoNoc3Ac0XhRKUYFyLbMI=;
        b=RqAiKyZEF/wuEkZjK7fwiA5UicNCOBxqdp0ZZgYm50UA00dmAuxuJCH7RBFGQaofiw
         YTKWR5LGlzFsP2ih1ksIlPbGNbzWInXVYAAQ9XikbZTgd7euhjcPpbOeg37dJRm3lYIi
         JczgmyoQApSxM7FpcJgtMDcKFUqZ+l3sqJ8kmt0rUJ/1OeAeIMYFgysqUcksfyfvX4q7
         Bn0PB+5tXQZq+UWP621UppxYlw2HnFurT6JiGEyAtIQvg8zW7G3kvxalL6XimyDh7P61
         eACil4okEikbly4np2nInSAG/wY3zViH1LiBMBMDulWBVFtyad0CAVmN6lK0VmGYkM7w
         B2yg==
X-Gm-Message-State: AG10YORC9cyq9XJb9NBSJOl36iilSwfS7BDmIPocaSn11w56Fz+C1MZDyG/xltScv0BxvQ==
X-Received: by 10.66.252.136 with SMTP id zs8mr24353594pac.110.1454724263783;
        Fri, 05 Feb 2016 18:04:23 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 74sm27234350pfs.33.2016.02.05.18.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 18:04:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 06 Feb 2016 09:04:37 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285675>

There's another regcomp code block coming in this function. By moving
the error handling code out of this block, we don't have to add the
same error handling code in the new block.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diffcore-pickaxe.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 7715c13..69c6567 100644
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
2.7.0.377.g4cd97dd
