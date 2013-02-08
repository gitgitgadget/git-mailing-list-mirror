From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] count-objects: report how much disk space taken by garbage files
Date: Fri,  8 Feb 2013 10:48:27 +0700
Message-ID: <1360295307-5469-4-git-send-email-pclouds@gmail.com>
References: <1359982145-10792-1-git-send-email-pclouds@gmail.com>
 <1360295307-5469-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 04:51:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3ezw-0001c0-Ah
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 04:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759727Ab3BHDvM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2013 22:51:12 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:33583 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759721Ab3BHDvK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 22:51:10 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so1573742dak.28
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 19:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=K3yzhCRqcqduz0elsqY9PAmF/8Ij5o2cNZdy80FA8DY=;
        b=tbThE6Q9XfyiXfwgsEJSbFCMDIcbt3VxpuZR7CjPt5OqPUHHek3Txl8kkZLKGDAExE
         NMa7F1DFTMHq5c+UjflrlVZ4v/+3xwK1KxjETYGJrcZZEG0v+UflwYbQ1r8+g8i09Q61
         V+/msLPivnCygDJR3lr0UmoKi1uhRklCMUNGINZaC1T1dNET8zc+8EaOgiB30TVequl0
         3Gcy/6ntmgn96DlhnHSnMhTl1wcG+A8HaW6emaq6xTG0OF2cljijDELfUhV5OcKYNz1Y
         1nHbdjWifMxcNT87iyNtFZVW0eD3s5iTdEJjn+ge7uAud3SYKviRwWmlGgdxIeZMUUwv
         jRIg==
X-Received: by 10.66.81.68 with SMTP id y4mr12573415pax.66.1360295470042;
        Thu, 07 Feb 2013 19:51:10 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id q4sm50879634paz.20.2013.02.07.19.51.06
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 19:51:09 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 08 Feb 2013 10:51:03 +0700
X-Mailer: git-send-email 1.8.1.2.495.g3fdf5d5.dirty
In-Reply-To: <1360295307-5469-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215747>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 We may do some redundant stat() here, but I don't think it can slow
 count-objects down much to worry about.

 Documentation/git-count-objects.txt |  2 ++
 builtin/count-objects.c             | 29 ++++++++++++++++++-----------
 2 files changed, 20 insertions(+), 11 deletions(-)

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
index 118b2ae..90d476d 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -10,24 +10,33 @@
 #include "parse-options.h"
=20
 static unsigned long garbage;
+static off_t size_garbage;
=20
 extern void (*report_pack_garbage)(const char *path, int len, const ch=
ar *name);
 static void real_report_pack_garbage(const char *path, int len, const =
char *name)
 {
+	struct strbuf sb =3D STRBUF_INIT;
+	struct stat st;
+
 	if (len && name)
-		error("garbage found: %.*s/%s", len, path, name);
+		strbuf_addf(&sb, "%.*s/%s", len, path, name);
 	else if (!len && name)
-		error("garbage found: %s%s", path, name);
+		strbuf_addf(&sb, "%s%s", path, name);
 	else
-		error("garbage found: %s", path);
+		strbuf_addf(&sb, "%s", path);
+	error(_("garbage found: %s"), sb.buf);
+
+	if (!stat(sb.buf, &st))
+		size_garbage +=3D st.st_size;
+
 	garbage++;
+	strbuf_release(&sb);
 }
=20
 static void count_objects(DIR *d, char *path, int len, int verbose,
 			  unsigned long *loose,
 			  off_t *loose_size,
-			  unsigned long *packed_loose,
-			  unsigned long *garbage)
+			  unsigned long *packed_loose)
 {
 	struct dirent *ent;
 	while ((ent =3D readdir(d)) !=3D NULL) {
@@ -59,11 +68,8 @@ static void count_objects(DIR *d, char *path, int le=
n, int verbose,
 				(*loose_size) +=3D xsize_t(on_disk_bytes(st));
 		}
 		if (bad) {
-			if (verbose) {
-				error("garbage found: %.*s/%s",
-				      len + 2, path, ent->d_name);
-				(*garbage)++;
-			}
+			if (verbose)
+				report_pack_garbage(path, len + 2, ent->d_name);
 			continue;
 		}
 		(*loose)++;
@@ -113,7 +119,7 @@ int cmd_count_objects(int argc, const char **argv, =
const char *prefix)
 		if (!d)
 			continue;
 		count_objects(d, path, len, verbose,
-			      &loose, &loose_size, &packed_loose, &garbage);
+			      &loose, &loose_size, &packed_loose);
 		closedir(d);
 	}
 	if (verbose) {
@@ -138,6 +144,7 @@ int cmd_count_objects(int argc, const char **argv, =
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
1.8.1.2.495.g3fdf5d5.dirty
