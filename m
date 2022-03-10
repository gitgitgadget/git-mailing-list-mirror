Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C23EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245150AbiCJRga (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245058AbiCJRgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 12:36:25 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FAB18DA81
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 09:35:22 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A71635A12E;
        Thu, 10 Mar 2022 17:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646933721;
        bh=a0CQQxaHZyWnkGFJB3iQONvSs77QhkcfLCSNf9pbhdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=e1GFeHndiKJVT4airOYr15qzPryT0e9fk42sCKj0lFnUz33yZtAAJ5mQ69pv83ul1
         4d7mP6MFQkFJIhgoTPKgdUqkXHapT8JtUmYr3A++McS84SXCxaJlPDNZCf/ZSEQtzK
         P8PQHruH1VqBUtJ7qy0BcaGtl+iNKpilvIdEBEMMp/wzyIeQxOF3gJ1sn6F4TjXakY
         XbwxYFfu/Lcxd5GwnlYvkoeW7WzxvHRNFwxo3TOB4u9is6re7e/eV8P0Vg9F34OG4Y
         xkicRAyykiVsfVa8ouYau34QzzN3dDN28FHVkIsDikxX/zpiqrIbWfCBo9Blapl3Zk
         JHrnl6ie8KDnqwr3JHJg5zlAXRsGg8ZHqrrZd7VoB7MFbVGml68FEZn221ccZSsa4u
         gx0DquPvewU6nJXJLbZxRfpGPoJZfVO86ilF0YXUGqLBIV3DmpetL7znvU0DF0gq7k
         yA1BQE0lroPT/SUky3x3QrwMnJY/5AkAN9Z/D2zk9tmCi30klyn
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH 4/6] builtin/stash: provide a way to export stashes to a ref
Date:   Thu, 10 Mar 2022 17:32:34 +0000
Message-Id: <20220310173236.4165310-5-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed
In-Reply-To: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
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
commits identical to the ones used for reflog-based stashes, except that
the first parent is always a chain to the previous stash, or to a
single, empty commit (for the final item).

Iterate over each stash from topmost to bottomost, looking up the data
for each one, and then create the chain from the single empty commit
back up in reverse order.  Preserve the author and committer
information, as well as the commit message, so we produce an identical
stash when importing later.

If the user has specified specific stashes they'd like to export
instead, use those instead of iterating over all of the stashes.

As part of this, specifically request quiet behavior when looking up the
OID for a revision because we will eventually hit a revision that
doesn't exist and we don't want to die when that occurs.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/stash.c | 180 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 179 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 128f0a01ef..582a04dbab 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -33,6 +33,7 @@ static const char * const git_stash_usage[] = {
 	   "          [--] [<pathspec>...]]"),
 	N_("git stash save [-p|--patch] [-S|--staged] [-k|--[no-]keep-index] [-q|--quiet]\n"
 	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	N_("git stash export (--print | --to-ref <ref>) [<stashes>]"),
 	NULL
 };
 
@@ -89,6 +90,12 @@ static const char * const git_stash_save_usage[] = {
 	NULL
 };
 
+static const char * const git_stash_export_usage[] = {
+	N_("git stash export (--print | --to-ref <ref>) [<stashes>]"),
+	NULL
+};
+
+
 static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
@@ -139,6 +146,7 @@ static int get_stash_info_1(struct stash_info *info, const char *commit, int qui
 	const char *revision;
 	struct object_id dummy;
 	struct strbuf symbolic = STRBUF_INIT;
+	struct object_context unused;
 
 	strbuf_init(&info->revision, 0);
 	if (!commit) {
@@ -158,7 +166,9 @@ static int get_stash_info_1(struct stash_info *info, const char *commit, int qui
 
 	revision = info->revision.buf;
 
-	if (get_oid(revision, &info->w_commit)) {
+	if (get_oid_with_context(the_repository, revision,
+				 GET_OID_QUIETLY | GET_OID_RETURN_FAILURE,
+				 &info->w_commit, &unused)) {
 		if (!quiet)
 			error(_("%s is not a valid reference"), revision);
 		free_stash_info(info);
@@ -1775,6 +1785,172 @@ static int save_stash(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
+static char *write_commit_with_parents(struct object_id *out, const struct stash_info *info, struct commit_list *parents)
+{
+	size_t author_len, committer_len;
+	struct commit *this = NULL;
+	const char *orig_author = NULL, *orig_committer = NULL;
+	char *author = NULL, *committer = NULL;
+	const char *buffer = NULL;
+	unsigned long bufsize;
+	const char *p;
+	char *msg = NULL;
+
+	this = lookup_commit_reference(the_repository, &info->w_commit);
+	buffer = get_commit_buffer(this, &bufsize);
+	orig_author = find_commit_header(buffer, "author", &author_len);
+	orig_committer = find_commit_header(buffer, "committer", &committer_len);
+	p = memmem(buffer, bufsize, "\n\n", 2);
+
+	if (!orig_author || !orig_committer || !p) {
+		error(_("cannot parse commit %s"), oid_to_hex(&info->w_commit));
+		goto out;
+	}
+	/* Jump to message. */
+	p += 2;
+
+	author = xmemdupz(orig_author, author_len);
+	committer = xmemdupz(orig_committer, committer_len);
+
+	if (commit_tree_extended(p, bufsize - (p - buffer),
+				 &info->w_tree, parents,
+				 out, author, committer,
+				 NULL, NULL)) {
+		error(_("could not write commit"));
+		goto out;
+	}
+	msg = xmemdupz(p, bufsize - (p - buffer));
+out:
+	unuse_commit_buffer(this, buffer);
+	free(author);
+	free(committer);
+	return msg;
+}
+
+static int do_export_stash(const char *ref, size_t argc, const char **argv)
+{
+	struct object_id base;
+	struct commit *prev;
+	struct stash_info *items = NULL;
+	size_t nitems = 0, nalloc = 0;
+	int res = 0;
+
+	prepare_fallback_ident("git stash", "git@stash");
+
+	/* First, we create a single empty commit. */
+	if (commit_tree(NULL, 0, the_hash_algo->empty_tree, NULL, &base, NULL, NULL))
+		return error(_("unable to write base commit"));
+
+	prev = lookup_commit_reference(the_repository, &base);
+
+
+	if (argc) {
+		/*
+		 * Find each specified stash, and load data into the array.
+		 */
+		for (size_t i = 0; i < argc; i++, nitems++) {
+			int ret;
+
+			if (nalloc <= i) {
+				size_t new = nalloc * 3 / 2 + 5;
+				items = xrealloc(items, new * sizeof(*items));
+				nalloc = new;
+			}
+			memset(&items[i], 0, sizeof(*items));
+			/* We want this to be quiet because it might not exist. */
+			ret = get_stash_info_1(&items[i], argv[i], 1);
+			if (ret)
+				return error(_("unable to find stash entry %s"), argv[i]);
+		}
+	} else {
+		/*
+		 * Walk the reflog, finding each stash entry, and load data into the
+		 * array.
+		 */
+		for (size_t i = 0;; i++, nitems++) {
+			char buf[32];
+			int ret;
+
+			if (nalloc <= i) {
+				size_t new = nalloc * 3 / 2 + 5;
+				items = xrealloc(items, new * sizeof(*items));
+				nalloc = new;
+			}
+			snprintf(buf, sizeof(buf), "%zu", i);
+			memset(&items[i], 0, sizeof(*items));
+			/* We want this to be quiet because it might not exist. */
+			ret = get_stash_info_1(&items[i], buf, 1);
+			if (ret)
+				break;
+		}
+	}
+
+	/*
+	 * Now, create a set of commits identical to the regular stash commits,
+	 * but where their first parents form a chain to our original empty
+	 * base commit.
+	 */
+	for (ssize_t i = nitems - 1; i >= 0; i--) {
+		struct commit_list *parents = NULL;
+		struct commit_list **next = &parents;
+		struct object_id out;
+		char *msg;
+
+		next = commit_list_append(prev, next);
+		next = commit_list_append(lookup_commit_reference(the_repository, &items[i].b_commit), next);
+		next = commit_list_append(lookup_commit_reference(the_repository, &items[i].i_commit), next);
+		if (items[i].has_u)
+			next = commit_list_append(lookup_commit_reference(the_repository,
+									  &items[i].u_commit),
+						  next);
+
+		msg = write_commit_with_parents(&out, &items[i], parents);
+		if (!msg) {
+			res = -1;
+			goto out;
+		}
+		free(msg);
+		prev = lookup_commit_reference(the_repository, &out);
+	}
+	if (ref) {
+		update_ref(NULL, ref, &prev->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	} else {
+		puts(oid_to_hex(&prev->object.oid));
+	}
+out:
+	for (size_t i = 0; i < nitems; i++) {
+		free_stash_info(&items[i]);
+	}
+	free(items);
+
+	return res;
+}
+
+static int export_stash(int argc, const char **argv, const char *prefix)
+{
+	int ret = 0;
+	int print = 0;
+	const char *ref = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "print", &print,
+			 N_("print the object ID instead of writing it to a ref")),
+		OPT_STRING(0, "to-ref", &ref, "refname",
+			   N_("save the data to the given ref")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     git_stash_export_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (!(!!ref ^ print))
+		return error("exactly one of --print or --to-ref is required");
+
+
+	ret = do_export_stash(ref, argc, argv);
+	return ret;
+}
+
 int cmd_stash(int argc, const char **argv, const char *prefix)
 {
 	pid_t pid = getpid();
@@ -1818,6 +1994,8 @@ int cmd_stash(int argc, const char **argv, const char *prefix)
 		return !!push_stash(argc, argv, prefix, 0);
 	else if (!strcmp(argv[0], "save"))
 		return !!save_stash(argc, argv, prefix);
+	else if (!strcmp(argv[0], "export"))
+		return !!export_stash(argc, argv, prefix);
 	else if (*argv[0] != '-')
 		usage_msg_optf(_("unknown subcommand: %s"),
 			       git_stash_usage, options, argv[0]);
