From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 9/9] for-each-ref: support %(...:aligned) for left alignment
Date: Sun, 19 May 2013 17:27:15 +0700
Message-ID: <1368959235-27777-10-git-send-email-pclouds@gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 19 12:27:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0pZ-0006qt-9B
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254Ab3ESK1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 06:27:05 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49230 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab3ESK1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:27:04 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so4805565pad.22
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=5AUEJywanmkUbChNs8wVBsx7zSqeVQVlDoEoPW5+jAg=;
        b=e4eZ2FfGX2HjD6k44e8RKdB8MHIR1Mz0SazC3+VuZNmR8To8fsdQtLignrtzN7AhWV
         o5mf97gkPvoyfc70c7IVRdY4dyjSZPWHxTh/stDZvH5/CWPgjNCIZEmMG70Ag6gEfbDJ
         hdW6BqFBXoWISLWs9pA6/gbcGRcqqRjq2SurSPUGMMin2L8pyhF8Nz0+oQANTZ6QoHyW
         dy5anwjexmejn0+S7UOrykQivqmJjLrFV8ytW6HesOPmPQpwiSqSWONwESPwSL4U4upb
         wBNP8C/mr518ug5liSx18tdq4SIQKEt/n02+B+ndY7LBpfI3u3Nml7wf0rz+SmhZvYNs
         +/OQ==
X-Received: by 10.68.180.4 with SMTP id dk4mr55604333pbc.104.1368959223997;
        Sun, 19 May 2013 03:27:03 -0700 (PDT)
Received: from lanh ([115.73.232.21])
        by mx.google.com with ESMTPSA id gc5sm19227263pbb.19.2013.05.19.03.27.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:27:03 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 19 May 2013 17:28:14 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224845>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 1390da8..3240ca0 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -11,6 +11,7 @@
 #include "remote.h"
 #include "color.h"
 #include "branch.h"
+#include "utf8.h"
=20
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -733,7 +734,7 @@ static void populate_value(struct refinfo *ref)
 		/* look for "short" refname format */
 		if (formatp) {
 			formatp++;
-			if (!strcmp(formatp, "short"))
+			if (!prefixcmp(formatp, "short"))
 				refname =3D shorten_unambiguous_ref(refname,
 						      warn_ambiguous_refs);
 			else
@@ -994,7 +995,7 @@ static void show_refs(struct refinfo **refs, int ma=
xcount,
 {
 	struct strbuf *sb;
 	const char *cp, *sp, *ep;
-	int i, atom;
+	int i, atom, aligned, max_length, len;
=20
 	sb =3D xmalloc(sizeof(*sb) * maxcount);
 	for (i =3D 0; i < maxcount; i++) {
@@ -1012,8 +1013,26 @@ static void show_refs(struct refinfo **refs, int=
 maxcount,
 				emit(sb + i, cp, sp);
 		}
 		atom =3D parse_atom(sp + 2, ep);
-		for (i =3D 0; i < maxcount; i++)
+		aligned =3D !suffixcmp(used_atom[atom], ":aligned");
+		for (i =3D 0, max_length =3D 0; aligned && i < maxcount; i++) {
+			struct atom_value *v;
+			get_value(refs[i], atom, &v);
+			len =3D utf8_strnwidth(v->s, -1, 1);
+			if (len > max_length)
+				max_length =3D len;
+		}
+		for (i =3D 0; i < maxcount; i++) {
+			int old_len =3D sb[i].len;
 			print_value(sb + i, refs[i], atom, quote_style);
+			if (aligned) {
+				len =3D max_length -
+					utf8_strnwidth(sb[i].buf + old_len, -1, 1);
+				while (len) {
+					strbuf_addch(sb + i, ' ');
+					len--;
+				}
+			}
+		}
 	}
 	if (*cp) {
 		sp =3D cp + strlen(cp);
--=20
1.8.2.83.gc99314b
