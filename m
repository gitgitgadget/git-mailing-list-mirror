From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] Convert resolve_ref+xstrdup to new resolve_refdup function
Date: Tue, 13 Dec 2011 21:17:48 +0700
Message-ID: <1323785868-16601-1-git-send-email-pclouds@gmail.com>
References: <4EE75C88.5060700@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 13 15:19:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaTCK-00040C-Ql
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 15:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab1LMOTI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 09:19:08 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62296 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab1LMOTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 09:19:05 -0500
Received: by ghbz12 with SMTP id z12so417506ghb.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 06:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KvF4Wqd/9h7kvy3mb68SkU28/6xIeoXdwEt7Vywdyfw=;
        b=lKQUgA9j3auxvkb616RZWmkJX/WavYO20h2ycuytQ9aLRxV8fGrsURp3q5jLGwFzxH
         a7jt406tYkZkkOL3qLYMEoD3pJbZVyRKfsgOpXVtI+Vds1nJIaDSaXb0/Aa2KZUYgB+5
         2soA9jjjfgqA1Y3LtAvId1pM7RTD0lazyuVNY=
Received: by 10.50.188.129 with SMTP id ga1mr19411809igc.69.1323785944167;
        Tue, 13 Dec 2011 06:19:04 -0800 (PST)
Received: from tre ([115.74.32.245])
        by mx.google.com with ESMTPS id d19sm64485997ibh.8.2011.12.13.06.18.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 06:19:02 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Tue, 13 Dec 2011 21:17:54 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <4EE75C88.5060700@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187023>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 2011/12/13 Michael Haggerty <mhagger@alum.mit.edu>:
 >> This uses "one 'const char *' pointer that is used for reading data=
 from
 >> and an extra 'char *' pointer that is used only for freeing" approa=
ch,
 >> which has two advantages and one disadvantage:
 >> [...]
 >> When naming a "for-freeing" pointer variable, the kind of data the =
area of
 >> memory happens to contain is of secondary importance. Being deliber=
ately
 >> vague about what the area of memory may contain is a good thing, be=
cause
 >> it actively discourages the program from looking at the area via th=
e
 >> pointer if the variable is named "to_free" or something that does n=
ot
 >> specify what it contains.
 >
 > The to_free variable could even be declared void* to make it even le=
ss
 > (ab)usable.

 Good thinking. Here's the version with "char *foo_to_free" converted
 to "void *foo_to_free".

 builtin/branch.c        |   12 +++++-------
 builtin/checkout.c      |   15 +++++++--------
 builtin/fmt-merge-msg.c |    7 ++++---
 builtin/for-each-ref.c  |    7 ++-----
 builtin/merge.c         |   12 +++++-------
 builtin/notes.c         |    7 ++++---
 builtin/receive-pack.c  |    7 +++----
 builtin/show-branch.c   |    4 +---
 cache.h                 |    1 +
 reflog-walk.c           |   15 ++++++++-------
 refs.c                  |    6 ++++++
 wt-status.c             |    4 +---
 12 files changed, 47 insertions(+), 50 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e1e486e..c459f0b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -104,6 +104,7 @@ static int branch_merged(int kind, const char *name=
,
 	 */
 	struct commit *reference_rev =3D NULL;
 	const char *reference_name =3D NULL;
+	void *reference_name_to_free =3D NULL;
 	int merged;
=20
 	if (kind =3D=3D REF_LOCAL_BRANCH) {
@@ -114,11 +115,9 @@ static int branch_merged(int kind, const char *nam=
e,
 		    branch->merge &&
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
-		    (reference_name =3D
-		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL) {
-			reference_name =3D xstrdup(reference_name);
+		    (reference_name =3D reference_name_to_free =3D
+		     resolve_refdup(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL=
)
 			reference_rev =3D lookup_commit_reference(sha1);
-		}
 	}
 	if (!reference_rev)
 		reference_rev =3D head_rev;
@@ -143,7 +142,7 @@ static int branch_merged(int kind, const char *name=
,
 				"         '%s', even though it is merged to HEAD."),
 				name, reference_name);
 	}
-	free((char *)reference_name);
+	free(reference_name_to_free);
 	return merged;
 }
=20
@@ -731,10 +730,9 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
=20
 	track =3D git_branch_track;
=20
-	head =3D resolve_ref("HEAD", head_sha1, 0, NULL);
+	head =3D resolve_refdup("HEAD", head_sha1, 0, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
-	head =3D xstrdup(head);
 	if (!strcmp(head, "HEAD")) {
 		detached =3D 1;
 	} else {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b7c6302..00740bd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -696,17 +696,14 @@ static int switch_branches(struct checkout_opts *=
opts, struct branch_info *new)
 {
 	int ret =3D 0;
 	struct branch_info old;
+	void *path_to_free;
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path =3D resolve_ref("HEAD", rev, 0, &flag);
-	if (old.path)
-		old.path =3D xstrdup(old.path);
+	old.path =3D path_to_free =3D resolve_refdup("HEAD", rev, 0, &flag);
 	old.commit =3D lookup_commit_reference_gently(rev, 1);
-	if (!(flag & REF_ISSYMREF)) {
-		free((char *)old.path);
+	if (!(flag & REF_ISSYMREF))
 		old.path =3D NULL;
-	}
=20
 	if (old.path && !prefixcmp(old.path, "refs/heads/"))
 		old.name =3D old.path + strlen("refs/heads/");
@@ -720,8 +717,10 @@ static int switch_branches(struct checkout_opts *o=
pts, struct branch_info *new)
 	}
=20
 	ret =3D merge_working_tree(opts, &old, new);
-	if (ret)
+	if (ret) {
+		free(path_to_free);
 		return ret;
+	}
=20
 	if (!opts->quiet && !old.path && old.commit && new->commit !=3D old.c=
ommit)
 		orphaned_commit_warning(old.commit);
@@ -729,7 +728,7 @@ static int switch_branches(struct checkout_opts *op=
ts, struct branch_info *new)
 	update_refs_for_switch(opts, &old, new);
=20
 	ret =3D post_checkout_hook(old.commit, new->commit, 1);
-	free((char *)old.path);
+	free(path_to_free);
 	return ret || opts->writeout_error;
 }
=20
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index bdfa0ea..c81a7fe 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -372,14 +372,15 @@ int fmt_merge_msg(struct strbuf *in, struct strbu=
f *out,
 	int i =3D 0, pos =3D 0;
 	unsigned char head_sha1[20];
 	const char *current_branch;
+	void *current_branch_to_free;
=20
 	/* get current branch */
-	current_branch =3D resolve_ref("HEAD", head_sha1, 1, NULL);
+	current_branch =3D current_branch_to_free =3D
+		resolve_refdup("HEAD", head_sha1, 1, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (!prefixcmp(current_branch, "refs/heads/"))
 		current_branch +=3D 11;
-	current_branch =3D xstrdup(current_branch);
=20
 	/* get a line */
 	while (pos < in->len) {
@@ -421,7 +422,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf =
*out,
 	}
=20
 	strbuf_complete_line(out);
-	free((char *)current_branch);
+	free(current_branch_to_free);
 	return 0;
 }
=20
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index d90e5d2..b01d76a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -628,11 +628,8 @@ static void populate_value(struct refinfo *ref)
=20
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		const char *symref;
-		symref =3D resolve_ref(ref->refname, unused1, 1, NULL);
-		if (symref)
-			ref->symref =3D xstrdup(symref);
-		else
+		ref->symref =3D resolve_refdup(ref->refname, unused1, 1, NULL);
+		if (!ref->symref)
 			ref->symref =3D "";
 	}
=20
diff --git a/builtin/merge.c b/builtin/merge.c
index a1c8534..a3cd5e8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1096,6 +1096,7 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 	struct commit_list *common =3D NULL;
 	const char *best_strategy =3D NULL, *wt_strategy =3D NULL;
 	struct commit_list **remotes =3D &remoteheads;
+	void *branch_to_free;
=20
 	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_merge_usage, builtin_merge_options);
@@ -1104,12 +1105,9 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
-	if (branch) {
-		if (!prefixcmp(branch, "refs/heads/"))
-			branch +=3D 11;
-		branch =3D xstrdup(branch);
-	}
+	branch =3D branch_to_free =3D resolve_refdup("HEAD", head_sha1, 0, &f=
lag);
+	if (branch && !prefixcmp(branch, "refs/heads/"))
+		branch +=3D 11;
 	if (!branch || is_null_sha1(head_sha1))
 		head_commit =3D NULL;
 	else
@@ -1520,6 +1518,6 @@ int cmd_merge(int argc, const char **argv, const =
char *prefix)
 		ret =3D suggest_conflicts(option_renormalize);
=20
 done:
-	free((char *)branch);
+	free(branch_to_free);
 	return ret;
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index 10b8bc7..667e20a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -804,6 +804,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	struct notes_tree *t;
 	struct commit *partial;
 	struct pretty_print_context pretty_ctx;
+	void *local_ref_to_free;
 	int ret;
=20
 	/*
@@ -826,10 +827,10 @@ static int merge_commit(struct notes_merge_option=
s *o)
 	t =3D xcalloc(1, sizeof(struct notes_tree));
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
=20
-	o->local_ref =3D resolve_ref("NOTES_MERGE_REF", sha1, 0, NULL);
+	o->local_ref =3D local_ref_to_free =3D
+		resolve_refdup("NOTES_MERGE_REF", sha1, 0, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
-	o->local_ref =3D xstrdup(o->local_ref);
=20
 	if (notes_merge_commit(o, t, partial, sha1))
 		die("Failed to finalize notes merge");
@@ -846,7 +847,7 @@ static int merge_commit(struct notes_merge_options =
*o)
 	free_notes(t);
 	strbuf_release(&msg);
 	ret =3D merge_abort(o);
-	free((char *)o->local_ref);
+	free(local_ref_to_free);
 	return ret;
 }
=20
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b6d957c..62afac3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -37,6 +37,7 @@ static int prefer_ofs_delta =3D 1;
 static int auto_update_server_info;
 static int auto_gc =3D 1;
 static const char *head_name;
+static void *head_name_to_free;
 static int sent_capabilities;
=20
 static enum deny_action parse_deny_action(const char *var, const char =
*value)
@@ -695,10 +696,8 @@ static void execute_commands(struct command *comma=
nds, const char *unpacker_erro
=20
 	check_aliased_updates(commands);
=20
-	free((char *)head_name);
-	head_name =3D resolve_ref("HEAD", sha1, 0, NULL);
-	if (head_name)
-		head_name =3D xstrdup(head_name);
+	free(head_name_to_free);
+	head_name =3D head_name_to_free =3D resolve_refdup("HEAD", sha1, 0, N=
ULL);
=20
 	for (cmd =3D commands; cmd; cmd =3D cmd->next)
 		if (!cmd->skip_update)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 4b480d7..a1f148e 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -726,10 +726,8 @@ int cmd_show_branch(int ac, const char **av, const=
 char *prefix)
=20
 		if (ac =3D=3D 0) {
 			static const char *fake_av[2];
-			const char *refname;
=20
-			refname =3D resolve_ref("HEAD", sha1, 1, NULL);
-			fake_av[0] =3D xstrdup(refname);
+			fake_av[0] =3D resolve_refdup("HEAD", sha1, 1, NULL);
 			fake_av[1] =3D NULL;
 			av =3D fake_av;
 			ac =3D 1;
diff --git a/cache.h b/cache.h
index 8c98d05..4887a3e 100644
--- a/cache.h
+++ b/cache.h
@@ -866,6 +866,7 @@ extern int read_ref(const char *filename, unsigned =
char *sha1);
  * errno is sometimes set on errors, but not always.
  */
 extern const char *resolve_ref(const char *ref, unsigned char *sha1, i=
nt reading, int *flag);
+extern char *resolve_refdup(const char *ref, unsigned char *sha1, int =
reading, int *flag);
=20
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, cha=
r **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, cha=
r **ref);
diff --git a/reflog-walk.c b/reflog-walk.c
index da71a85..64c677f 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -50,11 +50,12 @@ static struct complete_reflogs *read_complete_reflo=
g(const char *ref)
 	for_each_reflog_ent(ref, read_one_reflog, reflogs);
 	if (reflogs->nr =3D=3D 0) {
 		unsigned char sha1[20];
-		const char *name =3D resolve_ref(ref, sha1, 1, NULL);
+		const char *name;
+		void *name_to_free;
+		name =3D name_to_free =3D resolve_refdup(ref, sha1, 1, NULL);
 		if (name) {
-			name =3D xstrdup(name);
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
-			free((char *)name);
+			free(name_to_free);
 		}
 	}
 	if (reflogs->nr =3D=3D 0) {
@@ -171,11 +172,11 @@ int add_reflog_for_walk(struct reflog_walk_info *=
info,
 	else {
 		if (*branch =3D=3D '\0') {
 			unsigned char sha1[20];
-			const char *head =3D resolve_ref("HEAD", sha1, 0, NULL);
-			if (!head)
-				die ("No current branch");
 			free(branch);
-			branch =3D xstrdup(head);
+			branch =3D resolve_refdup("HEAD", sha1, 0, NULL);
+			if (!branch)
+				die ("No current branch");
+
 		}
 		reflogs =3D read_complete_reflog(branch);
 		if (!reflogs || reflogs->nr =3D=3D 0) {
diff --git a/refs.c b/refs.c
index f5cb297..8ffb32f 100644
--- a/refs.c
+++ b/refs.c
@@ -605,6 +605,12 @@ const char *resolve_ref(const char *ref, unsigned =
char *sha1, int reading, int *
 	return ref;
 }
=20
+char *resolve_refdup(const char *ref, unsigned char *sha1, int reading=
, int *flag)
+{
+	const char *ret =3D resolve_ref(ref, sha1, reading, flag);
+	return ret ? xstrdup(ret) : NULL;
+}
+
 /* The argument to filter_refs */
 struct ref_filter {
 	const char *pattern;
diff --git a/wt-status.c b/wt-status.c
index 70fdb76..9ffc535 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -111,7 +111,6 @@ void status_printf_more(struct wt_status *s, const =
char *color,
 void wt_status_prepare(struct wt_status *s)
 {
 	unsigned char sha1[20];
-	const char *head;
=20
 	memset(s, 0, sizeof(*s));
 	memcpy(s->color_palette, default_wt_status_colors,
@@ -119,8 +118,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files =3D SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color =3D -1;
 	s->relative_paths =3D 1;
-	head =3D resolve_ref("HEAD", sha1, 0, NULL);
-	s->branch =3D head ? xstrdup(head) : NULL;
+	s->branch =3D resolve_refdup("HEAD", sha1, 0, NULL);
 	s->reference =3D "HEAD";
 	s->fp =3D stdout;
 	s->index_file =3D get_index_file();
--=20
1.7.8.36.g69ee2
