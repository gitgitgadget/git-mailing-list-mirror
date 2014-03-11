From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4] upload-pack: send shallow info over stdin to pack-objects
Date: Tue, 11 Mar 2014 19:59:46 +0700
Message-ID: <1394542786-2812-1-git-send-email-pclouds@gmail.com>
References: <1394095783-24402-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 11 13:59:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNMHP-0006is-Vd
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 13:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbaCKM7a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 08:59:30 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:54833 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056AbaCKM7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 08:59:18 -0400
Received: by mail-pa0-f47.google.com with SMTP id lj1so8743846pab.34
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3sF8kog5gOEUO04Wy05Mv78kbDoQWuaXC9mjnSr+KU0=;
        b=ITKXW4/S+yDnDTVL7ztwcd6z47mx8F62FRpNtSY5zBjgJruOD+SRvrxWctjkGKetsP
         A398lLKwmSqRPTWCj8xpMRFy4qtfWJGIDFeU4qm8Y32q233ObXmGLn/ankcU8zEqg1WY
         h+TsuAHeGqBa8ns8JhWloct77NbhIfz79XnWWsdYAEggZNcMaxCIHwEWRSBqZvOD/tlX
         fPwxv9GTvG+vqiSwsPoOudqlcmVYA1H4gwu0Nrs1Y4DUntMuN6fA4sv6VgOwd0iKthNr
         rGvf3DLxhENXkv3uRm/gcHv3vtVCoSqomfSwoxozDk5o35BEJzYqw0qSBzQ+Dqn447OC
         TNEg==
X-Received: by 10.68.189.5 with SMTP id ge5mr47111002pbc.42.1394542757156;
        Tue, 11 Mar 2014 05:59:17 -0700 (PDT)
Received: from lanh ([115.73.243.66])
        by mx.google.com with ESMTPSA id it4sm75121080pbc.39.2014.03.11.05.59.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 11 Mar 2014 05:59:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 11 Mar 2014 19:59:52 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1394095783-24402-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243863>

Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
pack-objects - 2013-08-16) upload-pack does not write to the source
repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
shallow fetch, so the source repo must be writable.

git:// servers do not need write access to repos and usually don't
have it, which means cdab485 breaks shallow clone over git://

Instead of using a temporary file as the media for shallow points, we
can send them over stdin to pack-objects as well. Prepend shallow
SHA-1 with --shallow so pack-objects knows what is what.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation update and a minor tweak.

 Documentation/git-pack-objects.txt |  2 ++
 builtin/pack-objects.c             | 10 ++++++++++
 t/t5537-fetch-shallow.sh           | 13 +++++++++++++
 upload-pack.c                      | 21 ++++++++++++---------
 4 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pac=
k-objects.txt
index cdab9ed..d2d8f47 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -64,6 +64,8 @@ base-name::
 	the same way as 'git rev-list' with the `--objects` flag
 	uses its `commit` arguments to build the list of objects it
 	outputs.  The objects on the resulting list are packed.
+	Besides revisions, `--not` or `--shallow <SHA-1>` lines are
+	also accepted.
=20
 --unpacked::
 	This implies `--revs`.  When processing the list of
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..358f9a3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2455,6 +2455,9 @@ static void get_object_list(int ac, const char **=
av)
 	save_commit_buffer =3D 0;
 	setup_revisions(ac, av, &revs, NULL);
=20
+	/* make sure shallows are read */
+	is_repository_shallow();
+
 	while (fgets(line, sizeof(line), stdin) !=3D NULL) {
 		int len =3D strlen(line);
 		if (len && line[len - 1] =3D=3D '\n')
@@ -2467,6 +2470,13 @@ static void get_object_list(int ac, const char *=
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
1.9.0.40.gaa8c3ea
