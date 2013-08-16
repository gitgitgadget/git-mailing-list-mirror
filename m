From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/6] Move setup_alternate_shallow and write_shallow_commits to shallow.c
Date: Fri, 16 Aug 2013 16:52:02 +0700
Message-ID: <1376646727-22318-1-git-send-email-pclouds@gmail.com>
References: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthijs Kooijman <matthijs@stdin.nl>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 16 11:52:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAGhg-0007ht-Es
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 11:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340Ab3HPJwQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 05:52:16 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61167 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab3HPJwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 05:52:15 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2027049pde.23
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Vp3S/YkmDL64grykuOs3lzwuxkG+O4hzVF5zEQX7gOw=;
        b=CWCCrifoSlXdepKFuINwBKbPgRnJqCo1bbGPLd4nKu1gqA2uf/2dK9STD/hp3ShVEk
         WBp4dBp7wjzkPRbhm9LmZXdFGeP8jZCwRUhNRgHKBJ6qYgDln03dfU2AZoYvMTgEO6n9
         Q0gZGM2nCbKr24Zd+8gqup6STurhcIMY5VHE8a1heJ7Eh6iBO/Oz/V0LW3E/nBWQ45Po
         kGh6DikiNKmbPX+BkbGCkx77nE/L5M6EHtjAavtCJtOERUv5tQNkkCIMlBQswacqDqY4
         34e1TZAnPP3KMpzwR3tKlgwxXXuyUKxSpZuP9BxA20CzXmbdQt7xn3KJVZ8I6//ep78e
         R6Qg==
X-Received: by 10.68.254.138 with SMTP id ai10mr651746pbd.151.1376646735456;
        Fri, 16 Aug 2013 02:52:15 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id qf7sm2348753pac.14.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 16 Aug 2013 02:52:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 16 Aug 2013 16:52:08 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <CACsJy8CDGgKftp0iBB8MYjMawKhxZ1JQ+xAYb0itpaCOjFHWxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232408>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h     |  3 +++
 fetch-pack.c | 53 +---------------------------------------------------=
-
 shallow.c    | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
++
 3 files changed, 58 insertions(+), 52 deletions(-)

diff --git a/commit.h b/commit.h
index d912a9d..790e31b 100644
--- a/commit.h
+++ b/commit.h
@@ -198,6 +198,9 @@ extern struct commit_list *get_shallow_commits(stru=
ct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern void check_shallow_file_for_update(void);
 extern void set_alternate_shallow_file(const char *path);
+extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
+extern void setup_alternate_shallow(struct lock_file *shallow_lock,
+				    const char **alternate_shallow_file);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/fetch-pack.c b/fetch-pack.c
index 6684348..28195ed 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -184,36 +184,6 @@ static void consume_shallow_list(struct fetch_pack=
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
index 8a9c96d..68dd106 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "commit.h"
 #include "tag.h"
+#include "pkt-line.h"
=20
 static int is_shallow =3D -1;
 static struct stat shallow_stat;
@@ -141,3 +142,56 @@ void check_shallow_file_for_update(void)
 		   )
 		die("shallow file was changed during fetch");
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
1.8.2.82.gc24b958
