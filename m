From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/9] for-each-ref: add %(current) for current branch marker
Date: Sun, 19 May 2013 17:27:10 +0700
Message-ID: <1368959235-27777-5-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:26:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pC-0006XP-N9
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:26:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754197Ab3ESK0i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:26:38 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:47906 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752790Ab3ESK0g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:26:36 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so3462203pdc.25
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iNlEtVXNLLFNkqCLExxUOAccrlziYAClEWc/GHWBY2U=;
        b=eNiLqb3T0U7sZaVyPevi41UiBmegd9vevstC2iOWefnxUMYEnxTjgzqNPJguC41Yat
         X1SrIVQqtfVrId4bhxk+1BroPYGi28ok6o/BEsWHrkOuswGuA5QF5gxwc7zkIFj/EbM1
         ixqt1OCRFUn0t0oAbeT7Eqhl/9Qwkg4oxE8tF5UVWTMBFPNSqRXi3JltuPKa5DxjQfmm
         2iTKo7Efcn/Gk2HoLnaRH75oYlGCEcmdj/SJx8KHtJfNsRnsJ//KNLhaPCwbzz7k7WKK
         nidavuxaBiHk5BH5/Fgw9gOnuEhlZlDuHSkD0grl1qFAiGuVorUm1sXaI5CeVGAER8WE
         z1jg==
X-Received: by 10.66.166.107 with SMTP id zf11mr56800417pab.166.1368959195905;
        Sun, 19 May 2013 03:26:35 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id k2sm20687457pat.7.2013.05.19.03.26.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:26:35 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:27:46 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224841>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 08d4eb1..498d703 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -75,6 +75,7 @@ static struct {
 	{ "upstream" },
 	{ "symref" },
 	{ "flag" },
+	{ "current" },
 };
=20
 /*
@@ -90,6 +91,7 @@ static struct {
 static const char **used_atom;
 static cmp_type *used_atom_type;
 static int used_atom_cnt, sort_atom_limit, need_tagged, need_symref;
+static const char *head;
=20
 /*
  * Used to parse format string and sort specifiers
@@ -676,6 +678,17 @@ static void populate_value(struct refinfo *ref)
 			}
 			continue;
 		}
+		else if (!strcmp(name, "current")) {
+			if (!head) {
+				unsigned char sha1[20];
+				head =3D resolve_refdup("HEAD", sha1, 0, NULL);
+			}
+			if (strcmp(head, "HEAD") && !strcmp(ref->refname, head))
+				v->s =3D "*";
+			else
+				v->s =3D " ";
+			continue;
+		}
 		else
 			continue;
=20
--=20
1.8.2.83.gc99314b
