Return-Path: <SRS0=/LSK=5B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18FEC3F2CE
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5182071C
	for <git@archiver.kernel.org>; Mon, 16 Mar 2020 18:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PWN11dMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbgCPSFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:05:55 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:55302 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730437AbgCPSFz (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Mar 2020 14:05:55 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 436B760797;
        Mon, 16 Mar 2020 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584381953;
        bh=uVpb6S0cZccCnUjNtATsIOgVJmktZCI4rTCyS1VjSKA=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=PWN11dMuGpx4FdjcJTgeBKQ1lHds285LqmjgsaSFD39ADk68eEZsVFprolk1Kvfp6
         mbEsmHELa2nszqg6BNfmGDmMzNJTVYH3UtV8QT/L1jG4vMZXF/XDztSq15JMFaZY7K
         Qf9TWiuJ5FD8tu9xj+YCBuCj5VNv9oQD+mX3evxfFV74++bbrd2F6S/IGOYghlU7QE
         U71be2yxvKmwF714rM6jdtSpi9aWDDddzwcfLBdWD6mpzfPvRHvOpI1tMuy5HBiwYF
         4kUeP7stZC9hzzYmT3g5tEMdG7O940jDAqhMu5I3YFtBgYpu7FRuDnvviLsiu2dFwa
         WPj3Ouf//83NEkmblKyhTDUsy6Ny4T7oFxZhMriswINZEoC3yHMUjJkD9v25Uq+lz4
         hHxVHReaRHBDooNDlXQrlWeFu4lhLPasfIQJv5T/eAgrW+CXqNnefwGgFSbPTIunaH
         wYBjSaRDSirxFTn0cE94CoQ16Vuends99Lrn8g+LJvta+AhM956
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 0/8] Additional metadata for filter processes
Date:   Mon, 16 Mar 2020 18:05:00 +0000
Message-Id: <20200316180508.367809-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Smudge and clean filters are currently provided with one particular
piece of data: the pathname of the file being smudged.  While this is
helpful, there are a variety of situations where people would like to
have more data.  This series introduces additional data for these
filters.

I decided that there is indeed value to providing the full ref when
using git checkout, so an invocation that uses a tag will now pass that
tag along.  It's easy for filters that don't want this data to simply
ignore it, but significantly harder to recover if it's not provided.

One thing I should mention here that may seem obvious: this metadata
only appears for smudge filters.  We obviously cannot know the blob when
data is being cleaned, and the ref, commit, and tree are already known
at that point (because one is using "git add" or an equivalent), so the
filter can simply do a git rev-parse if it's curious.

Changes from v1:
* Add support for arbitrary refs to checkout.
* Use FREE_AND_NULL where appropriate.
* Improve commit message to explain expected result and data as well as
  rationale.

brian m. carlson (8):
  builtin/checkout: pass branch info down to checkout_worktree
  convert: permit passing additional metadata to filter processes
  convert: provide additional metadata to filters
  builtin/checkout: compute checkout metadata for checkouts
  builtin/clone: compute checkout metadata for clones
  builtin/rebase: compute checkout metadata for rebases
  builtin/reset: compute checkout metadata for reset
  t0021: test filter metadata for additional cases

 apply.c                 |   2 +-
 archive.c               |  13 ++-
 archive.h               |   1 +
 builtin/cat-file.c      |   5 +-
 builtin/checkout.c      |  64 +++++++++----
 builtin/clone.c         |   5 +-
 builtin/rebase.c        |   1 +
 builtin/reset.c         |  16 +++-
 cache.h                 |   1 +
 convert.c               |  66 ++++++++++++--
 convert.h               |  29 +++++-
 diff.c                  |   5 +-
 entry.c                 |   7 +-
 merge-recursive.c       |   2 +-
 merge.c                 |   1 +
 sequencer.c             |   1 +
 t/t0021-conversion.sh   | 198 ++++++++++++++++++++++++++++++++++------
 t/t0021/rot13-filter.pl |   6 ++
 unpack-trees.c          |   1 +
 unpack-trees.h          |   1 +
 20 files changed, 350 insertions(+), 75 deletions(-)

Range-diff against v1:
1:  93111f0c13 = 1:  77b064093c builtin/checkout: pass branch info down to checkout_worktree
2:  7e3675fc33 ! 2:  d910bf619c convert: permit passing additional metadata to filter processes
    @@ Commit message
         pass this information in all cases, such as when renormalizing or when
         we're performing diffs, since it doesn't make sense in those cases.
     
    -    This series wires up the code to print this information, but doesn't
    +    The data we currently get from the filter process looks like the
    +    following:
    +
    +      command=smudge
    +      pathname=git.c
    +      0000
    +
    +    With this change, we'll get data more like this:
    +
    +      command=smudge
    +      pathname=git.c
    +      refname=refs/tags/v2.25.1
    +      treeish=c522f061d551c9bb8684a7c3859b2ece4499b56b
    +      blob=7be7ad34bd053884ec48923706e70c81719a8660
    +      0000
    +
    +    There are a couple things to note about this approach.  For operations
    +    like checkout, treeish will always be a commit, since we cannot check
    +    out individual trees, but for other operations, like archive, we can end
    +    up operating on only a particular tree, so we'll provide only a tree as
    +    the treeish.  Similar comments apply for refname, since there are a
    +    variety of cases in which we won't have a ref.
    +
    +    This commit wires up the code to print this information, but doesn't
         pass any of it at this point.  In a future commit, we'll have various
         code paths pass the actual useful data down.
     
3:  ed056a4516 ! 3:  ab2730d9a3 convert: provide additional metadata to filters
    @@ builtin/cat-file.c: static int filter_object(const char *path, unsigned mode,
      			*buf = strbuf_detach(&strbuf, NULL);
     
      ## builtin/checkout.c ##
    +@@ builtin/checkout.c: struct branch_info {
    + 	const char *name; /* The short name used */
    + 	const char *path; /* The full name of a real branch */
    + 	struct commit *commit; /* The named commit */
    ++	char *refname; /* The full name of the ref being checked out. */
    ++	struct object_id oid; /* The object ID of the commit being checked out. */
    + 	/*
    + 	 * if not null the branch is detached because it's already
    + 	 * checked out in this checkout
     @@ builtin/checkout.c: static int checkout_worktree(const struct checkout_opts *opts,
      	state.refresh_cache = 1;
      	state.istate = &the_index;
      
    -+	init_checkout_metadata(&state.meta, info->path,
    -+			       info->commit ? &info->commit->object.oid : NULL,
    ++	init_checkout_metadata(&state.meta, info->refname,
    ++			       info->commit ? &info->commit->object.oid : &info->oid,
     +			       NULL);
     +
      	enable_delayed_checkout(&state);
      	for (pos = 0; pos < active_nr; pos++) {
      		struct cache_entry *ce = active_cache[pos];
    +@@ builtin/checkout.c: static void setup_branch_path(struct branch_info *branch)
    + {
    + 	struct strbuf buf = STRBUF_INIT;
    + 
    ++	/*
    ++	 * If this is a ref, resolve it; otherwise, look up the OID for our
    ++	 * expression.  Failure here is okay.
    ++	 */
    ++	if (!dwim_ref(branch->name, strlen(branch->name), &branch->oid, &branch->refname))
    ++		repo_get_oid_committish(the_repository, branch->name, &branch->oid);
    ++
    + 	strbuf_branchname(&buf, branch->name, INTERPRET_BRANCH_LOCAL);
    + 	if (strcmp(buf.buf, branch->name))
    + 		branch->name = xstrdup(buf.buf);
     
      ## cache.h ##
     @@ cache.h: struct checkout {
4:  676b08a650 ! 4:  3630b2279b builtin/checkout: compute checkout metadata for checkouts
    @@ builtin/checkout.c: static int reset_tree(struct tree *tree, const struct checko
      	opts.verbose_update = o->show_progress;
      	opts.src_index = &the_index;
      	opts.dst_index = &the_index;
    -+	init_checkout_metadata(&opts.meta, info->path,
    ++	init_checkout_metadata(&opts.meta, info->refname,
     +			       info->commit ? &info->commit->object.oid :
    -+			       &tree->object.oid,
    ++			       is_null_oid(&info->oid) ? &tree->object.oid :
    ++			       &info->oid,
     +			       NULL);
      	parse_tree(tree);
      	init_tree_desc(&tree_desc, tree->buffer, tree->size);
    @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
      		topts.quiet = opts->merge && old_branch_info->commit;
      		topts.verbose_update = opts->show_progress;
      		topts.fn = twoway_merge;
    -+		init_checkout_metadata(&topts.meta, new_branch_info->path,
    ++		init_checkout_metadata(&topts.meta, new_branch_info->refname,
     +				       new_branch_info->commit ?
     +				       &new_branch_info->commit->object.oid :
    -+				       NULL, NULL);
    ++				       &new_branch_info->oid, NULL);
      		if (opts->overwrite_ignore) {
      			topts.dir = xcalloc(1, sizeof(*topts.dir));
      			topts.dir->flags |= DIR_SHOW_IGNORED;
5:  853af8380c ! 5:  79168566bc builtin/clone: compute checkout metadata for clones
    @@ builtin/clone.c: static int checkout(int submodule_progress)
      	if (!strcmp(head, "HEAD")) {
      		if (advice_detached_head)
      			detach_advice(oid_to_hex(&oid));
    -+		free(head);
    -+		head = NULL;
    ++		FREE_AND_NULL(head);
      	} else {
      		if (!starts_with(head, "refs/heads/"))
      			die(_("HEAD not found below refs/heads!"));
6:  22f2d41884 = 6:  af8e2af64b builtin/rebase: compute checkout metadata for rebases
7:  b789b6db7e = 7:  c0afbd1da2 builtin/reset: compute checkout metadata for reset
8:  b3aaf17a16 = 8:  32da1229ed t0021: test filter metadata for additional cases
