From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] upload-pack: delegate rev walking in shallow fetch to pack-objects
Date: Fri, 16 Aug 2013 16:52:05 +0700
Message-ID: <1376646727-22318-4-git-send-email-pclouds@gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
 <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 11:52:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGi0-00080b-De
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368Ab3HPJwf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 05:52:35 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36966 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755364Ab3HPJwe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:52:34 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so1672268pab.6
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=VtJr550HripJZG3oWx36Ahtwd57RZ2BWOJVmx89p6TQ=;
        b=GvhDCCC9yttBDiFXcShszxmgjq6i8MSoBnYNZOLTzhuCNKX4+5bs09WKAw4kVUFyYa
         BmhtHCxUCT6b0F4Q/PsBpTPGI3K6fXwLMqquyJ6rGu/KBUYavRyhOwWprW2ujbTu1HIZ
         o095CaOX42PW4Lue0AZHekB8+ZAw7VRtN5UQSJm/oSqJh+RgYXKyVsVD5tmJk8t62RKZ
         YK+2a904nlTMQi3Db3lJFLrE89XTMoqbKQ6QcQ9/JHPUYRUerBRCiO/CBbQdZuqLZKcR
         l5+oqkj209RJnDVK+5efkfQMr7ImSjKurF87ihNAGjE7e65sKVLYAbQB4D0c12oG1i/C
         3xwQ==
X-Received: by 10.66.26.132 with SMTP id l4mr2135213pag.138.1376646753531;
        Fri, 16 Aug 2013 02:52:33 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id bt1sm1154478pbb.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:52:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:27 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1376646727-22318-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232411>

upload-pack has a special rev walking code for shallow recipients. It
works almost like the similar code in pack-objects except:

1. in upload-pack, graft points could be added for deepening

2. also when the repository is deepened, the shallow point will be
   moved further away from the tip, but the old shallow point will be
   marked as edge to produce more efficient packs. See 6523078 (make
   shallow repository deepening more network efficient - 2009-09-03)

pass the file to pack-objects via --shallow-file. This will override
$GIT_DIR/shallow and give pack-objects the exact repository shape that
upload-pack has.

mark edge commits by revision command arguments. Even if old shallow
points are passed as "--not" revisions as in this patch, they will not
be picked up by mark_edges_uninteresting() because this function looks
up to parents for edges, while in this case the edge is the children,
in the opposite direction. This will be fixed in the next patch when
all given uninteresting commits are marked as edges.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5530-upload-pack-error.sh |   3 -
 upload-pack.c                | 128 +++++++++++------------------------=
--------
 2 files changed, 32 insertions(+), 99 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.s=
h
index c983d36..3932e79 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -54,9 +54,6 @@ test_expect_success 'upload-pack fails due to error i=
n rev-list' '
 	printf "0032want %s\n0034shallow %s00000009done\n0000" \
 		$(git rev-parse HEAD) $(git rev-parse HEAD^) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
-	# pack-objects survived
-	grep "Total.*, reused" output.err &&
-	# but there was an error, which must have been in rev-list
 	grep "bad tree object" output.err
 '
=20
diff --git a/upload-pack.c b/upload-pack.c
index 127e59a..d5a003a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -68,87 +68,28 @@ static ssize_t send_client_data(int fd, const char =
*data, ssize_t sz)
 	return sz;
 }
=20
-static FILE *pack_pipe =3D NULL;
-static void show_commit(struct commit *commit, void *data)
-{
-	if (commit->object.flags & BOUNDARY)
-		fputc('-', pack_pipe);
-	if (fputs(sha1_to_hex(commit->object.sha1), pack_pipe) < 0)
-		die("broken output pipe");
-	fputc('\n', pack_pipe);
-	fflush(pack_pipe);
-	free(commit->buffer);
-	commit->buffer =3D NULL;
-}
-
-static void show_object(struct object *obj,
-			const struct name_path *path, const char *component,
-			void *cb_data)
-{
-	show_object_with_name(pack_pipe, obj, path, component);
-}
-
-static void show_edge(struct commit *commit)
-{
-	fprintf(pack_pipe, "-%s\n", sha1_to_hex(commit->object.sha1));
-}
-
-static int do_rev_list(int in, int out, void *user_data)
-{
-	int i;
-	struct rev_info revs;
-
-	pack_pipe =3D xfdopen(out, "w");
-	init_revisions(&revs, NULL);
-	revs.tag_objects =3D 1;
-	revs.tree_objects =3D 1;
-	revs.blob_objects =3D 1;
-	if (use_thin_pack)
-		revs.edge_hint =3D 1;
-
-	for (i =3D 0; i < want_obj.nr; i++) {
-		struct object *o =3D want_obj.objects[i].item;
-		/* why??? */
-		o->flags &=3D ~UNINTERESTING;
-		add_pending_object(&revs, o, NULL);
-	}
-	for (i =3D 0; i < have_obj.nr; i++) {
-		struct object *o =3D have_obj.objects[i].item;
-		o->flags |=3D UNINTERESTING;
-		add_pending_object(&revs, o, NULL);
-	}
-	setup_revisions(0, NULL, &revs, NULL);
-	if (prepare_revision_walk(&revs))
-		die("revision walk setup failed");
-	mark_edges_uninteresting(revs.commits, &revs, show_edge);
-	if (use_thin_pack)
-		for (i =3D 0; i < extra_edge_obj.nr; i++)
-			fprintf(pack_pipe, "-%s\n", sha1_to_hex(
-					extra_edge_obj.objects[i].item->sha1));
-	traverse_commit_list(&revs, show_commit, show_object, NULL);
-	fflush(pack_pipe);
-	fclose(pack_pipe);
-	return 0;
-}
-
 static void create_pack_file(void)
 {
-	struct async rev_list;
 	struct child_process pack_objects;
 	char data[8193], progress[128];
 	char abort_msg[] =3D "aborting due to possible repository "
 		"corruption on the remote side.";
 	int buffered =3D -1;
 	ssize_t sz;
-	const char *argv[10];
-	int arg =3D 0;
+	const char *argv[12];
+	int i, arg =3D 0;
+	FILE *pipe_fd;
+	char *shallow_file =3D NULL;
=20
-	argv[arg++] =3D "pack-objects";
-	if (!shallow_nr) {
-		argv[arg++] =3D "--revs";
-		if (use_thin_pack)
-			argv[arg++] =3D "--thin";
+	if (shallow_nr) {
+		shallow_file =3D setup_temporary_shallow();
+		argv[arg++] =3D "--shallow-file";
+		argv[arg++] =3D shallow_file;
 	}
+	argv[arg++] =3D "pack-objects";
+	argv[arg++] =3D "--revs";
+	if (use_thin_pack)
+		argv[arg++] =3D "--thin";
=20
 	argv[arg++] =3D "--stdout";
 	if (!no_progress)
@@ -169,29 +110,21 @@ static void create_pack_file(void)
 	if (start_command(&pack_objects))
 		die("git upload-pack: unable to fork git-pack-objects");
=20
-	if (shallow_nr) {
-		memset(&rev_list, 0, sizeof(rev_list));
-		rev_list.proc =3D do_rev_list;
-		rev_list.out =3D pack_objects.in;
-		if (start_async(&rev_list))
-			die("git upload-pack: unable to fork git-rev-list");
-	}
-	else {
-		FILE *pipe_fd =3D xfdopen(pack_objects.in, "w");
-		int i;
-
-		for (i =3D 0; i < want_obj.nr; i++)
-			fprintf(pipe_fd, "%s\n",
-				sha1_to_hex(want_obj.objects[i].item->sha1));
-		fprintf(pipe_fd, "--not\n");
-		for (i =3D 0; i < have_obj.nr; i++)
-			fprintf(pipe_fd, "%s\n",
-				sha1_to_hex(have_obj.objects[i].item->sha1));
-		fprintf(pipe_fd, "\n");
-		fflush(pipe_fd);
-		fclose(pipe_fd);
-	}
-
+	pipe_fd =3D xfdopen(pack_objects.in, "w");
+
+	for (i =3D 0; i < want_obj.nr; i++)
+		fprintf(pipe_fd, "%s\n",
+			sha1_to_hex(want_obj.objects[i].item->sha1));
+	fprintf(pipe_fd, "--not\n");
+	for (i =3D 0; i < have_obj.nr; i++)
+		fprintf(pipe_fd, "%s\n",
+			sha1_to_hex(have_obj.objects[i].item->sha1));
+	for (i =3D 0; i < extra_edge_obj.nr; i++)
+		fprintf(pipe_fd, "%s\n",
+			sha1_to_hex(extra_edge_obj.objects[i].item->sha1));
+	fprintf(pipe_fd, "\n");
+	fflush(pipe_fd);
+	fclose(pipe_fd);
=20
 	/* We read from pack_objects.err to capture stderr output for
 	 * progress bar, and pack_objects.out to capture the pack data.
@@ -290,8 +223,11 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_nr && finish_async(&rev_list))
-		goto fail;	/* error was already reported */
+	if (shallow_file) {
+		if (*shallow_file)
+			unlink(shallow_file);
+		free(shallow_file);
+	}
=20
 	/* flush the data */
 	if (0 <=3D buffered) {
--=20
1.8.2.82.gc24b958
