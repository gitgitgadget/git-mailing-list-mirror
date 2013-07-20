From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 04/16] Move setup_alternate_shallow and write_shallow_commits to shallow.c
Date: Sat, 20 Jul 2013 16:57:58 +0700
Message-ID: <1374314290-5976-5-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Tvp-0001Gz-CG
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753090Ab3GTJ6X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:58:23 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:56827 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab3GTJ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:58:21 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so11262641iet.23
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NeBkEklD1NBjGrnvdc+i8Ejuc39FOeVwxJNe1xdWEUw=;
        b=TnR8EA8ca023fbTUqia1LdumG2qvMQUGEI52Ub630+gF19Iwd/u+sLBBXq13bmD1bH
         kk0ysZDUF7iSVD+J9URec4cRW0/D1GwJfq7znWCfmDZCvWGckAlK0vFKGXpeiVAJehKq
         8kD0jhrWmqAEtoGNnElacJNbKipZoGcHcBCm3wZkPNehYhgpvyE4LrHdBdumPGMqkAjn
         ZLBtPcUQ2JhnR4lhgooXugv9QM4dY+jUQbteXf5jR2EOx3lxS1PTxEobY3q4PSxPEpu4
         a3Z0kp498ipjuAlpDD+DWDGNlpczKXj2yCqRpklTr7gYKMhbcL7XV9EMQZJgDQIFYtGg
         P5kg==
X-Received: by 10.50.57.51 with SMTP id f19mr14616408igq.26.1374314300943;
        Sat, 20 Jul 2013 02:58:20 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id vc13sm21116072igb.1.2013.07.20.02.58.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:58:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:58:39 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230880>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h     |  3 +++
 fetch-pack.c | 53 +---------------------------------------------------=
-
 shallow.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+
 3 files changed, 57 insertions(+), 52 deletions(-)

diff --git a/commit.h b/commit.h
index e0688c3..678fa20 100644
--- a/commit.h
+++ b/commit.h
@@ -188,6 +188,9 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 extern void check_shallow_file_for_update(void);
 extern void set_alternate_shallow_file(const char *path);
 extern void advertise_shallow_grafts(int);
+extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
+extern void setup_alternate_shallow(struct lock_file *shallow_lock,
+				    const char **alternate_shallow_file);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/fetch-pack.c b/fetch-pack.c
index abe5ffb..dc71a2b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -185,36 +185,6 @@ static void consume_shallow_list(struct fetch_pack=
_args *args, int fd)
 	}
 }
=20
-struct write_shallow_data {
-	struct strbuf *out;
-	int use_pack_protocol;
-	int count;
-};
-
-static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
-{
-	struct write_shallow_data *data =3D cb_data;
-	const char *hex =3D sha1_to_hex(graft->sha1);
-	data->count++;
-	if (data->use_pack_protocol)
-		packet_buf_write(data->out, "shallow %s", hex);
-	else {
-		strbuf_addstr(data->out, hex);
-		strbuf_addch(data->out, '\n');
-	}
-	return 0;
-}
-
-static int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol)
-{
-	struct write_shallow_data data;
-	data.out =3D out;
-	data.use_pack_protocol =3D use_pack_protocol;
-	data.count =3D 0;
-	for_each_commit_graft(write_one_shallow, &data);
-	return data.count;
-}
-
 static enum ack_type get_ack(int fd, unsigned char *result_sha1)
 {
 	int len;
@@ -795,27 +765,6 @@ static int cmp_ref_by_name(const void *a_, const v=
oid *b_)
 	return strcmp(a->name, b->name);
 }
=20
-static void setup_alternate_shallow(void)
-{
-	struct strbuf sb =3D STRBUF_INIT;
-	int fd;
-
-	check_shallow_file_for_update();
-	fd =3D hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
-				       LOCK_DIE_ON_ERROR);
-	if (write_shallow_commits(&sb, 0)) {
-		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
-			die_errno("failed to write to %s", shallow_lock.filename);
-		alternate_shallow_file =3D shallow_lock.filename;
-	} else
-		/*
-		 * is_repository_shallow() sees empty string as "no
-		 * shallow file".
-		 */
-		alternate_shallow_file =3D "";
-	strbuf_release(&sb);
-}
-
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
@@ -896,7 +845,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
 	if (args->depth > 0)
-		setup_alternate_shallow();
+		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file);
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
diff --git a/shallow.c b/shallow.c
index ccdfefc..ee9edd4 100644
--- a/shallow.c
+++ b/shallow.c
@@ -162,3 +162,56 @@ void advertise_shallow_grafts(int fd)
 		return;
 	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
 }
+
+struct write_shallow_data {
+	struct strbuf *out;
+	int use_pack_protocol;
+	int count;
+};
+
+static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
+{
+	struct write_shallow_data *data =3D cb_data;
+	const char *hex =3D sha1_to_hex(graft->sha1);
+	data->count++;
+	if (data->use_pack_protocol)
+		packet_buf_write(data->out, "shallow %s", hex);
+	else {
+		strbuf_addstr(data->out, hex);
+		strbuf_addch(data->out, '\n');
+	}
+	return 0;
+}
+
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
+{
+	struct write_shallow_data data;
+	data.out =3D out;
+	data.use_pack_protocol =3D use_pack_protocol;
+	data.count =3D 0;
+	for_each_commit_graft(write_one_shallow, &data);
+	return data.count;
+}
+
+void setup_alternate_shallow(struct lock_file *shallow_lock,
+			     const char **alternate_shallow_file)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+
+	check_shallow_file_for_update();
+	fd =3D hold_lock_file_for_update(shallow_lock, git_path("shallow"),
+				       LOCK_DIE_ON_ERROR);
+	if (write_shallow_commits(&sb, 0)) {
+		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
+			die_errno("failed to write to %s",
+				  shallow_lock->filename);
+		*alternate_shallow_file =3D shallow_lock->filename;
+	} else
+		/*
+		 * is_repository_shallow() sees empty string as "no
+		 * shallow file".
+		 */
+		*alternate_shallow_file =3D "";
+	strbuf_release(&sb);
+}
--=20
1.8.2.83.gc99314b
