From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 07/28] shallow.c: extend setup_*_shallow() to accept extra shallow commits
Date: Thu,  5 Dec 2013 20:02:34 +0700
Message-ID: <1386248575-10206-8-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWH-0001fC-Li
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148Ab3LEM7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:00 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:61001 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab3LEM67 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:59 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so24512225pdj.22
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WvLxSLHzQ1J9KXNSI1bKXY2EkFPsUCJBpyLFi/7lBio=;
        b=zQj1WdrKnYxo51n27nJGkgjaM3O1XAlM3ephIhxFfxK5uAmxVhhI8vWh6vr8WLueVJ
         PPvvsHcbcZS7GXapeIZA8Obp6Yav6/H13rEMt2llTJ5j2JUV7GCsBHRxKkPZBrX9f26K
         txO41IM9fUaNzoOZI/fsi0CFW+dWfALKlCoME+hrUDyhTC/R80xL2A8F5/rg4wqx6WWL
         q9x6+8TtT+nOY/O0hnqNv88+M4iLuUt98B7A3R604IFpUBvit+7BwmmMx5772QNgaUVC
         oMCEDoPyd5trfNrBGnbBg1aHDqu756lVTY7qGe3XKxjzw/ZrkGFYOv0XHGw08Lxb00Q1
         BEjw==
X-Received: by 10.68.59.202 with SMTP id b10mr52877740pbr.78.1386248339151;
        Thu, 05 Dec 2013 04:58:59 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id hz10sm144592312pbc.36.2013.12.05.04.58.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:43 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238863>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h      |  8 +++++---
 fetch-pack.c  |  5 +++--
 shallow.c     | 20 +++++++++++++++-----
 upload-pack.c |  2 +-
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/commit.h b/commit.h
index a879526..1faf717 100644
--- a/commit.h
+++ b/commit.h
@@ -201,10 +201,12 @@ extern struct commit_list *get_shallow_commits(st=
ruct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 extern void check_shallow_file_for_update(void);
 extern void set_alternate_shallow_file(const char *path);
-extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
+extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol,
+				 const struct sha1_array *extra);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
-				    const char **alternate_shallow_file);
-extern char *setup_temporary_shallow(void);
+				    const char **alternate_shallow_file,
+				    const struct sha1_array *extra);
+extern char *setup_temporary_shallow(const struct sha1_array *extra);
 extern void advertise_shallow_grafts(int);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
diff --git a/fetch-pack.c b/fetch-pack.c
index 1042448..0e7483e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -311,7 +311,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	}
=20
 	if (is_repository_shallow())
-		write_shallow_commits(&req_buf, 1);
+		write_shallow_commits(&req_buf, 1, NULL);
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	packet_buf_flush(&req_buf);
@@ -850,7 +850,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
 	if (args->depth > 0)
-		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file);
+		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
+					NULL);
 	else
 		alternate_shallow_file =3D NULL;
 	if (get_pack(args, fd, pack_lockfile))
diff --git a/shallow.c b/shallow.c
index 9552512..f9d1633 100644
--- a/shallow.c
+++ b/shallow.c
@@ -165,22 +165,31 @@ static int write_one_shallow(const struct commit_=
graft *graft, void *cb_data)
 	return 0;
 }
=20
-int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
+			  const struct sha1_array *extra)
 {
 	struct write_shallow_data data;
+	int i;
 	data.out =3D out;
 	data.use_pack_protocol =3D use_pack_protocol;
 	data.count =3D 0;
 	for_each_commit_graft(write_one_shallow, &data);
+	if (!extra)
+		return data.count;
+	for (i =3D 0; i < extra->nr; i++) {
+		strbuf_addstr(out, sha1_to_hex(extra->sha1[i]));
+		strbuf_addch(out, '\n');
+		data.count++;
+	}
 	return data.count;
 }
=20
-char *setup_temporary_shallow(void)
+char *setup_temporary_shallow(const struct sha1_array *extra)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int fd;
=20
-	if (write_shallow_commits(&sb, 0)) {
+	if (write_shallow_commits(&sb, 0, extra)) {
 		struct strbuf path =3D STRBUF_INIT;
 		strbuf_addstr(&path, git_path("shallow_XXXXXX"));
 		fd =3D xmkstemp(path.buf);
@@ -199,7 +208,8 @@ char *setup_temporary_shallow(void)
 }
=20
 void setup_alternate_shallow(struct lock_file *shallow_lock,
-			     const char **alternate_shallow_file)
+			     const char **alternate_shallow_file,
+			     const struct sha1_array *extra)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int fd;
@@ -207,7 +217,7 @@ void setup_alternate_shallow(struct lock_file *shal=
low_lock,
 	check_shallow_file_for_update();
 	fd =3D hold_lock_file_for_update(shallow_lock, git_path("shallow"),
 				       LOCK_DIE_ON_ERROR);
-	if (write_shallow_commits(&sb, 0)) {
+	if (write_shallow_commits(&sb, 0, extra)) {
 		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
 			die_errno("failed to write to %s",
 				  shallow_lock->filename);
diff --git a/upload-pack.c b/upload-pack.c
index 38b2a29..f082f06 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -84,7 +84,7 @@ static void create_pack_file(void)
 	char *shallow_file =3D NULL;
=20
 	if (shallow_nr) {
-		shallow_file =3D setup_temporary_shallow();
+		shallow_file =3D setup_temporary_shallow(NULL);
 		argv[arg++] =3D "--shallow-file";
 		argv[arg++] =3D shallow_file;
 	}
--=20
1.8.5.1.25.g8667982
