From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series
 overview)
Date: Wed, 10 Sep 2014 20:03:18 -0700
Message-ID: <20140911030318.GD18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:03:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRufS-0007hO-JF
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbaIKDDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:03:25 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35858 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaIKDDW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:03:22 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so9542410pdj.30
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uCG1eBtRyqhujePp75d+sKMxWDq5baYCSlLP8xc+pnA=;
        b=OTCKVkfuu5jXZttTRdmMWpCJ0zEji9PbZZI0jQ8hpGLAaA7c5/yMZM1fvh4QzAGUbt
         TDta8tG6SFzVf6DX8ci1+gvTGM4xyczb8pcMLBS/hmMSDnl7lOg7rl4/FDMAdlRMc+o1
         z7balS9a+nws6LFRekmmluRPbPoaWI1s5dYXXJPR007SecxUvyFKfI4SgUubfq6+9HhQ
         tBe3cjjx/TJBG+/n5c8qWIxagA6fDnoKucFvdsHAjFOOqrfMMEzrw46GydJwa271d+D1
         4Dn9PJRs5E/7QNIvnHamxtu4AFfBlN8Ps0o7qW3mVgDlbJejxQgFekU0zVK6WzVeeVJn
         48aw==
X-Received: by 10.70.129.106 with SMTP id nv10mr73125808pdb.24.1410404602126;
        Wed, 10 Sep 2014 20:03:22 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ud6sm15751090pbc.25.2014.09.10.20.03.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:03:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140820231723.GF20185@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256812>

Jonathan Nieder wrote:

> The next series from Ronnie's collection is available at
> https://code-review.googlesource.com/#/q/topic:ref-transaction in case
> someone wants a fresh series to look at.

Here is the outcome of that review.  It could use another set of eyes
(hint, hint) but should be mostly ready.  Interdiff below.  This is meant
to replace rs/ref-transaction in 'pu' and I'd prefer to wait a little
for more comments before merging to 'next'.

These patches are also available from the git repository at

  git://repo.or.cz/git/jrn.git tags/rs/ref-transaction

"Use ref transactions", part 3

Ronnie explains:

	This is the third and final part of the original 48 patch
	series for basic transaction support.  This version implements
	some changes suggested by mhagger for the warn_if_unremovable
	changes.  It also adds a new patch "fix handling of badly
	named refs" that repairs the handling of badly named refs.

This includes some improvements to the transaction API (in
particular allowing different reflog messages per ref update in
a transaction), some cleanups and consistency improvements, and
preparation for an implementation of ref renaming in terms of
the transaction API.

It also improves handling of refs with invalid names.  Today "git
branch --list" and "git for-each-ref" do not provide a way to discover
refs with invalid names and "git branch -d" and "git update-ref -d"
cannot delete them.  After this series, such bad refs will be
discoverable and deletable again as in olden times.

Jonathan Nieder (5):
  mv test: recreate mod/ directory instead of relying on stale copy
  branch -d: avoid repeated symref resolution
  refs.c: do not permit err == NULL
  lockfile: remove unable_to_lock_error
  ref_transaction_commit: bail out on failure to remove a ref

Ronnie Sahlberg (14):
  wrapper.c: remove/unlink_or_warn: simplify, treat ENOENT as success
  wrapper.c: add a new function unlink_or_msg
  refs.c: add an err argument to delete_ref_loose
  refs.c: pass the ref log message to _create/delete/update instead of
    _commit
  rename_ref: don't ask read_ref_full where the ref came from
  refs.c: move the check for valid refname to lock_ref_sha1_basic
  refs.c: call lock_ref_sha1_basic directly from commit
  refs.c: pass a skip list to name_conflict_fn
  refs.c: ref_transaction_commit: distinguish name conflicts from other
    errors
  fetch.c: change s_update_ref to use a ref transaction
  refs.c: make write_ref_sha1 static
  refs.c: change resolve_ref_unsafe reading argument to be a flags field
  refs.c: fix handling of badly named refs
  for-each-ref.c: improve message before aborting on broken ref

 branch.c                    |   6 +-
 builtin/blame.c             |   2 +-
 builtin/branch.c            |  19 ++-
 builtin/checkout.c          |   6 +-
 builtin/clone.c             |   2 +-
 builtin/commit.c            |   6 +-
 builtin/fetch.c             |  34 +++--
 builtin/fmt-merge-msg.c     |   2 +-
 builtin/for-each-ref.c      |  12 +-
 builtin/fsck.c              |   2 +-
 builtin/log.c               |   3 +-
 builtin/merge.c             |   2 +-
 builtin/notes.c             |   2 +-
 builtin/receive-pack.c      |   9 +-
 builtin/remote.c            |   5 +-
 builtin/replace.c           |   5 +-
 builtin/show-branch.c       |   6 +-
 builtin/symbolic-ref.c      |   2 +-
 builtin/tag.c               |   4 +-
 builtin/update-ref.c        |  16 ++-
 bundle.c                    |   2 +-
 cache.h                     |  31 +++--
 fast-import.c               |   8 +-
 git-compat-util.h           |  16 ++-
 http-backend.c              |   3 +-
 lockfile.c                  |  10 --
 notes-merge.c               |   2 +-
 reflog-walk.c               |   5 +-
 refs.c                      | 321 ++++++++++++++++++++++++++++++--------------
 refs.h                      |  18 ++-
 remote.c                    |  10 +-
 sequencer.c                 |   8 +-
 t/t1400-update-ref.sh       |  16 +++
 t/t1402-check-ref-format.sh |  48 +++++++
 t/t3200-branch.sh           |   9 ++
 t/t7001-mv.sh               |  15 ++-
 transport-helper.c          |   4 +-
 transport.c                 |   5 +-
 upload-pack.c               |   2 +-
 walker.c                    |   5 +-
 wrapper.c                   |  28 ++--
 wt-status.c                 |   2 +-
 42 files changed, 487 insertions(+), 226 deletions(-)
---
Changes since last appearance:

diff --git c/branch.c w/branch.c
index 76a8ec9..ba3e1c1 100644
--- c/branch.c
+++ w/branch.c
@@ -186,7 +186,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 		const char *head;
 		unsigned char sha1[20];
 
-		head = resolve_ref_unsafe("HEAD", sha1, 0, NULL);
+		head = resolve_ref_unsafe("HEAD", sha1, NULL, 0);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
diff --git c/builtin/blame.c w/builtin/blame.c
index 1568bd8..b8bec0a 100644
--- c/builtin/blame.c
+++ w/builtin/blame.c
@@ -2292,7 +2292,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->object.type = OBJ_COMMIT;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, RESOLVE_REF_READING, NULL))
+	if (!resolve_ref_unsafe("HEAD", head_sha1, NULL, RESOLVE_REF_READING))
 		die("no such ref: HEAD");
 
 	parent_tail = append_parent(parent_tail, head_sha1);
diff --git c/builtin/branch.c w/builtin/branch.c
index 5c95656..5d5bc56 100644
--- c/builtin/branch.c
+++ w/builtin/branch.c
@@ -130,7 +130,7 @@ static int branch_merged(int kind, const char *name,
 		    branch->merge[0]->dst &&
 		    (reference_name = reference_name_to_free =
 		     resolve_refdup(branch->merge[0]->dst, sha1,
-				    RESOLVE_REF_READING, NULL)) != NULL)
+				    NULL, RESOLVE_REF_READING)) != NULL)
 			reference_rev = lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -234,10 +234,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, sha1,
-					    RESOLVE_REF_ALLOW_BAD_NAME, &flags);
+		target = resolve_ref_unsafe(name, sha1, &flags,
+					    RESOLVE_REF_READING
+					    | RESOLVE_REF_NODEREF
+					    | RESOLVE_REF_ALLOW_BAD_NAME);
 		if (!target ||
-		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
+		    (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
+		     is_null_sha1(sha1))) {
 			error(remote_branch
 			      ? _("remote branch '%s' not found.")
 			      : _("branch '%s' not found."), bname.buf);
@@ -245,14 +248,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (!(flags & REF_ISSYMREF) &&
+		if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
 		    check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
 					force)) {
 			ret = 1;
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF)) {
+		if (delete_ref(name, sha1, REF_NODEREF|REF_BADNAMEOK)) {
 			error(remote_branch
 			      ? _("Error deleting remote branch '%s'")
 			      : _("Error deleting branch '%s'"),
@@ -298,7 +301,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 	int flag;
 	const char *dst, *cp;
 
-	dst = resolve_ref_unsafe(src, sha1, 0, &flag);
+	dst = resolve_ref_unsafe(src, sha1, &flag, 0);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
 	if (prefix && (cp = skip_prefix(dst, prefix)))
@@ -864,7 +867,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", head_sha1, 0, NULL);
+	head = resolve_refdup("HEAD", head_sha1, NULL, 0);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD")) {
diff --git c/builtin/checkout.c w/builtin/checkout.c
index f1dc56e..64af1f7 100644
--- c/builtin/checkout.c
+++ w/builtin/checkout.c
@@ -356,7 +356,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", rev, 0, &flag);
+	read_ref_full("HEAD", rev, &flag, 0);
 	head = lookup_commit_reference_gently(rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
@@ -771,7 +771,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	unsigned char rev[20];
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", rev, 0, &flag);
+	old.path = path_to_free = resolve_refdup("HEAD", rev, &flag, 0);
 	old.commit = lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
@@ -1068,7 +1068,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		unsigned char rev[20];
 		int flag;
 
-		if (!read_ref_full("HEAD", rev, 0, &flag) &&
+		if (!read_ref_full("HEAD", rev, &flag, 0) &&
 		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
 			return switch_unborn_to_new_branch(opts);
 	}
diff --git c/builtin/clone.c w/builtin/clone.c
index f7307e6..12a78e1 100644
--- c/builtin/clone.c
+++ w/builtin/clone.c
@@ -622,7 +622,7 @@ static int checkout(void)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", sha1, RESOLVE_REF_READING, NULL);
+	head = resolve_refdup("HEAD", sha1, NULL, RESOLVE_REF_READING);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
diff --git c/builtin/commit.c w/builtin/commit.c
index d23e876..3536330 100644
--- c/builtin/commit.c
+++ w/builtin/commit.c
@@ -1468,7 +1468,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
+	head = resolve_ref_unsafe("HEAD", junk_sha1, NULL, 0);
 	printf("[%s%s ",
 		starts_with(head, "refs/heads/") ?
 			head + 11 :
diff --git c/builtin/fetch.c w/builtin/fetch.c
index 52f1ebc..2e3bc73 100644
--- c/builtin/fetch.c
+++ w/builtin/fetch.c
@@ -398,6 +398,7 @@ static int s_update_ref(const char *action,
 		goto fail;
 
 	ref_transaction_free(transaction);
+	strbuf_release(&err);
 	return 0;
 fail:
 	ref_transaction_free(transaction);
@@ -686,9 +687,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			}
 		}
 	}
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
-		      "'git remote prune %s' to remove any old, conflicting "
+		      " 'git remote prune %s' to remove any old, conflicting "
 		      "branches"), remote_name);
 
  abort:
diff --git c/builtin/fmt-merge-msg.c w/builtin/fmt-merge-msg.c
index d8ab177..b2355ad 100644
--- c/builtin/fmt-merge-msg.c
+++ w/builtin/fmt-merge-msg.c
@@ -602,7 +602,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", head_sha1, RESOLVE_REF_READING, NULL);
+		resolve_refdup("HEAD", head_sha1, NULL, RESOLVE_REF_READING);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
diff --git c/builtin/for-each-ref.c w/builtin/for-each-ref.c
index 7c5b479..090390c 100644
--- c/builtin/for-each-ref.c
+++ w/builtin/for-each-ref.c
@@ -650,7 +650,7 @@ static void populate_value(struct refinfo *ref)
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
 		ref->symref = resolve_refdup(ref->refname, unused1,
-					     RESOLVE_REF_READING, NULL);
+					     NULL, RESOLVE_REF_READING);
 		if (!ref->symref)
 			ref->symref = "";
 	}
@@ -709,7 +709,7 @@ static void populate_value(struct refinfo *ref)
 			unsigned char sha1[20];
 
 			head = resolve_ref_unsafe("HEAD", sha1,
-						  RESOLVE_REF_READING, NULL);
+						  NULL, RESOLVE_REF_READING);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
 			else
@@ -853,6 +853,12 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	struct refinfo *ref;
 	int cnt;
 
+	if ((flag & REF_ISBROKEN) &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		  warning("ignoring ref with broken name %s", refname);
+		  return 0;
+	}
+
 	if (*cb->grab_pattern) {
 		const char **pattern;
 		int namelen = strlen(refname);
diff --git c/builtin/fsck.c w/builtin/fsck.c
index fc150c8..506e32b 100644
--- c/builtin/fsck.c
+++ w/builtin/fsck.c
@@ -560,7 +560,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);
+	head_points_at = resolve_ref_unsafe("HEAD", head_sha1, &flag, 0);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
diff --git c/builtin/log.c w/builtin/log.c
index 92db809..230a9ef 100644
--- c/builtin/log.c
+++ w/builtin/log.c
@@ -1395,8 +1395,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (check_head) {
 			unsigned char sha1[20];
 			const char *ref;
-			ref = resolve_ref_unsafe("HEAD", sha1,
-						 RESOLVE_REF_READING, NULL);
+			ref = resolve_ref_unsafe("HEAD", sha1, NULL,
+						 RESOLVE_REF_READING);
 			if (ref && starts_with(ref, "refs/heads/"))
 				branch_name = xstrdup(ref + strlen("refs/heads/"));
 			else
diff --git c/builtin/merge.c w/builtin/merge.c
index 428ca24..d262279 100644
--- c/builtin/merge.c
+++ w/builtin/merge.c
@@ -1108,7 +1108,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", head_sha1, 0, &flag);
+	branch = branch_to_free = resolve_refdup("HEAD", head_sha1, &flag, 0);
 	if (branch && starts_with(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
diff --git c/builtin/notes.c w/builtin/notes.c
index 820c341..16df78c 100644
--- c/builtin/notes.c
+++ w/builtin/notes.c
@@ -703,7 +703,7 @@ static int merge_commit(struct notes_merge_options *o)
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", sha1, 0, NULL);
+		resolve_refdup("NOTES_MERGE_REF", sha1, NULL, 0);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
 
diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index d1f4cf7..555a4a6 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -656,7 +656,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
+	dst_name = resolve_ref_unsafe(buf.buf, sha1, &flag, 0);
 	strbuf_release(&buf);
 
 	if (!(flag & REF_ISSYMREF))
@@ -817,7 +817,7 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
+	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, NULL, 0);
 
 	checked_connectivity = 1;
 	for (cmd = commands; cmd; cmd = cmd->next) {
diff --git c/builtin/remote.c w/builtin/remote.c
index be8ebac..6eaeee7 100644
--- c/builtin/remote.c
+++ w/builtin/remote.c
@@ -568,8 +568,8 @@ static int read_remote_branches(const char *refname,
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
-		symref = resolve_ref_unsafe(refname, orig_sha1,
-					    RESOLVE_REF_READING, &flag);
+		symref = resolve_ref_unsafe(refname, orig_sha1, &flag,
+					    RESOLVE_REF_READING);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
@@ -705,7 +705,7 @@ static int mv(int argc, const char **argv)
 		int flag = 0;
 		unsigned char sha1[20];
 
-		read_ref_full(item->string, sha1, RESOLVE_REF_READING, &flag);
+		read_ref_full(item->string, sha1, &flag, RESOLVE_REF_READING);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
diff --git c/builtin/replace.c w/builtin/replace.c
index df060f8..9d03b84 100644
--- c/builtin/replace.c
+++ w/builtin/replace.c
@@ -170,7 +170,7 @@ static int replace_object_sha1(const char *object_ref,
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_update(transaction, ref, repl, prev,
-				   0, !is_null_sha1(prev), NULL, &err) ||
+				   0, 1, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
diff --git c/builtin/show-branch.c w/builtin/show-branch.c
index a9a5eb3..ef6ea52 100644
--- c/builtin/show-branch.c
+++ w/builtin/show-branch.c
@@ -727,8 +727,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (ac == 0) {
 			static const char *fake_av[2];
 
-			fake_av[0] = resolve_refdup("HEAD", sha1,
-						    RESOLVE_REF_READING, NULL);
+			fake_av[0] = resolve_refdup("HEAD", sha1, NULL,
+						    RESOLVE_REF_READING);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -790,8 +790,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	head_p = resolve_ref_unsafe("HEAD", head_sha1,
-				    RESOLVE_REF_READING, NULL);
+	head_p = resolve_ref_unsafe("HEAD", head_sha1, NULL,
+				    RESOLVE_REF_READING);
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
diff --git c/builtin/symbolic-ref.c w/builtin/symbolic-ref.c
index b6a711d..1dd04af 100644
--- c/builtin/symbolic-ref.c
+++ w/builtin/symbolic-ref.c
@@ -13,7 +13,7 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *refname = resolve_ref_unsafe(HEAD, sha1, 0, &flag);
+	const char *refname = resolve_ref_unsafe(HEAD, sha1, &flag, 0);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
diff --git c/builtin/update-ref.c w/builtin/update-ref.c
index 6c9be05..e379fdd 100644
--- c/builtin/update-ref.c
+++ w/builtin/update-ref.c
@@ -419,7 +419,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (no_deref)
 		flags = REF_NODEREF;
 	if (delete)
-		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
+		return delete_ref(refname, oldval ? oldsha1 : NULL,
+				  flags|REF_BADNAMEOK);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  flags, UPDATE_REFS_DIE_ON_ERR);
diff --git c/bundle.c w/bundle.c
index 8aaf5f8..32dd2f7 100644
--- c/bundle.c
+++ w/bundle.c
@@ -311,7 +311,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 			continue;
-		if (read_ref_full(e->name, sha1, RESOLVE_REF_READING, &flag))
+		if (read_ref_full(e->name, sha1, &flag, RESOLVE_REF_READING))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
diff --git c/cache.h w/cache.h
index 3a4b087..995729f 100644
--- c/cache.h
+++ w/cache.h
@@ -558,7 +558,6 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
-extern int unable_to_lock_error(const char *path, int err);
 extern void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
@@ -948,7 +947,7 @@ extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 extern int read_ref_full(const char *refname, unsigned char *sha1,
-			 int flags, int *ref_flag);
+			 int *flags, int resolve_flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
 
 /*
@@ -970,21 +969,27 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
- * If ref_flag is non-NULL, set the value that it points to the
+ * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
- * packed references) and REF_ISSYMREF (if the initial reference was a
- * symbolic reference).
+ * packed references), REF_ISSYMREF (if the initial reference was a
+ * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
  *
  * If ref is not a properly-formatted, normalized reference, return
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
  * give up and return NULL.
  *
- * errno is set to something meaningful on error.
+ * RESOLVE_REF_ALLOW_BAD_NAME disables most of the ref name checking except
+ * for names that are absolute paths or contain ".." components. For both
+ * these cases the function will return NULL and set errno to EINVAL.
+ * If the name is bad then the function will set the REF_ISBROKEN flag and
+ * return the name, if the ref exists, or NULL, if it does not.
+ * When this flag is set, any badly named refs will resolve to nullsha1.
  */
-#define RESOLVE_REF_READING        0x01
-#define RESOLVE_REF_ALLOW_BAD_NAME 0x02
-extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int flags, int *ref_flag);
-extern char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag);
+#define RESOLVE_REF_READING 0x01
+#define RESOLVE_REF_NODEREF 0x02
+#define RESOLVE_REF_ALLOW_BAD_NAME 0x04
+extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
+extern char *resolve_refdup(const char *ref, unsigned char *sha1, int *flags, int resolve_flags);
 
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
diff --git c/git-compat-util.h w/git-compat-util.h
index 426bc98..5ee140c 100644
--- c/git-compat-util.h
+++ w/git-compat-util.h
@@ -307,6 +307,8 @@ extern char *gitbasename(char *);
 
 #include "wildmatch.h"
 
+struct strbuf;
+
 /* General helper functions */
 extern void vreportf(const char *prefix, const char *err, va_list params);
 extern void vwritef(int fd, const char *prefix, const char *err, va_list params);
@@ -704,19 +706,23 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif
 
-#include "strbuf.h"
-
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
- * Always returns the return value of unlink(2).
+ * Returns 0 on success which includes trying to unlink an object that does
+ * not exist.
  */
 int unlink_or_warn(const char *path);
-/*
- * Like unlink_or_warn but populates a strbuf
- */
+ /*
+  * Tries to unlink file.  Returns 0 if unlink succeeded
+  * or the file already didn't exist.  Returns -1 and
+  * appends a message to err suitable for
+  * 'error("%s", err->buf)' on error.
+  */
 int unlink_or_msg(const char *file, struct strbuf *err);
 /*
- * Likewise for rmdir(2).
+ * Preserves errno, prints a message, but gives no warning for ENOENT.
+ * Returns 0 on success which includes trying to remove a directory that does
+ * not exist.
  */
 int rmdir_or_warn(const char *path);
 /*
diff --git c/http-backend.c w/http-backend.c
index 059f790..8f94f9b 100644
--- c/http-backend.c
+++ w/http-backend.c
@@ -418,7 +418,7 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 	if (flag & REF_ISSYMREF) {
 		unsigned char unused[20];
 		const char *target = resolve_ref_unsafe(refname, unused,
-						RESOLVE_REF_READING, NULL);
+						NULL, RESOLVE_REF_READING);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
diff --git c/lockfile.c w/lockfile.c
index a921d77..dbd4101 100644
--- c/lockfile.c
+++ w/lockfile.c
@@ -176,16 +176,6 @@ void unable_to_lock_message(const char *path, int err, struct strbuf *buf)
 			    absolute_path(path), strerror(err));
 }
 
-int unable_to_lock_error(const char *path, int err)
-{
-	struct strbuf buf = STRBUF_INIT;
-
-	unable_to_lock_message(path, err, &buf);
-	error("%s", buf.buf);
-	strbuf_release(&buf);
-	return -1;
-}
-
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git c/notes-merge.c w/notes-merge.c
index 94a1a8a..ffca602 100644
--- c/notes-merge.c
+++ w/notes-merge.c
@@ -549,7 +549,7 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
 
 	/* Dereference o->local_ref into local_sha1 */
-	if (read_ref_full(o->local_ref, local_sha1, 0, NULL))
+	if (read_ref_full(o->local_ref, local_sha1, NULL, 0))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_sha1(local_sha1))
diff --git c/reflog-walk.c w/reflog-walk.c
index d80a42a..feeaf0a 100644
--- c/reflog-walk.c
+++ w/reflog-walk.c
@@ -48,8 +48,8 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 		unsigned char sha1[20];
 		const char *name;
 		void *name_to_free;
-		name = name_to_free = resolve_refdup(ref, sha1,
-						     RESOLVE_REF_READING, NULL);
+		name = name_to_free = resolve_refdup(ref, sha1, NULL,
+						     RESOLVE_REF_READING);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
@@ -175,7 +175,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (*branch == '\0') {
 			unsigned char sha1[20];
 			free(branch);
-			branch = resolve_refdup("HEAD", sha1, 0, NULL);
+			branch = resolve_refdup("HEAD", sha1, NULL, 0);
 			if (!branch)
 				die ("No current branch");
 
diff --git c/refs.c w/refs.c
index b14bbf0..3b27758 100644
--- c/refs.c
+++ w/refs.c
@@ -281,11 +281,15 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 }
 
 static struct ref_entry *create_ref_entry(const char *refname,
-					  const unsigned char *sha1, int flag)
+					  const unsigned char *sha1, int flag,
+					  int check_name)
 {
 	int len;
 	struct ref_entry *ref;
 
+	if (check_name &&
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -798,17 +802,16 @@ static int names_conflict(const char *refname1, const char *refname2)
 struct name_conflict_cb {
 	const char *refname;
 	const char *conflicting_refname;
-	const char **skip;
-	int skipnum;
+	struct string_list *skiplist;
 };
 
 static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
 {
 	struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
-	int i;
-	for (i = 0; i < data->skipnum; i++)
-		if (!strcmp(entry->name, data->skip[i]))
-			return 0;
+
+	if (data->skiplist &&
+	    string_list_has_string(data->skiplist, entry->name))
+		return 0;
 	if (names_conflict(data->refname, entry->name)) {
 		data->conflicting_refname = entry->name;
 		return 1;
@@ -821,18 +824,17 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
  * conflicting with the name of an existing reference in dir.  If
  * oldrefname is non-NULL, ignore potential conflicts with oldrefname
  * (e.g., because oldrefname is scheduled for deletion in the same
- * operation). skip contains a list of refs we want to skip checking for
- * conflicts with.
+ * operation). skiplist contains a list of refs we want to skip checking for
+ * conflicts with. skiplist must be sorted.
  */
 static int is_refname_available(const char *refname,
 				struct ref_dir *dir,
-				const char **skip, int skipnum)
+				struct string_list *skiplist)
 {
 	struct name_conflict_cb data;
 	data.refname = refname;
 	data.conflicting_refname = NULL;
-	data.skip = skip;
-	data.skipnum = skipnum;
+	data.skiplist = skiplist;
 
 	sort_ref_dir(dir);
 	if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
@@ -1062,8 +1064,9 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT)) {
 				flag |= REF_ISBROKEN;
+				hashclr(sha1);
 			}
-			last = create_ref_entry(refname, sha1, flag);
+			last = create_ref_entry(refname, sha1, flag, 0);
 			if (peeled == PEELED_FULLY ||
 			    (peeled == PEELED_TAGS && starts_with(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
@@ -1136,10 +1139,8 @@ void add_packed_ref(const char *refname, const unsigned char *sha1)
 
 	if (!packed_ref_cache->lock)
 		die("internal error: packed refs not locked");
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", refname);
 	add_ref(get_packed_ref_dir(packed_ref_cache),
-		create_ref_entry(refname, sha1, REF_ISPACKED));
+		create_ref_entry(refname, sha1, REF_ISPACKED, 1));
 }
 
 /*
@@ -1197,17 +1198,19 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			} else if (read_ref_full(refname.buf, sha1,
-						 RESOLVE_REF_READING, &flag)) {
+			} else if (read_ref_full(refname.buf, sha1, &flag,
+						 RESOLVE_REF_READING)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			if (check_refname_format(refname.buf, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT)) {
+			if (check_refname_format(refname.buf,
+						 REFNAME_ALLOW_ONELEVEL|
+						 REFNAME_DOT_COMPONENT)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
 			add_entry_to_dir(dir,
-					 create_ref_entry(refname.buf, sha1, flag));
+					 create_ref_entry(refname.buf, sha1, flag, 0));
 		}
 		strbuf_setlen(&refname, dirnamelen);
 	}
@@ -1353,21 +1356,40 @@ static const char *handle_missing_loose_ref(const char *refname,
 	}
 }
 
+static int escapes_cwd(const char *path) {
+	char *buf;
+	int result;
+
+	if (is_absolute_path(path))
+		return 1;
+	buf = xmalloc(strlen(path) + 1);
+	result = normalize_path_copy(buf, path);
+	free(buf);
+	return result;
+}
+
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int *flags, int resolve_flags)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
+	int bad_name = 0;
 
-	if (ref_flag)
-		*ref_flag = 0;
+	if (flags)
+		*flags = 0;
 
-	if (!(flags & RESOLVE_REF_ALLOW_BAD_NAME) &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		errno = EINVAL;
-		return NULL;
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+		    escapes_cwd(refname)) {
+			errno = EINVAL;
+			return NULL;
+		}
+		hashclr(sha1);
+		if (flags)
+			*flags |= REF_ISBROKEN;
+		bad_name = 1;
 	}
 	for (;;) {
 		char path[PATH_MAX];
@@ -1395,8 +1417,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
 		if (lstat(path, &st) < 0) {
 			if (errno == ENOENT)
 				return handle_missing_loose_ref(refname, sha1,
-						flags & RESOLVE_REF_READING,
-						ref_flag);
+					resolve_flags & RESOLVE_REF_READING,
+					flags);
 			else
 				return NULL;
 		}
@@ -1416,8 +1438,12 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
 					!check_refname_format(buffer, 0)) {
 				strcpy(refname_buffer, buffer);
 				refname = refname_buffer;
-				if (ref_flag)
-					*ref_flag |= REF_ISSYMREF;
+				if (flags)
+					*flags |= REF_ISSYMREF;
+				if (resolve_flags & RESOLVE_REF_NODEREF) {
+					hashclr(sha1);
+					return refname;
+				}
 				continue;
 			}
 		}
@@ -1462,31 +1488,37 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int fla
 			 */
 			if (get_sha1_hex(buffer, sha1) ||
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
-				if (ref_flag)
-					*ref_flag |= REF_ISBROKEN;
+				if (flags)
+					*flags |= REF_ISBROKEN;
 				errno = EINVAL;
 				return NULL;
 			}
+			if (bad_name)
+				hashclr(sha1);
 			return refname;
 		}
-		if (ref_flag)
-			*ref_flag |= REF_ISSYMREF;
+		if (flags)
+			*flags |= REF_ISSYMREF;
 		buf = buffer + 4;
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (ref_flag)
-				*ref_flag |= REF_ISBROKEN;
+			if (flags)
+				*flags |= REF_ISBROKEN;
 			errno = EINVAL;
 			return NULL;
 		}
 		refname = strcpy(refname_buffer, buf);
+		if (resolve_flags & RESOLVE_REF_NODEREF) {
+			hashclr(sha1);
+			return refname;
+		}
 	}
 }
 
-char *resolve_refdup(const char *ref, unsigned char *sha1, int flags, int *ref_flag)
+char *resolve_refdup(const char *ref, unsigned char *sha1, int *flags, int resolve_flags)
 {
-	const char *ret = resolve_ref_unsafe(ref, sha1, flags, ref_flag);
+	const char *ret = resolve_ref_unsafe(ref, sha1, flags, resolve_flags);
 	return ret ? xstrdup(ret) : NULL;
 }
 
@@ -1497,22 +1529,22 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, unsigned char *sha1, int flags, int *ref_flag)
+int read_ref_full(const char *refname, unsigned char *sha1, int *flags, int resolve_flags)
 {
-	if (resolve_ref_unsafe(refname, sha1, flags, ref_flag))
+	if (resolve_ref_unsafe(refname, sha1, flags, resolve_flags))
 		return 0;
 	return -1;
 }
 
 int read_ref(const char *refname, unsigned char *sha1)
 {
-	return read_ref_full(refname, sha1, RESOLVE_REF_READING, NULL);
+	return read_ref_full(refname, sha1, NULL, RESOLVE_REF_READING);
 }
 
 int ref_exists(const char *refname)
 {
 	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, RESOLVE_REF_READING, NULL);
+	return !!resolve_ref_unsafe(refname, sha1, NULL, RESOLVE_REF_READING);
 }
 
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
@@ -1626,7 +1658,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return 0;
 	}
 
-	if (read_ref_full(refname, base, RESOLVE_REF_READING, &flag))
+	if (read_ref_full(refname, base, &flag, RESOLVE_REF_READING))
 		return -1;
 
 	/*
@@ -1667,7 +1699,7 @@ static int warn_if_dangling_symref(const char *refname, const unsigned char *sha
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = resolve_ref_unsafe(refname, junk, 0, NULL);
+	resolves_to = resolve_ref_unsafe(refname, junk, NULL, 0);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -1792,7 +1824,7 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", sha1, RESOLVE_REF_READING, &flag))
+	if (!read_ref_full("HEAD", sha1, &flag, RESOLVE_REF_READING))
 		return fn("HEAD", sha1, flag, cb_data);
 
 	return 0;
@@ -1872,7 +1904,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, sha1, RESOLVE_REF_READING, &flag))
+	if (!read_ref_full(buf.buf, sha1, &flag, RESOLVE_REF_READING))
 		ret = fn(buf.buf, sha1, flag, cb_data);
 	strbuf_release(&buf);
 
@@ -1967,8 +1999,8 @@ int refname_match(const char *abbrev_name, const char *full_name)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	if (read_ref_full(lock->ref_name, lock->old_sha1,
-			  mustexist ? RESOLVE_REF_READING : 0, NULL)) {
+	if (read_ref_full(lock->ref_name, lock->old_sha1, NULL,
+			  mustexist ? RESOLVE_REF_READING : 0)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
@@ -2041,8 +2073,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, this_result,
-				       RESOLVE_REF_READING, &flag);
+		r = resolve_ref_unsafe(fullref, this_result, &flag,
+				       RESOLVE_REF_READING);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -2071,7 +2103,7 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		const char *ref, *it;
 
 		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, hash, RESOLVE_REF_READING, NULL);
+		ref = resolve_ref_unsafe(path, hash, NULL, RESOLVE_REF_READING);
 		if (!ref)
 			continue;
 		if (reflog_exists(path))
@@ -2097,8 +2129,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
  */
 static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 					    const unsigned char *old_sha1,
-					    int flags, int *type_p,
-					    const char **skip, int skipnum)
+					    struct string_list *skiplist,
+					    int flags, int *type_p)
 {
 	char *ref_file;
 	const char *orig_refname = refname;
@@ -2106,22 +2138,23 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int last_errno = 0;
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
-	int resolve_flags;
+	int resolve_flags = 0;
 	int missing = 0;
 	int attempts_remaining = 3;
-	int bad_refname;
 
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	bad_refname = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
+	if (flags & REF_BADNAMEOK)
+		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
-	resolve_flags = RESOLVE_REF_ALLOW_BAD_NAME;
 	if (mustexist)
 		resolve_flags |= RESOLVE_REF_READING;
+	if (flags & REF_NODEREF)
+		resolve_flags |= RESOLVE_REF_NODEREF;
 
-	refname = resolve_ref_unsafe(refname, lock->old_sha1, resolve_flags,
-				     &type);
+	refname = resolve_ref_unsafe(refname, lock->old_sha1, &type,
+				     resolve_flags);
 	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -2135,7 +2168,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			goto error_return;
 		}
 		refname = resolve_ref_unsafe(orig_refname, lock->old_sha1,
-					     resolve_flags, &type);
+					     &type, resolve_flags);
 	}
 	if (type_p)
 	    *type_p = type;
@@ -2153,7 +2186,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	 */
 	if (missing &&
 	     !is_refname_available(refname, get_packed_refs(&ref_cache),
-				   skip, skipnum)) {
+				   skiplist)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -2199,8 +2232,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		else
 			unable_to_lock_index_die(ref_file, errno);
 	}
-	if (bad_refname)
-		return lock;
 	return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
 
  error_return:
@@ -2213,7 +2244,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
+	return lock_ref_sha1_basic(refname, old_sha1, NULL, flags, type_p);
 }
 
 /*
@@ -2364,9 +2395,8 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 		packed_entry->flag = REF_ISPACKED | REF_KNOWS_PEELED;
 		hashcpy(packed_entry->u.value.sha1, entry->u.value.sha1);
 	} else {
-		packed_entry = create_ref_entry(entry->name,
-					entry->u.value.sha1,
-					REF_ISPACKED | REF_KNOWS_PEELED);
+		packed_entry = create_ref_entry(entry->name, entry->u.value.sha1,
+						REF_ISPACKED | REF_KNOWS_PEELED, 0);
 		add_ref(cb->packed_refs, packed_entry);
 	}
 	hashcpy(packed_entry->u.value.peeled, entry->u.value.peeled);
@@ -2491,7 +2521,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 		unsigned char sha1[20];
 		int flags;
 
-		if (read_ref_full(entry->name, sha1, 0, &flags))
+		if (read_ref_full(entry->name, sha1, &flags, 0))
 			/* We should at least have found the packed ref. */
 			die("Internal error");
 		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED)) {
@@ -2530,6 +2560,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 	struct string_list_item *ref_to_delete;
 	int i, ret, removed = 0;
 
+	assert(err);
+
 	/* Look for a packed ref */
 	for (i = 0; i < n; i++)
 		if (get_packed_ref(refnames[i]))
@@ -2540,13 +2572,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 		return 0; /* no refname exists in packed refs */
 
 	if (lock_packed_refs(0)) {
-		if (err) {
-			unable_to_lock_message(git_path("packed-refs"), errno,
-					       err);
-			return -1;
-		}
-		unable_to_lock_error(git_path("packed-refs"), errno);
-		return error("cannot delete '%s' from packed refs", refnames[i]);
+		unable_to_lock_message(git_path("packed-refs"), errno, err);
+		return -1;
 	}
 	packed = get_packed_refs(&ref_cache);
 
@@ -2572,7 +2599,7 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 	/* Write what remains */
 	ret = commit_packed_refs();
-	if (ret && err)
+	if (ret)
 		strbuf_addf(err, "unable to overwrite old ref-pack file: %s",
 			    strerror(errno));
 	return ret;
@@ -2580,6 +2607,8 @@ int repack_without_refs(const char **refnames, int n, struct strbuf *err)
 
 static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
 {
+	assert(err);
+
 	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
 		/* loose */
 		int res, i = strlen(lock->lk->filename) - 5; /* .lock */
@@ -2678,25 +2707,31 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	struct stat loginfo;
 	int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
 	const char *symref = NULL;
+	struct string_list skiplist = STRING_LIST_INIT_NODUP;
 
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1,
-				    RESOLVE_REF_READING, &flag);
+	symref = resolve_ref_unsafe(oldrefname, orig_sha1, &flag,
+				    RESOLVE_REF_READING);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
 	if (!symref)
 		return error("refname %s not found", oldrefname);
 
+	string_list_insert(&skiplist, oldrefname);
 	if (!is_refname_available(newrefname, get_packed_refs(&ref_cache),
-				  &oldrefname, 1))
+				  &skiplist)) {
+		string_list_clear(&skiplist, 0);
 		return 1;
-
+	}
 	if (!is_refname_available(newrefname, get_loose_refs(&ref_cache),
-				  &oldrefname, 1))
+				  &skiplist)) {
+		string_list_clear(&skiplist, 0);
 		return 1;
+	}
+	string_list_clear(&skiplist, 0);
 
 	if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
 		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
@@ -2707,7 +2742,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, RESOLVE_REF_READING, NULL) &&
+	if (!read_ref_full(newrefname, sha1, NULL, RESOLVE_REF_READING) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
@@ -2725,7 +2760,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 
 	logmoved = log;
 
-	lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
+	lock = lock_ref_sha1_basic(newrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for update", newrefname);
 		goto rollback;
@@ -2740,7 +2775,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 0;
 
  rollback:
-	lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
+	lock = lock_ref_sha1_basic(oldrefname, NULL, NULL, 0, NULL);
 	if (!lock) {
 		error("unable to lock %s for rollback", oldrefname);
 		goto rollbacklog;
@@ -2985,8 +3020,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
-		head_ref = resolve_ref_unsafe("HEAD", head_sha1,
-					      RESOLVE_REF_READING, &head_flag);
+		head_ref = resolve_ref_unsafe("HEAD", head_sha1, &head_flag,
+					      RESOLVE_REF_READING);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -3353,7 +3388,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				retval = do_for_each_reflog(name, fn, cb_data);
 			} else {
 				unsigned char sha1[20];
-				if (read_ref_full(name->buf, sha1, 0, NULL))
+				if (read_ref_full(name->buf, sha1, NULL, 0))
 					retval = error("bad ref for %s", name->buf);
 				else
 					retval = fn(name->buf, sha1, 0, cb_data);
@@ -3423,6 +3458,8 @@ struct ref_transaction {
 
 struct ref_transaction *ref_transaction_begin(struct strbuf *err)
 {
+	assert(err);
+
 	return xcalloc(1, sizeof(struct ref_transaction));
 }
 
@@ -3462,6 +3499,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: update called for transaction that is not open");
 
@@ -3470,7 +3509,8 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	if (!is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "Bad refname: %s", refname);
+		strbuf_addf(err, "refusing to update ref with bad name %s",
+			    refname);
 		return -1;
 	}
 
@@ -3493,6 +3533,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: create called for transaction that is not open");
 
@@ -3500,7 +3542,8 @@ int ref_transaction_create(struct ref_transaction *transaction,
 		die("BUG: create ref with null new_sha1");
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "Bad refname: %s", refname);
+		strbuf_addf(err, "refusing to create ref with bad name %s",
+			    refname);
 		return -1;
 	}
 
@@ -3523,6 +3566,8 @@ int ref_transaction_delete(struct ref_transaction *transaction,
 {
 	struct ref_update *update;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: delete called for transaction that is not open");
 
@@ -3585,13 +3630,14 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 					struct strbuf *err)
 {
 	int i;
+
+	assert(err);
+
 	for (i = 1; i < n; i++)
 		if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
-			const char *str =
-				"Multiple updates for ref '%s' not allowed.";
-			if (err)
-				strbuf_addf(err, str, updates[i]->refname);
-
+			strbuf_addf(err,
+				    "Multiple updates for ref '%s' not allowed.",
+				    updates[i]->refname);
 			return 1;
 		}
 	return 0;
@@ -3600,11 +3646,13 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
 int ref_transaction_commit(struct ref_transaction *transaction,
 			   struct strbuf *err)
 {
-	int ret = 0, delnum = 0, i, df_conflict = 0;
+	int ret = 0, delnum = 0, i;
 	const char **delnames;
 	int n = transaction->nr;
 	struct ref_update **updates = transaction->updates;
 
+	assert(err);
+
 	if (transaction->state != REF_TRANSACTION_OPEN)
 		die("BUG: commit called for transaction that is not open");
 
@@ -3631,16 +3679,15 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 						   (update->have_old ?
 						    update->old_sha1 :
 						    NULL),
+						   NULL,
 						   update->flags,
-						   &update->type,
-						   delnames, delnum);
+						   &update->type);
 		if (!update->lock) {
-			if (errno == ENOTDIR)
-				df_conflict = 1;
-			if (err)
-				strbuf_addf(err, "Cannot lock the ref '%s'.",
-					    update->refname);
-			ret = -1;
+			int df_conflict = (errno == ENOTDIR);
+
+			strbuf_addf(err, "Cannot lock the ref '%s'.",
+				    update->refname);
+			ret = df_conflict ? UPDATE_REFS_NAME_CONFLICT : -1;
 			goto cleanup;
 		}
 	}
@@ -3654,9 +3701,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 					     update->msg);
 			update->lock = NULL; /* freed by write_ref_sha1 */
 			if (ret) {
-				if (err)
-					strbuf_addf(err, "Cannot update the ref '%s'.",
-						    update->refname);
+				strbuf_addf(err, "Cannot update the ref '%s'.",
+					    update->refname);
 				ret = -1;
 				goto cleanup;
 			}
@@ -3668,16 +3714,20 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 		struct ref_update *update = updates[i];
 
 		if (update->lock) {
-			if (delete_ref_loose(update->lock, update->type, err))
+			if (delete_ref_loose(update->lock, update->type, err)) {
 				ret = -1;
+				goto cleanup;
+			}
 
 			if (!(update->flags & REF_ISPRUNING))
 				delnames[delnum++] = update->lock->ref_name;
 		}
 	}
 
-	if (repack_without_refs(delnames, delnum, err))
+	if (repack_without_refs(delnames, delnum, err)) {
 		ret = -1;
+		goto cleanup;
+	}
 	for (i = 0; i < delnum; i++)
 		unlink_or_warn(git_path("logs/%s", delnames[i]));
 	clear_loose_ref_cache(&ref_cache);
@@ -3689,8 +3739,6 @@ cleanup:
 		if (updates[i]->lock)
 			unlock_ref(updates[i]->lock);
 	free(delnames);
-	if (df_conflict)
-		ret = -2;
 	return ret;
 }
 
diff --git c/refs.h w/refs.h
index a7b8009..a96e174 100644
--- c/refs.h
+++ w/refs.h
@@ -175,10 +175,12 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
  * ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
  *              symbolic references.
+ * REF_BADNAMEOK: allow locking a ref that has a bad name.
  *
  * Flags >= 0x100 are reserved for internal use.
  */
 #define REF_NODEREF	0x01
+#define REF_BADNAMEOK	0x02
 /*
  * This function sets errno to something meaningful on failure.
  */
@@ -322,11 +324,10 @@ int ref_transaction_delete(struct ref_transaction *transaction,
  * Commit all of the changes that have been queued in transaction, as
  * atomically as possible.  Return a nonzero value if there is a
  * problem.
- * If the transaction is already in failed state this function will return
- * an error.
+ *
  * Function returns 0 on success, -1 for generic failures and
- * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a name
- * collision (ENOTDIR).
+ * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a naming conflict.
+ * For example, the ref names A and A/B conflict.
  */
 #define UPDATE_REFS_NAME_CONFLICT -2
 int ref_transaction_commit(struct ref_transaction *transaction,
diff --git c/remote.c w/remote.c
index 2adb31c..67c375d 100644
--- c/remote.c
+++ w/remote.c
@@ -486,7 +486,7 @@ static void read_config(void)
 		return;
 	default_remote_name = "origin";
 	current_branch = NULL;
-	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
+	head_ref = resolve_ref_unsafe("HEAD", sha1, &flag, 0);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    starts_with(head_ref, "refs/heads/")) {
 		current_branch =
@@ -1121,8 +1121,8 @@ static char *guess_ref(const char *name, struct ref *peer)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	const char *r = resolve_ref_unsafe(peer->name, sha1,
-					   RESOLVE_REF_READING, NULL);
+	const char *r = resolve_ref_unsafe(peer->name, sha1, NULL,
+					   RESOLVE_REF_READING);
 	if (!r)
 		return NULL;
 
@@ -1183,8 +1183,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		unsigned char sha1[20];
 		int flag;
 
-		dst_value = resolve_ref_unsafe(matched_src->name, sha1,
-					       RESOLVE_REF_READING, &flag);
+		dst_value = resolve_ref_unsafe(matched_src->name, sha1, &flag,
+					       RESOLVE_REF_READING);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
@@ -1658,7 +1658,7 @@ static int ignore_symref_update(const char *refname)
 	unsigned char sha1[20];
 	int flag;
 
-	if (!resolve_ref_unsafe(refname, sha1, 0, &flag))
+	if (!resolve_ref_unsafe(refname, sha1, &flag, 0))
 		return 0; /* non-existing refs are OK */
 	return (flag & REF_ISSYMREF);
 }
diff --git c/sequencer.c w/sequencer.c
index ebe8713..6a05ad4 100644
--- c/sequencer.c
+++ w/sequencer.c
@@ -366,7 +366,7 @@ static int is_index_unchanged(void)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, RESOLVE_REF_READING, NULL))
+	if (!resolve_ref_unsafe("HEAD", head_sha1, NULL, RESOLVE_REF_READING))
 		return error(_("Could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(head_sha1);
@@ -912,7 +912,7 @@ static int rollback_single_pick(void)
 	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
 	    !file_exists(git_path("REVERT_HEAD")))
 		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", head_sha1, 0, NULL))
+	if (read_ref_full("HEAD", head_sha1, NULL, 0))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_sha1(head_sha1))
 		return error(_("cannot abort from a branch yet to be born"));
diff --git c/t/t1400-update-ref.sh w/t/t1400-update-ref.sh
index 0218e96..ff4607b 100755
--- c/t/t1400-update-ref.sh
+++ w/t/t1400-update-ref.sh
@@ -110,6 +110,22 @@ test_expect_success "delete symref without dereference when the referred ref is
 cp -f .git/HEAD.orig .git/HEAD
 git update-ref -d $m
 
+test_expect_success 'update-ref -d is not confused by self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_path_is_file .git/refs/heads/self &&
+	test_must_fail git update-ref -d refs/heads/self &&
+	test_path_is_file .git/refs/heads/self
+'
+
+test_expect_success 'update-ref --no-deref -d can delete self-reference' '
+	git symbolic-ref refs/heads/self refs/heads/self &&
+	test_when_finished "rm -f .git/refs/heads/self" &&
+	test_path_is_file .git/refs/heads/self &&
+	git update-ref --no-deref -d refs/heads/self &&
+	test_path_is_missing .git/refs/heads/self
+'
+
 test_expect_success '(not) create HEAD with old sha1' "
 	test_must_fail git update-ref HEAD $A $B
 "
diff --git c/t/t1402-check-ref-format.sh w/t/t1402-check-ref-format.sh
index 1a5a5f3..058fa37 100755
--- c/t/t1402-check-ref-format.sh
+++ w/t/t1402-check-ref-format.sh
@@ -196,4 +196,52 @@ invalid_ref_normalized 'heads///foo.lock'
 invalid_ref_normalized 'foo.lock/bar'
 invalid_ref_normalized 'foo.lock///bar'
 
+test_expect_success 'git branch shows badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch >output &&
+	grep -e "broken...ref" output
+'
+
+test_expect_success 'git branch -d can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -d broken...ref &&
+	git branch >output &&
+	! grep -e "broken...ref" output
+'
+
+test_expect_success 'git branch -D can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -D broken...ref &&
+	git branch >output &&
+	! grep -e "broken...ref" output
+'
+
+test_expect_success 'git update-ref -d can delete badly named ref' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git update-ref -d refs/heads/broken...ref &&
+	git branch >output &&
+	! grep -e "broken...ref" output
+'
+
+test_expect_success 'git branch can not create a badly named ref' '
+	test_must_fail git branch broken...ref
+'
+
+test_expect_success 'git branch can not rename to a bad ref name' '
+	git branch goodref &&
+	test_must_fail git branch -m goodref broken...ref
+'
+
+test_expect_failure 'git branch can rename from a bad ref name' '
+	cp .git/refs/heads/master .git/refs/heads/broken...ref &&
+	test_when_finished "rm -f .git/refs/heads/broken...ref" &&
+	git branch -m broken...ref renamed &&
+	test_must_fail git rev-parse broken...ref &&
+	test_cmp_rev master renamed
+'
+
 test_done
diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index ac31b71..432921b 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -285,6 +285,15 @@ test_expect_success 'deleting a dangling symref' '
 	test_i18ncmp expect actual
 '
 
+test_expect_success 'deleting a self-referential symref' '
+	git symbolic-ref refs/heads/self-reference refs/heads/self-reference &&
+	test_path_is_file .git/refs/heads/self-reference &&
+	echo "Deleted branch self-reference (was refs/heads/self-reference)." >expect &&
+	git branch -d self-reference >actual &&
+	test_path_is_missing .git/refs/heads/self-reference &&
+	test_i18ncmp expect actual
+'
+
 test_expect_success 'renaming a symref is not allowed' '
 	git symbolic-ref refs/heads/master2 refs/heads/master &&
 	test_must_fail git branch -m master2 master3 &&
diff --git c/t/t7001-mv.sh w/t/t7001-mv.sh
index 54d7807..69f11bd 100755
--- c/t/t7001-mv.sh
+++ w/t/t7001-mv.sh
@@ -350,10 +350,11 @@ test_expect_success 'git mv moves a submodule with a .git directory and .gitmodu
 '
 
 test_expect_success 'git mv moves a submodule with gitfile' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	mkdir mod &&
 	(
 		cd mod &&
 		git mv ../sub/ .
@@ -372,11 +373,12 @@ test_expect_success 'git mv moves a submodule with gitfile' '
 '
 
 test_expect_success 'mv does not complain when no .gitmodules file is found' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	git rm .gitmodules &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	! test -s actual.err &&
 	! test -e sub &&
@@ -390,11 +392,12 @@ test_expect_success 'mv does not complain when no .gitmodules file is found' '
 '
 
 test_expect_success 'mv will error out on a modified .gitmodules file unless staged' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	git config -f .gitmodules foo.bar true &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
+	mkdir mod &&
 	test_must_fail git mv sub mod/sub 2>actual.err &&
 	test -s actual.err &&
 	test -e sub &&
@@ -413,13 +416,14 @@ test_expect_success 'mv will error out on a modified .gitmodules file unless sta
 '
 
 test_expect_success 'mv issues a warning when section is not found in .gitmodules' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
 	git config -f .gitmodules --remove-section submodule.sub &&
 	git add .gitmodules &&
 	entry="$(git ls-files --stage sub | cut -f 1)" &&
 	echo "warning: Could not find section in .gitmodules where path=sub" >expect.err &&
+	mkdir mod &&
 	git mv sub mod/sub 2>actual.err &&
 	test_i18ncmp expect.err actual.err &&
 	! test -e sub &&
@@ -433,9 +437,10 @@ test_expect_success 'mv issues a warning when section is not found in .gitmodule
 '
 
 test_expect_success 'mv --dry-run does not touch the submodule or .gitmodules' '
-	rm -rf mod/sub &&
+	rm -rf mod &&
 	git reset --hard &&
 	git submodule update &&
+	mkdir mod &&
 	git mv -n sub mod/sub 2>actual.err &&
 	test -f sub/.git &&
 	git diff-index --exit-code HEAD &&
diff --git c/transport-helper.c w/transport-helper.c
index 270ae28..8365441 100644
--- c/transport-helper.c
+++ w/transport-helper.c
@@ -889,7 +889,9 @@ static int push_refs_with_export(struct transport *transport,
 					int flag;
 
 					/* Follow symbolic refs (mainly for HEAD). */
-					name = resolve_ref_unsafe(ref->peer_ref->name, sha1, RESOLVE_REF_READING, &flag);
+					name = resolve_ref_unsafe(
+						 ref->peer_ref->name, sha1,
+						 &flag, RESOLVE_REF_READING);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
diff --git c/transport.c w/transport.c
index f40e950..3ba7bbf 100644
--- c/transport.c
+++ w/transport.c
@@ -168,8 +168,8 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
-		tmp = resolve_ref_unsafe(localname, sha,
-					 RESOLVE_REF_READING, &flag);
+		tmp = resolve_ref_unsafe(localname, sha, &flag,
+					 RESOLVE_REF_READING);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
 			localname = tmp;
@@ -754,7 +754,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	unsigned char head_sha1[20];
 	char *head;
 
-	head = resolve_refdup("HEAD", head_sha1, RESOLVE_REF_READING, NULL);
+	head = resolve_refdup("HEAD", head_sha1, NULL, RESOLVE_REF_READING);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
diff --git c/upload-pack.c w/upload-pack.c
index 01de944..3b51ccb 100644
--- c/upload-pack.c
+++ w/upload-pack.c
@@ -743,7 +743,7 @@ static int find_symref(const char *refname, const unsigned char *sha1, int flag,
 
 	if ((flag & REF_ISSYMREF) == 0)
 		return 0;
-	symref_target = resolve_ref_unsafe(refname, unused, 0, &flag);
+	symref_target = resolve_ref_unsafe(refname, unused, &flag, 0);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, refname);
diff --git c/wrapper.c w/wrapper.c
index 74a0cc0..ec7a08b 100644
--- c/wrapper.c
+++ w/wrapper.c
@@ -430,8 +430,8 @@ int xmkstemp_mode(char *template, int mode)
 static int warn_if_unremovable(const char *op, const char *file, int rc)
 {
 	int err;
-	if (rc >= 0 || errno == ENOENT)
-		return rc;
+	if (!rc || errno == ENOENT)
+		return 0;
 	err = errno;
 	warning("unable to %s %s: %s", op, file, strerror(errno));
 	errno = err;
@@ -440,20 +440,16 @@ static int warn_if_unremovable(const char *op, const char *file, int rc)
 
 int unlink_or_msg(const char *file, struct strbuf *err)
 {
-	if (err) {
-		int rc = unlink(file);
-		int save_errno = errno;
+	int rc = unlink(file);
 
-		if (rc < 0 && errno != ENOENT) {
-			strbuf_addf(err, "unable to unlink %s: %s",
-				    file, strerror(errno));
-			errno = save_errno;
-			return -1;
-		}
+	assert(err);
+
+	if (!rc || errno == ENOENT)
 		return 0;
-	}
 
-	return unlink_or_warn(file);
+	strbuf_addf(err, "unable to unlink %s: %s",
+		    file, strerror(errno));
+	return -1;
 }
 
 int unlink_or_warn(const char *file)
diff --git c/wt-status.c w/wt-status.c
index 318a191..6819e2b 100644
--- c/wt-status.c
+++ w/wt-status.c
@@ -128,7 +128,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = -1;
 	s->relative_paths = 1;
-	s->branch = resolve_refdup("HEAD", sha1, 0, NULL);
+	s->branch = resolve_refdup("HEAD", sha1, NULL, 0);
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
