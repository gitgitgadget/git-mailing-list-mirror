From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/5] fetch-pack: prepare updated shallow file before fetching the pack
Date: Wed,  1 May 2013 17:59:31 +0700
Message-ID: <1367405974-22190-3-git-send-email-pclouds@gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 12:59:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXUkc-0007EL-3J
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 12:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760401Ab3EAK7C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 May 2013 06:59:02 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:45586 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758441Ab3EAK7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 06:59:00 -0400
Received: by mail-pa0-f45.google.com with SMTP id lf10so816586pab.18
        for <git@vger.kernel.org>; Wed, 01 May 2013 03:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iG0pOtjmscZM6SWNyquL0Z4X5IhIMgNmZ0ZqrpT5pGo=;
        b=ruynI4ne9hBpIexLvM7qwwPK/8G6wzBqlW8DfUzm0aDRQ5fu067xKOgELk+gb5BW1t
         iXLWh/vH8b+DQPn8rART7GjNsLHviMmTuPnSvbjt9VrFGIvi86kT3Ei9Ggl4YjlWjYip
         aBBm8C5C1BdsfmXwSuN2Sr4p8f818hlgwwnuVtG6vClyyIjjNPt2QlRRg1gN7pc6rBmx
         x70BzTxbPnf8r6onrmfre3Faj8sYyaUKLLPlUuObM52yqMc7RO3PFqEySFcfsXZKKLca
         DOGZ6mrKI+k9FWjVyghnGr7aMLa/h+aRR5OvP4ZttsJ9VluEN08Nl53/YNJRL61lhOLs
         vh2w==
X-Received: by 10.66.5.133 with SMTP id s5mr4397686pas.43.1367405939988;
        Wed, 01 May 2013 03:58:59 -0700 (PDT)
Received: from lanh ([115.74.47.19])
        by mx.google.com with ESMTPSA id wz9sm2599052pbc.5.2013.05.01.03.58.56
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 01 May 2013 03:58:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 01 May 2013 17:59:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223082>

index-pack --strict looks up and follows parent commits. If shallow
information is not ready by the time index-pack is run, index-pack may
be lead to non-existent objects. Make fetch-pack save shallow file to
disk before invoking index-pack.

A new environment variable GIT_SHALLOW_FILE is used to inform
index-pack to use an alternate shallow file. This variable is for
internal use and thus not advertised in git.txt.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h              |  1 +
 fetch-pack.c          | 65 ++++++++++++++++++++++++-------------------=
--------
 shallow.c             | 30 ++++++++++++++++++++++--
 t/t5500-fetch-pack.sh |  7 ++++++
 4 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/commit.h b/commit.h
index 67bd509..0cef659 100644
--- a/commit.h
+++ b/commit.h
@@ -176,6 +176,7 @@ extern int for_each_commit_graft(each_commit_graft_=
fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
 		int depth, int shallow_flag, int not_shallow_flag);
+extern void check_shallow_file_for_update(void);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/fetch-pack.c b/fetch-pack.c
index f156dd4..17cfa88 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -20,6 +20,7 @@ static int no_done;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
+static struct lock_file shallow_lock;
=20
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -779,6 +780,26 @@ static int cmp_ref_by_name(const void *a_, const v=
oid *b_)
 	return strcmp(a->name, b->name);
 }
=20
+static void setup_alternate_shallow(void)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+
+	check_shallow_file_for_update();
+	fd =3D hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
+				       LOCK_DIE_ON_ERROR);
+	if (write_shallow_commits(&sb, 0)) {
+		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
+			die_errno("failed to write to %s", shallow_lock.filename);
+		if (setenv("GIT_SHALLOW_FILE", shallow_lock.filename, 1))
+			die_errno("failed to set GIT_SHALLOW_FILE");
+	} else {
+		if (setenv("GIT_SHALLOW_FILE", "", 1))
+			die_errno("failed to set GIT_SHALLOW_FILE");
+	}
+	strbuf_release(&sb);
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
@@ -858,6 +879,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
+	if (args->depth > 0)
+		setup_alternate_shallow();
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
@@ -936,15 +959,9 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
s,
 		       struct ref **sought, int nr_sought,
 		       char **pack_lockfile)
 {
-	struct stat st;
 	struct ref *ref_cpy;
=20
 	fetch_pack_setup();
-	if (args->depth > 0) {
-		if (stat(git_path("shallow"), &st))
-			st.st_mtime =3D 0;
-	}
-
 	if (nr_sought)
 		nr_sought =3D remove_duplicates_in_refs(sought, nr_sought);
=20
@@ -955,34 +972,14 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
gs,
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
=20
 	if (args->depth > 0) {
-		static struct lock_file lock;
-		struct cache_time mtime;
-		struct strbuf sb =3D STRBUF_INIT;
-		char *shallow =3D git_path("shallow");
-		int fd;
-
-		mtime.sec =3D st.st_mtime;
-		mtime.nsec =3D ST_MTIME_NSEC(st);
-		if (stat(shallow, &st)) {
-			if (mtime.sec)
-				die("shallow file was removed during fetch");
-		} else if (st.st_mtime !=3D mtime.sec
-#ifdef USE_NSEC
-				|| ST_MTIME_NSEC(st) !=3D mtime.nsec
-#endif
-			  )
-			die("shallow file was changed during fetch");
-
-		fd =3D hold_lock_file_for_update(&lock, shallow,
-					       LOCK_DIE_ON_ERROR);
-		if (!write_shallow_commits(&sb, 0)
-		 || write_in_full(fd, sb.buf, sb.len) !=3D sb.len) {
-			unlink_or_warn(shallow);
-			rollback_lock_file(&lock);
-		} else {
-			commit_lock_file(&lock);
-		}
-		strbuf_release(&sb);
+		struct stat st;
+		if (!fstat(shallow_lock.fd, &st) &&
+		    st.st_size =3D=3D 0) {
+			unlink_or_warn(git_path("shallow"));
+			rollback_lock_file(&shallow_lock);
+		} else
+			commit_lock_file(&shallow_lock);
+		unsetenv("GIT_SHALLOW_FILE");
 	}
=20
 	reprepare_packed_git();
diff --git a/shallow.c b/shallow.c
index 6be915f..9c03806 100644
--- a/shallow.c
+++ b/shallow.c
@@ -3,6 +3,7 @@
 #include "tag.h"
=20
 static int is_shallow =3D -1;
+static struct stat shallow_stat;
=20
 int register_shallow(const unsigned char *sha1)
 {
@@ -21,12 +22,15 @@ int is_repository_shallow(void)
 {
 	FILE *fp;
 	char buf[1024];
+	const char *path;
=20
 	if (is_shallow >=3D 0)
 		return is_shallow;
=20
-	fp =3D fopen(git_path("shallow"), "r");
-	if (!fp) {
+	path =3D getenv("GIT_SHALLOW_FILE");
+	if (!path)
+		path =3D git_path("shallow");
+	if (stat(path, &shallow_stat) || (fp =3D fopen(path, "r")) =3D=3D NUL=
L) {
 		is_shallow =3D 0;
 		return is_shallow;
 	}
@@ -108,3 +112,25 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
=20
 	return result;
 }
+
+void check_shallow_file_for_update(void)
+{
+	struct stat st;
+
+	if (getenv("GIT_SHALLOW_FILE"))
+		die("GIT_SHALLOW_FILE should not be manually set");
+
+	if (!is_shallow)
+		return;
+	else if (is_shallow =3D=3D -1)
+		die("BUG: shallow must be initialized by now");
+
+	if (stat(git_path("shallow"), &st))
+		die("shallow file was removed during fetch");
+	else if (st.st_mtime !=3D shallow_stat.st_mtime
+#ifdef USE_NSEC
+		 || ST_MTIME_NSEC(st) !=3D ST_MTIME_NSEC(shallow_stat)
+#endif
+		   )
+		die("shallow file was changed during fetch");
+}
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d574085..557b073 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -135,6 +135,13 @@ test_expect_success 'clone shallow depth 1' '
 	test "`git --git-dir=3Dshallow0/.git rev-list --count HEAD`" =3D 1
 '
=20
+test_expect_success 'clone shallow depth 1 with fsck' '
+	git config --global fetch.fsckobjects true &&
+	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0fsck=
 &&
+	test "`git --git-dir=3Dshallow0fsck/.git rev-list --count HEAD`" =3D =
1 &&
+	git config --global --unset fetch.fsckobjects
+'
+
 test_expect_success 'clone shallow' '
 	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
 '
--=20
1.8.2.83.gc99314b
