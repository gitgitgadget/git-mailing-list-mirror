From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] Copy resolve_ref() return value for longer use
Date: Sun, 13 Nov 2011 17:22:15 +0700
Message-ID: <1321179735-21890-2-git-send-email-pclouds@gmail.com>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <1321179735-21890-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:23:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXED-0001AT-3e
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798Ab1KMKXq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 05:23:46 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1KMKXo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:23:44 -0500
Received: by mail-pz0-f42.google.com with SMTP id 36so9273202pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0nlMhXWzN9ZJsyXcnVX0ufd/Ho8yLtCsqvv3E9QhUWw=;
        b=psZaBxyvNFS2/Am+/WrwRi22zf3PdOAvMD9qO/4k+nNpy/M8SMv9i+LdmBX+Jo93Zc
         7p0iMtVswe/zfU1/2MSDq6O71p3miydB+txHqV5Lx07aH5OVJJ6PS2ObaVhac9lZBN4W
         JKjRQVKxgS2s5lX2YjBr0k6x4e+bmOsn00bQQ=
Received: by 10.68.5.136 with SMTP id s8mr29676866pbs.10.1321179824289;
        Sun, 13 Nov 2011 02:23:44 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.226.96])
        by mx.google.com with ESMTPS id b2sm46907561pbc.2.2011.11.13.02.23.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:23:42 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 13 Nov 2011 17:22:23 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321179735-21890-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185326>

resolve_ref() may return a pointer to a static buffer. Callers that
use this value longer than a couple of statements should copy the
value to avoid some hidden resolve_ref() call that may change the
static buffer's value.

The bug found by Tony Wang <wwwjfy@gmail.com> in builtin/merge.c
demonstrates this. The first call is in cmd_merge()

branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);

Then deep in lookup_commit_or_die() a few lines after, resolve_ref()
may be called again and destroy "branch".

lookup_commit_or_die
 lookup_commit_reference
  lookup_commit_reference_gently
   parse_object
    lookup_replace_object
     do_lookup_replace_object
      prepare_replace_object
       for_each_replace_ref
        do_for_each_ref
         get_loose_refs
          get_ref_dir
           get_ref_dir
            resolve_ref

All call sites are checked and made sure that xstrdup() is called if
the value should be saved.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Unfortunately there are still 37 resolve_ref() calls. An API change
 would touch all of them and potentially introduce more bugs along the
 way, either leak more memory or free() the wrong way.

 So I'd stick with this for v1.7.8.

 builtin/branch.c        |    5 +++-
 builtin/checkout.c      |    4 ++-
 builtin/commit.c        |    3 +-
 builtin/fmt-merge-msg.c |    6 ++++-
 builtin/merge.c         |   62 ++++++++++++++++++++++++++++++---------=
-------
 builtin/notes.c         |    6 ++++-
 builtin/receive-pack.c  |    3 ++
 reflog-walk.c           |    5 +++-
 8 files changed, 66 insertions(+), 28 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0fe9c4d..5b6d839 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -115,8 +115,10 @@ static int branch_merged(int kind, const char *nam=
e,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name =3D
-		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)
+		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL) {
+			reference_name =3D xstrdup(reference_name);
 			reference_rev =3D lookup_commit_reference(sha1);
+		}
 	}
 	if (!reference_rev)
 		reference_rev =3D head_rev;
@@ -141,6 +143,7 @@ static int branch_merged(int kind, const char *name=
,
 				"         '%s', even though it is merged to HEAD."),
 				name, reference_name);
 	}
+	free((char*)reference_name);
 	return merged;
 }
=20
diff --git a/builtin/checkout.c b/builtin/checkout.c
index beeaee4..c6919f1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -699,7 +699,9 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path =3D xstrdup(resolve_ref("HEAD", rev, 0, &flag));
+	old.path =3D resolve_ref("HEAD", rev, 0, &flag);
+	if (old.path)
+		old.path =3D xstrdup(old.path);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF)) {
 		free((char *)old.path);
diff --git a/builtin/commit.c b/builtin/commit.c
index c46f2d1..f3a6ed2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1259,7 +1259,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	struct commit *commit;
 	struct strbuf format =3D STRBUF_INIT;
 	unsigned char junk_sha1[20];
-	const char *head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
+	const char *head;
 	struct pretty_print_context pctx =3D {0};
 	struct strbuf author_ident =3D STRBUF_INIT;
 	struct strbuf committer_ident =3D STRBUF_INIT;
@@ -1304,6 +1304,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	rev.diffopt.break_opt =3D 0;
 	diff_setup_done(&rev.diffopt);
=20
+	head =3D resolve_ref("HEAD", junk_sha1, 0, NULL);
 	printf("[%s%s ",
 		!prefixcmp(head, "refs/heads/") ?
 			head + 11 :
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7e2f225..6fe9102 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -268,6 +268,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 		die("No current branch");
 	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch +=3D 11;
+	current_branch =3D xstrdup(current_branch);
=20
 	/* get a line */
 	while (pos < in->len) {
@@ -283,8 +284,10 @@ static int do_fmt_merge_msg(int merge_title, struc=
t strbuf *in,
 			die ("Error in line %d: %.*s", i, len, p);
 	}
=20
-	if (!srcs.nr)
+	if (!srcs.nr) {
+		free((char*)current_branch);
 		return 0;
+	}
=20
 	if (merge_title)
 		do_fmt_merge_msg_title(out, current_branch);
@@ -306,6 +309,7 @@ static int do_fmt_merge_msg(int merge_title, struct=
 strbuf *in,
 			shortlog(origins.items[i].string, origins.items[i].util,
 					head, &rev, shortlog_len, out);
 	}
+	free((char*)current_branch);
 	return 0;
 }
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index 42b4f9e..33be6c8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1082,7 +1082,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	struct commit *head_commit;
 	struct strbuf buf =3D STRBUF_INIT;
 	const char *head_arg;
-	int flag, i;
+	int flag, i, ret =3D 0;
 	int best_cnt =3D -1, merge_was_ok =3D 0, automerge_was_ok =3D 0;
 	struct commit_list *common =3D NULL;
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
@@ -1096,8 +1096,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 	 * current branch.
 	 */
 	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
-	if (branch && !prefixcmp(branch, "refs/heads/"))
-		branch +=3D 11;
+	if (branch) {
+		if (!prefixcmp(branch, "refs/heads/"))
+			branch +=3D 11;
+		branch =3D xstrdup(branch);
+	}
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit =3D NULL;
 	else
@@ -1121,7 +1124,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
=20
 		/* Invoke 'git reset --merge' */
-		return cmd_reset(nargc, nargv, prefix);
+		ret =3D cmd_reset(nargc, nargv, prefix);
+		goto done;
 	}
=20
 	if (read_cache_unmerged())
@@ -1205,7 +1209,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		read_empty(remote_head->sha1, 0);
 		update_ref("initial pull", "HEAD", remote_head->sha1, NULL, 0,
 				DIE_ON_ERR);
-		return 0;
+		goto done;
 	} else {
 		struct strbuf merge_names =3D STRBUF_INIT;
=20
@@ -1292,7 +1296,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		 * but first the most common case of merging one remote.
 		 */
 		finish_up_to_date("Already up-to-date.");
-		return 0;
+		goto done;
 	} else if (allow_fast_forward && !remoteheads->next &&
 			!common->next &&
 			!hashcmp(common->item->object.sha1, head_commit->object.sha1)) {
@@ -1313,15 +1317,20 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 			strbuf_addstr(&msg,
 				" (no commit created; -m option ignored)");
 		o =3D want_commit(sha1_to_hex(remoteheads->item->object.sha1));
-		if (!o)
-			return 1;
+		if (!o) {
+			ret =3D 1;
+			goto done;
+		}
=20
-		if (checkout_fast_forward(head_commit->object.sha1, remoteheads->ite=
m->object.sha1))
-			return 1;
+		if (checkout_fast_forward(head_commit->object.sha1,
+					  remoteheads->item->object.sha1)) {
+			ret =3D 1;
+			goto done;
+		}
=20
 		finish(head_commit, o->sha1, msg.buf);
 		drop_save();
-		return 0;
+		goto done;
 	} else if (!remoteheads->next && common->next)
 		;
 		/*
@@ -1339,8 +1348,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 			git_committer_info(IDENT_ERROR_ON_NO_NAME);
 			printf(_("Trying really trivial in-index merge...\n"));
 			if (!read_tree_trivial(common->item->object.sha1,
-					head_commit->object.sha1, remoteheads->item->object.sha1))
-				return merge_trivial(head_commit);
+					       head_commit->object.sha1,
+					       remoteheads->item->object.sha1)) {
+				ret =3D merge_trivial(head_commit);
+				goto done;
+			}
 			printf(_("Nope.\n"));
 		}
 	} else {
@@ -1368,7 +1380,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		}
 		if (up_to_date) {
 			finish_up_to_date("Already up-to-date. Yeeah!");
-			return 0;
+			goto done;
 		}
 	}
=20
@@ -1450,9 +1462,11 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 	 * If we have a resulting tree, that means the strategy module
 	 * auto resolved the merge cleanly.
 	 */
-	if (automerge_was_ok)
-		return finish_automerge(head_commit, common, result_tree,
-					wt_strategy);
+	if (automerge_was_ok) {
+		ret =3D finish_automerge(head_commit, common, result_tree,
+				       wt_strategy);
+		goto done;
+	}
=20
 	/*
 	 * Pick the result from the best strategy and have the user fix
@@ -1466,7 +1480,8 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
-		return 2;
+		ret =3D 2;
+		goto done;
 	} else if (best_strategy =3D=3D wt_strategy)
 		; /* We already have its result in the working tree. */
 	else {
@@ -1482,10 +1497,13 @@ int cmd_merge(int argc, const char **argv, cons=
t char *prefix)
 	else
 		write_merge_state();
=20
-	if (merge_was_ok) {
+	if (merge_was_ok)
 		fprintf(stderr, _("Automatic merge went well; "
 			"stopped before committing as requested\n"));
-		return 0;
-	} else
-		return suggest_conflicts(option_renormalize);
+	else
+		ret =3D suggest_conflicts(option_renormalize);
+
+done:
+	free((char*)branch);
+	return ret;
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index f8e437d..ccff770 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -804,6 +804,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	struct notes_tree *t;
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
+	int ret;
=20
 	/*
 	 * Read partial merge result from .git/NOTES_MERGE_PARTIAL,
@@ -828,6 +829,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	o->local_ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
+	o->local_ref =3D xstrdup(o->local_ref);
=20
 	if (notes_merge_commit(o, t, partial, sha1))
 		die("Failed to finalize notes merge");
@@ -843,7 +845,9 @@ static int merge_commit(struct notes_merge_options =
*o)
=20
 	free_notes(t);
 	strbuf_release(&msg);
-	return merge_abort(o);
+	ret =3D merge_abort(o);
+	free((char*)o->local_ref);
+	return ret;
 }
=20
 static int merge(int argc, const char **argv, const char *prefix)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 7ec68a1..d3fe42a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -695,7 +695,10 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
=20
 	check_aliased_updates(commands);
=20
+	free((char*)head_name);
 	head_name =3D resolve_ref("HEAD", sha1, 0, NULL);
+	if (head_name)
+		head_name =3D xstrdup(head_name);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next)
 		if (!cmd->skip_update)
diff --git a/reflog-walk.c b/reflog-walk.c
index 5d81d39..efd13ad 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -51,8 +51,11 @@ static struct complete_reflogs *read_complete_reflog=
(const char *ref)
 	if (reflogs->nr =3D=3D 0) {
 		unsigned char sha1[20];
 		const char *name =3D resolve_ref(ref, sha1, 1, NULL);
-		if (name)
+		if (name) {
+			name =3D xstrdup(name);
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
+			free((char*)name);
+		}
 	}
 	if (reflogs->nr =3D=3D 0) {
 		int len =3D strlen(ref);
--=20
1.7.4.74.g639db
