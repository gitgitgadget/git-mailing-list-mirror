From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] upload-pack: send shallow info over stdin to pack-objects
Date: Thu,  6 Mar 2014 15:49:43 +0700
Message-ID: <1394095783-24402-1-git-send-email-pclouds@gmail.com>
References: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 09:50:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLU0M-0001Jh-8A
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 09:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbaCFIuH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 03:50:07 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:51740 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbaCFItx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 03:49:53 -0500
Received: by mail-pa0-f52.google.com with SMTP id rd3so2378206pab.11
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yLOdFPejboXTTSoCA1aO7eB0nAb4IngMAzi/NBXhVrw=;
        b=Iu3utGlW+F+rJC3eq8EpI1+AtL0PIMgmVaW28NMkVQZ2QhIpBQwm0Bg9fQ51dJEO0r
         TraHaz9nuRpPITQRM1PuMjsdMI8MgM8aQWR96jEhRdT7+mh/OJ2OCKsBF1lxAPgnQCUW
         StQX7WgFWrmzVaJZ0vfinooVVzV4wh3eOUoFTkSmTisunJpSpbcTk14SwgP+nXf1ai0Y
         UUsRIr1YJorjIrOs6GIlOd17MHk5j4y93BtJKOn35p8zaBtPfoGaIFDt1tElDaPNCNke
         WfyDDi2x/DCfpIdSU5JyGvf/BQp4Sn7XLNSiue1wIIblWQduDauAi93VEkoS37PpaTrG
         +KFA==
X-Received: by 10.66.246.229 with SMTP id xz5mr12798309pac.119.1394095792795;
        Thu, 06 Mar 2014 00:49:52 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id bc4sm17244306pbb.2.2014.03.06.00.49.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 06 Mar 2014 00:49:51 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 06 Mar 2014 15:49:44 +0700
X-Mailer: git-send-email 1.9.0.66.g14f785a
In-Reply-To: <1393936205-15953-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243503>

=46rom: Duy Nguyen <pclouds@gmail.com>

Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
pack-objects - 2013-08-16) upload-pack does not write to the source
repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
shallow fetch, so the source repo must be writable.

git:// servers do not need write access to repos and usually don't
have it, which means cdab485 breaks shallow clone over git://

Instead of using a temporary file as the media for shallow points, we
can send them over stdin to pack-objects as well. Prepend shallow
SHA-1 with --shallow so pack-objects knows what is
what.

read_object_list_from_stdin() does not accept --shallow lines because
upload-pack never uses that code. When upload-pack does, then it can
learn about --shallow lines.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 OK new approach, stop creating shallow_XXXXXX in upload-pack.

 builtin/pack-objects.c   |  7 +++++++
 shallow.c                |  2 ++
 t/t5537-fetch-shallow.sh | 13 +++++++++++++
 upload-pack.c            | 21 ++++++++++++---------
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..79e848e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2467,6 +2467,13 @@ static void get_object_list(int ac, const char *=
*av)
 				write_bitmap_index =3D 0;
 				continue;
 			}
+			if (starts_with(line, "--shallow ")) {
+				unsigned char sha1[20];
+				if (get_sha1_hex(line + 10, sha1))
+					die("not an SHA-1 '%s'", line + 10);
+				register_shallow(sha1);
+				continue;
+			}
 			die("not a rev '%s'", line);
 		}
 		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAM=
E))
diff --git a/shallow.c b/shallow.c
index bbc98b5..41ff4a0 100644
--- a/shallow.c
+++ b/shallow.c
@@ -33,6 +33,8 @@ int register_shallow(const unsigned char *sha1)
 	graft->nr_parent =3D -1;
 	if (commit && commit->object.parsed)
 		commit->parents =3D NULL;
+	if (is_shallow =3D=3D -1)
+		is_shallow =3D 1;
 	return register_commit_graft(graft, 0);
 }
=20
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 3ae9092..a980574 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -173,4 +173,17 @@ EOF
 	)
 '
=20
+test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only r=
epo' '
+	cp -R .git read-only.git &&
+	find read-only.git -print | xargs chmod -w &&
+	test_when_finished "find read-only.git -type d -print | xargs chmod +=
w" &&
+	git clone --no-local --depth=3D2 read-only.git from-read-only &&
+	git --git-dir=3Dfrom-read-only/.git log --format=3D%s >actual &&
+	cat >expect <<EOF &&
+add-1-back
+4
+EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index 0c44f6b..a5c50e4 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -70,6 +70,14 @@ static ssize_t send_client_data(int fd, const char *=
data, ssize_t sz)
 	return sz;
 }
=20
+static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
+{
+	FILE *fp =3D cb_data;
+	if (graft->nr_parent =3D=3D -1)
+		fprintf(fp, "--shallow %s\n", sha1_to_hex(graft->sha1));
+	return 0;
+}
+
 static void create_pack_file(void)
 {
 	struct child_process pack_objects;
@@ -81,12 +89,10 @@ static void create_pack_file(void)
 	const char *argv[12];
 	int i, arg =3D 0;
 	FILE *pipe_fd;
-	char *shallow_file =3D NULL;
=20
 	if (shallow_nr) {
-		shallow_file =3D setup_temporary_shallow(NULL);
 		argv[arg++] =3D "--shallow-file";
-		argv[arg++] =3D shallow_file;
+		argv[arg++] =3D "";
 	}
 	argv[arg++] =3D "pack-objects";
 	argv[arg++] =3D "--revs";
@@ -114,6 +120,9 @@ static void create_pack_file(void)
=20
 	pipe_fd =3D xfdopen(pack_objects.in, "w");
=20
+	if (shallow_nr)
+		for_each_commit_graft(write_one_shallow, pipe_fd);
+
 	for (i =3D 0; i < want_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
 			sha1_to_hex(want_obj.objects[i].item->sha1));
@@ -242,12 +251,6 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_file) {
-		if (*shallow_file)
-			unlink(shallow_file);
-		free(shallow_file);
-	}
-
 	/* flush the data */
 	if (0 <=3D buffered) {
 		data[0] =3D buffered;
--=20
1.9.0.66.g14f785a
