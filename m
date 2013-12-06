From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/3] pathspec.c: support adding prefix magic to a pathspec with mnemonic magic
Date: Fri,  6 Dec 2013 14:30:49 +0700
Message-ID: <1386315049-19097-4-git-send-email-pclouds@gmail.com>
References: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 08:26:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vopnw-0005Is-HJ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 08:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754029Ab3LFH0Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Dec 2013 02:26:24 -0500
Received: from mail-pd0-f176.google.com ([209.85.192.176]:35029 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3LFH0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 02:26:23 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so546975pde.35
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 23:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QCw08M4xgwkiFKJYJjkAoJ8JrhEfQoWSNHJD1MWXI38=;
        b=uHiq7qLQ7N97TNqQ3pfaOjm9ewqHGumPvhF7+SYtoYYzTyR66k6y9NJimc70O3T9oG
         2UHGOYwM86Aj4rqco+WXMK+RhUuzdUxhIxxl/y/JGHahs3a0R6Q3zEi03MT+NN6RGDXx
         u4/GZd32B10Q5qH6cI+rQzsDsOQZ9+nZ0o8JHpmsORfvQgVSv0Ze9wcHR/X+Eq8B85Kw
         1bDYmF6rpZlTWt2m59Aa2DiBmzrtOf0rNueCtuxdJRMjDB+e9RT9B8ELiiUkQXUr+A7A
         QCtCEzxM94OoDbUwy5+JhwjH3Ib8bGR9cykERBPeYbm3y4pBYiWAnaztAH00nBMn1cd8
         wuNg==
X-Received: by 10.66.162.167 with SMTP id yb7mr2479395pab.16.1386314783061;
        Thu, 05 Dec 2013 23:26:23 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id bp5sm149576593pbb.18.2013.12.05.23.26.20
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 23:26:22 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Dec 2013 14:31:07 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386315049-19097-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238928>

Back in 233c3e6 (parse_pathspec: preserve prefix length via
PATHSPEC_PREFIX_ORIGIN - 2013-07-14), parse_pathspec() is taught to
save prefix length as a dynamic magic. This is needed when the
pathspec is passed to another process and and prefix lenght would be
lost.

Back then we support two cases. If the pathspec is normal, e.g. "abc",
we simply add the prefix to become ":(prefix:2)abc". If the pathspec
contains long magic, e.g. ":(foo,bar)abc" then we turn it to
":(foo,bar,prefix:2)abc". We do not support prefixing on short form,
because the only supported mnemonic '/' disappears after the the
preprocessing steps.

With the introduction of exclude magic with mnemonic '!', we need to
add support for the short form case so that ':!abc' becomes
':(exclude,prefix:2)abc'. Without this, it will break

    cd Documentation
    git add -p -- . ':!technical'

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 pathspec.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 4e6a727..2b7f2e2 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -74,6 +74,20 @@ static struct pathspec_magic {
 	{ PATHSPEC_EXCLUDE, '!', "exclude" },
 };
=20
+static void prefix_short_magic(struct strbuf *sb, int prefixlen,
+			       unsigned short_magic)
+{
+	int i;
+	strbuf_addstr(sb, ":(");
+	for (i =3D 0; i < ARRAY_SIZE(pathspec_magic); i++)
+		if (short_magic & pathspec_magic[i].bit) {
+			if (sb->buf[sb->len - 1] !=3D '(')
+				strbuf_addch(sb, ',');
+			strbuf_addstr(sb, pathspec_magic[i].name);
+		}
+	strbuf_addf(sb, ",prefix:%d)", prefixlen);
+}
+
 /*
  * Take an element of a pathspec and check for magic signatures.
  * Append the result to the prefix. Return the magic bitmap.
@@ -233,22 +247,16 @@ static unsigned prefix_pathspec(struct pathspec_i=
tem *item,
 	 */
 	if (flags & PATHSPEC_PREFIX_ORIGIN) {
 		struct strbuf sb =3D STRBUF_INIT;
-		const char *start =3D elt;
 		if (prefixlen && !literal_global) {
 			/* Preserve the actual prefix length of each pattern */
 			if (short_magic)
-				die("BUG: prefixing on short magic is not supported");
+				prefix_short_magic(&sb, prefixlen, short_magic);
 			else if (long_magic_end) {
-				strbuf_add(&sb, start, long_magic_end - start);
-				strbuf_addf(&sb, ",prefix:%d", prefixlen);
-				start =3D long_magic_end;
-			} else {
-				if (*start =3D=3D ':')
-					start++;
+				strbuf_add(&sb, elt, long_magic_end - elt);
+				strbuf_addf(&sb, ",prefix:%d)", prefixlen);
+			} else
 				strbuf_addf(&sb, ":(prefix:%d)", prefixlen);
-			}
 		}
-		strbuf_add(&sb, start, copyfrom - start);
 		strbuf_addstr(&sb, match);
 		item->original =3D strbuf_detach(&sb, NULL);
 	} else
--=20
1.8.5.1.25.g8667982
