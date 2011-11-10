From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/6] parse-options: allow OPTION_ARGUMENT to take argument
Date: Thu, 10 Nov 2011 14:12:34 +0700
Message-ID: <1320909155-4575-5-git-send-email-pclouds@gmail.com>
References: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 08:12:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROOoF-0003tL-25
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 08:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757407Ab1KJHMU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Nov 2011 02:12:20 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46234 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757378Ab1KJHMU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2011 02:12:20 -0500
Received: by mail-yw0-f46.google.com with SMTP id 7so2627513ywf.19
        for <git@vger.kernel.org>; Wed, 09 Nov 2011 23:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/VI/ft//TzK/6JZ+c6yx5IHFh7ecfcw7rIYVyVnxI58=;
        b=g25FFr42bjO9sDZJqGePUMalNLX2wy4rsH8gkyMoOyn43YXgLv1hiC018hZEfT5ORY
         YbUyQ2GzzCNpSl/6618gIbLvKsc4RJQMX4j613NKQ2EHYriLj/S2oQzvRPaPrwZ882wJ
         fU4dhV1Rybt2BAH0ZoIqME9wDStSA3F7+E67U=
Received: by 10.68.11.233 with SMTP id t9mr11787916pbb.121.1320909139178;
        Wed, 09 Nov 2011 23:12:19 -0800 (PST)
Received: from tre ([115.73.226.96])
        by mx.google.com with ESMTPS id n4sm5082352pbo.10.2011.11.09.23.12.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Nov 2011 23:12:18 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 10 Nov 2011 14:13:02 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1320909155-4575-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185194>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 parse-options.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 58bb83d..3a1575a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -218,11 +218,23 @@ static int parse_long_opt(struct parse_opt_ctx_t =
*p, const char *arg,
 		if (options->type =3D=3D OPTION_ARGUMENT) {
 			if (!rest)
 				continue;
-			if (*rest =3D=3D '=3D')
-				return opterror(options, "takes no value", flags);
+			if (*rest =3D=3D '=3D') {
+				if (options->flags & PARSE_OPT_NOARG)
+					return opterror(options, "takes no value", flags);
+				p->out[p->cpidx++] =3D *p->argv;
+				return 0;
+			}
+
 			if (*rest)
 				continue;
-			p->out[p->cpidx++] =3D arg - 2;
+			p->out[p->cpidx++] =3D *p->argv;
+			if (!(options->flags & PARSE_OPT_NOARG)) {
+				p->argv++;
+				p->argc--;
+				if (!*p->argv)
+					return opterror(options, "takes no value", flags);
+				p->out[p->cpidx++] =3D *p->argv;
+			}
 			return 0;
 		}
 		if (!rest) {
--=20
1.7.4.74.g639db
