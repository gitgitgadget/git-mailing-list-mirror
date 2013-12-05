From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 27/28] prune: clean .git/shallow after pruning objects
Date: Thu,  5 Dec 2013 20:02:54 +0700
Message-ID: <1386248575-10206-28-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:01:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYYQ-0003Ch-IB
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab3LENBM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:01:12 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51965 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:01:11 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so25637712pbc.6
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=I3yW/AK1+YrrRxPN/q5Ktm2tf8Hkjd9H79JMlIkH2K8=;
        b=abf4rzINeKoGa8+b1iWzfRpGJe+ZWIlLaMraJTqeYNCQG76/cyVnRe4ApnQpoiNzkZ
         pkCPUqXjhaPi06/PAX+/PGE4EvJQKyiyNuCrMxQ+Z+ctt2En+nOPFfadsLNImhzIdKcB
         Pm+QwrjXQ7yzFcmIde02yt4hpjiDDH/OEUjHReCcMPo/B74RxWCVFI86hxe6M0BtJBx9
         GIMcBZZo6M60oOqCPc10WaFQqG1C0xVI2R6t1ZxknDXxSd8yp0TOuh7zQEhWAevygKni
         VLsduWEkg4oimV+xlPJhDNOWC5eGbXSosWHDadiXJJzMCgKEKAWsqYEM3N37rx9aFfqY
         ztNQ==
X-Received: by 10.68.232.196 with SMTP id tq4mr8442359pbc.166.1386248470650;
        Thu, 05 Dec 2013 05:01:10 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id gh3sm144631699pbb.2.2013.12.05.05.01.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:01:10 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:05:55 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238883>

This patch teaches "prune" to remove shallow roots that are no longer
reachable from any refs (e.g. when the relevant refs are removed).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-prune.txt |  2 ++
 builtin/gc.c                |  1 +
 builtin/prune.c             |  4 ++++
 commit.h                    |  1 +
 shallow.c                   | 55 +++++++++++++++++++++++++++++++++++++=
++++++--
 t/t5304-prune.sh            | 10 +++++++++
 6 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index bf82410..058ac0d 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -24,6 +24,8 @@ objects unreachable from any of these head objects fr=
om the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
 running 'git prune-packed'.
+It also removes entries from .git/shallow that are not reachable by
+any ref.
=20
 Note that unreachable, packed objects will remain.  If this is
 not desired, see linkgit:git-repack[1].
diff --git a/builtin/gc.c b/builtin/gc.c
index c14190f..cec8ecd 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -16,6 +16,7 @@
 #include "run-command.h"
 #include "sigchain.h"
 #include "argv-array.h"
+#include "commit.h"
=20
 #define FAILED_RUN "failed to run %s"
=20
diff --git a/builtin/prune.c b/builtin/prune.c
index 6366917..2214040 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -170,5 +170,9 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	s =3D mkpathdup("%s/pack", get_object_directory());
 	remove_temporary_files(s);
 	free(s);
+
+	if (is_repository_shallow())
+		prune_shallow(show_only);
+
 	return 0;
 }
diff --git a/commit.h b/commit.h
index a1f2d49..affe210 100644
--- a/commit.h
+++ b/commit.h
@@ -235,6 +235,7 @@ extern void assign_shallow_commits_to_refs(struct s=
hallow_info *info,
 					   uint32_t **used,
 					   int *ref_status);
 extern int delayed_reachability_test(struct shallow_info *si, int c);
+extern void prune_shallow(int show_only);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index e611639..f2ab72c 100644
--- a/shallow.c
+++ b/shallow.c
@@ -155,10 +155,14 @@ void check_shallow_file_for_update(void)
 		die("shallow file was changed during fetch");
 }
=20
+#define SEEN_ONLY 1
+#define VERBOSE   2
+
 struct write_shallow_data {
 	struct strbuf *out;
 	int use_pack_protocol;
 	int count;
+	unsigned flags;
 };
=20
 static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
@@ -167,6 +171,15 @@ static int write_one_shallow(const struct commit_g=
raft *graft, void *cb_data)
 	const char *hex =3D sha1_to_hex(graft->sha1);
 	if (graft->nr_parent !=3D -1)
 		return 0;
+	if (data->flags & SEEN_ONLY) {
+		struct commit *c =3D lookup_commit(graft->sha1);
+		if (!c || !(c->object.flags & SEEN)) {
+			if (data->flags & VERBOSE)
+				printf("Removing %s from .git/shallow\n",
+				       sha1_to_hex(c->object.sha1));
+			return 0;
+		}
+	}
 	data->count++;
 	if (data->use_pack_protocol)
 		packet_buf_write(data->out, "shallow %s", hex);
@@ -177,14 +190,16 @@ static int write_one_shallow(const struct commit_=
graft *graft, void *cb_data)
 	return 0;
 }
=20
-int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
-			  const struct sha1_array *extra)
+static int write_shallow_commits_1(struct strbuf *out, int use_pack_pr=
otocol,
+				   const struct sha1_array *extra,
+				   unsigned flags)
 {
 	struct write_shallow_data data;
 	int i;
 	data.out =3D out;
 	data.use_pack_protocol =3D use_pack_protocol;
 	data.count =3D 0;
+	data.flags =3D flags;
 	for_each_commit_graft(write_one_shallow, &data);
 	if (!extra)
 		return data.count;
@@ -196,6 +211,12 @@ int write_shallow_commits(struct strbuf *out, int =
use_pack_protocol,
 	return data.count;
 }
=20
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
+			  const struct sha1_array *extra)
+{
+	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
+}
+
 char *setup_temporary_shallow(const struct sha1_array *extra)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -258,6 +279,36 @@ void advertise_shallow_grafts(int fd)
 	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
 }
=20
+/*
+ * mark_reachable_objects() should have been run prior to this and all
+ * reachable commits marked as "SEEN".
+ */
+void prune_shallow(int show_only)
+{
+	static struct lock_file shallow_lock;
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+
+	if (show_only) {
+		write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY | VERBOSE);
+		strbuf_release(&sb);
+		return;
+	}
+	check_shallow_file_for_update();
+	fd =3D hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
+				       LOCK_DIE_ON_ERROR);
+	if (write_shallow_commits_1(&sb, 0, NULL, SEEN_ONLY)) {
+		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
+			die_errno("failed to write to %s",
+				  shallow_lock.filename);
+		commit_lock_file(&shallow_lock);
+	} else {
+		unlink(git_path("shallow"));
+		rollback_lock_file(&shallow_lock);
+	}
+	strbuf_release(&sb);
+}
+
 #define TRACE_KEY "GIT_TRACE_SHALLOW"
=20
 /*
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index e4bb3a1..66c9a41 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -221,4 +221,14 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'prune .git/shallow' '
+	SHA1=3D`echo hi|git commit-tree HEAD^{tree}` &&
+	echo $SHA1 >.git/shallow &&
+	git prune --dry-run >out &&
+	grep $SHA1 .git/shallow &&
+	grep $SHA1 out &&
+	git prune &&
+	! test -f .git/shallow
+'
+
 test_done
--=20
1.8.5.1.25.g8667982
