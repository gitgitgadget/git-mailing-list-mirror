From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 14/25] refs.c: change resolve_ref_unsafe reading argument to
 be a flags field
Date: Tue, 14 Oct 2014 17:51:47 -0700
Message-ID: <20141015005147.GR32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:51:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCon-0002fD-2a
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbaJOAvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:51:52 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:42614 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbaJOAvv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:51:51 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so225422pab.32
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ANV/Uje/I0U3pfhVUALwGy85dAiC48xFATVzDOfemc4=;
        b=DVSMV3nzZtaQPwPBfqD/4JSTo+jhQUt/Fsxcrt0d65pwZb2mS8W8KUkPveVLM8viqK
         71EPD5xOhagkTKVprKlFgKweX2VORBYgkK0Nc/NGtS2mSdXI9x0HnHPehBp0p6aApuZR
         ZSuv8Hl66eeIlR9uvy3THGXGLeKLuJv4IUqfNKMOAgJR6viAiaFQcHuW17ct+CTHI6Zo
         5Nr0D8DqpxC+NyqA/9upfkNNFB1ddQ6qfp8T15m7fbW2aXLpy9h0r/yUae+iw8/1Unt4
         bsHF5sSNhQSQVv/0N8Xzxd9mDROZKPiC54eOvNq9Wl9nCBMmkr6kvFGrylpWf4haaZ//
         zhxA==
X-Received: by 10.68.242.164 with SMTP id wr4mr6120456pbc.148.1413334310650;
        Tue, 14 Oct 2014 17:51:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id cl1sm14421328pbb.92.2014.10.14.17.51.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 15 Jul 2014 12:59:36 -0700

resolve_ref_unsafe takes a boolean argument for reading (a nonexistent ref
resolves successfully for writing but not for reading).  Change this to be
a flags field instead, and pass the new constant RESOLVE_REF_READING when
we want this behaviour.

While at it, swap two of the arguments in the function to put output
arguments at the end.  As a nice side effect, this ensures that we can
catch callers that were unaware of the new API so they can be audited.

Give the wrapper functions resolve_refdup and read_ref_full the same
treatment for consistency.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 branch.c                |  2 +-
 builtin/blame.c         |  2 +-
 builtin/branch.c        |  9 ++---
 builtin/checkout.c      |  6 ++--
 builtin/clone.c         |  2 +-
 builtin/commit.c        |  2 +-
 builtin/fmt-merge-msg.c |  2 +-
 builtin/for-each-ref.c  |  6 ++--
 builtin/fsck.c          |  2 +-
 builtin/log.c           |  3 +-
 builtin/merge.c         |  2 +-
 builtin/notes.c         |  2 +-
 builtin/receive-pack.c  |  4 +--
 builtin/remote.c        |  5 +--
 builtin/show-branch.c   |  7 ++--
 builtin/symbolic-ref.c  |  2 +-
 bundle.c                |  2 +-
 cache.h                 | 23 ++++++------
 http-backend.c          |  4 ++-
 notes-merge.c           |  2 +-
 reflog-walk.c           |  5 +--
 refs.c                  | 93 ++++++++++++++++++++++++++++---------------------
 remote.c                | 11 +++---
 sequencer.c             |  4 +--
 transport-helper.c      |  5 ++-
 transport.c             |  5 +--
 upload-pack.c           |  2 +-
 wt-status.c             |  2 +-
 28 files changed, 124 insertions(+), 92 deletions(-)

diff --git a/branch.c b/branch.c
index 884c62c..4bab55a 100644
--- a/branch.c
+++ b/branch.c
@@ -170,7 +170,7 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 		const char *head;
 		unsigned char sha1[20];
 
-		head = resolve_ref_unsafe("HEAD", sha1, 0, NULL);
+		head = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
diff --git a/builtin/blame.c b/builtin/blame.c
index 3838be2..303e217 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2286,7 +2286,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	commit->date = now;
 	parent_tail = &commit->parents;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
 		die("no such ref: HEAD");
 
 	parent_tail = append_parent(parent_tail, head_sha1);
diff --git a/builtin/branch.c b/builtin/branch.c
index 6785097..6491bac 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -131,7 +131,8 @@ static int branch_merged(int kind, const char *name,
 		    branch->merge[0] &&
 		    branch->merge[0]->dst &&
 		    (reference_name = reference_name_to_free =
-		     resolve_refdup(branch->merge[0]->dst, sha1, 1, NULL)) != NULL)
+		     resolve_refdup(branch->merge[0]->dst, RESOLVE_REF_READING,
+				    sha1, NULL)) != NULL)
 			reference_rev = lookup_commit_reference(sha1);
 	}
 	if (!reference_rev)
@@ -235,7 +236,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 		free(name);
 
 		name = mkpathdup(fmt, bname.buf);
-		target = resolve_ref_unsafe(name, sha1, 0, &flags);
+		target = resolve_ref_unsafe(name, 0, sha1, &flags);
 		if (!target ||
 		    (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
 			error(remote_branch
@@ -299,7 +300,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 	int flag;
 	const char *dst;
 
-	dst = resolve_ref_unsafe(src, sha1, 0, &flag);
+	dst = resolve_ref_unsafe(src, 0, sha1, &flag);
 	if (!(dst && (flag & REF_ISSYMREF)))
 		return NULL;
 	if (prefix)
@@ -869,7 +870,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", head_sha1, 0, NULL);
+	head = resolve_refdup("HEAD", 0, head_sha1, NULL);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
 	if (!strcmp(head, "HEAD"))
diff --git a/builtin/checkout.c b/builtin/checkout.c
index b4decd5..5410dac 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -355,7 +355,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
 		die(_("unable to write new index file"));
 
-	read_ref_full("HEAD", rev, 0, &flag);
+	read_ref_full("HEAD", 0, rev, &flag);
 	head = lookup_commit_reference_gently(rev, 1);
 
 	errs |= post_checkout_hook(head, head, 0);
@@ -775,7 +775,7 @@ static int switch_branches(const struct checkout_opts *opts,
 	unsigned char rev[20];
 	int flag, writeout_error = 0;
 	memset(&old, 0, sizeof(old));
-	old.path = path_to_free = resolve_refdup("HEAD", rev, 0, &flag);
+	old.path = path_to_free = resolve_refdup("HEAD", 0, rev, &flag);
 	old.commit = lookup_commit_reference_gently(rev, 1);
 	if (!(flag & REF_ISSYMREF))
 		old.path = NULL;
@@ -1072,7 +1072,7 @@ static int checkout_branch(struct checkout_opts *opts,
 		unsigned char rev[20];
 		int flag;
 
-		if (!read_ref_full("HEAD", rev, 0, &flag) &&
+		if (!read_ref_full("HEAD", 0, rev, &flag) &&
 		    (flag & REF_ISSYMREF) && is_null_sha1(rev))
 			return switch_unborn_to_new_branch(opts);
 	}
diff --git a/builtin/clone.c b/builtin/clone.c
index d3bf953..7f509d0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -623,7 +623,7 @@ static int checkout(void)
 	if (option_no_checkout)
 		return 0;
 
-	head = resolve_refdup("HEAD", sha1, 1, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, sha1, NULL);
 	if (!head) {
 		warning(_("remote HEAD refers to nonexistent ref, "
 			  "unable to checkout.\n"));
diff --git a/builtin/commit.c b/builtin/commit.c
index a7857ab..aa0940e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1515,7 +1515,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", junk_sha1, 0, NULL);
+	head = resolve_ref_unsafe("HEAD", 0, junk_sha1, NULL);
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 79df05e..37177c6 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -602,7 +602,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 
 	/* get current branch */
 	current_branch = current_branch_to_free =
-		resolve_refdup("HEAD", head_sha1, 1, NULL);
+		resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
 	if (!current_branch)
 		die("No current branch");
 	if (starts_with(current_branch, "refs/heads/"))
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index fda0f04..492265d 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -635,7 +635,8 @@ static void populate_value(struct refinfo *ref)
 
 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		ref->symref = resolve_refdup(ref->refname, unused1, 1, NULL);
+		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
+					     unused1, NULL);
 		if (!ref->symref)
 			ref->symref = "";
 	}
@@ -693,7 +694,8 @@ static void populate_value(struct refinfo *ref)
 			const char *head;
 			unsigned char sha1[20];
 
-			head = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+						  sha1, NULL);
 			if (!strcmp(ref->refname, head))
 				v->s = "*";
 			else
diff --git a/builtin/fsck.c b/builtin/fsck.c
index e9ba576..a27515a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -556,7 +556,7 @@ static int fsck_head_link(void)
 	if (verbose)
 		fprintf(stderr, "Checking HEAD link\n");
 
-	head_points_at = resolve_ref_unsafe("HEAD", head_sha1, 0, &flag);
+	head_points_at = resolve_ref_unsafe("HEAD", 0, head_sha1, &flag);
 	if (!head_points_at)
 		return error("Invalid HEAD");
 	if (!strcmp(head_points_at, "HEAD"))
diff --git a/builtin/log.c b/builtin/log.c
index 1202eba..83c0b92 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1400,7 +1400,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (check_head) {
 			unsigned char sha1[20];
 			const char *ref, *v;
-			ref = resolve_ref_unsafe("HEAD", sha1, 1, NULL);
+			ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+						 sha1, NULL);
 			if (ref && skip_prefix(ref, "refs/heads/", &v))
 				branch_name = xstrdup(v);
 			else
diff --git a/builtin/merge.c b/builtin/merge.c
index 4513fad..bebbe5b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1101,7 +1101,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * Check if we are _not_ on a detached HEAD, i.e. if there is a
 	 * current branch.
 	 */
-	branch = branch_to_free = resolve_refdup("HEAD", head_sha1, 0, &flag);
+	branch = branch_to_free = resolve_refdup("HEAD", 0, head_sha1, &flag);
 	if (branch && starts_with(branch, "refs/heads/"))
 		branch += 11;
 	if (!branch || is_null_sha1(head_sha1))
diff --git a/builtin/notes.c b/builtin/notes.c
index 67d0bb1..68b6cd8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -702,7 +702,7 @@ static int merge_commit(struct notes_merge_options *o)
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);
 
 	o->local_ref = local_ref_to_free =
-		resolve_refdup("NOTES_MERGE_REF", sha1, 0, NULL);
+		resolve_refdup("NOTES_MERGE_REF", 0, sha1, NULL);
 	if (!o->local_ref)
 		die("Failed to resolve NOTES_MERGE_REF");
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index df6c337..27e9dc2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -909,7 +909,7 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, sha1, 0, &flag);
+	dst_name = resolve_ref_unsafe(buf.buf, 0, sha1, &flag);
 	strbuf_release(&buf);
 
 	if (!(flag & REF_ISSYMREF))
@@ -1070,7 +1070,7 @@ static void execute_commands(struct command *commands,
 	check_aliased_updates(commands);
 
 	free(head_name_to_free);
-	head_name = head_name_to_free = resolve_refdup("HEAD", sha1, 0, NULL);
+	head_name = head_name_to_free = resolve_refdup("HEAD", 0, sha1, NULL);
 
 	checked_connectivity = 1;
 	for (cmd = commands; cmd; cmd = cmd->next) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 9a4640d..42a533a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -567,7 +567,8 @@ static int read_remote_branches(const char *refname,
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
-		symref = resolve_ref_unsafe(refname, orig_sha1, 1, &flag);
+		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
+					    orig_sha1, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
@@ -703,7 +704,7 @@ static int mv(int argc, const char **argv)
 		int flag = 0;
 		unsigned char sha1[20];
 
-		read_ref_full(item->string, sha1, 1, &flag);
+		read_ref_full(item->string, RESOLVE_REF_READING, sha1, &flag);
 		if (!(flag & REF_ISSYMREF))
 			continue;
 		if (delete_ref(item->string, NULL, REF_NODEREF))
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 199b081..270e39c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -728,7 +728,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (ac == 0) {
 			static const char *fake_av[2];
 
-			fake_av[0] = resolve_refdup("HEAD", sha1, 1, NULL);
+			fake_av[0] = resolve_refdup("HEAD",
+						    RESOLVE_REF_READING,
+						    sha1, NULL);
 			fake_av[1] = NULL;
 			av = fake_av;
 			ac = 1;
@@ -789,7 +791,8 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 	}
 
-	head_p = resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
+	head_p = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+				    head_sha1, NULL);
 	if (head_p) {
 		head_len = strlen(head_p);
 		memcpy(head, head_p, head_len + 1);
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index b6a711d..29fb3f1 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -13,7 +13,7 @@ static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *refname = resolve_ref_unsafe(HEAD, sha1, 0, &flag);
+	const char *refname = resolve_ref_unsafe(HEAD, 0, sha1, &flag);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
diff --git a/bundle.c b/bundle.c
index 9a22ab5..fa67057 100644
--- a/bundle.c
+++ b/bundle.c
@@ -310,7 +310,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			continue;
 		if (dwim_ref(e->name, strlen(e->name), sha1, &ref) != 1)
 			continue;
-		if (read_ref_full(e->name, sha1, 1, &flag))
+		if (read_ref_full(e->name, RESOLVE_REF_READING, sha1, &flag))
 			flag = 0;
 		display_ref = (flag & REF_ISSYMREF) ? e->name : ref;
 
diff --git a/cache.h b/cache.h
index 5b86065..7200639 100644
--- a/cache.h
+++ b/cache.h
@@ -950,8 +950,8 @@ extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 extern int get_sha1_hex(const char *hex, unsigned char *sha1);
 
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
-extern int read_ref_full(const char *refname, unsigned char *sha1,
-			 int reading, int *flags);
+extern int read_ref_full(const char *refname, int resolve_flags,
+			 unsigned char *sha1, int *flags);
 extern int read_ref(const char *refname, unsigned char *sha1);
 
 /*
@@ -963,20 +963,20 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  * or the input ref.
  *
  * If the reference cannot be resolved to an object, the behavior
- * depends on the "reading" argument:
+ * depends on the RESOLVE_REF_READING flag:
  *
- * - If reading is set, return NULL.
+ * - If RESOLVE_REF_READING is set, return NULL.
  *
- * - If reading is not set, clear sha1 and return the name of the last
- *   reference name in the chain, which will either be a non-symbolic
+ * - If RESOLVE_REF_READING is not set, clear sha1 and return the name of
+ *   the last reference name in the chain, which will either be a non-symbolic
  *   reference or an undefined reference.  If this is a prelude to
  *   "writing" to the ref, the return value is the name of the ref
  *   that will actually be created or changed.
  *
- * If flag is non-NULL, set the value that it points to the
+ * If flags is non-NULL, set the value that it points to the
  * combination of REF_ISPACKED (if the reference was found among the
- * packed references) and REF_ISSYMREF (if the initial reference was a
- * symbolic reference).
+ * packed references), REF_ISSYMREF (if the initial reference was a
+ * symbolic reference) and REF_ISBROKEN (if the ref is malformed).
  *
  * If ref is not a properly-formatted, normalized reference, return
  * NULL.  If more than MAXDEPTH recursive symbolic lookups are needed,
@@ -984,8 +984,9 @@ extern int read_ref(const char *refname, unsigned char *sha1);
  *
  * errno is set to something meaningful on error.
  */
-extern const char *resolve_ref_unsafe(const char *ref, unsigned char *sha1, int reading, int *flag);
-extern char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag);
+#define RESOLVE_REF_READING 0x01
+extern const char *resolve_ref_unsafe(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
+extern char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags);
 
 extern int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref);
 extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
diff --git a/http-backend.c b/http-backend.c
index 404e682..9977c5d 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -412,7 +412,9 @@ static int show_head_ref(const char *refname, const unsigned char *sha1,
 
 	if (flag & REF_ISSYMREF) {
 		unsigned char unused[20];
-		const char *target = resolve_ref_unsafe(refname, unused, 1, NULL);
+		const char *target = resolve_ref_unsafe(refname,
+							RESOLVE_REF_READING,
+							unused, NULL);
 		const char *target_nons = strip_namespace(target);
 
 		strbuf_addf(buf, "ref: %s\n", target_nons);
diff --git a/notes-merge.c b/notes-merge.c
index fd5fae2..7eb9d7a 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -549,7 +549,7 @@ int notes_merge(struct notes_merge_options *o,
 	       o->local_ref, o->remote_ref);
 
 	/* Dereference o->local_ref into local_sha1 */
-	if (read_ref_full(o->local_ref, local_sha1, 0, NULL))
+	if (read_ref_full(o->local_ref, 0, local_sha1, NULL))
 		die("Failed to resolve local notes ref '%s'", o->local_ref);
 	else if (!check_refname_format(o->local_ref, 0) &&
 		is_null_sha1(local_sha1))
diff --git a/reflog-walk.c b/reflog-walk.c
index 0e5174b..222de76 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -48,7 +48,8 @@ static struct complete_reflogs *read_complete_reflog(const char *ref)
 		unsigned char sha1[20];
 		const char *name;
 		void *name_to_free;
-		name = name_to_free = resolve_refdup(ref, sha1, 1, NULL);
+		name = name_to_free = resolve_refdup(ref, RESOLVE_REF_READING,
+						     sha1, NULL);
 		if (name) {
 			for_each_reflog_ent(name, read_one_reflog, reflogs);
 			free(name_to_free);
@@ -174,7 +175,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		if (*branch == '\0') {
 			unsigned char sha1[20];
 			free(branch);
-			branch = resolve_refdup("HEAD", sha1, 0, NULL);
+			branch = resolve_refdup("HEAD", 0, sha1, NULL);
 			if (!branch)
 				die ("No current branch");
 
diff --git a/refs.c b/refs.c
index 6b4236a..f8d59ab 100644
--- a/refs.c
+++ b/refs.c
@@ -1251,7 +1251,9 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 					hashclr(sha1);
 					flag |= REF_ISBROKEN;
 				}
-			} else if (read_ref_full(refname.buf, sha1, 1, &flag)) {
+			} else if (read_ref_full(refname.buf,
+						 RESOLVE_REF_READING,
+						 sha1, &flag)) {
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
@@ -1376,9 +1378,9 @@ static struct ref_entry *get_packed_ref(const char *refname)
  * options are forwarded from resolve_safe_unsafe().
  */
 static const char *handle_missing_loose_ref(const char *refname,
+					    int resolve_flags,
 					    unsigned char *sha1,
-					    int reading,
-					    int *flag)
+					    int *flags)
 {
 	struct ref_entry *entry;
 
@@ -1389,12 +1391,12 @@ static const char *handle_missing_loose_ref(const char *refname,
 	entry = get_packed_ref(refname);
 	if (entry) {
 		hashcpy(sha1, entry->u.value.sha1);
-		if (flag)
-			*flag |= REF_ISPACKED;
+		if (flags)
+			*flags |= REF_ISPACKED;
 		return refname;
 	}
 	/* The reference is not a packed reference, either. */
-	if (reading) {
+	if (resolve_flags & RESOLVE_REF_READING) {
 		return NULL;
 	} else {
 		hashclr(sha1);
@@ -1403,21 +1405,20 @@ static const char *handle_missing_loose_ref(const char *refname,
 }
 
 /* This function needs to return a meaningful errno on failure */
-const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int reading, int *flag)
+const char *resolve_ref_unsafe(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
 {
 	int depth = MAXDEPTH;
 	ssize_t len;
 	char buffer[256];
 	static char refname_buffer[256];
 
-	if (flag)
-		*flag = 0;
+	if (flags)
+		*flags = 0;
 
 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
 		errno = EINVAL;
 		return NULL;
 	}
-
 	for (;;) {
 		char path[PATH_MAX];
 		struct stat st;
@@ -1443,8 +1444,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	stat_ref:
 		if (lstat(path, &st) < 0) {
 			if (errno == ENOENT)
-				return handle_missing_loose_ref(refname, sha1,
-								reading, flag);
+				return handle_missing_loose_ref(refname,
+						resolve_flags, sha1, flags);
 			else
 				return NULL;
 		}
@@ -1464,8 +1465,8 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 					!check_refname_format(buffer, 0)) {
 				strcpy(refname_buffer, buffer);
 				refname = refname_buffer;
-				if (flag)
-					*flag |= REF_ISSYMREF;
+				if (flags)
+					*flags |= REF_ISSYMREF;
 				continue;
 			}
 		}
@@ -1510,21 +1511,21 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 			 */
 			if (get_sha1_hex(buffer, sha1) ||
 			    (buffer[40] != '\0' && !isspace(buffer[40]))) {
-				if (flag)
-					*flag |= REF_ISBROKEN;
+				if (flags)
+					*flags |= REF_ISBROKEN;
 				errno = EINVAL;
 				return NULL;
 			}
 			return refname;
 		}
-		if (flag)
-			*flag |= REF_ISSYMREF;
+		if (flags)
+			*flags |= REF_ISSYMREF;
 		buf = buffer + 4;
 		while (isspace(*buf))
 			buf++;
 		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL)) {
-			if (flag)
-				*flag |= REF_ISBROKEN;
+			if (flags)
+				*flags |= REF_ISBROKEN;
 			errno = EINVAL;
 			return NULL;
 		}
@@ -1532,9 +1533,9 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 	}
 }
 
-char *resolve_refdup(const char *ref, unsigned char *sha1, int reading, int *flag)
+char *resolve_refdup(const char *ref, int resolve_flags, unsigned char *sha1, int *flags)
 {
-	const char *ret = resolve_ref_unsafe(ref, sha1, reading, flag);
+	const char *ret = resolve_ref_unsafe(ref, resolve_flags, sha1, flags);
 	return ret ? xstrdup(ret) : NULL;
 }
 
@@ -1545,22 +1546,22 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int read_ref_full(const char *refname, unsigned char *sha1, int reading, int *flags)
+int read_ref_full(const char *refname, int resolve_flags, unsigned char *sha1, int *flags)
 {
-	if (resolve_ref_unsafe(refname, sha1, reading, flags))
+	if (resolve_ref_unsafe(refname, resolve_flags, sha1, flags))
 		return 0;
 	return -1;
 }
 
 int read_ref(const char *refname, unsigned char *sha1)
 {
-	return read_ref_full(refname, sha1, 1, NULL);
+	return read_ref_full(refname, RESOLVE_REF_READING, sha1, NULL);
 }
 
 int ref_exists(const char *refname)
 {
 	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, sha1, 1, NULL);
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
 }
 
 static int filter_refs(const char *refname, const unsigned char *sha1, int flags,
@@ -1673,7 +1674,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		return 0;
 	}
 
-	if (read_ref_full(refname, base, 1, &flag))
+	if (read_ref_full(refname, RESOLVE_REF_READING, base, &flag))
 		return -1;
 
 	/*
@@ -1714,7 +1715,7 @@ static int warn_if_dangling_symref(const char *refname, const unsigned char *sha
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = resolve_ref_unsafe(refname, junk, 0, NULL);
+	resolves_to = resolve_ref_unsafe(refname, 0, junk, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
@@ -1839,7 +1840,7 @@ static int do_head_ref(const char *submodule, each_ref_fn fn, void *cb_data)
 		return 0;
 	}
 
-	if (!read_ref_full("HEAD", sha1, 1, &flag))
+	if (!read_ref_full("HEAD", RESOLVE_REF_READING, sha1, &flag))
 		return fn("HEAD", sha1, flag, cb_data);
 
 	return 0;
@@ -1919,7 +1920,7 @@ int head_ref_namespaced(each_ref_fn fn, void *cb_data)
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!read_ref_full(buf.buf, sha1, 1, &flag))
+	if (!read_ref_full(buf.buf, RESOLVE_REF_READING, sha1, &flag))
 		ret = fn(buf.buf, sha1, flag, cb_data);
 	strbuf_release(&buf);
 
@@ -2014,7 +2015,9 @@ int refname_match(const char *abbrev_name, const char *full_name)
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
 {
-	if (read_ref_full(lock->ref_name, lock->old_sha1, mustexist, NULL)) {
+	if (read_ref_full(lock->ref_name,
+			  mustexist ? RESOLVE_REF_READING : 0,
+			  lock->old_sha1, NULL)) {
 		int save_errno = errno;
 		error("Can't verify ref %s", lock->ref_name);
 		unlock_ref(lock);
@@ -2087,7 +2090,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
-		r = resolve_ref_unsafe(fullref, this_result, 1, &flag);
+		r = resolve_ref_unsafe(fullref, RESOLVE_REF_READING,
+				       this_result, &flag);
 		if (r) {
 			if (!refs_found++)
 				*ref = xstrdup(r);
@@ -2116,7 +2120,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		const char *ref, *it;
 
 		mksnpath(path, sizeof(path), *p, len, str);
-		ref = resolve_ref_unsafe(path, hash, 1, NULL);
+		ref = resolve_ref_unsafe(path, RESOLVE_REF_READING,
+					 hash, NULL);
 		if (!ref)
 			continue;
 		if (reflog_exists(path))
@@ -2151,6 +2156,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int last_errno = 0;
 	int type, lflags;
 	int mustexist = (old_sha1 && !is_null_sha1(old_sha1));
+	int resolve_flags = 0;
 	int missing = 0;
 	int attempts_remaining = 3;
 
@@ -2162,7 +2168,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
-	refname = resolve_ref_unsafe(refname, lock->old_sha1, mustexist, &type);
+	if (mustexist)
+		resolve_flags |= RESOLVE_REF_READING;
+
+	refname = resolve_ref_unsafe(refname, resolve_flags,
+				     lock->old_sha1, &type);
 	if (!refname && errno == EISDIR) {
 		/* we are trying to lock foo but we used to
 		 * have foo/bar which now does not exist;
@@ -2175,7 +2185,8 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 			error("there are still refs under '%s'", orig_refname);
 			goto error_return;
 		}
-		refname = resolve_ref_unsafe(orig_refname, lock->old_sha1, mustexist, &type);
+		refname = resolve_ref_unsafe(orig_refname, resolve_flags,
+					     lock->old_sha1, &type);
 	}
 	if (type_p)
 	    *type_p = type;
@@ -2517,7 +2528,7 @@ static int curate_packed_ref_fn(struct ref_entry *entry, void *cb_data)
 		unsigned char sha1[20];
 		int flags;
 
-		if (read_ref_full(entry->name, sha1, 0, &flags))
+		if (read_ref_full(entry->name, 0, sha1, &flags))
 			/* We should at least have found the packed ref. */
 			die("Internal error");
 		if ((flags & REF_ISSYMREF) || !(flags & REF_ISPACKED)) {
@@ -2721,7 +2732,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	if (log && S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldrefname);
 
-	symref = resolve_ref_unsafe(oldrefname, orig_sha1, 1, &flag);
+	symref = resolve_ref_unsafe(oldrefname, RESOLVE_REF_READING,
+				    orig_sha1, &flag);
 	if (flag & REF_ISSYMREF)
 		return error("refname %s is a symbolic ref, renaming it is not supported",
 			oldrefname);
@@ -2740,7 +2752,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 		goto rollback;
 	}
 
-	if (!read_ref_full(newrefname, sha1, 1, NULL) &&
+	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
 	    delete_ref(newrefname, sha1, REF_NODEREF)) {
 		if (errno==EISDIR) {
 			if (remove_empty_directories(git_path("%s", newrefname))) {
@@ -3018,7 +3030,8 @@ static int write_ref_sha1(struct ref_lock *lock,
 		unsigned char head_sha1[20];
 		int head_flag;
 		const char *head_ref;
-		head_ref = resolve_ref_unsafe("HEAD", head_sha1, 1, &head_flag);
+		head_ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
+					      head_sha1, &head_flag);
 		if (head_ref && (head_flag & REF_ISSYMREF) &&
 		    !strcmp(head_ref, lock->ref_name))
 			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
@@ -3389,7 +3402,7 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
 				retval = do_for_each_reflog(name, fn, cb_data);
 			} else {
 				unsigned char sha1[20];
-				if (read_ref_full(name->buf, sha1, 0, NULL))
+				if (read_ref_full(name->buf, 0, sha1, NULL))
 					retval = error("bad ref for %s", name->buf);
 				else
 					retval = fn(name->buf, sha1, 0, cb_data);
diff --git a/remote.c b/remote.c
index ce785f8..f624217 100644
--- a/remote.c
+++ b/remote.c
@@ -508,7 +508,7 @@ static void read_config(void)
 		return;
 	default_remote_name = "origin";
 	current_branch = NULL;
-	head_ref = resolve_ref_unsafe("HEAD", sha1, 0, &flag);
+	head_ref = resolve_ref_unsafe("HEAD", 0, sha1, &flag);
 	if (head_ref && (flag & REF_ISSYMREF) &&
 	    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 		current_branch = make_branch(head_ref, 0);
@@ -1138,7 +1138,8 @@ static char *guess_ref(const char *name, struct ref *peer)
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char sha1[20];
 
-	const char *r = resolve_ref_unsafe(peer->name, sha1, 1, NULL);
+	const char *r = resolve_ref_unsafe(peer->name, RESOLVE_REF_READING,
+					   sha1, NULL);
 	if (!r)
 		return NULL;
 
@@ -1199,7 +1200,9 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		unsigned char sha1[20];
 		int flag;
 
-		dst_value = resolve_ref_unsafe(matched_src->name, sha1, 1, &flag);
+		dst_value = resolve_ref_unsafe(matched_src->name,
+					       RESOLVE_REF_READING,
+					       sha1, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
@@ -1673,7 +1676,7 @@ static int ignore_symref_update(const char *refname)
 	unsigned char sha1[20];
 	int flag;
 
-	if (!resolve_ref_unsafe(refname, sha1, 0, &flag))
+	if (!resolve_ref_unsafe(refname, 0, sha1, &flag))
 		return 0; /* non-existing refs are OK */
 	return (flag & REF_ISSYMREF);
 }
diff --git a/sequencer.c b/sequencer.c
index 47aac75..a03d4fa 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -331,7 +331,7 @@ static int is_index_unchanged(void)
 	unsigned char head_sha1[20];
 	struct commit *head_commit;
 
-	if (!resolve_ref_unsafe("HEAD", head_sha1, 1, NULL))
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_sha1, NULL))
 		return error(_("Could not resolve HEAD commit\n"));
 
 	head_commit = lookup_commit(head_sha1);
@@ -871,7 +871,7 @@ static int rollback_single_pick(void)
 	if (!file_exists(git_path("CHERRY_PICK_HEAD")) &&
 	    !file_exists(git_path("REVERT_HEAD")))
 		return error(_("no cherry-pick or revert in progress"));
-	if (read_ref_full("HEAD", head_sha1, 0, NULL))
+	if (read_ref_full("HEAD", 0, head_sha1, NULL))
 		return error(_("cannot resolve HEAD"));
 	if (is_null_sha1(head_sha1))
 		return error(_("cannot abort from a branch yet to be born"));
diff --git a/transport-helper.c b/transport-helper.c
index 2b24d51..9b29620 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -897,7 +897,10 @@ static int push_refs_with_export(struct transport *transport,
 					int flag;
 
 					/* Follow symbolic refs (mainly for HEAD). */
-					name = resolve_ref_unsafe(ref->peer_ref->name, sha1, 1, &flag);
+					name = resolve_ref_unsafe(
+						 ref->peer_ref->name,
+						 RESOLVE_REF_READING,
+						 sha1, &flag);
 					if (!name || !(flag & REF_ISSYMREF))
 						name = ref->peer_ref->name;
 
diff --git a/transport.c b/transport.c
index 055d2a2..b56620e 100644
--- a/transport.c
+++ b/transport.c
@@ -168,7 +168,8 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		/* Follow symbolic refs (mainly for HEAD). */
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
-		tmp = resolve_ref_unsafe(localname, sha, 1, &flag);
+		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING,
+					 sha, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
 			localname = tmp;
@@ -743,7 +744,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	unsigned char head_sha1[20];
 	char *head;
 
-	head = resolve_refdup("HEAD", head_sha1, 1, NULL);
+	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
 
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
diff --git a/upload-pack.c b/upload-pack.c
index c789ec0..ac9ac15 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -744,7 +744,7 @@ static int find_symref(const char *refname, const unsigned char *sha1, int flag,
 
 	if ((flag & REF_ISSYMREF) == 0)
 		return 0;
-	symref_target = resolve_ref_unsafe(refname, unused, 0, &flag);
+	symref_target = resolve_ref_unsafe(refname, 0, unused, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, refname);
diff --git a/wt-status.c b/wt-status.c
index 1bf5d72..f367066 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -128,7 +128,7 @@ void wt_status_prepare(struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = -1;
 	s->relative_paths = 1;
-	s->branch = resolve_refdup("HEAD", sha1, 0, NULL);
+	s->branch = resolve_refdup("HEAD", 0, sha1, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
-- 
2.1.0.rc2.206.gedb03e5
