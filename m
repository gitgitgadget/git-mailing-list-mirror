From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v5 4/4] Accept tags in HEAD or MERGE_HEAD
Date: Sat, 17 Sep 2011 21:57:45 +1000
Message-ID: <1316260665-1728-4-git-send-email-pclouds@gmail.com>
References: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 13:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4tXa-0005Lm-Pg
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 13:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369Ab1IQL6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Sep 2011 07:58:21 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35780 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab1IQL6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 07:58:19 -0400
Received: by mail-iy0-f174.google.com with SMTP id q3so3214468iaq.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 04:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=AmYgQdhPqU908MiTTKgZWCEQrxrfHL6pMZ0l9fttohQ=;
        b=sR8aHdixvh0y5QoP1Hy0iXKLra0k7jYw3qL16rc+3D/3wgcWAxWytw2Trzt/ByDkXg
         HomW2SilRDDeQJt3LLhKarTHVK8XwkUyNl30dm7qTLztExy3TVziTmRbdt2sDkoJEr9h
         1X/Xos4vlR0t2n1xWm99DOeR0TG5b2QzL+s5w=
Received: by 10.42.159.3 with SMTP id j3mr805627icx.210.1316260698528;
        Sat, 17 Sep 2011 04:58:18 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id n14sm14301845ibi.4.2011.09.17.04.58.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 04:58:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 17 Sep 2011 21:58:10 +1000
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1316260665-1728-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181579>

HEAD and MERGE_HEAD (among other branch tips) should never hold a
tag. That can only be caused by broken tools and is cumbersome to fix
by an end user with:

  $ git update-ref HEAD $(git rev-parse HEAD^{commit})

which may look like a magic to a new person.

Be easy, warn users (so broken tools can be fixed if they bother to
report) and move on.

Be robust, if the given SHA-1 cannot be resolved to a commit object,
die (therefore return value is always valid).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c        |    6 ++++--
 builtin/fmt-merge-msg.c |    2 +-
 builtin/merge.c         |    7 ++-----
 commit.c                |   12 ++++++++++++
 commit.h                |    7 +++++++
 http-push.c             |    8 ++++----
 revision.c              |    6 ++++--
 7 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1a65319..402eb5a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1396,7 +1396,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 	if (get_sha1("HEAD", sha1))
 		current_head =3D NULL;
 	else {
-		current_head =3D lookup_commit(sha1);
+		current_head =3D lookup_commit_or_die(sha1, "HEAD");
 		if (!current_head || parse_commit(current_head))
 			die(_("could not parse HEAD commit"));
 	}
@@ -1431,6 +1431,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			pptr =3D &commit_list_insert(c->item, pptr)->next;
 	} else if (whence =3D=3D FROM_MERGE) {
 		struct strbuf m =3D STRBUF_INIT;
+		struct commit *commit;
 		FILE *fp;
=20
 		if (!reflog_msg)
@@ -1444,7 +1445,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
 				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
-			pptr =3D &commit_list_insert(lookup_commit(sha1), pptr)->next;
+			commit =3D lookup_commit_or_die(sha1, "MERGE_HEAD");
+			pptr =3D &commit_list_insert(commit, pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7581632..7e2f225 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -293,7 +293,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 		struct commit *head;
 		struct rev_info rev;
=20
-		head =3D lookup_commit(head_sha1);
+		head =3D lookup_commit_or_die(head_sha1, "HEAD");
 		init_revisions(&rev, NULL);
 		rev.commit_format =3D CMIT_FMT_ONELINE;
 		rev.ignore_merges =3D 1;
diff --git a/builtin/merge.c b/builtin/merge.c
index f5eb3f5..9567d60 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1036,11 +1036,8 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 		branch +=3D 11;
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit =3D NULL;
-	else {
-		head_commit =3D lookup_commit(head_sha1);
-		if (!head_commit)
-			die(_("could not parse HEAD"));
-	}
+	else
+		head_commit =3D lookup_commit_or_die(head_sha1, "HEAD");
=20
 	git_config(git_merge_config, NULL);
=20
diff --git a/commit.c b/commit.c
index ac337c7..50fcf96 100644
--- a/commit.c
+++ b/commit.c
@@ -39,6 +39,18 @@ struct commit *lookup_commit_reference(const unsigne=
d char *sha1)
 	return lookup_commit_reference_gently(sha1, 0);
 }
=20
+struct commit *lookup_commit_or_die(const unsigned char *sha1, const c=
har *ref_name)
+{
+	struct commit *c =3D lookup_commit_reference(sha1);
+	if (!c)
+		die(_("could not parse %s"), ref_name);
+	if (hashcmp(sha1, c->object.sha1)) {
+		warning(_("%s %s is not a commit!"),
+			ref_name, sha1_to_hex(sha1));
+	}
+	return c;
+}
+
 struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj =3D lookup_object(sha1);
diff --git a/commit.h b/commit.h
index a2d571b..044134a 100644
--- a/commit.h
+++ b/commit.h
@@ -37,6 +37,13 @@ struct commit *lookup_commit_reference(const unsigne=
d char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha=
1,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
+/*
+ * Look sha1 up for a commit, defer if needed. If dereference occurs,
+ * update "sha1" for consistency with retval->object.sha1. Also warn
+ * users this case because it is expected that sha1 points directly to
+ * a commit.
+ */
+struct commit *lookup_commit_or_die(const unsigned char *sha1, const c=
har *ref_name);
=20
 int parse_commit_buffer(struct commit *item, const void *buffer, unsig=
ned long size);
 int parse_commit(struct commit *item);
diff --git a/http-push.c b/http-push.c
index 28bfe76..d432b30 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1606,10 +1606,10 @@ static void fetch_symref(const char *path, char=
 **symref, unsigned char *sha1)
 	strbuf_release(&buffer);
 }
=20
-static int verify_merge_base(unsigned char *head_sha1, unsigned char *=
branch_sha1)
+static int verify_merge_base(unsigned char *head_sha1, struct ref *rem=
ote)
 {
-	struct commit *head =3D lookup_commit(head_sha1);
-	struct commit *branch =3D lookup_commit(branch_sha1);
+	struct commit *head =3D lookup_commit_or_die(head_sha1, "HEAD");
+	struct commit *branch =3D lookup_commit_or_die(remote->old_sha1, remo=
te->name);
 	struct commit_list *merge_bases =3D get_merge_bases(head, branch, 1);
=20
 	return (merge_bases && !merge_bases->next && merge_bases->item =3D=3D=
 branch);
@@ -1680,7 +1680,7 @@ static int delete_remote_branch(const char *patte=
rn, int force)
 			return error("Remote branch %s resolves to object %s\nwhich does no=
t exist locally, perhaps you need to fetch?", remote_ref->name, sha1_to=
_hex(remote_ref->old_sha1));
=20
 		/* Remote branch must be an ancestor of remote HEAD */
-		if (!verify_merge_base(head_sha1, remote_ref->old_sha1)) {
+		if (!verify_merge_base(head_sha1, remote_ref)) {
 			return error("The branch '%s' is not an ancestor "
 				     "of your current HEAD.\n"
 				     "If you are sure you want to delete it,"
diff --git a/revision.c b/revision.c
index c46cfaa..5e057a0 100644
--- a/revision.c
+++ b/revision.c
@@ -986,10 +986,12 @@ static void prepare_show_merge(struct rev_info *r=
evs)
 	const char **prune =3D NULL;
 	int i, prune_num =3D 1; /* counting terminating NULL */
=20
-	if (get_sha1("HEAD", sha1) || !(head =3D lookup_commit(sha1)))
+	if (get_sha1("HEAD", sha1))
 		die("--merge without HEAD?");
-	if (get_sha1("MERGE_HEAD", sha1) || !(other =3D lookup_commit(sha1)))
+	head =3D lookup_commit_or_die(sha1, "HEAD");
+	if (get_sha1("MERGE_HEAD", sha1))
 		die("--merge without MERGE_HEAD?");
+	other =3D lookup_commit_or_die(sha1, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases =3D get_merge_bases(head, other, 1);
--=20
1.7.3.1.256.g2539c.dirty
