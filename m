From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/4] count-objects: report how much disk space taken by garbage files
Date: Wed, 13 Feb 2013 16:13:19 +0700
Message-ID: <1360746799-3668-5-git-send-email-pclouds@gmail.com>
References: <7va9r9igze.fsf@alter.siamese.dyndns.org>
 <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 10:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5YPH-0005CV-RK
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 10:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635Ab3BMJNK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2013 04:13:10 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:45763 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754317Ab3BMJNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 04:13:07 -0500
Received: by mail-pa0-f53.google.com with SMTP id bg4so594468pad.40
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 01:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=cAn2dV0iwJKVSDo1mUyOPKn5qkHJST+OAZAYdonhpwM=;
        b=HTqXDzCWbUMlmNK6YLidcPiQaiomCvvdoYoLmKB417clJWNcxnvN7emt5rvIlALysX
         R9YX4p0O96+qIQmfOGCAi5ccptaTQuAXKkJfrj1MXu6Ze0vi1D86tRbwCyqK+c6gmFpz
         PMRFrEUMn/Zg4kPa3zes/7jPjKZ4sg0oVLqBi/+YwytZZl9TaXs08MnGJ6NKOq6ebbTV
         TZRsQv3iv1WFREzvpYoQnFXDZ2vXZp1OcopN+ZFn+2O1z8IsBaPN07vvbHbxqJVUBPrW
         cpoxWnNTNvkHUgXgYXwQJOC5zTrOg/dwbj7M/PFOssDz0wQ1ACdGe0KMvWYrm+4Q8jS3
         x9rg==
X-Received: by 10.66.9.2 with SMTP id v2mr61552990paa.18.1360746786892;
        Wed, 13 Feb 2013 01:13:06 -0800 (PST)
Received: from lanh ([115.74.60.127])
        by mx.google.com with ESMTPS id i6sm81963261paw.19.2013.02.13.01.13.03
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 01:13:05 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Feb 2013 16:13:52 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1360746799-3668-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216243>

Also issue warnings on loose garbages instead of errors as a result of
using report_garbage() function in count_objects()

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-count-objects.txt |  2 ++
 builtin/count-objects.c             | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-count-objects.txt b/Documentation/git-co=
unt-objects.txt
index 1611d7c..da6e72e 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -35,6 +35,8 @@ the packs. These objects could be pruned using `git p=
rune-packed`.
 +
 garbage: the number of files in object database that are not valid
 loose objects nor valid packs
++
+size-garbage: disk space consumed by garbage files, in KiB
=20
 GIT
 ---
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 1706c8b..3a01a8d 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -10,9 +10,13 @@
 #include "parse-options.h"
=20
 static unsigned long garbage;
+static off_t size_garbage;
=20
 static void real_report_garbage(const char *desc, const char *path)
 {
+	struct stat st;
+	if (!stat(path, &st))
+		size_garbage +=3D st.st_size;
 	warning("%s: %s", desc, path);
 	garbage++;
 }
@@ -20,8 +24,7 @@ static void real_report_garbage(const char *desc, con=
st char *path)
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
-			  unsigned long *packed_loose,
-			  unsigned long *garbage)
+			  unsigned long *packed_loose)
 {
 	struct dirent *ent;
 	while ((ent =3D readdir(d)) !=3D NULL) {
@@ -54,9 +57,11 @@ static void count_objects(DIR *d, char *path, int le=
n, int verbose,
 		}
 		if (bad) {
 			if (verbose) {
-				error("garbage found: %.*s/%s",
-				      len + 2, path, ent->d_name);
-				(*garbage)++;
+				struct strbuf sb =3D STRBUF_INIT;
+				strbuf_addf(&sb, "%.*s/%s",
+					    len + 2, path, ent->d_name);
+				report_garbage("garbage found", sb.buf);
+				strbuf_release(&sb);
 			}
 			continue;
 		}
@@ -107,7 +112,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		if (!d)
 			continue;
 		count_objects(d, path, len, verbose,
-			      &loose, &loose_size, &packed_loose, &garbage);
+			      &loose, &loose_size, &packed_loose);
 		closedir(d);
 	}
 	if (verbose) {
@@ -132,6 +137,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		printf("size-pack: %lu\n", (unsigned long) (size_pack / 1024));
 		printf("prune-packable: %lu\n", packed_loose);
 		printf("garbage: %lu\n", garbage);
+		printf("size-garbage: %lu\n", (unsigned long) (size_garbage / 1024))=
;
 	}
 	else
 		printf("%lu objects, %lu kilobytes\n",
--=20
1.8.1.2.536.gf441e6d
