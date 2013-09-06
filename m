From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/3] receive-pack: use index-pack --unpack-limit instead of unpack-objects
Date: Fri,  6 Sep 2013 07:46:03 +0700
Message-ID: <1378428363-14086-3-git-send-email-pclouds@gmail.com>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
 <1378428363-14086-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 06 02:43:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHk8v-0000QU-4p
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 02:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab3IFAnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 20:43:16 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:61789 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab3IFAnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 20:43:15 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so2625587pab.22
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WFlMvjvfbicJ+JSqnKk+6Fded8lWwG/z7UjOE3O/3TY=;
        b=bCFpoS1KWv6O2wD7R4VeDj4ZuozgwDMkg5OGLqexmgcZcSF71D2qzrOJZYkrJz3sC+
         xLnOf0vBw3swYPmFSKqSijU/AqmFSBeDKB5YhtyEhGPR1EQoXqPUgf/gL0ora8xg4KGp
         wifcNxZzPcr26GBY0DnmIoZe4qmMoRnQuqODH3J6a7VAv8FswN+UPC537TjtfgcZSqhJ
         bhO4W5FOGeCSwsARrFkxcKjKH1o2R84FgmdL9P32HodrEGtQsi5swj1hnMyVPlskT2Kq
         2Rg5QVAUp53+0LkhCgUUGEieSHnYofQP+75onCpem8SimoikNAqiK1lCy3qyQcD2hfZ/
         ya2Q==
X-Received: by 10.68.52.200 with SMTP id v8mr12221950pbo.48.1378428195292;
        Thu, 05 Sep 2013 17:43:15 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id qf7sm630025pac.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 17:43:14 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Sep 2013 07:46:22 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378428363-14086-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234011>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/receive-pack.c | 122 ++++++++++++++---------------------------=
--------
 1 file changed, 34 insertions(+), 88 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e3eb5fc..0a84a61 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -792,105 +792,51 @@ static struct command *read_head_info(void)
 	return commands;
 }
=20
-static const char *parse_pack_header(struct pack_header *hdr)
-{
-	switch (read_pack_header(0, hdr)) {
-	case PH_ERROR_EOF:
-		return "eof before pack header was fully read";
-
-	case PH_ERROR_PACK_SIGNATURE:
-		return "protocol error (pack signature mismatch detected)";
-
-	case PH_ERROR_PROTOCOL:
-		return "protocol error (pack version unsupported)";
-
-	default:
-		return "unknown error in parse_pack_header";
-
-	case 0:
-		return NULL;
-	}
-}
-
 static const char *pack_lockfile;
=20
 static const char *unpack(int err_fd)
 {
-	struct pack_header hdr;
-	const char *hdr_err;
-	char hdr_arg[38];
 	int fsck_objects =3D (receive_fsck_objects >=3D 0
 			    ? receive_fsck_objects
 			    : transfer_fsck_objects >=3D 0
 			    ? transfer_fsck_objects
 			    : 0);
=20
-	hdr_err =3D parse_pack_header(&hdr);
-	if (hdr_err) {
-		if (err_fd > 0)
-			close(err_fd);
-		return hdr_err;
-	}
-	snprintf(hdr_arg, sizeof(hdr_arg),
-			"--pack_header=3D%"PRIu32",%"PRIu32,
-			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
-
-	if (ntohl(hdr.hdr_entries) < unpack_limit) {
-		int code, i =3D 0;
-		struct child_process child;
-		const char *unpacker[5];
-		unpacker[i++] =3D "unpack-objects";
-		if (quiet)
-			unpacker[i++] =3D "-q";
-		if (fsck_objects)
-			unpacker[i++] =3D "--strict";
-		unpacker[i++] =3D hdr_arg;
-		unpacker[i++] =3D NULL;
-		memset(&child, 0, sizeof(child));
-		child.argv =3D unpacker;
-		child.no_stdout =3D 1;
-		child.err =3D err_fd;
-		child.git_cmd =3D 1;
-		code =3D run_command(&child);
-		if (!code)
-			return NULL;
-		return "unpack-objects abnormal exit";
-	} else {
-		const char *keeper[7];
-		int s, status, i =3D 0;
-		char keep_arg[256];
-		struct child_process ip;
-
-		s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (uin=
tmax_t) getpid());
-		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-			strcpy(keep_arg + s, "localhost");
-
-		keeper[i++] =3D "index-pack";
-		keeper[i++] =3D "--stdin";
-		if (fsck_objects)
-			keeper[i++] =3D "--strict";
-		keeper[i++] =3D "--fix-thin";
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
-			return "index-pack fork failed";
-		}
-		pack_lockfile =3D index_pack_lockfile(ip.out);
-		close(ip.out);
-		status =3D finish_command(&ip);
-		if (!status) {
-			reprepare_packed_git();
-			return NULL;
-		}
+	const char *keeper[7];
+	int s, status, i =3D 0;
+	char keep_arg[256];
+	char unpack_limit_arg[256];
+	struct child_process ip;
+
+	s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (uint=
max_t) getpid());
+	if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+		strcpy(keep_arg + s, "localhost");
+	sprintf(unpack_limit_arg, "--unpack-limit=3D%u", unpack_limit);
+
+	keeper[i++] =3D "index-pack";
+	keeper[i++] =3D "--stdin";
+	if (fsck_objects)
+		keeper[i++] =3D "--strict";
+	keeper[i++] =3D "--fix-thin";
+	keeper[i++] =3D keep_arg;
+	keeper[i++] =3D unpack_limit_arg;
+	keeper[i++] =3D NULL;
+	memset(&ip, 0, sizeof(ip));
+	ip.argv =3D keeper;
+	ip.out =3D -1;
+	ip.err =3D err_fd;
+	ip.git_cmd =3D 1;
+	status =3D start_command(&ip);
+	if (status)
+		return "index-pack fork failed";
+	pack_lockfile =3D index_pack_lockfile(ip.out);
+	close(ip.out);
+	status =3D finish_command(&ip);
+	if (status)
 		return "index-pack abnormal exit";
-	}
+	if (pack_lockfile)
+		reprepare_packed_git();
+	return NULL;
 }
=20
 static const char *unpack_with_sideband(void)
--=20
1.8.2.83.gc99314b
