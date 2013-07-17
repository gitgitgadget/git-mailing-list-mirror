From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/7] fetch-pack: support fetching from a shallow repository
Date: Wed, 17 Jul 2013 19:47:12 +0700
Message-ID: <1374065234-870-6-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR8t-00058J-E0
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab3GQMrf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:35 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:52386 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab3GQMre (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:34 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so1789077pdi.25
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xjtvpSpAN8PyiwxI6eD/VM4ELqFo6T8OKHBPkiuu+nc=;
        b=QFJt5KwbT1D0BsJI9wz94xT7Tcs7H7x6TCoj35N5foD5dDRAVYoWI77yBqvB0TnJdP
         Od/Nr6vZgbijZaIlss2AAgpV8ZzY+FyXptyNJZQetD759IYo9GlU1FAXvUKep3mAVzC/
         auLHwPuUL51uoUkMWqmCsiefXyA5nNurDi4WrrNZ6enxxhIuHFgpnlBFaoWnTq/bC2oM
         JxDmLsXoDLg3eXFjwZiF1fnC/dWTyHyw8CKDpQ/LWnFV7gAlRwe6wrQ1kwPudLBFTY2E
         sqWcMrvLmDLenfiJ9P1epvFehn2bKE+e0wKoaLWfD9L90TK/ZEb8Bt9/e6IkIICsM5rF
         dTCg==
X-Received: by 10.68.201.193 with SMTP id kc1mr6606548pbc.91.1374065253890;
        Wed, 17 Jul 2013 05:47:33 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id ue9sm10380583pab.7.2013.07.17.05.47.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:33 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:47:49 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230618>

upload-pack already advertises all shallow grafts if server repository
is shallow. This information can be used to add more grafts to the
client if the server sends commit chains down to its graft points.

If the server is shallow, before we receive the pack, we setup a
temporary shallow file that contains both local graft points and the
server's. This stops index-pack from going beyond server's graft
points.

Only server graft points that do not have corresponding SHA-1s in
local repo are added to the temp shallow file because we don't want to
accidentally cut the client history because the server's is
shorter. The client cutting can only happen when --depth is requested.

After index-pack finishes successfully, we write the temporary shallow
down with one exception: unused graft points provided by the server
are removed. We don't want those lying around and suddenly become
active.

Note that in the "shallow -> shallow" case, the server might not have
enough information to find common roots to create an optimum pack. It
might send complete commit chains down to the graft points as a
result. I don't think we can improve this, unless upload-pack somehow
has access to a full repository.

"shallow -> shallow" case only makes sense when the upstream provides
a stable shallow repo (e.g. make a cut every year or so and ask devs
to all move to the new base). If the cloned repos are all based on a
stable (shallow) upstream, the above problem is unlikely to happen.

A side effect of this change is we can now clone from a shallow
repository. And a full repository may automatically become shallow if
you fetch from a shallow repository.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c              |  6 ++--
 commit.h                          |  8 +++--
 fetch-pack.c                      | 27 +++++++++++---
 fetch-pack.h                      |  1 +
 shallow.c                         | 46 ++++++++++++++++++++----
 t/t5536-fetch-shallow.sh (new +x) | 75 +++++++++++++++++++++++++++++++=
++++++++
 transport.c                       |  8 +++--
 7 files changed, 153 insertions(+), 18 deletions(-)
 create mode 100755 t/t5536-fetch-shallow.sh

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 080e599..b89d753 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -37,6 +37,7 @@ int cmd_fetch_pack(int argc, const char **argv, const=
 char *prefix)
 	char **pack_lockfile_ptr =3D NULL;
 	struct child_process *conn;
 	struct fetch_pack_args args;
+	struct extra_have_objects shallow;
=20
 	packet_trace_identity("fetch-pack");
=20
@@ -144,10 +145,11 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
 				   args.verbose ? CONNECT_VERBOSE : 0);
 	}
=20
-	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, NULL);
+	memset(&shallow, 0, sizeof(shallow));
+	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
=20
 	ref =3D fetch_pack(&args, fd, conn, ref, dest,
-			 sought, nr_sought, pack_lockfile_ptr);
+			 sought, nr_sought, &shallow, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
 		fflush(stdout);
diff --git a/commit.h b/commit.h
index 678fa20..7faf0e4 100644
--- a/commit.h
+++ b/commit.h
@@ -188,9 +188,13 @@ extern struct commit_list *get_shallow_commits(str=
uct object_array *heads,
 extern void check_shallow_file_for_update(void);
 extern void set_alternate_shallow_file(const char *path);
 extern void advertise_shallow_grafts(int);
-extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol);
+extern int write_shallow_commits(struct strbuf *out, int use_pack_prot=
ocol,
+				 struct extra_have_objects *extra,
+				 int remove_unused_grafts);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
-				    const char **alternate_shallow_file);
+				    const char **alternate_shallow_file,
+				    struct extra_have_objects *extra,
+				    int rewrite);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/fetch-pack.c b/fetch-pack.c
index dc71a2b..68b95a5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -311,7 +311,7 @@ static int find_common(struct fetch_pack_args *args=
,
 	}
=20
 	if (is_repository_shallow())
-		write_shallow_commits(&req_buf, 1);
+		write_shallow_commits(&req_buf, 1, NULL, 0);
 	if (args->depth > 0)
 		packet_buf_write(&req_buf, "deepen %d", args->depth);
 	packet_buf_flush(&req_buf);
@@ -769,6 +769,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
 				 int fd[2],
 				 const struct ref *orig_ref,
 				 struct ref **sought, int nr_sought,
+				 struct extra_have_objects *shallow,
 				 char **pack_lockfile)
 {
 	struct ref *ref =3D copy_ref_list(orig_ref);
@@ -844,8 +845,9 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if (args->stateless_rpc)
 		packet_flush(fd[1]);
-	if (args->depth > 0)
-		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file);
+	if (args->depth > 0 || shallow->nr)
+		setup_alternate_shallow(&shallow_lock, &alternate_shallow_file,
+					shallow, 0);
 	if (get_pack(args, fd, pack_lockfile))
 		die("git fetch-pack: fetch failed.");
=20
@@ -922,6 +924,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args=
,
 		       const struct ref *ref,
 		       const char *dest,
 		       struct ref **sought, int nr_sought,
+		       struct extra_have_objects *shallow,
 		       char **pack_lockfile)
 {
 	struct ref *ref_cpy;
@@ -934,14 +937,28 @@ struct ref *fetch_pack(struct fetch_pack_args *ar=
gs,
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought, pack_lock=
file);
+	ref_cpy =3D do_fetch_pack(args, fd, ref, sought, nr_sought,
+				shallow, pack_lockfile);
=20
 	if (alternate_shallow_file) {
 		if (*alternate_shallow_file =3D=3D '\0') { /* --unshallow */
 			unlink_or_warn(git_path("shallow"));
 			rollback_lock_file(&shallow_lock);
-		} else
+		} else {
+			/*
+			 *  The server is a shallow clone and it sends
+			 *  us all of its shallow grafts. Some may be
+			 *  needed if the server sends objects down to
+			 *  the bottom. Remove all unused grafts.
+			 */
+			if (shallow->nr) {
+				reprepare_packed_git();
+				setup_alternate_shallow(&shallow_lock,
+							&alternate_shallow_file,
+							shallow, 1);
+			}
 			commit_lock_file(&shallow_lock);
+		}
 	}
=20
 	reprepare_packed_git();
diff --git a/fetch-pack.h b/fetch-pack.h
index 40f08ba..c55bf1c 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -32,6 +32,7 @@ struct ref *fetch_pack(struct fetch_pack_args *args,
 		       const char *dest,
 		       struct ref **sought,
 		       int nr_sought,
+		       struct extra_have_objects *shallow,
 		       char **pack_lockfile);
=20
 #endif
diff --git a/shallow.c b/shallow.c
index ee9edd4..d909d95 100644
--- a/shallow.c
+++ b/shallow.c
@@ -183,26 +183,60 @@ static int write_one_shallow(const struct commit_=
graft *graft, void *cb_data)
 	return 0;
 }
=20
-int write_shallow_commits(struct strbuf *out, int use_pack_protocol)
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
+			  struct extra_have_objects *extra,
+			  int remove_unused_grafts)
 {
 	struct write_shallow_data data;
+	int i;
 	data.out =3D out;
 	data.use_pack_protocol =3D use_pack_protocol;
 	data.count =3D 0;
 	for_each_commit_graft(write_one_shallow, &data);
+	if (!extra)
+		return data.count;
+
+	for (i =3D 0; i < extra->nr; i++) {
+		if (!remove_unused_grafts && has_sha1_file(extra->array[i]))
+			/*
+			 * The server may have even shorter history
+			 * than the client (e.g. the client has
+			 * A-B-C-D but the server only has C-D). We do
+			 * NOT want to cut client's history down to
+			 * C-D simply because the server is set up
+			 * so. If we don't have "C" and the server
+			 * sends C-D to us, then we set up a graft at
+			 * "C".
+			 */
+			continue;
+		if (remove_unused_grafts && !has_sha1_file(extra->array[i]))
+			continue;
+		strbuf_addstr(out, sha1_to_hex(extra->array[i]));
+		strbuf_addch(out, '\n');
+		data.count++;
+	}
 	return data.count;
 }
=20
 void setup_alternate_shallow(struct lock_file *shallow_lock,
-			     const char **alternate_shallow_file)
+			     const char **alternate_shallow_file,
+			     struct extra_have_objects *extra,
+			     int rewrite)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int fd;
=20
-	check_shallow_file_for_update();
-	fd =3D hold_lock_file_for_update(shallow_lock, git_path("shallow"),
-				       LOCK_DIE_ON_ERROR);
-	if (write_shallow_commits(&sb, 0)) {
+	if (!rewrite)
+		fd =3D hold_lock_file_for_update(shallow_lock,
+					       git_path("shallow"),
+					       LOCK_DIE_ON_ERROR);
+	else
+		fd =3D shallow_lock->fd;
+	if (write_shallow_commits(&sb, 0, extra, rewrite)) {
+		if (rewrite && (lseek(fd, 0, SEEK_SET) =3D=3D -1 ||
+				ftruncate(fd, 0) =3D=3D -1))
+			die_errno("unable to truncate the new shallow file %s",
+				  shallow_lock->filename);
 		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
 			die_errno("failed to write to %s",
 				  shallow_lock->filename);
diff --git a/t/t5536-fetch-shallow.sh b/t/t5536-fetch-shallow.sh
new file mode 100755
index 0000000..599928f
--- /dev/null
+++ b/t/t5536-fetch-shallow.sh
@@ -0,0 +1,75 @@
+#!/bin/sh
+
+test_description=3D'fetch/clone from a shallow clone'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit 1 &&
+	test_commit 2 &&
+	test_commit 3 &&
+	test_commit 4
+'
+
+test_expect_success 'setup shallow clone' '
+	git clone --no-local --depth=3D2 .git shallow &&
+	git --git-dir=3Dshallow/.git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'clone from shallow clone' '
+	git clone --no-local shallow shallow2 &&
+	(
+	cd shallow2 &&
+	git fsck &&
+	git log --format=3D%s >actual &&
+	cat <<EOF >expect &&
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'fetch from shallow clone' '
+	(
+	cd shallow &&
+	test_commit 5
+	) &&
+	(
+	cd shallow2 &&
+	git fetch &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+5
+4
+3
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_expect_success 'fetch --depth from shallow clone' '
+	(
+	cd shallow &&
+	test_commit 6
+	) &&
+	(
+	cd shallow2 &&
+	git fetch --depth=3D2 &&
+	git fsck &&
+	git log --format=3D%s origin/master >actual &&
+	cat <<EOF >expect &&
+6
+5
+EOF
+	test_cmp expect actual
+	)
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 10a8cb8..17fef16 100644
--- a/transport.c
+++ b/transport.c
@@ -453,6 +453,7 @@ struct git_transport_data {
 	int fd[2];
 	unsigned got_remote_heads : 1;
 	struct extra_have_objects extra_have;
+	struct extra_have_objects shallow;
 };
=20
 static int set_git_option(struct git_transport_options *opts,
@@ -509,7 +510,8 @@ static struct ref *get_refs_via_connect(struct tran=
sport *transport, int for_pus
=20
 	connect_setup(transport, for_push, 0);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
-			 for_push ? REF_NORMAL : 0, &data->extra_have, NULL);
+			 for_push ? REF_NORMAL : 0,
+			 &data->extra_have, &data->shallow);
 	data->got_remote_heads =3D 1;
=20
 	return refs;
@@ -540,13 +542,13 @@ static int fetch_refs_via_pack(struct transport *=
transport,
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
-				 NULL, NULL);
+				 NULL, &data->shallow);
 		data->got_remote_heads =3D 1;
 	}
=20
 	refs =3D fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-			  dest, to_fetch, nr_heads,
+			  dest, to_fetch, nr_heads, &data->shallow,
 			  &transport->pack_lockfile);
 	close(data->fd[0]);
 	close(data->fd[1]);
--=20
1.8.2.83.gc99314b
