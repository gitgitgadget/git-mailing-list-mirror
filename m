From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/4] fetch-pack: prepare updated shallow file before fetching the pack
Date: Fri,  3 May 2013 19:35:12 +0700
Message-ID: <1367584514-19806-3-git-send-email-pclouds@gmail.com>
References: <1367405974-22190-1-git-send-email-pclouds@gmail.com>
 <1367584514-19806-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 14:34:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYFCQ-00023g-KA
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 14:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762044Ab3ECMek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 May 2013 08:34:40 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:46496 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761902Ab3ECMeh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 08:34:37 -0400
Received: by mail-pa0-f48.google.com with SMTP id kp6so896155pab.21
        for <git@vger.kernel.org>; Fri, 03 May 2013 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Yxx9cO3uCTpdvNZ7Y958/+22J8C7UCTEHXqXB1ZssCM=;
        b=ndV144fjWdkLWXi+PKXh2NNf7n7lzdLxbQ/geTurAXcLc3rXcw0P1bQWYDZA0cYFyT
         yYPhFQP4lEblKCLj9qpV4z6iLnTnBtlBqElMfRXrw0/SmaN2vVAaqsV8QTagel0K1EkE
         eBv2oJzmmLXl9jZUCQ1TljQVgPEnHfNjcI6Xb9jvWHrG8iBYtJLE+lpqQadsI/PqIibg
         0yfdSTCioYeP4oslJ06NwZVFrXnNDf1ujVhLgZXURUoaTQzowgDKBV38zJPHc1w+gHFW
         yfCr34zCVYv0t/IXtnwIUXGyvEkdjy/6XmRx5K4OS9qlbBfzmQT4TNiJzNcxuqGMgrzl
         FB9w==
X-Received: by 10.68.35.3 with SMTP id d3mr6549788pbj.155.1367584476888;
        Fri, 03 May 2013 05:34:36 -0700 (PDT)
Received: from lanh ([115.74.38.7])
        by mx.google.com with ESMTPSA id sa6sm11519008pbb.26.2013.05.03.05.34.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 03 May 2013 05:34:36 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 03 May 2013 19:35:29 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1367584514-19806-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223306>

index-pack --strict looks up and follows parent commits. If shallow
information is not ready by the time index-pack is run, index-pack may
be lead to non-existent objects. Make fetch-pack save shallow file to
disk before invoking index-pack.

git learns new global option --shallow-file to pass on the alternate
shallow file path. Undocumented (and not even support --shallow-file=3D
syntax) because it's unlikely to be used again elsewhere.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 commit.h              |  2 ++
 fetch-pack.c          | 69 +++++++++++++++++++++++++------------------=
--------
 git.c                 |  5 ++++
 shallow.c             | 45 +++++++++++++++++++++++++++++++--
 t/t5500-fetch-pack.sh |  7 ++++++
 5 files changed, 91 insertions(+), 37 deletions(-)

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
index f156dd4..1ca4f6b 100644
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
@@ -779,6 +786,23 @@ static int cmp_ref_by_name(const void *a_, const v=
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
+		alternate_shallow_file =3D "";
+	strbuf_release(&sb);
+}
+
 static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
@@ -858,6 +882,8 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
+	if (args->depth > 0)
+		setup_alternate_shallow();
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
@@ -936,15 +962,9 @@ struct ref *fetch_pack(struct fetch_pack_args *arg=
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
@@ -955,34 +975,13 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
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
 	}
=20
 	reprepare_packed_git();
diff --git a/git.c b/git.c
index 1ada169..6450a38 100644
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
@@ -146,6 +147,10 @@ static int handle_options(const char ***argv, int =
*argc, int *envchanged)
 			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "0", 1);
 			if (envchanged)
 				*envchanged =3D 1;
+		} else if (!strcmp(cmd, "--shallow-file")) {
+			(*argv)++;
+			(*argc)--;
+			set_alternate_shallow_file((*argv)[0]);
 		} else {
 			fprintf(stderr, "Unknown option: %s\n", cmd);
 			usage(git_usage_string);
diff --git a/shallow.c b/shallow.c
index 6be915f..bdae988 100644
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
+	 * fetch-pack set '--shallow-file ""' as an indicator that no
+	 * shallow file should be used. We could just open it and it
+	 * will likely fail. But let's do an explicit check instead.
+	 */
+	if (!*path ||
+	    stat(path, &shallow_stat) ||
+	    (fp =3D fopen(path, "r")) =3D=3D NULL) {
 		is_shallow =3D 0;
 		return is_shallow;
 	}
@@ -108,3 +127,25 @@ struct commit_list *get_shallow_commits(struct obj=
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
