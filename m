From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: [PATCH 2/2] added more informative error messages to git-mktag
Date: Mon, 22 May 2006 16:49:53 +0200
Message-ID: <4471CF91.9010202@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon May 22 16:50:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiBjB-0005hs-Gf
	for gcvg-git@gmane.org; Mon, 22 May 2006 16:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbWEVOtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 May 2006 10:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWEVOtq
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 10:49:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:13762 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750888AbWEVOtq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 10:49:46 -0400
Received: (qmail invoked by alias); 22 May 2006 14:49:44 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp026) with SMTP; 22 May 2006 16:49:44 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20510>


Signed-off-by: Bj=F6rn Engelmann <BjEngelmann@gmx.de>


---

5045fd2336abbe57f191e8839759369ee1c7cc6e
 mktag.c |   41 +++++++++++++++++++++++++++++++----------
 1 files changed, 31 insertions(+), 10 deletions(-)

5045fd2336abbe57f191e8839759369ee1c7cc6e
diff --git a/mktag.c b/mktag.c
index 79c466c..9f4878c 100644
--- a/mktag.c
+++ b/mktag.c
@@ -45,42 +45,60 @@ static int verify_tag(char *buffer, unsi
     unsigned char sha1[20];
     const char *object, *type_line, *tag_line, *tagger_line;
=20
-    if (size < 64)
+    if (size < 64) {
+        printf("wanna fool me ? you obviously got the size wrong !\n")=
;
         return -1;
+    }
     buffer[size] =3D 0;
=20
     /* Verify object line */
     object =3D buffer;
-    if (memcmp(object, "object ", 7))
+    if (memcmp(object, "object ", 7)) {
+        printf("char%i: does not start with \"object \"\n", 0);
         return -1;
-    if (get_sha1_hex(object + 7, sha1))
+    }
+    if (get_sha1_hex(object + 7, sha1)) {
+        printf("char%i: could not get SHA1 hash\n", 7);
         return -1;
+    }
=20
     /* Verify type line */
     type_line =3D object + 48;
-    if (memcmp(type_line - 1, "\ntype ", 6))
+    if (memcmp(type_line - 1, "\ntype ", 6)) {
+        printf("char%i: could not find \"\\ntype \"\n", 47);
         return -1;
+    }
=20
     /* Verify tag-line */
     tag_line =3D strchr(type_line, '\n');
-    if (!tag_line)
+    if (!tag_line) {
+        printf("char%i: could not find next \"\\n\"\n", (int)type_line
- (int)buffer);
         return -1;
+    }
     tag_line++;
-    if (memcmp(tag_line, "tag ", 4) || tag_line[4] =3D=3D '\n')
+    if (memcmp(tag_line, "tag ", 4) || tag_line[4] =3D=3D '\n') {
+        printf("char%i: no \"tag \" found\n", (int)tag_line - (int)buf=
fer);
         return -1;
+    }
=20
     /* Get the actual type */
     typelen =3D tag_line - type_line - strlen("type \n");
-    if (typelen >=3D sizeof(type))
+    if (typelen >=3D sizeof(type)) {
+        printf("char%i: type too long\n", (int)type_line + strlen("typ=
e
\n") - (int)buffer);
         return -1;
+    }
     memcpy(type, type_line+5, typelen);
     type[typelen] =3D 0;
=20
     /* Verify that the object matches */
-    if (get_sha1_hex(object + 7, sha1))
+    if (get_sha1_hex(object + 7, sha1)) {
+        printf("char%i: could not get SHA1 hash but this is really odd
since i got it before !\n", 7);
         return -1;
-    if (verify_object(sha1, type))
+    }
+    if (verify_object(sha1, type)) {
+        printf("char%i: could not verify object %s\n", 7, sha1);
         return -1;
+    }
=20
     /* Verify the tag-name: we don't allow control characters or space=
s
in it */
     tag_line +=3D 4;
@@ -90,14 +108,17 @@ static int verify_tag(char *buffer, unsi
             break;
         if (c > ' ')
             continue;
+        printf("char%i: could not verify tag name\n", (int)tag_line -
(int)buffer);
         return -1;
     }
=20
     /* Verify the tagger line */
     tagger_line =3D tag_line;
=20
-    if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] =3D=3D '\n=
'))
+    if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] =3D=3D '\n=
')) {
+        printf("char%i: could not find \"tagger\"\n", (int)tagger_line
- (int)buffer);
         return -1;
+    }
=20
     /* The actual stuff afterwards we don't care about.. */
     return 0;
--=20
1.3.3.g5045-dirty
