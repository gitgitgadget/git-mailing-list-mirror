From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/3] commit: teach --gpg-sign option
Date: Tue, 18 Oct 2011 17:20:44 -0700
Message-ID: <1318983645-18897-3-git-send-email-gitster@pobox.com>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <1318983645-18897-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 02:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGJu4-0007Gr-88
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 02:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1JSAUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 20:20:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48303 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323Ab1JSAUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 20:20:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F377744E0
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aeyO
	yVS3C8CnZcb/aOWbOZHf3Uk=; b=rYByDznwjVo0fXCzc3tkrPIxL0yZsSK8XCb+
	s5h/lABJ8tm5NaxrksqtK8hxAiIqaBwsId9Y8MM7uP3SzOP7Pn+jjeaIjxcvS5x4
	q5SfC0ejW0Rviu/TY95xklU3aaR5KzUYwbLSwvYhimrHiKFwXD16E/s3Pf/4S+xw
	vjek9AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=PGJx58
	cdU1VecXa28NBp+jyCUAYIbNOnIdk2hpp84nsP/MHpTK6i59rTZssuDTtmGIYbp+
	iIv3woCusncvAMI95QXqZ5yzFqvFBEM0PmtAkGeEIxd/HfbUvZ9iqVBOBRKRDxrn
	XS1CIRu6S0ful8gXtxnCKhT82j8Y17lBWpjn0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E99BA44DF
	for <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E81444DE for
 <git@vger.kernel.org>; Tue, 18 Oct 2011 20:20:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.388.g3a4b7
In-Reply-To: <1318983645-18897-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 335EBC92-F9E8-11E0-B00B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183911>

And this uses the gpg-interface.[ch] to allow signing the commit, i.e.

    $ git commit --gpg-sign -m foo
    You need a passphrase to unlock the secret key for
    user: "Junio C Hamano <gitster@pobox.com>"
    4096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID 713660A7)

    [master 8457d13] foo
     1 files changed, 1 insertions(+), 0 deletions(-)

The lines of GPG detached signature are placed in new header lines, after
the standard tree/parent/author/committer headers, instead of tucking the
signature block at the end of the commit log message text (similar to how
signed tag is done), for multiple reasons:

 - The signature won't clutter output from "git log" and friends if it is
   in the extra header. If we place it at the end of the log message, we
   would need to teach "git log" and friends to strip the signature block
   with an option.

 - Teaching new versions of "git log" and "gitk" to optionally verify and
   show signatures is cleaner if we structurally know where the signature
   block is (instead of scanning in the commit log message).

 - The signature needs to be stripped upon various commit rewriting
   operations, e.g. rebase, filter-branch, etc. They all already ignore
   unknown headers, but if we place signature in the log message, all of
   these tools (and third-party tools) also need to learn how a signature
   block would look like.

 - When we added the optional encoding header, all the tools (both in tree
   and third-party) that acts on the raw commit object should have been
   fixed to ignore headers they do not understand, so it is not like that
   new header would be more likely to break than extra text in the commit.

A commit made with the above sample sequence would look like this:

    $ git cat-file commit HEAD
    tree 3cd71d90e3db4136e5260ab54599791c4f883b9d
    parent b87755351a47b09cb27d6913e6e0e17e6254a4d4
    author Junio C Hamano <gitster@pobox.com> 1317862251 -0700
    committer Junio C Hamano <gitster@pobox.com> 1317862251 -0700
    gpgsig -----BEGIN PGP SIGNATURE-----
    gpgsig Version: GnuPG v1.4.10 (GNU/Linux)
    gpgsig
    gpgsig iQIcBAABAgAGBQJOjPtrAAoJELC16IaWr+bL4TMP/RSe2Y/jYnCkds9unO5JEnfG
    gpgsig ...
    gpgsig =dt98
    gpgsig -----END PGP SIGNATURE-----

    foo

but "git log" (unless you ask for it with --pretty=raw) output is not
cluttered with the signature information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The header field was updated from "sig" to "gpgsig" so that later we
   won't have to regret the choice when we introduce different kind of
   signature mechanism.

 builtin/commit-tree.c |   24 +++++++++++++++++++++---
 builtin/commit.c      |   12 ++++++++++--
 builtin/merge.c       |   16 ++++++++++++++--
 commit.c              |   40 +++++++++++++++++++++++++++++++++++++++-
 commit.h              |    2 +-
 notes-cache.c         |    2 +-
 notes-merge.c         |    2 +-
 7 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d083795..a17811f 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -8,8 +8,9 @@
 #include "tree.h"
 #include "builtin.h"
 #include "utf8.h"
+#include "gpg-interface.h"
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [(-p <sha1>)...] < changelog";
+static const char commit_tree_usage[] = "git commit-tree [-S<signer>] <sha1> [(-p <sha1>)...] < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
@@ -25,6 +26,14 @@ static void new_parent(struct commit *parent, struct commit_list **parents_p)
 	commit_list_insert(parent, parents_p);
 }
 
+static int commit_tree_config(const char *var, const char *value, void *cb)
+{
+	int status = git_gpg_config(var, value, NULL);
+	if (status)
+		return status;
+	return git_default_config(var, value, cb);
+}
+
 int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -32,11 +41,19 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 	struct strbuf buffer = STRBUF_INIT;
+	const char *sign_commit = NULL;
 
-	git_config(git_default_config, NULL);
+	git_config(commit_tree_config, NULL);
 
 	if (argc < 2 || !strcmp(argv[1], "-h"))
 		usage(commit_tree_usage);
+
+	if (!memcmp(argv[1], "-S", 2)) {
+		sign_commit = argv[1] + 2;
+		argv++;
+		argc--;
+	}
+
 	if (get_sha1(argv[1], tree_sha1))
 		die("Not a valid object name %s", argv[1]);
 
@@ -56,7 +73,8 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	if (strbuf_read(&buffer, 0, 0) < 0)
 		die_errno("git commit-tree: failed to read");
 
-	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1, NULL)) {
+	if (commit_tree(buffer.buf, tree_sha1, parents, commit_sha1,
+			NULL, sign_commit)) {
 		strbuf_release(&buffer);
 		return 1;
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index cbc9613..90cf7e8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -26,6 +26,7 @@
 #include "unpack-trees.h"
 #include "quote.h"
 #include "submodule.h"
+#include "gpg-interface.h"
 
 static const char * const builtin_commit_usage[] = {
 	"git commit [options] [--] <filepattern>...",
@@ -85,6 +86,8 @@ static int all, edit_flag, also, interactive, patch_interactive, only, amend, si
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
+static char *sign_commit;
+
 /*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
@@ -144,6 +147,8 @@ static struct option builtin_commit_options[] = {
 	OPT_BOOLEAN('e', "edit", &edit_flag, "force edit of commit"),
 	OPT_STRING(0, "cleanup", &cleanup_arg, "default", "how to strip spaces and #comments from message"),
 	OPT_BOOLEAN(0, "status", &include_status, "include status in commit message template"),
+	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
+	  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	/* end commit message options */
 
 	OPT_GROUP("Commit contents options"),
@@ -1323,6 +1328,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
+	int status;
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
@@ -1330,7 +1336,9 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		include_status = git_config_bool(k, v);
 		return 0;
 	}
-
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
 	return git_status_config(k, v, s);
 }
 
@@ -1481,7 +1489,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	if (commit_tree(sb.buf, active_cache_tree->sha1, parents, sha1,
-			author_ident.buf)) {
+			author_ident.buf, sign_commit)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index ab4077f..53cff02 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -26,6 +26,7 @@
 #include "merge-recursive.h"
 #include "resolve-undo.h"
 #include "remote.h"
+#include "gpg-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -63,6 +64,7 @@ static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
+static const char *sign_commit;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -206,6 +208,8 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
 		"abort the current in-progress merge"),
 	OPT_SET_INT(0, "progress", &show_progress, "force progress reporting", 1),
+	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
+	  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_END()
 };
 
@@ -525,6 +529,8 @@ static void parse_branch_merge_options(char *bmo)
 
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
+	int status;
+
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
 		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
@@ -562,6 +568,10 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
 	}
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
 	return git_diff_ui_config(k, v, cb);
 }
 
@@ -870,7 +880,8 @@ static int merge_trivial(void)
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
 	run_prepare_commit_msg();
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL,
+		    sign_commit);
 	finish(result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -900,7 +911,8 @@ static int finish_automerge(struct commit_list *common,
 	free_commit_list(remoteheads);
 	strbuf_addch(&merge_msg, '\n');
 	run_prepare_commit_msg();
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
+	commit_tree(merge_msg.buf, result_tree, parents, result_commit,
+		    NULL, sign_commit);
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
diff --git a/commit.c b/commit.c
index 97b4327..4bff3cd 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "gpg-interface.h"
 
 int save_commit_buffer = 1;
 
@@ -814,6 +815,40 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static const char gpg_sig_header[] = "gpgsig ";
+static const int gpg_sig_header_len = sizeof(gpg_sig_header) - 1;
+
+static int do_sign_commit(struct strbuf *buf, const char *keyid)
+{
+	struct strbuf sig = STRBUF_INIT;
+	int inspos, copypos;
+
+	/* find the end of the header */
+	inspos = strstr(buf->buf, "\n\n") - buf->buf + 1;
+
+	if (!keyid || !*keyid)
+		keyid = get_signing_key();
+	if (sign_buffer(buf, &sig, keyid)) {
+		strbuf_release(&sig);
+		return -1;
+	}
+
+	for (copypos = 0; sig.buf[copypos]; ) {
+		const char *bol = sig.buf + copypos;
+		const char *eol = strchrnul(bol, '\n');
+		int len = (eol - bol) + !!*eol;
+
+		strbuf_insert(buf, inspos, gpg_sig_header, gpg_sig_header_len);
+		inspos += gpg_sig_header_len;
+		strbuf_insert(buf, inspos, bol, len);
+		inspos += len;
+		copypos += len;
+	}
+	strbuf_release(&sig);
+	return 0;
+}
+
+
 static const char commit_utf8_warn[] =
 "Warning: commit message does not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
@@ -821,7 +856,7 @@ static const char commit_utf8_warn[] =
 
 int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
-		const char *author)
+		const char *author, const char *sign_commit)
 {
 	int result;
 	int encoding_is_utf8;
@@ -864,6 +899,9 @@ int commit_tree(const char *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
+	if (sign_commit && do_sign_commit(&buffer, sign_commit))
+		return -1;
+
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
 	return result;
diff --git a/commit.h b/commit.h
index 12d100b8..8c2419b 100644
--- a/commit.h
+++ b/commit.h
@@ -175,6 +175,6 @@ struct commit_list *reduce_heads(struct commit_list *heads);
 
 extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
-		const char *author);
+		       const char *author, const char *sign_commit);
 
 #endif /* COMMIT_H */
diff --git a/notes-cache.c b/notes-cache.c
index 4c8984e..c36a960 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -56,7 +56,7 @@ int notes_cache_write(struct notes_cache *c)
 
 	if (write_notes_tree(&c->tree, tree_sha1))
 		return -1;
-	if (commit_tree(c->validity, tree_sha1, NULL, commit_sha1, NULL) < 0)
+	if (commit_tree(c->validity, tree_sha1, NULL, commit_sha1, NULL, NULL) < 0)
 		return -1;
 	if (update_ref("update notes cache", c->tree.ref, commit_sha1, NULL,
 		       0, QUIET_ON_ERR) < 0)
diff --git a/notes-merge.c b/notes-merge.c
index e1aaf43..c29c434 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -546,7 +546,7 @@ void create_notes_commit(struct notes_tree *t, struct commit_list *parents,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
 
-	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL))
+	if (commit_tree(msg, tree_sha1, parents, result_sha1, NULL, NULL))
 		die("Failed to commit notes tree to database");
 }
 
-- 
1.7.7.388.g3a4b7
