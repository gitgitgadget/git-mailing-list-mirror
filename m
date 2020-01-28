Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6120DC33CB3
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3899420661
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 07:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgA1HbD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:31:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:46044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725776AbgA1HbD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 02:31:03 -0500
Received: (qmail 7422 invoked by uid 109); 28 Jan 2020 07:31:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Jan 2020 07:31:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5062 invoked by uid 111); 28 Jan 2020 07:38:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 02:38:32 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 02:31:00 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v2 5/5] Reftable support for git-core
Message-ID: <20200128073100.GA563058@coredump.intra.peff.net>
References: <pull.539.git.1579808479.gitgitgadget@gmail.com>
 <pull.539.v2.git.1580134944.gitgitgadget@gmail.com>
 <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <721201269df47dc2e406e4091ab6b18a4a59b65f.1580134944.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 02:22:24PM +0000, Han-Wen Nienhuys via GitGitGadget wrote:

> [...]

I'll try to add my 2 cents to all of the XXX spots you flagged.

> @@ -1839,10 +1839,22 @@ static struct ref_store *lookup_ref_store_map(struct hashmap *map,
>  static struct ref_store *ref_store_init(const char *gitdir,
>  					unsigned int flags)
>  {
> -	const char *be_name = "files";
> -	struct ref_storage_be *be = find_ref_storage_backend(be_name);
> +	struct strbuf refs_path = STRBUF_INIT;
> +
> +        /* XXX this should probably come from a git config setting and not
> +           default to reftable. */
> +	const char *be_name = "reftable";

I think the scheme here needs to be something like:

  - "struct repository" gets a new "ref_format" field

  - setup.c:check_repo_format() learns about an extensions.refFormat
    config key, which we use to set repo->ref_format

  - init/clone should take a command-line option for the ref format of
    the new repository. Anybody choosing reftables would want to set
    core.repositoryformatversion to "1" and set the extensions.refFormat
    key.

  - likewise, there should be a config setting to choose the default ref
    format. It would obviously stay at "files" for now, but we'd
    eventually perhaps flip the default to "reftable".

Some thoughts on compatibility:

The idea of the config changes is that older versions of Git will either
complain about repositoryformatversion (if very old), or will complain
that they don't know about extensions.refFormat. But the changes you
made in patch 1 indicate that existing versions of Git won't consider it
to be a Git repository at all!

I think this is slightly non-ideal, in that we'd continue walking up the
tree looking for a Git repo. And either:

  - we'd find one, which would be confusing and possibly wrong

  - we wouldn't, in which case the error would be something like "no git
    repository", and not "your git repository is too new"

So it would be really nice if we continued to have a HEAD file (just
with some sentinel value in it) and a refs/ directory, so that existing
versions of Git realize "there's a repository here, but it's too new for
me".

There's a slight downside in that tools which _aren't_ careful about
repositoryformatversion might try to operate on the repository, writing
into refs/ or whatever. But such tools are broken, and I'm not sure we
should be catering to them (besides which, the packed-refs ship sailed
long ago, so they're already potentially dangerous).

> +/* XXX which ordering are these? Newest or oldest first? */
>  int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
>  int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);

The top one is chronological order (i.e., reading the file from start to
finish), and the latter is reverse-chronological (seeking backwards in
the file).

> +static struct ref_iterator *
> +reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
> +			    unsigned int flags)
> +{
> +	struct reftable_ref_store *refs =
> +		(struct reftable_ref_store *)ref_store;
> +	struct reftable_iterator *ri = xcalloc(1, sizeof(*ri));
> +	struct merged_table *mt = NULL;
> +	int err = 0;
> +	if (refs->err) {
> +		/* how to propagate errors? */
> +		return NULL;
> +	}
> +
> +	mt = stack_merged_table(refs->stack);
> +
> +	/* XXX something with flags? */

I think the flags here are DO_FOR_EACH_*. You might need to consider
INCLUDE_BROKEN here (or it might be dealt with at a layer above).

There's also PER_WORKTREE_ONLY; I think you'd need to check ref_type()
there, like the files backend does.

> +	err = merged_table_seek_ref(mt, &ri->iter, prefix);
> +	/* XXX what to do with err? */

Hmm, I don't think you can return an error from iterator_begin(). It
would probably be OK to record the error in your local struct, and then
later return ITER_ERROR from iterator_advance().

I notice that the more-recent dir_iterator_begin() returns NULL in case
of an error, but looking at the callers of the ref iterators, they don't
seem to be ready to handle NULL.

> +static int write_transaction_table(struct writer *writer, void *arg)
> +{
> +	struct ref_transaction *transaction = (struct ref_transaction *)arg;
> +	struct reftable_ref_store *refs =
> +		(struct reftable_ref_store *)transaction->ref_store;
> +	uint64_t ts = stack_next_update_index(refs->stack);
> +	int err = 0;
> +	/* XXX - are we allowed to mutate the input data? */
> +	qsort(transaction->updates, transaction->nr,
> +	      sizeof(struct ref_update *), ref_update_cmp);

I don't offhand know of anything that would break, but it's probably a
bad idea to do so. If you need a sorted view, can you make an auxiliary
array-of-pointers? Also, the QSORT() macro is a little shorter and has
some extra checks.

> +	for (int i = 0; i < transaction->nr; i++) {
> +		struct ref_update *u = transaction->updates[i];
> +		if (u->flags & REF_HAVE_NEW) {
> +			struct object_id out_oid = {};
> +			int out_flags = 0;
> +			/* XXX who owns the memory here? */
> +			const char *resolved = refs_resolve_ref_unsafe(
> +				transaction->ref_store, u->refname, 0, &out_oid,
> +				&out_flags);

In the "unsafe" version, the memory belongs to a static buffer inside
the function. You shouldn't need to free it.

> +static int
> +reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
> [...]
> +		/* XXX const? */
> +		memcpy(&ri->oid.hash, ri->log.new_hash, GIT_SHA1_RAWSZ);

You'd want probably want to use hashcpy() here (or better yet, use
"struct object_id" in ri->log, too, and then use oidcpy()).

But that raises a question: how ready are reftables to handle non-sha1
object ids? I see a lot of GIT_SHA1_RAWSZ, and I think the on-disk
format actually has binary sha1s, right? In theory if those all become
the_hash_algo->rawsz, then it might "Just Work" to read and write
slightly larger entries.

> +reftable_for_each_reflog_ent_newest_first(struct ref_store *ref_store,
> +					  const char *refname,
> +					  each_reflog_ent_fn fn, void *cb_data)
> [...]
> +			/* XXX committer = email? name? */
> +			if (fn(&old_oid, &new_oid, log.name, log.time,
> +			       log.tz_offset, log.message, cb_data)) {
> +				err = -1;
> +				break;
> +			}

The committer entry we pass back to each_reflog_ent_fn should be the
full "Human Name <email@host>".

> +static int reftable_reflog_expire(struct ref_store *ref_store,
> +				  const char *refname,
> +				  const struct object_id *oid,
> +				  unsigned int flags,
> +				  reflog_expiry_prepare_fn prepare_fn,
> +				  reflog_expiry_should_prune_fn should_prune_fn,
> +				  reflog_expiry_cleanup_fn cleanup_fn,
> +				  void *policy_cb_data)
> +{
> +	/*
> +	  XXX
> +
> +	  This doesn't fit with the reftable API. If we are expiring for space
> +	  reasons, the expiry should be combined with a compaction, and there
> +	  should be a policy that can be called for all refnames, not for a
> +	  single ref name.
> +
> +	  If this is for cleaning up individual entries, we'll have to write
> +	  extra data to create tombstones.
> +	 */
> +	return 0;
> +}

I agree that we'd generally want to expire and compact all entries at
once. Unfortunately I think this per-ref interface is exposed by
git-reflog. I.e., you can do "git reflog expire refs/heads/foo".

Could we add an extra API call for "expire everything", and then:

  - have refs/files-backend.c implement that by just iterating over all
    of the refs and pruning them one by one

  - have builtin/reflog.c trigger the "expire everything" API when it
    sees "--all"

  - teach refs/reftables-backend.c a crappy version of the per-ref
    expiration, where it just inserts tombstones but doesn't do any
    compaction. It doesn't have to be fast or produce a good output;
    it's just for compatibility.

    Alternatively, I'd be OK with die("sorry, reftables doesn't support
    per-ref reflog expiration") as a first step.

-Peff
