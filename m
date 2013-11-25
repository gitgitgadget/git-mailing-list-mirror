From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 16/28] receive-pack: reorder some code in unpack()
Date: Mon, 25 Nov 2013 10:55:42 +0700
Message-ID: <1385351754-9954-17-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:53:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknEk-00027m-KF
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609Ab3KYDxI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:53:08 -0500
Received: from mail-pb0-f49.google.com ([209.85.160.49]:59543 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab3KYDxE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:53:04 -0500
Received: by mail-pb0-f49.google.com with SMTP id jt11so4794565pbb.36
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4IyXKZc1UBB1zfxxP3pTmCtqScel07Zy5sSQELBUC84=;
        b=DDvHKtMJ5ZOJNr0/x7vFaPXU70RK8C56D/sCntqcepiNt2k1WzfLyHm+jBAC15KxNx
         Wc7qK7vVO4VzwXqEgFrNQw0SgIh1pdtq7gcAw2pKttYyFBoz3ZOJIFgf4DAjw7U4Yd5A
         lg9coYRJmd52Ugy2OzwbNzccj0jdwKvLpU1MsQtxO5d4clPH7tAxAgWcsx7VbwId4tyD
         DhVGuURuPymmLzxHZl9zR0Ydm6Bvn6fRv4ZcyypJg6ypEdNIo0YlfFdKGwOmiSOjIgoF
         qN0Hdjyfv0yNNP4yCae94oZ8yYlP74wzNRaXA8/ZgF+M5Hrxwzs1L1cM5ZI1oqioehMN
         3eWw==
X-Received: by 10.66.142.132 with SMTP id rw4mr25698785pab.6.1385351584129;
        Sun, 24 Nov 2013 19:53:04 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id vh3sm36524417pbc.8.2013.11.24.19.53.01
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:53:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:37 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238288>

This is the preparation for adding --shallow-file to both
unpack-objects and index-pack. To sum up:

 - status/code, ip/child, unpacker/keeper and i (now ac) are moved out
   to function top level

 - successful flow now ends at the end of the function

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c | 74 +++++++++++++++++++++++-------------------=
--------
 1 file changed, 34 insertions(+), 40 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cc8c34f..22e162d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -822,8 +822,11 @@ static const char *pack_lockfile;
 static const char *unpack(int err_fd)
 {
 	struct pack_header hdr;
+	const char *argv[7];
 	const char *hdr_err;
+	int status, ac =3D 0;
 	char hdr_arg[38];
+	struct child_process child;
 	int fsck_objects =3D (receive_fsck_objects >=3D 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >=3D 0
@@ -840,63 +843,54 @@ static const char *unpack(int err_fd)
 			"--pack_header=3D%"PRIu32",%"PRIu32,
 			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
=20
+	memset(&child, 0, sizeof(child));
 	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		int code, i =3D 0;
-		struct child_process child;
-		const char *unpacker[5];
-		unpacker[i++] =3D "unpack-objects";
+		argv[ac++] =3D "unpack-objects";
 		if (quiet)
-			unpacker[i++] =3D "-q";
+			argv[ac++] =3D "-q";
 		if (fsck_objects)
-			unpacker[i++] =3D "--strict";
-		unpacker[i++] =3D hdr_arg;
-		unpacker[i++] =3D NULL;
-		memset(&child, 0, sizeof(child));
-		child.argv =3D unpacker;
+			argv[ac++] =3D "--strict";
+		argv[ac++] =3D hdr_arg;
+		argv[ac++] =3D NULL;
+		child.argv =3D argv;
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
+		argv[ac++] =3D "index-pack";
+		argv[ac++] =3D "--stdin";
 		if (fsck_objects)
-			keeper[i++] =3D "--strict";
+			argv[ac++] =3D "--strict";
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
+			argv[ac++] =3D "--fix-thin";
+		argv[ac++] =3D hdr_arg;
+		argv[ac++] =3D keep_arg;
+		argv[ac++] =3D NULL;
+		child.argv =3D argv;
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
1.8.2.83.gc99314b
