Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623F01EC01F
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940180; cv=none; b=a/nq3W/lBXqvWRpccXNIQgIe5+6JwQpHTCXGdqRZER1f0qhGvxSYBMWxugSr54jPq3QTb7QZpNWOluiAczuWX2UAh9DgOyW1iWfKh6E/80isDgcHTwwlmn2C7uQoCZNxAru4RT9nd8NOUNGWMbKAlJG8XP8fLnMtt8NCHTr8eO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940180; c=relaxed/simple;
	bh=1HC18bZxq9tRU1//ycxZrqUsy6mKUlNVGjCEhVYFisQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lK7Q1Lv2DKyap3zFg1hpxWQKx5nNC1JgVqoW2L12XtLgARnnbl4BhK+TiKp9uQJLPjEX7EMLjhvxnEhAj5penPZxgS7siK4giSH9c/NZwz1WlJLu1wILX27MgZBNrttpuweG6Wsc8+2+8LyHzNGjZ/lbCa3IgmXNknIwmIzWdfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=RMK2bFCE; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="RMK2bFCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940175;
	bh=1HC18bZxq9tRU1//ycxZrqUsy6mKUlNVGjCEhVYFisQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=RMK2bFCE1KRf2BcfzwOjpDkC3kxJvmFyBfZArBNpey/NfDWqTedNJD+M83mQEpNff
	 79RMWzckZZqyr54xHFsxvgiJhohIItQQYfGMUpEQ+8BbtnB+CSjwXRr7iY5etv/zvB
	 DXDKe3sYINAT++5VJig8hfPXny4KR2fBbwsziFxG3Hg5QD4ZqgI7eZv7IC/RoImGNl
	 OL0notu0UwZH4spzMjeebpzR10wzPppbFaK2eMUFOxZx3xYaQChVOYyASLwUc3R5DH
	 LxG0WxlGtaQjA6k1pRgwOSsWCtcJD/CqoByFjQGXAbYVpcD3jo7pJBU1cXs2/cP1vz
	 VJaeJfANpAsFNhW/DGrHMqLZQx5kEX0l/71eLC05ZXWmwYuItTkjK4EN2YNkuTLG0q
	 e3mTluZpzewWeUVofLCPWwBeIbXLfHfQRfDrA8lkxCqP5ZVx+AIVHXqV3Edn138Nt3
	 FPNFOkgwveR+GtWTAL65QN99CPfQXyVIHaQ5tsA50g7KVme0mr4
Received: from tapette.. (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 036F820192;
	Thu, 22 May 2025 18:56:14 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	pwodd,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 4/5] builtin/stash: provide a way to export stashes to a ref
Date: Thu, 22 May 2025 18:55:23 +0000
Message-ID: <20250522185524.18398-6-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

In addition, users often want to replicate stashes across machines, such
as when they must use multiple machines or when they use throwaway dev
environments, such as those based on the Devcontainer spec, where they
might otherwise lose various in-progress work.

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

When exporting stashes, be sure to verify that they look like valid
stashes and don't contain invalid data.  This will help avoid failures
on import or problems due to attempting to export invalid refs that are
not stashes.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 Documentation/git-stash.adoc |  22 ++-
 builtin/stash.c              | 250 +++++++++++++++++++++++++++++++++++
 2 files changed, 271 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 1a5177f498..e8efd43ba4 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -23,6 +23,7 @@ SYNOPSIS
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [(-m | --message) <message>] [-q | --quiet] <commit>
+'git stash' export (--print | --to-ref <ref>) [<stash>...]
 
 DESCRIPTION
 -----------
@@ -154,6 +155,12 @@ store::
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
@@ -242,6 +249,19 @@ literally (including newlines and quotes).
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
@@ -259,7 +279,7 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 <stash>::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
-	`show` commands.
+	`show`, and `export` commands.
 +
 A reference of the form `stash@{<revision>}`. When no `<stash>` is
 given, the latest stash is assumed (that is, `stash@{0}`).
diff --git a/builtin/stash.c b/builtin/stash.c
index ab491d5ff6..ca00663e36 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -28,7 +28,10 @@
 #include "log-tree.h"
 #include "diffcore.h"
 #include "reflog.h"
+#include "reflog-walk.h"
 #include "add-interactive.h"
+#include "oid-array.h"
+#include "commit.h"
 
 #define INCLUDE_ALL_FILES 2
 
@@ -56,6 +59,8 @@
 	   "          [-u | --include-untracked] [-a | --all] [<message>]")
 #define BUILTIN_STASH_CREATE_USAGE \
 	N_("git stash create [<message>]")
+#define BUILTIN_STASH_EXPORT_USAGE \
+	N_("git stash export (--print | --to-ref <ref>) [<stash>...]")
 #define BUILTIN_STASH_CLEAR_USAGE \
 	"git stash clear"
 
@@ -71,6 +76,7 @@ static const char * const git_stash_usage[] = {
 	BUILTIN_STASH_CLEAR_USAGE,
 	BUILTIN_STASH_CREATE_USAGE,
 	BUILTIN_STASH_STORE_USAGE,
+	BUILTIN_STASH_EXPORT_USAGE,
 	NULL
 };
 
@@ -124,6 +130,12 @@ static const char * const git_stash_save_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_export_usage[] = {
+	BUILTIN_STASH_EXPORT_USAGE,
+	NULL
+};
+
+
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -160,6 +172,33 @@ static void free_stash_info(struct stash_info *info)
 	strbuf_release(&info->revision);
 }
 
+static int check_stash_topology(struct repository *r, struct commit *stash)
+{
+	struct commit *p1, *p2, *p3 = NULL;
+
+	/* stash must have two or three parents */
+	if (!stash->parents || !stash->parents->next ||
+			(stash->parents->next->next && stash->parents->next->next->next))
+		return -1;
+	p1 = stash->parents->item;
+	p2 = stash->parents->next->item;
+	if (stash->parents->next->next)
+		p3 = stash->parents->next->next->item;
+	if (repo_parse_commit(r, p1) || repo_parse_commit(r, p2) ||
+			(p3 && repo_parse_commit(r, p3)))
+		return -1;
+	/* p2 must have a single parent, p3 must have no parents */
+	if (!p2->parents || p2->parents->next || (p3 && p3->parents))
+		return -1;
+	if (repo_parse_commit(r, p2->parents->item))
+		return -1;
+	/* p2^1 must equal p1 */
+	if (!oideq(&p1->object.oid, &p2->parents->item->object.oid))
+		return -1;
+
+	return 0;
+}
+
 static void assert_stash_like(struct stash_info *info, const char *revision)
 {
 	if (get_oidf(&info->b_commit, "%s^1", revision) ||
@@ -1895,6 +1934,216 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int write_commit_with_parents(struct repository *r,
+				     struct object_id *out,
+				     const struct object_id *oid,
+				     struct commit_list *parents)
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
+	struct ident_split id;
+
+	this = lookup_commit_reference(r, oid);
+	buffer = repo_get_commit_buffer(r, this, &bufsize);
+	orig_author = find_commit_header(buffer, "author", &author_len);
+	orig_committer = find_commit_header(buffer, "committer", &committer_len);
+
+	if (!orig_author || !orig_committer) {
+		ret = error(_("cannot parse commit %s"), oid_to_hex(oid));
+		goto out;
+	}
+
+	if (split_ident_line(&id, orig_author, author_len) < 0 ||
+	    split_ident_line(&id, orig_committer, committer_len) < 0) {
+		ret = error(_("invalid author or committer for %s"), oid_to_hex(oid));
+		goto out;
+	}
+
+	p = strstr(buffer, "\n\n");
+	strbuf_addstr(&msg, "git stash: ");
+
+	if (p)
+		strbuf_add(&msg, p + 2, bufsize - (p + 2 - buffer));
+	strbuf_complete_line(&msg);
+
+	author = xmemdupz(orig_author, author_len);
+	committer = xmemdupz(orig_committer, committer_len);
+
+	if (commit_tree_extended(msg.buf, msg.len,
+				 r->hash_algo->empty_tree, parents,
+				 out, author, committer,
+				 NULL, NULL)) {
+		ret = error(_("could not write commit"));
+		goto out;
+	}
+out:
+	strbuf_release(&msg);
+	repo_unuse_commit_buffer(r, this, buffer);
+	free_commit_list(parents);
+	free(author);
+	free(committer);
+	return ret;
+}
+
+static int do_export_stash(struct repository *r,
+			   const char *ref,
+			   int argc,
+			   const char **argv)
+{
+	struct object_id base;
+	struct object_context unused;
+	struct commit *prev;
+	struct oid_array items = OID_ARRAY_INIT;
+	int res = 0;
+	ssize_t i;
+	struct strbuf revision = STRBUF_INIT;
+	const char *author, *committer;
+
+	/*
+	 * This is an arbitrary, fixed date, specifically the one used by git
+	 * format-patch.  The goal is merely to produce reproducible output.
+	 */
+	prepare_fallback_ident("git stash", "git@stash");
+	author = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT,
+			   "2001-09-17T00:00:00Z", 0);
+	committer = fmt_ident("git stash", "git@stash", WANT_BLANK_IDENT,
+			      "2001-09-17T00:00:00Z", 0);
+
+	/* First, we create a single empty commit. */
+	if (commit_tree_extended("", 0, r->hash_algo->empty_tree, NULL,
+				 &base, author, committer, NULL, NULL))
+		return error(_("unable to write base commit"));
+
+	prev = lookup_commit_reference(r, &base);
+
+	if (argc) {
+		/*
+		 * Find each specified stash, and load data into the array.
+		 */
+		for (i = 0; i < argc; i++) {
+			struct object_id oid;
+			struct commit *stash;
+
+			if (parse_stash_revision(&revision, argv[i], 1) ||
+			    get_oid_with_context(r, revision.buf,
+						 GET_OID_QUIETLY | GET_OID_GENTLY,
+						 &oid, &unused)) {
+				res = error(_("unable to find stash entry %s"), argv[i]);
+				goto out;
+			}
+
+			stash = lookup_commit_reference(r, &oid);
+			if (!stash || check_stash_topology(r, stash)) {
+				res = error(_("%s does not look like a stash commit"),
+						revision.buf);
+				goto out;
+			}
+			oid_array_append(&items, &oid);
+		}
+	} else {
+		/*
+		 * Walk the reflog, finding each stash entry, and load data into the
+		 * array.
+		 */
+		struct complete_reflogs *crl = read_complete_reflog("refs/stash");
+		for (i = 0; i < crl->nr; i++) {
+			/*
+			 * Iterate from the latest item in the reflog to the
+			 * earliest.  crl->items starts from the earliest first.
+			 */
+			struct reflog_info *item = crl->items + (crl->nr - i - 1);
+			struct commit *stash;
+
+			stash = lookup_commit_reference(r, &item->noid);
+			if (!stash || check_stash_topology(r, stash)) {
+				res = error(_("%s does not look like a stash commit"),
+						revision.buf);
+				goto out;
+			}
+			oid_array_append(&items, &item->noid);
+		}
+		free_complete_reflog(crl);
+	}
+
+	/*
+	 * Now, create a set of commits identical to the regular stash commits,
+	 * but where their first parents form a chain to our original empty
+	 * base commit.
+	 */
+	for (i = (ssize_t)items.nr - 1; i >= 0; i--) {
+		struct commit_list *parents = NULL;
+		struct commit_list **next = &parents;
+		struct object_id out;
+		const struct object_id *oid = items.oid + i;
+		struct commit *stash;
+
+		next = commit_list_append(prev, next);
+		stash = lookup_commit_reference(r, oid);
+		if (!stash) {
+			res = error(_("%s is not a valid commit"),
+					revision.buf);
+			goto out;
+		}
+		next = commit_list_append(stash, next);
+		res = write_commit_with_parents(r, &out, oid, parents);
+		if (res)
+			goto out;
+		prev = lookup_commit_reference(r, &out);
+	}
+	if (ref)
+		refs_update_ref(get_main_ref_store(r), NULL, ref,
+				&prev->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	else
+		puts(oid_to_hex(&prev->object.oid));
+out:
+	strbuf_release(&revision);
+	oid_array_clear(&items);
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
+static int export_stash(int argc,
+			const char **argv,
+			const char *prefix,
+			struct repository *repo)
+{
+	const char *ref = NULL;
+	enum export_action action = ACTION_NONE;
+	struct option options[] = {
+		OPT_CMDMODE(0, "print", &action,
+			    N_("print the object ID instead of writing it to a ref"),
+			    ACTION_PRINT),
+		OPT_STRING(0, "to-ref", &ref, "ref",
+			    N_("save the data to the given ref")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_export_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (ref && action == ACTION_NONE)
+		action = ACTION_TO_REF;
+
+	if (action == ACTION_NONE)
+		return error(_("exactly one of --print and --to-ref is required"));
+
+	return do_export_stash(repo, ref, argc, argv);
+}
+
 int cmd_stash(int argc,
 	      const char **argv,
 	      const char *prefix,
@@ -1915,6 +2164,7 @@ int cmd_stash(int argc,
 		OPT_SUBCOMMAND("store", &fn, store_stash),
 		OPT_SUBCOMMAND("create", &fn, create_stash),
 		OPT_SUBCOMMAND("push", &fn, push_stash_unassumed),
+		OPT_SUBCOMMAND("export", &fn, export_stash),
 		OPT_SUBCOMMAND_F("save", &fn, save_stash, PARSE_OPT_NOCOMPLETE),
 		OPT_END()
 	};
