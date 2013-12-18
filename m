From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/12] diff.c: reduce code duplication in --stat-xxx parsing
Date: Wed, 18 Dec 2013 21:53:54 +0700
Message-ID: <1387378437-20646-10-git-send-email-pclouds@gmail.com>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 18 15:55:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtIWk-0004B4-NK
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 15:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755203Ab3LROzA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 09:55:00 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:48321 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754693Ab3LROy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 09:54:59 -0500
Received: by mail-pa0-f45.google.com with SMTP id fb1so6045793pad.4
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DR106/ZwoBOTpvuoiXBGRA83aZRkIFuGy39WsNyujcY=;
        b=cnwh30u/dv1tGJTmuuICdqSp2uZMoH+NNKwZBoIa1mHba0QufPzXhxdh4f4pP4QBOW
         OsJlzlM2Ptx6bpah6wqGUzplfbjRKi+51ZGe0u3h9F4uLD7gnBg8t5BJwvUJ9gZPaNMM
         HIXWEKpQf8k9zwWYDCn1RFAUhJJE3u8v1InNdedTFPAWqQ/VZPK/GeTCK5DcCYwFjB7v
         Kqfxz3hSwE+CRbiZr3mX3vv+Mpa3dG3IiDaSA2RyvrtY3GT9dO0HmMlRD78d+k5XGBlU
         PRSS2SyBT0bKMDiudgM9Jr9b4JSZMusmy4Hfv8XBO3pEy2vQmFEA6Da9QRH/VJFqKPKH
         X1vA==
X-Received: by 10.68.206.171 with SMTP id lp11mr7050993pbc.109.1387378498620;
        Wed, 18 Dec 2013 06:54:58 -0800 (PST)
Received: from lanh ([115.73.220.136])
        by mx.google.com with ESMTPSA id oa3sm558106pbb.15.2013.12.18.06.54.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 06:54:57 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 18 Dec 2013 21:54:55 +0700
X-Mailer: git-send-email 1.8.5.1.208.g019362e
In-Reply-To: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239448>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 67 +++++++++++++++++++++++++---------------------------------=
--------
 1 file changed, 25 insertions(+), 42 deletions(-)

diff --git a/diff.c b/diff.c
index d754e2f..4da77fd 100644
--- a/diff.c
+++ b/diff.c
@@ -3405,6 +3405,23 @@ int parse_long_opt(const char *opt, const char *=
*argv,
 	return 2;
 }
=20
+static int parse_statopt(const char *arg, const char *next,
+			 const char *opt, int *value, char **end)
+{
+	const char *p =3D skip_prefix(arg, opt);
+	if (!p)
+		return 0;
+	if (*p =3D=3D '=3D')
+		*value =3D strtoul(p + 1, end, 10);
+	else if (!*p && !next)
+		die("Option '--stat%s' requires a value", opt);
+	else if (!*p) {
+		*value =3D strtoul(next, end, 10);
+		return 2;
+	}
+	return 1;
+}
+
 static int stat_opt(struct diff_options *options, const char **av)
 {
 	const char *arg =3D av[0];
@@ -3417,50 +3434,16 @@ static int stat_opt(struct diff_options *option=
s, const char **av)
=20
 	arg +=3D strlen("--stat");
 	end =3D (char *)arg;
-
 	switch (*arg) {
 	case '-':
-		if (starts_with(arg, "-width")) {
-			arg +=3D strlen("-width");
-			if (*arg =3D=3D '=3D')
-				width =3D strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die("Option '--stat-width' requires a value");
-			else if (!*arg) {
-				width =3D strtoul(av[1], &end, 10);
-				argcount =3D 2;
-			}
-		} else if (starts_with(arg, "-name-width")) {
-			arg +=3D strlen("-name-width");
-			if (*arg =3D=3D '=3D')
-				name_width =3D strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die("Option '--stat-name-width' requires a value");
-			else if (!*arg) {
-				name_width =3D strtoul(av[1], &end, 10);
-				argcount =3D 2;
-			}
-		} else if (starts_with(arg, "-graph-width")) {
-			arg +=3D strlen("-graph-width");
-			if (*arg =3D=3D '=3D')
-				graph_width =3D strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die("Option '--stat-graph-width' requires a value");
-			else if (!*arg) {
-				graph_width =3D strtoul(av[1], &end, 10);
-				argcount =3D 2;
-			}
-		} else if (starts_with(arg, "-count")) {
-			arg +=3D strlen("-count");
-			if (*arg =3D=3D '=3D')
-				count =3D strtoul(arg + 1, &end, 10);
-			else if (!*arg && !av[1])
-				die("Option '--stat-count' requires a value");
-			else if (!*arg) {
-				count =3D strtoul(av[1], &end, 10);
-				argcount =3D 2;
-			}
-		}
+		if ((argcount =3D parse_statopt(arg, av[1], "-width", &width, &end))=
 !=3D 0 ||
+		    (argcount =3D parse_statopt(arg, av[1], "-name-width", &name_wid=
th, &end)) !=3D 0 ||
+		    (argcount =3D parse_statopt(arg, av[1], "-graph-width", &graph_w=
idth, &end)) !=3D 0 ||
+		    (argcount =3D parse_statopt(arg, av[1], "-count", &count, &end))=
 !=3D 0)
+			/* nothing else, it's the OR chain that's important */
+			;
+		else
+			argcount =3D 1;
 		break;
 	case '=3D':
 		width =3D strtoul(arg+1, &end, 10);
--=20
1.8.5.1.208.g019362e
