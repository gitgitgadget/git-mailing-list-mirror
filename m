From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 1/2] Get correct column with for options in command usage
Date: Wed,  6 Feb 2013 00:16:55 +0800
Message-ID: <883efc2358a0deb48bee48134d45ddd528a732d3.1360080194.git.worldhello.net@gmail.com>
References: <20130205121552.GA16601@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 17:20:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2lFh-0000sA-DQ
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 17:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756041Ab3BEQTi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 11:19:38 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:62439 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697Ab3BEQTf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 11:19:35 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so434510ieb.25
        for <git@vger.kernel.org>; Tue, 05 Feb 2013 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=34smzjxbZ97WcDQ7mk6Nc/xyZe8TfPsr83ousHgWmBo=;
        b=sZ6Q0HeH9/CQbJgb0uotG/ZXZKdHc1pAokybTH6KGYP3UTjrLsQPryPf3H9r23IOLw
         DKcD1k0YrJgkTSVSheM5wBbT9kP9x2DmOH+FlrshjJ8rWYwAELvzCpsiKBmiT9o+fRJK
         N3CuYZg38JQSSAHv4fRsLG4SqEE5LFBxeaHRHpOgTR3itamTL+wmlgD23riVxqsMJXWp
         K00Ghw9S4dqi7JDJEX12HS9rQiOBCtaWHcNZeJGIEzpXhsMslSy231jvDfaSVOmfF94W
         Wtof97gdlFkmNrN2xFehpVOhl+qTebmmATDrw+0O7wGqzjhr6Nlsj8i8985yvL/AcE17
         hUTg==
X-Received: by 10.50.47.168 with SMTP id e8mr14303586ign.50.1360081174923;
        Tue, 05 Feb 2013 08:19:34 -0800 (PST)
Received: from localhost.localdomain ([114.248.148.50])
        by mx.google.com with ESMTPS id iw5sm20961335igc.5.2013.02.05.08.19.26
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 05 Feb 2013 08:19:33 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.369.g1321903.dirty
In-Reply-To: <20130205121552.GA16601@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215515>

Command usage would not align well if command options are translated,
especially to CJK. Call utf8_strwidth in function usage_argh, so that
the caller will get correct column width.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 67e98..cd029f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -3,6 +3,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "color.h"
+#include "utf8.h"
=20
 static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 			       const char * const *usagestr,
@@ -473,7 +474,7 @@ int parse_options(int argc, const char **argv, cons=
t char *prefix,
=20
 static int usage_argh(const struct option *opts, FILE *outfile)
 {
-	const char *s;
+	const char *s, *p;
 	int literal =3D (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->a=
rgh;
 	if (opts->flags & PARSE_OPT_OPTARG)
 		if (opts->long_name)
@@ -482,7 +483,10 @@ static int usage_argh(const struct option *opts, F=
ILE *outfile)
 			s =3D literal ? "[%s]" : "[<%s>]";
 	else
 		s =3D literal ? " %s" : " <%s>";
-	return fprintf(outfile, s, opts->argh ? _(opts->argh) : _("..."));
+	p =3D opts->argh ? _(opts->argh) : _("...");
+	fprintf(outfile, s, p);
+	/* Remove extra 2 chars ("%s" in s) to get column width of utf8 strin=
g */
+	return utf8_strwidth(p) + strlen(s) - 2;
 }
=20
 #define USAGE_OPTS_WIDTH 24
--=20
1.8.1.1.368.g6034fad.dirty
