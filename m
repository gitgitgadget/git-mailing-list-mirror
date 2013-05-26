From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 2/4] fetch-pack: prepare updated shallow file before fetching the pack
Date: Sun, 26 May 2013 08:16:15 +0700
Message-ID: <1369530977-12746-3-git-send-email-pclouds@gmail.com>
References: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 03:15:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgPYS-00081c-7h
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 03:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758781Ab3EZBPT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 May 2013 21:15:19 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34912 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758754Ab3EZBPR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 May 2013 21:15:17 -0400
Received: by mail-pd0-f175.google.com with SMTP id 6so5036565pdd.6
        for <git@vger.kernel.org>; Sat, 25 May 2013 18:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Rge3KvLq+I2cEgH3jEi+Z9b3y8tzFnTF1D6+fs17i+I=;
        b=PbYOvjLUnX3w8rjNmTqL33Jjj6elPHHQyVboIy1LqSFzoXwS+RG9UPwz/obdnlOLdv
         PzdxO04Jf20bRerbGwVNxZPbEfqo1zStotPjLWDVXwfWbrqRWGhY1JulwAaC4lFQftWV
         5c1h9XTY+2nVjcQP2vW5b2LgoEmx+EoBj2TaJB+LpC139bpwWgZmcBpg3TeuJg2rk+Ba
         WNiYTi+yPggMsuIq8fe0EsiaXoaNsxgHoTiZt5GFbjpjy5PfZuf1s+SXU3eD+blGLBCu
         HbiAswbofh10Xyh+yKpu89OtDdWwo1iC18JJ9cflfY8zeJfwp9qEVB2CF2wKOYh+Dm3j
         eH3g==
X-Received: by 10.68.228.195 with SMTP id sk3mr23506983pbc.103.1369530917176;
        Sat, 25 May 2013 18:15:17 -0700 (PDT)
Received: from lanh ([115.73.211.70])
        by mx.google.com with ESMTPSA id un15sm22340906pab.7.2013.05.25.18.15.14
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 25 May 2013 18:15:16 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 26 May 2013 08:16:34 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1369530977-12746-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225539>

index-pack --strict looks up and follows parent commits. If shallow
information is not ready by the time index-pack is run, index-pack may
be led to non-existent objects. Make fetch-pack save shallow file to
disk before invoking index-pack.

git learns new global option --shallow-file to pass on the alternate
shallow file path. Undocumented (and not even support --shallow-file=3D
syntax) because it's unlikely to be used again elsewhere.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h              |  2 ++
 fetch-pack.c          | 73 ++++++++++++++++++++++++++-----------------=
--------
 git.c                 |  7 +++++
 shallow.c             | 42 +++++++++++++++++++++++++++--
 t/t5500-fetch-pack.sh |  7 +++++
 5 files changed, 93 insertions(+), 38 deletions(-)

diff --git a/commit.h b/commit.h
index 67bd509..6e9c7cd 100644
--- a/commit.h
+++ b/commit.h
@@ -176,6 +176,8 @@ extern int for_each_commit_graft(each_commit_graft_=
fn, void *);
 extern int is_repository_shallow(void);
 extern struct commit_list *get_shallow_commits(struct object_array *he=
ads,
 		int depth, int shallow_flag, int not_shallow_flag);
+extern void check_shallow_file_for_update(void);
+extern void set_alternate_shallow_file(const char *path);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/fetch-pack.c b/fetch-pack.c
index f156dd4..6b5467c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -20,6 +20,8 @@ static int no_done;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
+static struct lock_file shallow_lock;
+static const char *alternate_shallow_file;
=20
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
@@ -683,7 +685,7 @@ static int get_pack(struct fetch_pack_args *args,
 		    int xd[2], char **pack_lockfile)
 {
 	struct async demux;
-	const char *argv[20];
+	const char *argv[22];
 	char keep_arg[256];
 	char hdr_arg[256];
 	const char **av;
@@ -724,6 +726,11 @@ static int get_pack(struct fetch_pack_args *args,
 			do_keep =3D 1;
 	}
=20
+	if (alternate_shallow_file) {
+		*av++ =3D "--shallow-file";
+		*av++ =3D alternate_shallow_file;
+	}
+
 	if (do_keep) {
 		if (pack_lockfile)
 			cmd.out =3D -1;
@@ -779,6 +786,27 @@ static int cmp_ref_by_name(const void *a_, const v=
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
+		alternate_shallow_file =3D shallow_lock.filename;
+	} else
+		/*
+		 * is_repository_shallow() sees empty string as "no
+		 * shallow file".
+		 */
+		alternate_shallow_file =3D "";
+	strbuf_release(&sb);
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
@@ -858,6 +886,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
+	if (args->depth > 0)
+		setup_alternate_shallow();
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
@@ -936,15 +966,9 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
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
@@ -954,35 +978,12 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
gs,
 	}
 	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
=20
-	if (args->depth > 0) {
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
+	if (alternate_shallow_file) {
+		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
+			unlink_or_warn(git_path("shallow"));
+			rollback_lock_file(&shallow_lock);
+		} else
+			commit_lock_file(&shallow_lock);
 	}
=20
 	reprepare_packed_git();
diff --git a/git.c b/git.c
index 1ada169..88eef5a 100644
--- a/git.c
+++ b/git.c
@@ -4,6 +4,7 @@
 #include "help.h"
 #include "quote.h"
 #include "run-command.h"
+#include "commit.h"
=20
 const char git_usage_string[] =3D
 	"git [--version] [--help] [-c name=3Dvalue]\n"
@@ -146,6 +147,12 @@ static int handle_options(const char ***argv, int =
*argc, int *envchanged)
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "--shallow-file")) {
+			(*argv)++;
+			(*argc)--;
+			set_alternate_shallow_file((*argv)[0]);
+			if (envchanged)
+				*envchanged =3D 1;
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/shallow.c b/shallow.c
index 6be915f..cbe2526 100644
--- a/shallow.c
+++ b/shallow.c
@@ -3,6 +3,16 @@
 #include "tag.h"
=20
 static int is_shallow =3D -1;
+static struct stat shallow_stat;
+static char *alternate_shallow_file;
+
+void set_alternate_shallow_file(const char *path)
+{
+	if (is_shallow !=3D -1)
+		die("BUG: is_repository_shallow must not be called before set_altern=
ate_shallow_file");
+	free(alternate_shallow_file);
+	alternate_shallow_file =3D path ? xstrdup(path) : NULL;
+}
=20
 int register_shallow(const unsigned char *sha1)
 {
@@ -21,12 +31,21 @@ int is_repository_shallow(void)
 {
 	FILE *fp;
 	char buf[1024];
+	const char *path =3D alternate_shallow_file;
=20
 	if (is_shallow >=3D 0)
 		return is_shallow;
=20
-	fp =3D fopen(git_path("shallow"), "r");
-	if (!fp) {
+	if (!path)
+		path =3D git_path("shallow");
+	/*
+	 * fetch-pack sets '--shallow-file ""' as an indicator that no
+	 * shallow file should be used. We could just open it and it
+	 * will likely fail. But let's do an explicit check instead.
+	 */
+	if (!*path ||
+	    stat(path, &shallow_stat) ||
+	    (fp =3D fopen(path, "r")) =3D=3D NULL) {
 		is_shallow =3D 0;
 		return is_shallow;
 	}
@@ -108,3 +127,22 @@ struct commit_list *get_shallow_commits(struct obj=
ect_array *heads, int depth,
=20
 	return result;
 }
+
+void check_shallow_file_for_update(void)
+{
+	struct stat st;
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
