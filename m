From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 5/8] Use resolve_ref() instead of resolve_ref_unsafe()
Date: Thu, 17 Nov 2011 16:32:12 +0700
Message-ID: <1321522335-24193-6-git-send-email-pclouds@gmail.com>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 10:29:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQyHl-0002no-88
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 10:29:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215Ab1KQJ3Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 04:29:24 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36906 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210Ab1KQJ3V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 04:29:21 -0500
Received: by mail-gx0-f174.google.com with SMTP id b2so788172ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 01:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z6/yTA4fzSxLwRCLP3nDkJoQCe6043hnK27gm0NKwuc=;
        b=FbnK6lw6898Ypxf6WwuojQaWpizjmhyz3/2lD/ZNaMFZia4lHBosDM+3Vrsnjduhlk
         NtJKQixSmf948kKIYij8FIN0booKcIUPF9Br1+7ewVsKUue6gbQ7Qu+tdWT4SwwMGlD+
         Op8qQoA9b5wH5TY4OKpuZtjcmt5eljdbZRgPs=
Received: by 10.42.168.202 with SMTP id x10mr39982182icy.4.1321522161209;
        Thu, 17 Nov 2011 01:29:21 -0800 (PST)
Received: from tre ([115.74.43.88])
        by mx.google.com with ESMTPS id bu33sm55727446ibb.11.2011.11.17.01.29.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 01:29:20 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Thu, 17 Nov 2011 16:32:57 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185585>

resolve_ref_unsaf() may return a pointer to a static buffer. Callers
that use this value longer than a couple of statements should copy the
value to avoid some hidden resolve_ref() call that may change the
static buffer's value.

The bug found by Tony Wang <wwwjfy@gmail.com> in builtin/merge.c
demonstrates this. The first call is in cmd_merge()

branch =3D resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);

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
           read_ref_full
	    resolve_ref_unsafe

Convert all resolve_ref_unsafe() call sites, where the return value may
be held across many function calls, to resolve_ref() and free buffer
after use.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c        |    5 +++--
 builtin/commit.c        |    3 ++-
 builtin/fmt-merge-msg.c |    8 ++++++--
 builtin/merge.c         |    4 +++-
 builtin/notes.c         |    8 ++++++--
 builtin/receive-pack.c  |    5 +++--
 reflog-walk.c           |    6 ++++--
 7 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6903b0d..633b56e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -103,7 +103,7 @@ static int branch_merged(int kind, const char *name=
,
 	 * safely to HEAD (or the other branch).
 	 */
 	struct commit *reference_rev =3D NULL;
-	const char *reference_name =3D NULL;
+	char *reference_name =3D NULL;
 	int merged;
=20
 	if (kind =3D=3D REF_LOCAL_BRANCH) {
@@ -115,7 +115,7 @@ static int branch_merged(int kind, const char *name=
,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name =3D
-		     resolve_ref_unsafe(branch->merge[0]->dst, sha1, 1, NULL)) !=3D =
NULL)
+		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)
 			reference_rev =3D lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -141,6 +141,7 @@ static int branch_merged(int kind, const char *name=
,
 				"         '%s', even though it is merged to HEAD."),
 				name, reference_name);
 	}
+	free(reference_name);
 	return merged;
 }
=20
diff --git a/builtin/commit.c b/builtin/commit.c
index 0be3b45..f3a6ed2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1259,7 +1259,7 @@ static void print_summary(const char *prefix, con=
st unsigned char *sha1,
 	struct commit *commit;
 	struct strbuf format =3D STRBUF_INIT;
 	unsigned char junk_sha1[20];
-	const char *head =3D resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
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
index 5c9b40e..dd94c3d 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -261,9 +261,10 @@ static int do_fmt_merge_msg(int merge_title, struc=
t strbuf *in,
 	int i =3D 0, pos =3D 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
+	char *ref;
=20
 	/* get current branch */
-	current_branch =3D resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
+	current_branch =3D ref =3D resolve_ref("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (!prefixcmp(current_branch, "refs/heads/"))
@@ -283,8 +284,10 @@ static int do_fmt_merge_msg(int merge_title, struc=
t strbuf *in,
 			die ("Error in line %d: %.*s", i, len, p);
 	}
=20
-	if (!srcs.nr)
+	if (!srcs.nr) {
+		free(ref);
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
+	free(ref);
 	return 0;
 }
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index 0d597b3..8be0594 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1087,6 +1087,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	struct commit_list *common =3D NULL;
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
 	struct commit_list **remotes =3D &remoteheads;
+	char *branch_ref;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
@@ -1095,7 +1096,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch =3D resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);
+	branch =3D branch_ref =3D resolve_ref("HEAD", head_sha1, 0, &flag);
 	if (branch && !prefixcmp(branch, "refs/heads/"))
 		branch +=3D 11;
 	if (!branch || is_null_sha1(head_sha1))
@@ -1497,5 +1498,6 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		ret =3D suggest_conflicts(option_renormalize);
=20
 done:
+	free(branch_ref);
 	return ret;
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index e191ce6..725a701 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -804,6 +804,8 @@ static int merge_commit(struct notes_merge_options =
*o)
 	struct notes_tree *t;
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
+	char *ref;
+	int ret;
=20
 	/*
 	 * Read partial merge result from .git/NOTES_MERGE_PARTIAL,
@@ -825,7 +827,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	t =3D xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
=20
-	o->local_ref =3D resolve_ref_unsafe("NOTES_MERGE_REF", sha1, 0, NULL)=
;
+	o->local_ref =3D ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL=
);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
=20
@@ -843,7 +845,9 @@ static int merge_commit(struct notes_merge_options =
*o)
=20
 	free_notes(t);
 	strbuf_release(&msg);
-	return merge_abort(o);
+	ret =3D merge_abort(o);
+	free(ref);
+	return ret;
 }
=20
 static int merge(int argc, const char **argv, const char *prefix)
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 333f2b0..d41884a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -36,7 +36,7 @@ static int use_sideband;
 static int prefer_ofs_delta =3D 1;
 static int auto_update_server_info;
 static int auto_gc =3D 1;
-static const char *head_name;
+static char *head_name;
 static int sent_capabilities;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
@@ -695,7 +695,8 @@ static void execute_commands(struct command *comman=
ds, const char *unpacker_erro
=20
 	check_aliased_updates(commands);
=20
-	head_name =3D resolve_ref_unsafe("HEAD", sha1, 0, NULL);
+	free(head_name);
+	head_name =3D resolve_ref("HEAD", sha1, 0, NULL);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next)
 		if (!cmd->skip_update)
diff --git a/reflog-walk.c b/reflog-walk.c
index b9b2453..2d5aee0 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -50,9 +50,11 @@ static struct complete_reflogs *read_complete_reflog=
(const char *ref)
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr =3D=3D 0) {
 		unsigned char sha1[20];
-		const char *name =3D resolve_ref_unsafe(ref, sha1, 1, NULL);
-		if (name)
+		char *name =3D resolve_ref(ref, sha1, 1, NULL);
+		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
+			free(name);
+		}
 	}
 	if (reflogs->nr =3D=3D 0) {
 		int len =3D strlen(ref);
--=20
1.7.4.74.g639db
