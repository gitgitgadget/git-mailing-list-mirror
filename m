From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] Convert many resolve_ref() calls to read_ref*() and ref_exists()
Date: Sun, 13 Nov 2011 17:22:14 +0700
Message-ID: <1321179735-21890-1-git-send-email-pclouds@gmail.com>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 11:23:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPXE2-00018D-Qd
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 11:23:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab1KMKXj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 05:23:39 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:36709 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1KMKXh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Nov 2011 05:23:37 -0500
Received: by pzk36 with SMTP id 36so9273202pzk.1
        for <git@vger.kernel.org>; Sun, 13 Nov 2011 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=66cRT7ctL7YF7n6t4+vlCdNrJoEIl9WQzhzWNzAxw7A=;
        b=XbJtce23lF9ysQvvBoANSDMp926jw0/6ECDmxVM8atdh9jqsauH23ZXVrGKlL89q6p
         J9jdwi9NbOEO8c7awy5tn1sFnIytSS3sa2HX6n2DMjPr0rGmO2CIV+CnLlOB3O0778b2
         zHqo3keaZpUUkqHGI1+AI1OH2Ldv9gNLUbNO8=
Received: by 10.68.73.232 with SMTP id o8mr40102338pbv.82.1321179817110;
        Sun, 13 Nov 2011 02:23:37 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.226.96])
        by mx.google.com with ESMTPS id wf19sm46844477pbb.17.2011.11.13.02.23.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Nov 2011 02:23:35 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 13 Nov 2011 17:22:16 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185325>

resolve_ref() may return a pointer to a static buffer, which is not
safe for long-term use because if another resolve_ref() call happens,
the buffer may be changed.  Many call sites though do not care about
this buffer. They simply check if the return value is NULL or not.

Convert all these call sites to new wrappers to reduce resolve_ref()
calls from 57 to 34. If we change resolve_ref() prototype later on
to avoid passing static buffer out, this helps reduce changes.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Sun, Nov 13, 2011 at 2:59 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
 > But if we were to go that route, as the first step, it might make se=
nse to
 > rewrite "only checks if it returns NULL and uses sha1" callers to ca=
ll
 > either read_ref() or ref_exists(), so that we do not have to worry a=
bout
 > leaking at such callers when we later decide to return allocated mem=
ory
 > from resolve_ref().

 Good idea.

 builtin/branch.c   |    5 ++---
 builtin/checkout.c |    4 ++--
 builtin/merge.c    |    4 ++--
 builtin/remote.c   |    8 +++-----
 builtin/replace.c  |    4 ++--
 builtin/show-ref.c |    2 +-
 builtin/tag.c      |    4 ++--
 bundle.c           |    2 +-
 cache.h            |    2 ++
 notes-merge.c      |    2 +-
 refs.c             |   27 ++++++++++++++++-----------
 remote.c           |    4 ++--
 12 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 51ca6a0..0fe9c4d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -186,7 +186,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
 		free(name);
=20
 		name =3D xstrdup(mkpath(fmt, bname.buf));
-		if (!resolve_ref(name, sha1, 1, NULL)) {
+		if (read_ref(name, sha1)) {
 			error(_("%sbranch '%s' not found."),
 					remote, bname.buf);
 			ret =3D 1;
@@ -565,7 +565,6 @@ static int print_ref_list(int kinds, int detached, =
int verbose, int abbrev, stru
 static void rename_branch(const char *oldname, const char *newname, in=
t force)
 {
 	struct strbuf oldref =3D STRBUF_INIT, newref =3D STRBUF_INIT, logmsg =
=3D STRBUF_INIT;
-	unsigned char sha1[20];
 	struct strbuf oldsection =3D STRBUF_INIT, newsection =3D STRBUF_INIT;
 	int recovery =3D 0;
=20
@@ -577,7 +576,7 @@ static void rename_branch(const char *oldname, cons=
t char *newname, int force)
 		 * Bad name --- this could be an attempt to rename a
 		 * ref that we used to allow to be created by accident.
 		 */
-		if (resolve_ref(oldref.buf, sha1, 1, NULL))
+		if (ref_exists(oldref.buf))
 			recovery =3D 1;
 		else
 			die(_("Invalid branch name: '%s'"), oldname);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2a80772..beeaee4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -288,7 +288,7 @@ static int checkout_paths(struct tree *source_tree,=
 const char **pathspec,
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
=20
-	resolve_ref("HEAD", rev, 0, &flag);
+	read_ref_full("HEAD", rev, 0, &flag);
 	head =3D lookup_commit_reference_gently(rev, 1);
=20
 	errs |=3D post_checkout_hook(head, head, 0);
@@ -866,7 +866,7 @@ static int parse_branchname_arg(int argc, const cha=
r **argv,
 	setup_branch_path(new);
=20
 	if (!check_refname_format(new->path, 0) &&
-	    resolve_ref(new->path, branch_rev, 1, NULL))
+	    !read_ref(new->path, branch_rev))
 		hashcpy(rev, branch_rev);
 	else
 		new->path =3D NULL; /* not an existing branch */
diff --git a/builtin/merge.c b/builtin/merge.c
index dffd5ec..42b4f9e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -420,7 +420,7 @@ static struct object *want_commit(const char *name)
 static void merge_name(const char *remote, struct strbuf *msg)
 {
 	struct object *remote_head;
-	unsigned char branch_head[20], buf_sha[20];
+	unsigned char branch_head[20];
 	struct strbuf buf =3D STRBUF_INIT;
 	struct strbuf bname =3D STRBUF_INIT;
 	const char *ptr;
@@ -479,7 +479,7 @@ static void merge_name(const char *remote, struct s=
trbuf *msg)
 		strbuf_addstr(&truname, "refs/heads/");
 		strbuf_addstr(&truname, remote);
 		strbuf_setlen(&truname, truname.len - len);
-		if (resolve_ref(truname.buf, buf_sha, 1, NULL)) {
+		if (ref_exists(truname.buf)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    sha1_to_hex(remote_head->sha1),
diff --git a/builtin/remote.c b/builtin/remote.c
index c810643..407abfb 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -343,8 +343,7 @@ static int get_ref_states(const struct ref *remote_=
refs, struct ref_states *stat
 	states->tracked.strdup_strings =3D 1;
 	states->stale.strdup_strings =3D 1;
 	for (ref =3D fetch_map; ref; ref =3D ref->next) {
-		unsigned char sha1[20];
-		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
+		if (!ref->peer_ref || !ref_exists(ref->peer_ref->name))
 			string_list_append(&states->new, abbrev_branch(ref->name));
 		else
 			string_list_append(&states->tracked, abbrev_branch(ref->name));
@@ -710,7 +709,7 @@ static int mv(int argc, const char **argv)
 		int flag =3D 0;
 		unsigned char sha1[20];
=20
-		resolve_ref(item->string, sha1, 1, &flag);
+		read_ref_full(item->string, sha1, 1, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
@@ -1220,10 +1219,9 @@ static int set_head(int argc, const char **argv)
 		usage_with_options(builtin_remote_sethead_usage, options);
=20
 	if (head_name) {
-		unsigned char sha1[20];
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
 		/* make sure it's valid */
-		if (!resolve_ref(buf2.buf, sha1, 1, NULL))
+		if (!ref_exists(buf2.buf))
 			result |=3D error("Not a valid ref: %s", buf2.buf);
 		else if (create_symref(buf.buf, buf2.buf, "remote set-head"))
 			result |=3D error("Could not setup %s", buf.buf);
diff --git a/builtin/replace.c b/builtin/replace.c
index 517fa10..4a8970e 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -58,7 +58,7 @@ static int for_each_replace_name(const char **argv, e=
ach_replace_name_fn fn)
 			had_error =3D 1;
 			continue;
 		}
-		if (!resolve_ref(ref, sha1, 1, NULL)) {
+		if (read_ref(ref, sha1)) {
 			error("replace ref '%s' not found.", *p);
 			had_error =3D 1;
 			continue;
@@ -97,7 +97,7 @@ static int replace_object(const char *object_ref, con=
st char *replace_ref,
 	if (check_refname_format(ref, 0))
 		die("'%s' is not a valid ref name.", ref);
=20
-	if (!resolve_ref(ref, prev, 1, NULL))
+	if (read_ref(ref, prev))
 		hashclr(prev);
 	else if (!force)
 		die("replace ref '%s' already exists", ref);
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index fafb6dd..3911661 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -225,7 +225,7 @@ int cmd_show_ref(int argc, const char **argv, const=
 char *prefix)
 			unsigned char sha1[20];
=20
 			if (!prefixcmp(*pattern, "refs/") &&
-			    resolve_ref(*pattern, sha1, 1, NULL)) {
+			    !read_ref(*pattern, sha1)) {
 				if (!quiet)
 					show_one(*pattern, sha1);
 			}
diff --git a/builtin/tag.c b/builtin/tag.c
index 9b6fd95..439249d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -174,7 +174,7 @@ static int for_each_tag_name(const char **argv, eac=
h_tag_name_fn fn)
 			had_error =3D 1;
 			continue;
 		}
-		if (!resolve_ref(ref, sha1, 1, NULL)) {
+		if (read_ref(ref, sha1)) {
 			error(_("tag '%s' not found."), *p);
 			had_error =3D 1;
 			continue;
@@ -518,7 +518,7 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 	if (strbuf_check_tag_ref(&ref, tag))
 		die(_("'%s' is not a valid tag name."), tag);
=20
-	if (!resolve_ref(ref.buf, prev, 1, NULL))
+	if (read_ref(ref.buf, prev))
 		hashclr(prev);
 	else if (!force)
 		die(_("tag '%s' already exists"), tag);
diff --git a/bundle.c b/bundle.c
index 08020bc..4742f27 100644
--- a/bundle.c
+++ b/bundle.c
@@ -320,7 +320,7 @@ int create_bundle(struct bundle_header *header, con=
st char *path,
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) !=3D 1)
 			continue;
-		if (!resolve_ref(e->name, sha1, 1, &flag))
+		if (read_ref_full(e->name, sha1, 1, &flag))
 			flag =3D 0;
 		display_ref =3D (flag & REF_ISSYMREF) ? e->name : ref;
=20
diff --git a/cache.h b/cache.h
index 2e6ad36..5badece 100644
--- a/cache.h
+++ b/cache.h
@@ -832,6 +832,8 @@ static inline int get_sha1_with_context(const char =
*str, unsigned char *sha1, st
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
=20
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer =
result! */
+extern int read_ref_full(const char *filename, unsigned char *sha1,
+			 int reading, int *flags);
 extern int read_ref(const char *filename, unsigned char *sha1);
=20
 /*
diff --git a/notes-merge.c b/notes-merge.c
index e9e4199..e33c2c9 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -568,7 +568,7 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
=20
 	/* Dereference o->local_ref into local_sha1 */
-	if (!resolve_ref(o->local_ref, local_sha1, 0, NULL))
+	if (read_ref_full(o->local_ref, local_sha1, 0, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_sha1(local_sha1))
diff --git a/refs.c b/refs.c
index e69ba26..44c1c86 100644
--- a/refs.c
+++ b/refs.c
@@ -334,7 +334,7 @@ static void get_ref_dir(const char *submodule, cons=
t char *base,
 					flag |=3D REF_ISBROKEN;
 				}
 			} else
-				if (!resolve_ref(ref, sha1, 1, &flag)) {
+				if (read_ref_full(ref, sha1, 1, &flag)) {
 					hashclr(sha1);
 					flag |=3D REF_ISBROKEN;
 				}
@@ -612,13 +612,18 @@ struct ref_filter {
 	void *cb_data;
 };
=20
-int read_ref(const char *ref, unsigned char *sha1)
+int read_ref_full(const char *ref, unsigned char *sha1, int reading, i=
nt *flags)
 {
-	if (resolve_ref(ref, sha1, 1, NULL))
+	if (resolve_ref(ref, sha1, reading, flags))
 		return 0;
 	return -1;
 }
=20
+int read_ref(const char *ref, unsigned char *sha1)
+{
+	return read_ref_full(ref, sha1, 1, NULL);
+}
+
 #define DO_FOR_EACH_INCLUDE_BROKEN 01
 static int do_one_ref(const char *base, each_ref_fn fn, int trim,
 		      int flags, void *cb_data, struct ref_entry *entry)
@@ -663,7 +668,7 @@ int peel_ref(const char *ref, unsigned char *sha1)
 		goto fallback;
 	}
=20
-	if (!resolve_ref(ref, base, 1, &flag))
+	if (read_ref_full(ref, base, 1, &flag))
 		return -1;
=20
 	if ((flag & REF_ISPACKED)) {
@@ -746,7 +751,7 @@ static int do_head_ref(const char *submodule, each_=
ref_fn fn, void *cb_data)
 		return 0;
 	}
=20
-	if (resolve_ref("HEAD", sha1, 1, &flag))
+	if (!read_ref_full("HEAD", sha1, 1, &flag))
 		return fn("HEAD", sha1, flag, cb_data);
=20
 	return 0;
@@ -826,7 +831,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_da=
ta)
 	int flag;
=20
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (resolve_ref(buf.buf, sha1, 1, &flag))
+	if (!read_ref_full(buf.buf, sha1, 1, &flag))
 		ret =3D fn(buf.buf, sha1, flag, cb_data);
 	strbuf_release(&buf);
=20
@@ -1022,7 +1027,7 @@ int refname_match(const char *abbrev_name, const =
char *full_name, const char **r
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	if (!resolve_ref(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
 		return NULL;
@@ -1377,7 +1382,8 @@ int rename_ref(const char *oldref, const char *ne=
wref, const char *logmsg)
 		goto rollback;
 	}
=20
-	if (resolve_ref(newref, sha1, 1, &flag) && delete_ref(newref, sha1, R=
EF_NODEREF)) {
+	if (!read_ref_full(newref, sha1, 1, &flag) &&
+	    delete_ref(newref, sha1, REF_NODEREF)) {
 		if (errno=3D=3DEISDIR) {
 			if (remove_empty_directories(git_path("%s", newref))) {
 				error("Directory not empty: %s", newref);
@@ -1929,7 +1935,7 @@ static int do_for_each_reflog(const char *base, e=
ach_ref_fn fn, void *cb_data)
 				retval =3D do_for_each_reflog(log, fn, cb_data);
 			} else {
 				unsigned char sha1[20];
-				if (!resolve_ref(log, sha1, 0, NULL))
+				if (read_ref_full(log, sha1, 0, NULL))
 					retval =3D error("bad ref for %s", log);
 				else
 					retval =3D fn(log, sha1, 0, cb_data);
@@ -2072,7 +2078,6 @@ char *shorten_unambiguous_ref(const char *ref, in=
t strict)
 		 */
 		for (j =3D 0; j < rules_to_fail; j++) {
 			const char *rule =3D ref_rev_parse_rules[j];
-			unsigned char short_objectname[20];
 			char refname[PATH_MAX];
=20
 			/* skip matched rule */
@@ -2086,7 +2091,7 @@ char *shorten_unambiguous_ref(const char *ref, in=
t strict)
 			 */
 			mksnpath(refname, sizeof(refname),
 				 rule, short_name_len, short_name);
-			if (!read_ref(refname, short_objectname))
+			if (ref_exists(refname))
 				break;
 		}
=20
diff --git a/remote.c b/remote.c
index e2ef991..6655bb0 100644
--- a/remote.c
+++ b/remote.c
@@ -1507,13 +1507,13 @@ int stat_tracking_info(struct branch *branch, i=
nt *num_ours, int *num_theirs)
 	 * nothing to report.
 	 */
 	base =3D branch->merge[0]->dst;
-	if (!resolve_ref(base, sha1, 1, NULL))
+	if (read_ref(base, sha1))
 		return 0;
 	theirs =3D lookup_commit_reference(sha1);
 	if (!theirs)
 		return 0;
=20
-	if (!resolve_ref(branch->refname, sha1, 1, NULL))
+	if (read_ref(branch->refname, sha1))
 		return 0;
 	ours =3D lookup_commit_reference(sha1);
 	if (!ours)
--=20
1.7.4.74.g639db
