From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 16/28] receive-pack: reorder some code in unpack()
Date: Thu,  5 Dec 2013 20:02:43 +0700
Message-ID: <1386248575-10206-17-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:00:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYXB-0002IY-IA
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194Ab3LEM76 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:58 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64081 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab3LEM75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:57 -0500
Received: by mail-pd0-f180.google.com with SMTP id q10so24447362pdj.25
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BYsPUBBpohup5UN0y9LA9WOorlQseIUFwVGON8m2SQc=;
        b=x7TQ6MKlDV12GM6vX00GQRnJj7MwbXIv26uhKdNha3nYieuN/jniVe1mLhR76luZAr
         wWCpJGVycAKw0JquXPnU/fdzcB0UMCghnuGPq2v40nsJM0sCUCOWtX9dgSBrRXzuqfvz
         qGrc9OPU3SWEpoAQWMtz8YJSRHIa6U/i9qc7mqPzib5CYcgSUfxHe2vZFLi8KqrDV8I6
         nOJmuwsNxsuRctuokSkf2uX3FYy08CgKvMMIo0w+Xbwxq0Wx2QiQeGEzkRm3eCOlhbI1
         lVivOfFXy4IiVvp2133UENhFTK7WFz0eQwy58Zx2NwPzK15MHxOEsmDRUK2pSd8mPYMO
         hg+w==
X-Received: by 10.68.191.106 with SMTP id gx10mr52289384pbc.47.1386248396553;
        Thu, 05 Dec 2013 04:59:56 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id gf5sm144609664pbc.22.2013.12.05.04.59.53
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:55 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:39 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238872>

This is the preparation for adding --shallow-file to both
unpack-objects and index-pack. To sum up:

 - struct argv_array used instead of const char **

 - status/code, ip/child, unpacker/keeper are moved out to function
   top level

 - successful flow now ends at the end of the function

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c | 70 ++++++++++++++++++++++--------------------=
--------
 1 file changed, 30 insertions(+), 40 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cc8c34f..8927ddf 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -13,6 +13,7 @@
 #include "string-list.h"
 #include "sha1-array.h"
 #include "connected.h"
+#include "argv-array.h"
 #include "version.h"
=20
 static const char receive_pack_usage[] =3D "git receive-pack <git-dir>=
";
@@ -822,8 +823,11 @@ static const char *pack_lockfile;
 static const char *unpack(int err_fd)
 {
 	struct pack_header hdr;
+	struct argv_array av =3D ARGV_ARRAY_INIT;
 	const char *hdr_err;
+	int status;
 	char hdr_arg[38];
+	struct child_process child;
 	int fsck_objects =3D (receive_fsck_objects >=3D 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >=3D 0
@@ -840,63 +844,49 @@ static const char *unpack(int err_fd)
 			"--pack_header=3D%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
=20
+	memset(&child, 0, sizeof(child));
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		int code, i =3D 0;
-		struct child_process child;
-		const char *unpacker[5];
-		unpacker[i++] =3D "unpack-objects";
+		argv_array_pushl(&av, "unpack-objects", hdr_arg, NULL);
 		if (quiet)
-			unpacker[i++] =3D "-q";
+			argv_array_push(&av, "-q");
 		if (fsck_objects)
-			unpacker[i++] =3D "--strict";
-		unpacker[i++] =3D hdr_arg;
-		unpacker[i++] =3D NULL;
-		memset(&child, 0, sizeof(child));
-		child.argv =3D unpacker;
+			argv_array_push(&av, "--strict");
+		child.argv =3D av.argv;
 		child.no_stdout =3D 1;
 		child.err =3D err_fd;
 		child.git_cmd =3D 1;
-		code =3D run_command(&child);
-		if (!code)
-			return NULL;
-		return "unpack-objects abnormal exit";
+		status =3D run_command(&child);
+		if (status)
+			return "unpack-objects abnormal exit";
 	} else {
-		const char *keeper[7];
-		int s, status, i =3D 0;
+		int s;
 		char keep_arg[256];
-		struct child_process ip;
=20
 		s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (uin=
tmax_t) getpid());
 		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
 			strcpy(keep_arg + s, "localhost");
=20
-		keeper[i++] =3D "index-pack";
-		keeper[i++] =3D "--stdin";
+		argv_array_pushl(&av, "index-pack",
+				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
-			keeper[i++] =3D "--strict";
+			argv_array_push(&av, "--strict");
 		if (fix_thin)
-			keeper[i++] =3D "--fix-thin";
-		keeper[i++] =3D hdr_arg;
-		keeper[i++] =3D keep_arg;
-		keeper[i++] =3D NULL;
-		memset(&ip, 0, sizeof(ip));
-		ip.argv =3D keeper;
-		ip.out =3D -1;
-		ip.err =3D err_fd;
-		ip.git_cmd =3D 1;
-		status =3D start_command(&ip);
-		if (status) {
+			argv_array_push(&av, "--fix-thin");
+		child.argv =3D av.argv;
+		child.out =3D -1;
+		child.err =3D err_fd;
+		child.git_cmd =3D 1;
+		status =3D start_command(&child);
+		if (status)
 			return "index-pack fork failed";
-		}
-		pack_lockfile =3D index_pack_lockfile(ip.out);
-		close(ip.out);
-		status =3D finish_command(&ip);
-		if (!status) {
-			reprepare_packed_git();
-			return NULL;
-		}
-		return "index-pack abnormal exit";
+		pack_lockfile =3D index_pack_lockfile(child.out);
+		close(child.out);
+		status =3D finish_command(&child);
+		if (status)
+			return "index-pack abnormal exit";
+		reprepare_packed_git();
 	}
+	return NULL;
 }
=20
 static const char *unpack_with_sideband(void)
--=20
1.8.5.1.25.g8667982
