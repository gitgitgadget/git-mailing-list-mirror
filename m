From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/3] fetch-pack: use index-pack --unpack-limit instead of unpack-objects
Date: Fri,  6 Sep 2013 07:46:02 +0700
Message-ID: <1378428363-14086-2-git-send-email-pclouds@gmail.com>
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
	id 1VHk8u-0000QU-Eo
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 02:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745Ab3IFAnN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Sep 2013 20:43:13 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36962 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab3IFAnK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 20:43:10 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so2493304pbc.35
        for <git@vger.kernel.org>; Thu, 05 Sep 2013 17:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KV9NcgHhgw7nxD1rkbKVf1UdCQ+18wNol/V+S63Vzbo=;
        b=rYrVGbfAd6Gw8Ye4HWuoPx0P/KHZXQ+wzgVb3GgIgWOXpi2NL9ITOhBwQsQfMF1o2e
         mXXdmnz42oyAtv2hV5UhqZXMK4FLDKIL20nGr8YQhKoRFjMaSTjNKXkcWvdR+5nYya9k
         L9QbNW1z4PYx4zPXAzK2W+zdSX9Gdj5uVFLHnRQ8C1iM8zRowcAcUigwc29Wkc26iqp9
         G9bQTMA6gbSz/ZFCt3unbM+uO/VSLvQHBQ6SUCdAXhTdzRbB3Cut16Q0tccjAncrIZSt
         oNnEtw9tpUfyOjKhyr3iv2KJNwp3uGPn5OssFzgWDUbN8N/cANu31QUILYye4VZvnoK0
         XkJg==
X-Received: by 10.68.200.34 with SMTP id jp2mr12038520pbc.53.1378428189633;
        Thu, 05 Sep 2013 17:43:09 -0700 (PDT)
Received: from lanh ([115.73.241.111])
        by mx.google.com with ESMTPSA id sb9sm38487061pbb.0.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Sep 2013 17:43:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 06 Sep 2013 07:46:16 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1378428363-14086-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234010>

Current code peeks into the transfered pack's header, if the number of
objects is under a limit, unpack-objects is called to handle the rest,
otherwise index-pack is. This patch makes index-pack handle both
cases. After the next patch, unpack-objects will no longer be used. It
may be removed in future.

Now we only have two code paths to maintain regarding pack reading
(sha1_file.c and index-pack.c). When .pack v4 comes, we don't need to
duplicate work in index-pack and unpack-objects.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.c | 86 +++++++++++++++++++++++++---------------------------=
--------
 1 file changed, 35 insertions(+), 51 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f5d99c1..44d029f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -682,16 +682,16 @@ static int sideband_demux(int in, int out, void *=
data)
 }
=20
 static int get_pack(struct fetch_pack_args *args,
-		    int xd[2], char **pack_lockfile)
+		    int xd[2], char **pack_lockfile_p)
 {
 	struct async demux;
-	const char *argv[22];
+	const char *argv[23];
 	char keep_arg[256];
-	char hdr_arg[256];
+	char unpack_limit_arg[256];
 	const char **av;
-	int do_keep =3D args->keep_pack;
 	struct child_process cmd;
 	int ret;
+	char *pack_lockfile;
=20
 	memset(&demux, 0, sizeof(demux));
 	if (use_sideband) {
@@ -711,54 +711,33 @@ static int get_pack(struct fetch_pack_args *args,
=20
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.argv =3D argv;
+	cmd.out =3D -1;
 	av =3D argv;
-	*hdr_arg =3D 0;
-	if (!args->keep_pack && unpack_limit) {
-		struct pack_header header;
-
-		if (read_pack_header(demux.out, &header))
-			die("protocol error: bad pack header");
-		snprintf(hdr_arg, sizeof(hdr_arg),
-			 "--pack_header=3D%"PRIu32",%"PRIu32,
-			 ntohl(header.hdr_version), ntohl(header.hdr_entries));
-		if (ntohl(header.hdr_entries) < unpack_limit)
-			do_keep =3D 0;
-		else
-			do_keep =3D 1;
-	}
=20
 	if (alternate_shallow_file) {
 		*av++ =3D "--shallow-file";
 		*av++ =3D alternate_shallow_file;
 	}
=20
-	if (do_keep) {
-		if (pack_lockfile)
-			cmd.out =3D -1;
-		*av++ =3D "index-pack";
-		*av++ =3D "--stdin";
-		if (!args->quiet && !args->no_progress)
-			*av++ =3D "-v";
-		if (args->use_thin_pack)
-			*av++ =3D "--fix-thin";
-		if (args->lock_pack || unpack_limit) {
-			int s =3D sprintf(keep_arg,
-					"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
-			if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
-				strcpy(keep_arg + s, "localhost");
-			*av++ =3D keep_arg;
-		}
-		if (args->check_self_contained_and_connected)
-			*av++ =3D "--check-self-contained-and-connected";
-	}
-	else {
-		*av++ =3D "unpack-objects";
-		if (args->quiet || args->no_progress)
-			*av++ =3D "-q";
-		args->check_self_contained_and_connected =3D 0;
-	}
-	if (*hdr_arg)
-		*av++ =3D hdr_arg;
+	*av++ =3D "index-pack";
+	*av++ =3D "--stdin";
+	if (!args->quiet && !args->no_progress)
+		*av++ =3D "-v";
+	if (args->use_thin_pack)
+		*av++ =3D "--fix-thin";
+	if (args->lock_pack || unpack_limit) {
+		int s =3D sprintf(keep_arg,
+				"--keep=3Dfetch-pack %"PRIuMAX " on ", (uintmax_t) getpid());
+		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
+			strcpy(keep_arg + s, "localhost");
+		*av++ =3D keep_arg;
+	}
+	if (!args->keep_pack) {
+		sprintf(unpack_limit_arg, "--unpack-limit=3D%u", unpack_limit);
+		*av++ =3D unpack_limit_arg;
+	}
+	if (args->check_self_contained_and_connected)
+		*av++ =3D "--check-self-contained-and-connected";
 	if (fetch_fsck_objects >=3D 0
 	    ? fetch_fsck_objects
 	    : transfer_fsck_objects >=3D 0
@@ -771,20 +750,26 @@ static int get_pack(struct fetch_pack_args *args,
 	cmd.git_cmd =3D 1;
 	if (start_command(&cmd))
 		die("fetch-pack: unable to fork off %s", argv[0]);
-	if (do_keep && pack_lockfile) {
-		*pack_lockfile =3D index_pack_lockfile(cmd.out);
-		close(cmd.out);
-	}
-
+	pack_lockfile =3D index_pack_lockfile(cmd.out);
+	close(cmd.out);
 	ret =3D finish_command(&cmd);
+
 	if (!ret || (args->check_self_contained_and_connected && ret =3D=3D 1=
))
 		args->self_contained_and_connected =3D
 			args->check_self_contained_and_connected &&
 			ret =3D=3D 0;
 	else
 		die("%s failed", argv[0]);
+
 	if (use_sideband && finish_async(&demux))
 		die("error in sideband demultiplexer");
+
+	if (pack_lockfile)
+		reprepare_packed_git();
+
+	if (pack_lockfile_p)
+		*pack_lockfile_p =3D pack_lockfile;
+
 	return 0;
 }
=20
@@ -997,6 +982,5 @@ struct ref *fetch_pack(struct fetch_pack_args *args=
,
 			commit_lock_file(&shallow_lock);
 	}
=20
-	reprepare_packed_git();
 	return ref_cpy;
 }
--=20
1.8.2.83.gc99314b
