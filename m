From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] rev-parse: support OPT_NUMBER_CALLBACK in --parseopt
Date: Sun,  2 Mar 2014 09:53:12 +0700
Message-ID: <1393728794-29566-2-git-send-email-pclouds@gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, philipoakley@iee.org,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 03:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwXX-0000U4-Lr
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbaCBCxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Mar 2014 21:53:55 -0500
Received: from mail-pb0-f48.google.com ([209.85.160.48]:63124 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbaCBCxd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:53:33 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so2356664pbc.21
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yyNGM7qt5msadK5UfO7x5zpyKmq42R0ATkUgjbbUO3A=;
        b=kmGUar6rzcSQ7vCB2/2uvYSW/O6Mzbsg2AnBC3dO2rV8cyBtL0yzBeoQ+gS6q9YaGw
         ft+TV5qUJMg32exuPsXMnFosGohmOUF6J+s1RiXSnxLcT83pk9ruEa9Ndz6aP1TNLPUo
         bdYrult8CLDhjHgAmpHyD+teQuuW9knXAsurkFswAfAo6fXPLK6JEguxWDvwyfwQM1u2
         F4bIZUcoLO+nx5lcIrbOkZUAL/jDV6Ynf6Mrn1lpPqgdW8GVL6uCGz3Td/ZGM3rJSZGn
         3n0WZmzO29gDbkTkpEBJM+bSCT2sxAPE0uCD9yK+p5TH1Wi1AH2DrqDrH4UpgMhSlAio
         Kghw==
X-Received: by 10.68.89.162 with SMTP id bp2mr101769pbb.151.1393728812927;
        Sat, 01 Mar 2014 18:53:32 -0800 (PST)
Received: from lanh ([115.73.238.45])
        by mx.google.com with ESMTPSA id it4sm20998241pbc.39.2014.03.01.18.53.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 01 Mar 2014 18:53:32 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 02 Mar 2014 09:53:58 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1393728794-29566-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243124>

If the option spec is

-NUM Help string

then rev-parse will accept and parse -([0-9]+) and return "-NUM $1"

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/rev-parse.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 45901df..b37676f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -331,6 +331,8 @@ static int parseopt_dump(const struct option *o, co=
nst char *arg, int unset)
 	struct strbuf *parsed =3D o->value;
 	if (unset)
 		strbuf_addf(parsed, " --no-%s", o->long_name);
+	else if (o->type =3D=3D OPTION_NUMBER)
+		strbuf_addf(parsed, " -NUM");
 	else if (o->short_name && (o->long_name =3D=3D NULL || !stuck_long))
 		strbuf_addf(parsed, " -%c", o->short_name);
 	else
@@ -338,7 +340,7 @@ static int parseopt_dump(const struct option *o, co=
nst char *arg, int unset)
 	if (arg) {
 		if (!stuck_long)
 			strbuf_addch(parsed, ' ');
-		else if (o->long_name)
+		else if (o->long_name || o->type =3D=3D OPTION_NUMBER)
 			strbuf_addch(parsed, '=3D');
 		sq_quote_buf(parsed, arg);
 	}
@@ -439,7 +441,10 @@ static int cmd_parseopt(int argc, const char **arg=
v, const char *prefix)
=20
 		if (s - sb.buf =3D=3D 1) /* short option only */
 			o->short_name =3D *sb.buf;
-		else if (sb.buf[1] !=3D ',') /* long option only */
+		else if (s - sb.buf =3D=3D 4 && !strncmp(sb.buf, "-NUM", 4)) {
+			o->type =3D OPTION_NUMBER;
+			o->flags =3D PARSE_OPT_NOARG | PARSE_OPT_NONEG;
+		} else if (sb.buf[1] !=3D ',') /* long option only */
 			o->long_name =3D xmemdupz(sb.buf, s - sb.buf);
 		else {
 			o->short_name =3D *sb.buf;
--=20
1.9.0.40.gaa8c3ea
