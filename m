From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 08/16] upload-pack: let pack-objects do the object counting in shallow case
Date: Sat, 20 Jul 2013 16:58:02 +0700
Message-ID: <1374314290-5976-9-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0TwD-0001Sy-9B
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753388Ab3GTJ6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:49 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:42884 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823Ab3GTJ6r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:47 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so11533905iea.32
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dnByeStuCxPkHEka69vvz6dv7doaHkmM28o6C6FwPjI=;
        b=YXysK6Q7zxEfIMPiLcTvnDKWp8oCq8Cwa6O6tBOvKkxwLuIcdTVL2darG5aVBpQxVa
         hOr/sDP15QFDOVrdp1sgywF+sYH8HVTRMvzOLloFOso4Crp50G7+Mk7q/l9RvwDgzUga
         Q/n94iishIWmOVMaW7er963F7S4qC5b4LF9jwlFs/mlIDr4aah/T+jIKv/GrQtFRN1HK
         eelb1vGOr7tJlzR/lZllVD/4HQJvo85DT+KGshreSi8e0kucQ5rqTsADqeb/D9Q9mIQg
         Yx617yiShyKuHAP9LFOnttpY8bbNt6wmY0J9bO4R73zwbDsgiadnlkM3U8Nhg0Fm/BcE
         RM1g==
X-Received: by 10.50.119.42 with SMTP id kr10mr2673047igb.20.1374314327577;
        Sat, 20 Jul 2013 02:58:47 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id kj5sm21079463igb.7.2013.07.20.02.58.44
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:06 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230886>

Remove the duplicate object counting code in upload-pack, dump out all
register_shallow()'d SHA-1 into a temporary shallow file and feed it
to pack-objects. The end result is the same, except with less code,
and fewer bytes sending over pipe to pack-objects.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t5530-upload-pack-error.sh |   3 -
 upload-pack.c                | 128 ++++++++++-------------------------=
--------
 2 files changed, 30 insertions(+), 101 deletions(-)

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
index c377a3e..c3e68ae 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -35,7 +35,6 @@ static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
 static int allow_tip_sha1_in_want;
-static int shallow_nr;
 static struct object_array have_obj;
 static struct object_array want_obj;
 static struct object_array extra_edge_obj;
@@ -68,87 +67,32 @@ static ssize_t send_client_data(int fd, const char =
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
+	static struct lock_file shallow_lock;
+	const char *alternate_shallow_file =3D NULL;
+
+	setup_alternate_shallow(&shallow_lock,
+				&alternate_shallow_file,
+				NULL, 0);
+	if (*alternate_shallow_file) {
+		argv[arg++] =3D "--shallow-file";
+		argv[arg++] =3D alternate_shallow_file;
+	}
=20
 	argv[arg++] =3D "pack-objects";
-	if (!shallow_nr) {
-		argv[arg++] =3D "--revs";
-		if (use_thin_pack)
-			argv[arg++] =3D "--thin";
-	}
+	argv[arg++] =3D "--revs";
+	if (use_thin_pack)
+		argv[arg++] =3D "--thin";
=20
 	argv[arg++] =3D "--stdout";
 	if (!no_progress)
@@ -169,28 +113,18 @@ static void create_pack_file(void)
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
+	pipe_fd =3D xfdopen(pack_objects.in, "w");
=20
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
+	for (i =3D 0; i < want_obj.nr; i++)
+		fprintf(pipe_fd, "%s\n",
+			sha1_to_hex(want_obj.objects[i].item->sha1));
+	fprintf(pipe_fd, "--not\n");
+	for (i =3D 0; i < have_obj.nr; i++)
+		fprintf(pipe_fd, "%s\n",
+			sha1_to_hex(have_obj.objects[i].item->sha1));
+	fprintf(pipe_fd, "\n");
+	fflush(pipe_fd);
+	fclose(pipe_fd);
=20
=20
 	/* We read from pack_objects.err to capture stderr output for
@@ -290,8 +224,9 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_nr && finish_async(&rev_list))
-		goto fail;	/* error was already reported */
+
+	if (*alternate_shallow_file)
+		rollback_lock_file(&shallow_lock);
=20
 	/* flush the data */
 	if (0 <=3D buffered) {
@@ -575,7 +510,6 @@ static void receive_needs(void)
 	int depth =3D 0;
 	int has_non_tip =3D 0;
=20
-	shallow_nr =3D 0;
 	for (;;) {
 		struct object *o;
 		const char *features;
@@ -679,7 +613,6 @@ static void receive_needs(void)
 				packet_write(1, "shallow %s",
 						sha1_to_hex(object->sha1));
 				register_shallow(object->sha1);
-				shallow_nr++;
 			}
 			result =3D result->next;
 		}
@@ -715,7 +648,6 @@ static void receive_needs(void)
 				register_shallow(shallows.objects[i].item->sha1);
 		}
=20
-	shallow_nr +=3D shallows.nr;
 	free(shallows.objects);
 }
=20
--=20
1.8.2.83.gc99314b
