From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 28/28] prune: clean .git/shallow after pruning objects
Date: Mon, 25 Nov 2013 10:55:54 +0700
Message-ID: <1385351754-9954-29-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:54:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknFg-0002Uq-PV
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab3KYDyQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:54:16 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:50534 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780Ab3KYDyN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:54:13 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so4828536pbb.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=H05irq7XPcMEI/v8oZCm/zOiEJSnK1rQhDI4OI3UWK8=;
        b=p7Eo1pcga8eA+NyQtIGhf0ecjuc/nJyJtc4JtKuJSZ+xW62wmRjWJQs9ythheYUf5m
         Sc3TK5+oPmm2GfQu0AEl9d9Q14jvuiTlJVMZjYOE+OgRi2WNgf5Gzg/k34A/10ZoYU19
         0Ph1pPujIqgfl64JiB/VFYHTjDCY29Zob0tj8oaLA9gUl3BurxmG9IJio94y4iaigvoU
         DMuk+8m0rv8hUa1SVz1punOCS9cv1LIBdXhy7VeQcRMopeu4/eZJvFcPtbxB1kKxbtsc
         ZhijIsG5wLB/i6yfi0M9Y04IgfIgZmWMGbR/NDmoo3W7cqO8vR/Oi714DUuAY3aQa6Ms
         et2w==
X-Received: by 10.66.234.131 with SMTP id ue3mr24862943pac.35.1385351653113;
        Sun, 24 Nov 2013 19:54:13 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id ry4sm79021753pab.4.2013.11.24.19.54.10
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:54:12 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:58:46 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238299>

This patch teaches "prune" to remove shallow roots that are no longer
reachable from any refs (e.g. when the relevant refs are removed).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c    |  1 +
 builtin/prune.c |  4 ++++
 commit.h        |  1 +
 shallow.c       | 43 +++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 47 insertions(+), 2 deletions(-)

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
index 6366917..023aea8 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -170,5 +170,9 @@ int cmd_prune(int argc, const char **argv, const ch=
ar *prefix)
 	s =3D mkpathdup("%s/pack", get_object_directory());
 	remove_temporary_files(s);
 	free(s);
+
+	if (!show_only && is_repository_shallow())
+		prune_shallow();
+
 	return 0;
 }
diff --git a/commit.h b/commit.h
index 0ff70fa..ff93a59 100644
--- a/commit.h
+++ b/commit.h
@@ -215,6 +215,7 @@ extern void remove_reachable_shallow_points(struct =
extra_have_objects *out,
 extern int mark_new_shallow_refs(const struct extra_have_objects *ref,
 				 int *ref_status, uint32_t **used,
 				 const struct extra_have_objects *shallow);
+extern void prune_shallow(void);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index abb04db..0eda40f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -157,6 +157,7 @@ struct write_shallow_data {
 	struct strbuf *out;
 	int use_pack_protocol;
 	int count;
+	int seen_only;
 };
=20
 static int write_one_shallow(const struct commit_graft *graft, void *c=
b_data)
@@ -165,6 +166,11 @@ static int write_one_shallow(const struct commit_g=
raft *graft, void *cb_data)
 	const char *hex =3D sha1_to_hex(graft->sha1);
 	if (graft->nr_parent !=3D -1)
 		return 0;
+	if (data->seen_only) {
+		struct commit *c =3D lookup_commit(graft->sha1);
+		if (!c || !(c->object.flags & SEEN))
+			return 0;
+	}
 	data->count++;
 	if (data->use_pack_protocol)
 		packet_buf_write(data->out, "shallow %s", hex);
@@ -175,14 +181,16 @@ static int write_one_shallow(const struct commit_=
graft *graft, void *cb_data)
 	return 0;
 }
=20
-int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
-			  const struct extra_have_objects *extra)
+static int write_shallow_commits_1(struct strbuf *out, int use_pack_pr=
otocol,
+				   const struct extra_have_objects *extra,
+				   int seen_only)
 {
 	struct write_shallow_data data;
 	int i;
 	data.out =3D out;
 	data.use_pack_protocol =3D use_pack_protocol;
 	data.count =3D 0;
+	data.seen_only =3D seen_only;
 	for_each_commit_graft(write_one_shallow, &data);
 	if (!extra)
 		return data.count;
@@ -194,6 +202,12 @@ int write_shallow_commits(struct strbuf *out, int =
use_pack_protocol,
 	return data.count;
 }
=20
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
+			  const struct extra_have_objects *extra)
+{
+	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
+}
+
 char *setup_temporary_shallow(const struct extra_have_objects *extra)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -515,3 +529,28 @@ int mark_new_shallow_refs(const struct extra_have_=
objects *ref,
=20
 	return ret;
 }
+
+/*
+ * mark_reachable_objects() should have been run prior to this and all
+ * reachable commits marked as "SEEN".
+ */
+void prune_shallow(void)
+{
+	static struct lock_file shallow_lock;
+	struct strbuf sb =3D STRBUF_INIT;
+	int fd;
+
+	check_shallow_file_for_update();
+	fd =3D hold_lock_file_for_update(&shallow_lock, git_path("shallow"),
+				       LOCK_DIE_ON_ERROR);
+	if (write_shallow_commits_1(&sb, 0, NULL, 1)) {
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
--=20
1.8.2.83.gc99314b
