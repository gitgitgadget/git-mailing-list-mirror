From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3] Accept tags in HEAD or MERGE_HEAD
Date: Thu, 18 Aug 2011 20:43:14 +0700
Message-ID: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
References: <1313545369-7096-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 15:43:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu2se-0004Px-BP
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 15:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755231Ab1HRNn1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 09:43:27 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:57771 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1HRNn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 09:43:26 -0400
Received: by gxk21 with SMTP id 21so1469176gxk.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 06:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/ODNXU6pQyvnqcIw5RoHvAJdqaGYPfR8NBiam1bhlyQ=;
        b=b9KASflaIdf1zIuiXrJ2vqsfs47wpXmBD9895p8eIUKIKtKTAIglhOTi8i8v4qvhy5
         9e1nigxLYR8T59l+CwaU0ES5ITlF5AMBWTEW/ll6U3KCZTU+Dq0aEVHIeJRbIYE7rOkd
         hn9JKJ3iLl2xrB2j7nwzKf6Kkjen1Ade4FiKs=
Received: by 10.143.37.20 with SMTP id p20mr413474wfj.304.1313675005599;
        Thu, 18 Aug 2011 06:43:25 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.228.117])
        by mx.google.com with ESMTPS id s8sm1006923wff.5.2011.08.18.06.43.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 06:43:24 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Aug 2011 20:43:18 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1313545369-7096-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179597>

HEAD and MERGE_HEAD (among other branch tips) should never hold a
tag. That can only be caused by broken tools and is cumbersome to fix
by an end user with:

  $ git update-ref HEAD $(git rev-parse HEAD^{commit})

which may look like a magic to a new person.

Be easy, warn users (so broken tools can be fixed) and move on.

Be robust, if the given SHA-1 cannot be resolved to a commit object,
die (therefore return value is always valid).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/commit.c        |   25 ++++++++++++-------------
 builtin/fmt-merge-msg.c |    2 +-
 builtin/merge.c         |   19 +++++++++++--------
 commit.c                |   12 ++++++++++++
 commit.h                |    1 +
 http-push.c             |    8 ++++----
 revision.c              |    6 ++++--
 7 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index cb73857..f78b449 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -63,6 +63,7 @@ N_("The previous cherry-pick is now empty, possibly d=
ue to conflict resolution.\
 "Otherwise, please use 'git reset'\n");
=20
 static unsigned char head_sha1[20];
+static struct commit *head_commit;
=20
 static const char *use_message_buffer;
 static const char commit_editmsg[] =3D "COMMIT_EDITMSG";
@@ -518,11 +519,8 @@ static int run_status(FILE *fp, const char *index_=
file, const char *prefix, int
 	return s->commitable;
 }
=20
-static int is_a_merge(const unsigned char *sha1)
+static int is_a_merge(struct commit *commit)
 {
-	struct commit *commit =3D lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
-		die(_("could not parse HEAD commit"));
 	return !!(commit->parents && commit->parents->next);
 }
=20
@@ -848,7 +846,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	 * empty due to conflict resolution, which the user should okay.
 	 */
 	if (!commitable && whence !=3D FROM_MERGE && !allow_empty &&
-	    !(amend && is_a_merge(head_sha1))) {
+	    !(amend && is_a_merge(head_commit))) {
 		run_status(stdout, index_file, prefix, 0, s);
 		if (amend)
 			fputs(_(empty_amend_advice), stderr);
@@ -1028,6 +1026,9 @@ static int parse_and_validate_options(int argc, c=
onst char *argv[],
=20
 	if (get_sha1("HEAD", head_sha1))
 		initial_commit =3D 1;
+	else
+		head_commit =3D lookup_expect_commit(head_sha1, "HEAD");
+
=20
 	/* Sanity check options */
 	if (amend && initial_commit)
@@ -1421,23 +1422,20 @@ int cmd_commit(int argc, const char **argv, con=
st char *prefix)
 			reflog_msg =3D "commit (initial)";
 	} else if (amend) {
 		struct commit_list *c;
-		struct commit *commit;
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (amend)";
-		commit =3D lookup_commit(head_sha1);
-		if (!commit || parse_commit(commit))
-			die(_("could not parse HEAD commit"));
=20
-		for (c =3D commit->parents; c; c =3D c->next)
+		for (c =3D head_commit->parents; c; c =3D c->next)
 			pptr =3D &commit_list_insert(c->item, pptr)->next;
 	} else if (whence =3D=3D FROM_MERGE) {
 		struct strbuf m =3D STRBUF_INIT;
+		struct commit *commit;
 		FILE *fp;
=20
 		if (!reflog_msg)
 			reflog_msg =3D "commit (merge)";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		pptr =3D &commit_list_insert(head_commit, pptr)->next;
 		fp =3D fopen(git_path("MERGE_HEAD"), "r");
 		if (fp =3D=3D NULL)
 			die_errno(_("could not open '%s' for reading"),
@@ -1446,7 +1444,8 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			unsigned char sha1[20];
 			if (get_sha1_hex(m.buf, sha1) < 0)
 				die(_("Corrupt MERGE_HEAD file (%s)"), m.buf);
-			pptr =3D &commit_list_insert(lookup_commit(sha1), pptr)->next;
+			commit =3D lookup_expect_commit(sha1, "MERGE_HEAD");
+			pptr =3D &commit_list_insert(commit, pptr)->next;
 		}
 		fclose(fp);
 		strbuf_release(&m);
@@ -1463,7 +1462,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
 			reflog_msg =3D (whence =3D=3D FROM_CHERRY_PICK)
 					? "commit (cherry-pick)"
 					: "commit";
-		pptr =3D &commit_list_insert(lookup_commit(head_sha1), pptr)->next;
+		pptr =3D &commit_list_insert(head_commit, pptr)->next;
 	}
=20
 	/* Finally, get the commit message */
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7581632..1a31b64 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -293,7 +293,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 		struct commit *head;
 		struct rev_info rev;
=20
-		head =3D lookup_commit(head_sha1);
+		head =3D lookup_expect_commit(head_sha1, "HEAD");
 		init_revisions(&rev, NULL);
 		rev.commit_format =3D CMIT_FMT_ONELINE;
 		rev.ignore_merges =3D 1;
diff --git a/builtin/merge.c b/builtin/merge.c
index 325891e..22e98e8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -51,6 +51,7 @@ static int allow_trivial =3D 1, have_message;
 static struct strbuf merge_msg;
 static struct commit_list *remoteheads;
 static unsigned char head[20], stash[20];
+static struct commit* head_commit;
 static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char **xopts;
@@ -326,7 +327,7 @@ static void squash_message(void)
 	rev.ignore_merges =3D 1;
 	rev.commit_format =3D CMIT_FMT_MEDIUM;
=20
-	commit =3D lookup_commit(head);
+	commit =3D head_commit;
 	commit->object.flags |=3D UNINTERESTING;
 	add_pending_object(&rev, &commit->object, NULL);
=20
@@ -709,7 +710,7 @@ static int try_merge_strategy(const char *strategy,=
 struct commit_list *common,
 			commit_list_insert(j->item, &reversed);
=20
 		index_fd =3D hold_locked_index(lock, 1);
-		clean =3D merge_recursive(&o, lookup_commit(head),
+		clean =3D merge_recursive(&o, head_commit,
 				remoteheads->item, reversed, &result);
 		if (active_cache_changed &&
 				(write_cache(index_fd, active_cache, active_nr) ||
@@ -867,7 +868,7 @@ static int merge_trivial(void)
=20
 	write_tree_trivial(result_tree);
 	printf(_("Wonderful.\n"));
-	parent->item =3D lookup_commit(head);
+	parent->item =3D head_commit;
 	parent->next =3D xmalloc(sizeof(*parent->next));
 	parent->next->item =3D remoteheads->item;
 	parent->next->next =3D NULL;
@@ -889,12 +890,12 @@ static int finish_automerge(struct commit_list *c=
ommon,
 	free_commit_list(common);
 	if (allow_fast_forward) {
 		parents =3D remoteheads;
-		commit_list_insert(lookup_commit(head), &parents);
+		commit_list_insert(head_commit, &parents);
 		parents =3D reduce_heads(parents);
 	} else {
 		struct commit_list **pptr =3D &parents;
=20
-		pptr =3D &commit_list_insert(lookup_commit(head),
+		pptr =3D &commit_list_insert(head_commit,
 				pptr)->next;
 		for (j =3D remoteheads; j; j =3D j->next)
 			pptr =3D &commit_list_insert(j->item, pptr)->next;
@@ -1030,6 +1031,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		branch +=3D 11;
 	if (is_null_sha1(head))
 		head_invalid =3D 1;
+	else
+		head_commit =3D lookup_expect_commit(head, "HEAD");
=20
 	git_config(git_merge_config, NULL);
=20
@@ -1203,11 +1206,11 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	}
=20
 	if (!remoteheads->next)
-		common =3D get_merge_bases(lookup_commit(head),
+		common =3D get_merge_bases(head_commit,
 				remoteheads->item, 1);
 	else {
 		struct commit_list *list =3D remoteheads;
-		commit_list_insert(lookup_commit(head), &list);
+		commit_list_insert(head_commit, &list);
 		common =3D get_octopus_merge_bases(list);
 		free(list);
 	}
@@ -1292,7 +1295,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one =3D get_merge_bases(lookup_commit(head),
+			common_one =3D get_merge_bases(head_commit,
 				j->item, 1);
 			if (hashcmp(common_one->item->object.sha1,
 				j->item->object.sha1)) {
diff --git a/commit.c b/commit.c
index ac337c7..dc22695 100644
--- a/commit.c
+++ b/commit.c
@@ -39,6 +39,18 @@ struct commit *lookup_commit_reference(const unsigne=
d char *sha1)
 	return lookup_commit_reference_gently(sha1, 0);
 }
=20
+struct commit *lookup_expect_commit(const unsigned char *sha1,
+				    const char *ref_name)
+{
+	struct commit *c =3D lookup_commit_reference(sha1);
+	if (!c)
+		die(_("could not parse %s"), ref_name);
+	if (hashcmp(sha1, c->object.sha1))
+		warning(_("%s %s is not a commit!"),
+			ref_name, sha1_to_hex(sha1));
+	return c;
+}
+
 struct commit *lookup_commit(const unsigned char *sha1)
 {
 	struct object *obj =3D lookup_object(sha1);
diff --git a/commit.h b/commit.h
index a2d571b..f36c913 100644
--- a/commit.h
+++ b/commit.h
@@ -37,6 +37,7 @@ struct commit *lookup_commit_reference(const unsigned=
 char *sha1);
 struct commit *lookup_commit_reference_gently(const unsigned char *sha=
1,
 					      int quiet);
 struct commit *lookup_commit_reference_by_name(const char *name);
+struct commit *lookup_expect_commit(const unsigned char *sha1, const c=
har *ref_name);
=20
 int parse_commit_buffer(struct commit *item, const void *buffer, unsig=
ned long size);
 int parse_commit(struct commit *item);
diff --git a/http-push.c b/http-push.c
index 6e8f6d0..31297af 100644
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
+	struct commit *head =3D lookup_expect_commit(head_sha1, "HEAD");
+	struct commit *branch =3D lookup_expect_commit(remote->old_sha1, remo=
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
index c46cfaa..f926412 100644
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
+	head =3D lookup_expect_commit(sha1, "HEAD");
+	if (get_sha1("MERGE_HEAD", sha1))
 		die("--merge without MERGE_HEAD?");
+	other =3D lookup_expect_commit(sha1, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases =3D get_merge_bases(head, other, 1);
--=20
1.7.4.74.g639db
