From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 14/17] commit: teach --gpg-sign option
Date: Tue,  8 Nov 2011 17:02:00 -0800
Message-ID: <1320800523-5407-15-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ2-0003z8-QR
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754504Ab1KIBCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227Ab1KIBCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:37 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1923B5BA5
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=sHhJ
	+vsxIGmTwkiSR6Nt+8pkJlg=; b=JgbXxSshSAKk2hhaUnwnuY/zvVTMHfTDE2wQ
	OvLykZJS9yY8zcVsn7Yx+hpSai2oBfkpv7guHRLuTcT2eoYazFh6/YNNSF0CLz6Z
	6SGzfOiEqcOk0l4DQ+zMxE65tYzZjqazSQ1tT0a3JrKlWGw2lyXIRrSvDiLgHhjg
	pAUF8jQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=F6vg4E
	o9onUJXWsYwH70DqgW2z+2Ztk9xXrp3CujDKL6Wm/9chGAQjn91/djJomkef5ihy
	ktK3M6xGMe8TaQ64y38kUQsjkhuqSqOLtpS541CjvINGjeYq95i630jy/mdKUR5K
	kI/HL7Ct6YJEFLjd9POqfCmtsBdaLvmX5FBTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10A4E5BA4
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6B875BA2 for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:35 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8312C760-0A6E-11E1-8EA1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185135>

This uses the gpg-interface.[ch] to allow signing the commit, i.e.

    $ git commit --gpg-sign -m foo
    You need a passphrase to unlock the secret key for
    user: "Junio C Hamano <gitster@pobox.com>"
    4096-bit RSA key, ID 96AFE6CB, created 2011-10-03 (main key ID 713660A7)

    [master 8457d13] foo
     1 files changed, 1 insertions(+), 0 deletions(-)

The lines of GPG detached signature are placed in a new multi-line header
field, instead of tucking the signature block at the end of the commit log
message text (similar to how signed tag is done), for multiple reasons:

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
     Version: GnuPG v1.4.10 (GNU/Linux)

     iQIcBAABAgAGBQJOjPtrAAoJELC16IaWr+bL4TMP/RSe2Y/jYnCkds9unO5JEnfG
     ...
     =dt98
     -----END PGP SIGNATURE-----

    foo

but "git log" (unless you ask for it with --pretty=raw) output is not
cluttered with the signature information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit-tree.c |   24 +++++++++++++++++++++---
 builtin/commit.c      |   11 ++++++++++-
 builtin/merge.c       |   16 ++++++++++++++--
 commit.c              |   48 +++++++++++++++++++++++++++++++++++++++++++++---
 commit.h              |    4 ++--
 notes-cache.c         |    2 +-
 notes-merge.c         |    2 +-
 7 files changed, 94 insertions(+), 13 deletions(-)

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
index fca7ea0..7e8a1cf 100644
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
@@ -1324,6 +1329,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1,
 static int git_commit_config(const char *k, const char *v, void *cb)
 {
 	struct wt_status *s = cb;
+	int status;
 
 	if (!strcmp(k, "commit.template"))
 		return git_config_pathname(&template_file, k, v);
@@ -1332,6 +1338,9 @@ static int git_commit_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
 	return git_status_config(k, v, s);
 }
 
@@ -1488,7 +1497,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		extra = read_commit_extra_headers(current_head);
 
 	if (commit_tree_extended(sb.buf, active_cache_tree->sha1, parents, sha1,
-				 author_ident.buf, extra)) {
+				 author_ident.buf, sign_commit, extra)) {
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
diff --git a/builtin/merge.c b/builtin/merge.c
index 3b3e374..b810e2e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -26,6 +26,7 @@
 #include "merge-recursive.h"
 #include "resolve-undo.h"
 #include "remote.h"
+#include "gpg-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -62,6 +63,7 @@ static int allow_rerere_auto;
 static int abort_current_merge;
 static int show_progress = -1;
 static int default_to_upstream;
+static const char *sign_commit;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -207,6 +209,8 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOLEAN(0, "abort", &abort_current_merge,
 		"abort the current in-progress merge"),
 	OPT_SET_INT(0, "progress", &show_progress, "force progress reporting", 1),
+	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, "key id",
+	  "GPG sign commit", PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_END()
 };
 
@@ -533,6 +537,8 @@ static void parse_branch_merge_options(char *bmo)
 
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
+	int status;
+
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
 		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
@@ -570,6 +576,10 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
 	}
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
 	return git_diff_ui_config(k, v, cb);
 }
 
@@ -902,7 +912,8 @@ static int merge_trivial(struct commit *head)
 	parent->next->item = remoteheads->item;
 	parent->next->next = NULL;
 	prepare_to_commit();
-	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL);
+	commit_tree(merge_msg.buf, result_tree, parent, result_commit, NULL,
+		    sign_commit);
 	finish(head, result_commit, "In-index merge");
 	drop_save();
 	return 0;
@@ -933,7 +944,8 @@ static int finish_automerge(struct commit *head,
 	strbuf_addch(&merge_msg, '\n');
 	prepare_to_commit();
 	free_commit_list(remoteheads);
-	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
+	commit_tree(merge_msg.buf, result_tree, parents, result_commit,
+		    NULL, sign_commit);
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, result_commit, buf.buf);
 	strbuf_release(&buf);
diff --git a/commit.c b/commit.c
index 1c05879..a5c53b3 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "gpg-interface.h"
 
 int save_commit_buffer = 1;
 
@@ -840,6 +841,42 @@ struct commit_list *reduce_heads(struct commit_list *heads)
 	return result;
 }
 
+static const char gpg_sig_header[] = "gpgsig";
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
+		if (!copypos) {
+			strbuf_insert(buf, inspos, gpg_sig_header, gpg_sig_header_len);
+			inspos += gpg_sig_header_len;
+		}
+		strbuf_insert(buf, inspos++, " ", 1);
+		strbuf_insert(buf, inspos, bol, len);
+		inspos += len;
+		copypos += len;
+	}
+	strbuf_release(&sig);
+	return 0;
+}
+
 static void handle_signed_tag(struct commit *parent, struct commit_extra_header ***tail)
 {
 	struct merge_remote_desc *desc;
@@ -969,13 +1006,14 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 
 int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
-		const char *author)
+		const char *author, const char *sign_commit)
 {
 	struct commit_extra_header *extra = NULL, **tail = &extra;
 	int result;
 
 	append_merge_tag_headers(parents, &tail);
-	result = commit_tree_extended(msg, tree, parents, ret, author, extra);
+	result = commit_tree_extended(msg, tree, parents, ret,
+				      author, sign_commit, extra);
 	free_commit_extra_headers(extra);
 	return result;
 }
@@ -987,7 +1025,8 @@ static const char commit_utf8_warn[] =
 
 int commit_tree_extended(const char *msg, unsigned char *tree,
 			 struct commit_list *parents, unsigned char *ret,
-			 const char *author, struct commit_extra_header *extra)
+			 const char *author, const char *sign_commit,
+			 struct commit_extra_header *extra)
 {
 	int result;
 	int encoding_is_utf8;
@@ -1037,6 +1076,9 @@ int commit_tree_extended(const char *msg, unsigned char *tree,
 	if (encoding_is_utf8 && !is_utf8(buffer.buf))
 		fprintf(stderr, commit_utf8_warn);
 
+	if (sign_commit && do_sign_commit(&buffer, sign_commit))
+		return -1;
+
 	result = write_sha1_file(buffer.buf, buffer.len, commit_type, ret);
 	strbuf_release(&buffer);
 	return result;
diff --git a/commit.h b/commit.h
index 3745f12..d2c3e65 100644
--- a/commit.h
+++ b/commit.h
@@ -193,11 +193,11 @@ extern void append_merge_tag_headers(struct commit_list *parents,
 
 extern int commit_tree(const char *msg, unsigned char *tree,
 		       struct commit_list *parents, unsigned char *ret,
-		       const char *author);
+		       const char *author, const char *sign_commit);
 
 extern int commit_tree_extended(const char *msg, unsigned char *tree,
 				struct commit_list *parents, unsigned char *ret,
-				const char *author,
+				const char *author, const char *sign_commit,
 				struct commit_extra_header *);
 
 extern struct commit_extra_header *read_commit_extra_headers(struct commit *);
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
index e9e4199..61cf18e 100644
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
1.7.8.rc1.82.g90e080
