Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6FDC433EF
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359756AbiDCSY6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359742AbiDCSYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 14:24:50 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7B838BC7
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 11:22:55 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9D3AB5A3EA;
        Sun,  3 Apr 2022 18:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649010174;
        bh=uTc3srZhypW8DHhObDqqm7vRXu/3ewVAdnhVKtVu93I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=j79rSGcEmrhlico1ymzMnUTmiYVEGOBsnS0zKREdMZSs4fjgDGXvBycP1MtXbXVGx
         y7NKnCs7amNrHprb7X56oPuVHqRiRD/AbNXhuNCJJyJOwhx3TN3oIL3ewBL8UOIrsm
         pb9NsaeBImN/1HegBXnexDViLhvbmnMYBDfQV5ndEsEoTXdX4HQYxsf4EQyHjltqk3
         /Jx08bW+pnL9L4u1s8gLXpPi/wwmTXYe36dQBvXtft+R3KgjNgRlEGwpjC87OJrCpP
         GNeHn0ASZ5LCEQq1jS9Iu8t2T97UqF8voEXAAFwV3O2gHF/T3sTudjstqtKvS4YcuV
         HU18VFFi0Z+LVFReJGpgiaR95GpYATawc1N/T3Gtys05WGvSRev3Fdtg03RnehOfiT
         R/kERzRVzrKUA7owBgEQMlq7Q2cg6Uu//ABETYSHANd/rd1WkSi8dmMvwwc8jnuVMz
         yUyfD3cB+yBfc4GRg8p5xSukC1QWXKQWmBeXJ77D7trskGHTX/B
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] builtin/stash: provide a way to export stashes to a ref
Date:   Sun,  3 Apr 2022 18:22:49 +0000
Message-Id: <20220403182250.904933-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220403182250.904933-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220403182250.904933-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A common user problem is how to sync in-progress work to another
machine.  Users currently must use some sort of transfer of the working
tree, which poses security risks and also necessarily causes the index
to become dirty.  The experience is suboptimal and frustrating for
users.

A reasonable idea is to use the stash for this purpose, but the stash is
stored in the reflog, not in a ref, and as such it cannot be pushed or
pulled.  This also means that it cannot be saved into a bundle or
preserved elsewhere, which is a problem when using throwaway development
environments.

Let's solve this problem by allowing the user to export the stash to a
ref (or, to just write it into the repository and print the hash, à la
git commit-tree).  Introduce git stash export, which writes a chain of
commits where the first parent is always a chain to the previous stash,
or to a single, empty commit (for the final item) and the second is the
stash commit normally written to the reflog.

Iterate over each stash from topmost to bottomost, looking up the data
for each one, and then create the chain from the single empty commit
back up in reverse order.  Generate a predictable empty commit so our
behavior is reproducible.  Create a useful commit message, preserving
the author and committer information, to help users identify stash
commits when viewing them as normal commits.

If the user has specified specific stashes they'd like to export
instead, use those instead of iterating over all of the stashes.

As part of this, specifically request quiet behavior when looking up the
OID for a revision because we will eventually hit a revision that
doesn't exist and we don't want to die when that occurs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-stash.txt |  22 ++++-
 builtin/stash.c             | 184 ++++++++++++++++++++++++++++++++++++
 2 files changed, 205 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 6e15f47525..162110314e 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
+'git stash' export ( --print | --to-ref <ref> ) [<stash>...]
 
 DESCRIPTION
 -----------
@@ -151,6 +152,12 @@ store::
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
 
+export ( --print | --to-ref <ref> ) [<stash>...]::
+
+	Export the specified stashes, or all of them if none are specified, to
+	a chain of commits which can be transferred using the normal fetch and
+	push mechanisms, then imported using the `import` subcommand.
+
 OPTIONS
 -------
 -a::
@@ -239,6 +246,19 @@ literally (including newlines and quotes).
 +
 Quiet, suppress feedback messages.
 
+--print::
+	This option is only valid for `export`.
++
+Create the chain of commits representing the exported stashes without
+storing it anywhere in the ref namespace and print the object ID to
+standard output.  This is designed for scripts.
+
+--to-ref::
+	This option is only valid for `export`.
++
+Create the chain of commits representing the exported stashes and store
+it to the specified ref.
+
 \--::
 	This option is only valid for `push` command.
 +
@@ -256,7 +276,7 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 <stash>::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
-	`show` commands.
+	`show`, and `export` commands.
 +
 A reference of the form `stash@{<revision>}`. When no `<stash>` is
 given, the latest stash is assumed (that is, `stash@{0}`).
diff --git a/builtin/stash.c b/builtin/stash.c
index 4c281a5781..89e22d0cdd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -33,6 +33,7 @@ static const char * const git_stash_usage[] = {
 	   "          [--] [<pathspec>...]]"),
 	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	N_("git stash export (--print | --to-ref <ref>) [<stash>...]"),
 	NULL
 };
 
@@ -89,6 +90,12 @@ static const char * const git_stash_save_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_export_usage[] = {
+	N_("git stash export (--print | --to-ref <ref>) [<stash>...]"),
+	NULL
+};
+
+
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -1773,6 +1780,181 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static int write_commit_with_parents(struct object_id *out, const struct object_id *oid, struct commit_list *parents)
+{
+	size_t author_len, committer_len;
+	struct commit *this;
+	const char *orig_author, *orig_committer;
+	char *author = NULL, *committer = NULL;
+	const char *buffer;
+	unsigned long bufsize;
+	const char *p;
+	struct strbuf msg = STRBUF_INIT;
+	int ret = 0;
+
+	this = lookup_commit_reference(the_repository, oid);
+	buffer = get_commit_buffer(this, &bufsize);
+	orig_author = find_commit_header(buffer, "author", &author_len);
+	orig_committer = find_commit_header(buffer, "committer", &committer_len);
+	p = memmem(buffer, bufsize, "\n\n", 2);
+
+	if (!orig_author || !orig_committer || !p) {
+		error(_("cannot parse commit %s"), oid_to_hex(oid));
+		goto out;
+	}
+	/* Jump to message. */
+	p += 2;
+	strbuf_addstr(&msg, "git stash: ");
+	strbuf_add(&msg, p, bufsize - (p - buffer));
+
+	author = xmemdupz(orig_author, author_len);
+	committer = xmemdupz(orig_committer, committer_len);
+
+	if (commit_tree_extended(msg.buf, msg.len,
+				 the_hash_algo->empty_tree, parents,
+				 out, author, committer,
+				 NULL, NULL)) {
+		ret = -1;
+		error(_("could not write commit"));
+		goto out;
+	}
+out:
+	strbuf_reset(&msg);
+	unuse_commit_buffer(this, buffer);
+	free(author);
+	free(committer);
+	return ret;
+}
+
+static int do_export_stash(const char *ref, size_t argc, const char **argv)
+{
+	struct object_id base;
+	struct object_context unused;
+	struct commit *prev;
+	struct object_id *items = NULL;
+	int nitems = 0, nalloc = 0;
+	int res = 0;
+	int i;
+	struct strbuf revision = STRBUF_INIT;
+	const char *author, *committer;
+
+	/*
+	 * This is an arbitrary, fixed date, specifically the one used by git
+	 * format-patch.  The goal is merely to produce reproducible output.
+	 */
+	prepare_fallback_ident("git stash", "git@stash");
+	author = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT, "2001-09-17T00:00:00Z", 0);
+	committer = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT, "2001-09-17T00:00:00Z", 0);
+
+	/* First, we create a single empty commit. */
+	if (commit_tree_extended(NULL, 0, the_hash_algo->empty_tree, NULL, &base, author, committer, NULL, NULL))
+		return error(_("unable to write base commit"));
+
+	prev = lookup_commit_reference(the_repository, &base);
+
+	if (argc) {
+		/*
+		 * Find each specified stash, and load data into the array.
+		 */
+		for (i = 0; i < argc; i++) {
+			ALLOC_GROW_BY(items, nitems, 1, nalloc);
+			if (parse_revision(&revision, argv[i], 0) ||
+			    get_oid_with_context(the_repository, revision.buf,
+						 GET_OID_QUIETLY | GET_OID_GENTLY,
+						 &items[i], &unused)) {
+				error(_("unable to find stash entry %s"), argv[i]);
+				res = -1;
+				goto out;
+			}
+		}
+	} else {
+		/*
+		 * Walk the reflog, finding each stash entry, and load data into the
+		 * array.
+		 */
+		for (i = 0;; i++) {
+			char buf[32];
+			struct object_id oid;
+
+			snprintf(buf, sizeof(buf), "%d", i);
+			if (parse_revision(&revision, buf, 1) ||
+			    get_oid_with_context(the_repository, revision.buf,
+						 GET_OID_QUIETLY | GET_OID_GENTLY,
+						 &oid, &unused))
+				break;
+			ALLOC_GROW_BY(items, nitems, 1, nalloc);
+			oidcpy(&items[i], &oid);
+		}
+	}
+
+	/*
+	 * Now, create a set of commits identical to the regular stash commits,
+	 * but where their first parents form a chain to our original empty
+	 * base commit.
+	 */
+	for (i = nitems - 1; i >= 0; i--) {
+		struct commit_list *parents = NULL;
+		struct commit_list **next = &parents;
+		struct object_id out;
+
+		next = commit_list_append(prev, next);
+		next = commit_list_append(lookup_commit_reference(the_repository, &items[i]), next);
+		if (write_commit_with_parents(&out, &items[i], parents)) {
+			res = -1;
+			goto out;
+		}
+		prev = lookup_commit_reference(the_repository, &out);
+	}
+	if (ref)
+		update_ref(NULL, ref, &prev->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	else
+		puts(oid_to_hex(&prev->object.oid));
+out:
+	free(items);
+
+	return res;
+}
+
+enum export_action {
+	ACTION_NONE,
+	ACTION_PRINT,
+	ACTION_TO_REF,
+};
+
+static int export_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret = 0;
+	const char *ref = NULL;
+	enum export_action action = ACTION_NONE;
+	struct option options[] = {
+		OPT_CMDMODE(0, "print", &action,
+			    N_("print the object ID instead of writing it to a ref"),
+			    ACTION_PRINT),
+		OPT_CMDMODE(0, "to-ref", &action,
+			    N_("save the data to the given ref"),
+			    ACTION_TO_REF),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_export_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (action == ACTION_NONE) {
+		return error(_("exactly one of --print and --to-ref is required"));
+	} else if (action == ACTION_TO_REF) {
+		if (!argc)
+			return error(_("--to-ref requires an argument"));
+		ref = argv[0];
+		argc--;
+		argv++;
+	}
+
+
+	ret = do_export_stash(ref, argc, argv);
+	return ret;
+}
+
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1816,6 +1998,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		return !!push_stash(argc, argv, prefix, 0);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "export"))
+		return !!export_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
 		usage_msg_optf(_("unknown subcommand: %s"),
 			       git_stash_usage, options, argv[0]);
