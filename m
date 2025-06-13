Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE482C159F
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807288; cv=none; b=To8o4z9byb9CL/oQ3/78CJnHz6jbhVETsik0DaQwvj7RkFch5WATN5N3Oc4fxcO6spc9z+fQl/3YThYmgYY7GiU8W1Py3NMBT/0uTymFFhjQBLnmvb7zMC6O0GCLnDqACHJ7BUhy35IrTica0upogxztfWaq6G5mcys+yR6SsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807288; c=relaxed/simple;
	bh=UZi2gsy15e4ZHWNiDmg3inlCCMP9u27gl2t7mF8/V54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fZzh0IHbodaw7uSo80qckE0Ce14m5LckNia1IeVNibmkXdoFb+B0OMNUBhmfU0nn4EJCrlriK1noqRptd3SbmSph9w+QddTDSwZIfPdK0kIkGRD7rHNTykuqUMmFDjRW04ipC5CqhtmjzHs5r8McIIIGzLbqQF8YLQI3CPNn+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lYqI7yVc; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lYqI7yVc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749807280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=moWX/7p4/xOiEiAMKb/uPhk5BCYrFw9QpAR6ZAW0yxI=;
	b=lYqI7yVcfo+sWxBKV/jKD1B6aobUTp2lFNYOumXbBlMQ2K1IiKIHVMi3IJJ/lu2M4fPbcz
	FgrHrNB+7txXIPQEiKn1DB8WmVlUSciCiiVvAvjIU5OLZBjO514AegGIW2ZqB34yXdEFQw
	yJ+XS57DBjUVD7oXF136hEtnqV60wZ4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC v2 1/5] last-modified: new subcommand to show when
 files were last modified
In-Reply-To: <aDWWe6qCQXorPESd@pks.im>
References: <20250523-toon-new-blame-tree-v2-0-101e4ca4c1c9@iotcl.com>
 <20250523-toon-new-blame-tree-v2-1-101e4ca4c1c9@iotcl.com>
 <aDWWe6qCQXorPESd@pks.im>
Date: Fri, 13 Jun 2025 11:34:28 +0200
Message-ID: <87ldpw0yu3.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 23, 2025 at 11:33:48AM +0200, Toon Claes wrote:
>> diff --git a/Documentation/git-last-modified.adoc b/Documentation/git-last-modified.adoc
>> new file mode 100644
>> index 0000000000..1af38f402e
>> --- /dev/null
>> +++ b/Documentation/git-last-modified.adoc
>> @@ -0,0 +1,49 @@
>> +git-last-modified(1)
>> +====================
>> +
>> +NAME
>> +----
>> +git-last-modified - EXPERIMENTAL: Show when files were last modified
>
> Nit: we don't have the EXPERIMENTAL label here for git-switch(1) or
> git-restore(1).

But we do for `git-replay(1)`. Because I haven't gotten much feedback
about the usage of the command, I wanted to be on the safe side and not
commit to the behavior. Marking it EXPERIMENTAL would allow us to make
changes on it's interface without _breaking_. But I wouldn't mind
dropping the experimental status.

>> +
>> +
>> +SYNOPSIS
>> +--------
>> +[synopsis]
>> +git last-modified [-r] [<revision-range>] [[--] <path>...]
>> +
>> +DESCRIPTION
>> +-----------
>> +
>> +Shows which commit last modified each of the relevant files and subdirectories.
>> +
>> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
>> +
>> +OPTIONS
>> +-------
>> +
>> +-r::
>> +	Recurse into subtrees.
>> +
>> +-t::
>> +	Show tree entry itself as well as subtrees.  Implies `-r`.
>
> These flags aren't yet supported in this version, are they?

They are, but I see there are no tests for `-t`. I shall add them.

>
>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> new file mode 100644
>> index 0000000000..0d4733f666
>> --- /dev/null
>> +++ b/builtin/last-modified.c
>> @@ -0,0 +1,43 @@
>> +#include "git-compat-util.h"
>> +#include "last-modified.h"
>> +#include "hex.h"
>> +#include "quote.h"
>> +#include "config.h"
>> +#include "object-name.h"
>> +#include "parse-options.h"
>> +#include "builtin.h"
>> +
>> +static void show_entry(const char *path, const struct commit *commit, void *d)
>> +{
>> +	struct last_modified *lm = d;
>> +
>> +	if (commit->object.flags & BOUNDARY)
>> +		putchar('^');
>> +	printf("%s\t", oid_to_hex(&commit->object.oid));
>> +
>> +	if (lm->rev.diffopt.line_termination)
>> +		write_name_quoted(path, stdout, '\n');
>> +	else
>> +		printf("%s%c", path, '\0');
>> +
>> +	fflush(stdout);
>> +}
>> +
>> +int cmd_last_modified(int argc,
>> +		   const char **argv,
>> +		   const char *prefix,
>> +		   struct repository *repo)
>> +{
>> +	int ret = 0;
>
> `ret` is basically unused here, we only use it to return 0.

Good catch. Thanks!

>> diff --git a/last-modified.c b/last-modified.c
>> new file mode 100644
>> index 0000000000..9283f8fcae
>> --- /dev/null
>> +++ b/last-modified.c
>> @@ -0,0 +1,213 @@
>> +#include "git-compat-util.h"
>> +#include "last-modified.h"
>> +#include "commit.h"
>> +#include "diffcore.h"
>> +#include "diff.h"
>> +#include "object.h"
>> +#include "revision.h"
>> +#include "repository.h"
>> +#include "log-tree.h"
>> +
>> +struct last_modified_entry {
>> +	struct hashmap_entry hashent;
>> +	struct object_id oid;
>> +	struct commit *commit;
>> +	const char path[FLEX_ARRAY];
>> +};
>> +
>> +static void add_from_diff(struct diff_queue_struct *q,
>> +			  struct diff_options *opt UNUSED,
>> +			  void *data)
>> +{
>> +	struct last_modified *lm = data;
>> +
>> +	for (int i = 0; i < q->nr; i++) {
>> +		struct diff_filepair *p = q->queue[i];
>> +		struct last_modified_entry *ent;
>> +		const char *path = p->two->path;
>> +
>> +		FLEX_ALLOC_STR(ent, path, path);
>> +		oidcpy(&ent->oid, &p->two->oid);
>> +		hashmap_entry_init(&ent->hashent, strhash(ent->path));
>> +		hashmap_add(&lm->paths, &ent->hashent);
>> +	}
>> +}
>> 
>> +static int add_from_revs(struct last_modified *lm)
>> +{
>> +	size_t count = 0;
>> +	struct diff_options diffopt;
>> +
>> +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
>> +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
>> +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	diffopt.format_callback = add_from_diff;
>> +	diffopt.format_callback_data = lm;
>
> As far as I understand we populate `paths` from the diff here, and
> `paths` later on acts as a filter of paths we're interested in? Might be
> nice to add a comment explaining the intent of this.

Will do.


>> +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
>> +		struct object_array_entry *obj = lm->rev.pending.objects + i;
>> +
>> +		if (obj->item->flags & UNINTERESTING)
>> +			continue;
>> +
>> +		if (count++)
>> +			return error(_("can only get last-modified one tree at a time"));
>
> It's a bit funny that `count` is pretending to be a counter even though
> it ultimately is only a boolean flag whether we have already seen an
> interesting item.

Okay, I'll refactor.

>> +		diff_tree_oid(lm->rev.repo->hash_algo->empty_tree,
>> +			      &obj->item->oid, "", &diffopt);
>> +		diff_flush(&diffopt);
>> +	}
>> +	clear_pathspec(&diffopt.pathspec);
>
> Shouldn't we call `diff_free()` instead of `clear_pathspec` to clear the
> whole `struct diff_options`?

Yeah, that's better.

>> +
>> +	return 0;
>> +}
>> +
>> +static int last_modified_entry_hashcmp(const void *unused UNUSED,
>> +				    const struct hashmap_entry *hent1,
>> +				    const struct hashmap_entry *hent2,
>> +				    const void *path)
>> +{
>> +	const struct last_modified_entry *ent1 =
>> +		container_of(hent1, const struct last_modified_entry, hashent);
>> +	const struct last_modified_entry *ent2 =
>> +		container_of(hent2, const struct last_modified_entry, hashent);
>> +	return strcmp(ent1->path, path ? path : ent2->path);
>> +}
>> +
>> +void last_modified_init(struct last_modified *lm,
>> +		     struct repository *r,
>> +		     const char *prefix,
>> +		     int argc, const char **argv)
>> +{
>> +	memset(lm, 0, sizeof(*lm));
>> +	hashmap_init(&lm->paths, last_modified_entry_hashcmp, NULL, 0);
>> +
>> +	repo_init_revisions(r, &lm->rev, prefix);
>> +	lm->rev.def = "HEAD";
>> +	lm->rev.combine_merges = 1;
>> +	lm->rev.show_root_diff = 1;
>> +	lm->rev.boundary = 1;
>> +	lm->rev.no_commit_id = 1;
>> +	lm->rev.diff = 1;
>> +	if (setup_revisions(argc, argv, &lm->rev, NULL) > 1)
>> +		die(_("unknown last-modified argument: %s"), argv[1]);
>> +
>> +	if (add_from_revs(lm) < 0)
>> +		die(_("unable to setup last-modified"));
>
> Given that this is library code, do we rather want to have
> `last_modified_init()` return an error code and let the caller die?

Yes, agreed.

>> +}
>> +
>> +void last_modified_release(struct last_modified *lm)
>> +{
>> +	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
>> +	release_revisions(&lm->rev);
>> +}
>> +
>> +struct last_modified_callback_data {
>> +	struct commit *commit;
>> +	struct hashmap *paths;
>> +
>> +	last_modified_callback callback;
>> +	void *callback_data;
>> +};
>> +
>> +static void mark_path(const char *path, const struct object_id *oid,
>> +		      struct last_modified_callback_data *data)
>> +{
>> +	struct last_modified_entry *ent;
>> +
>> +	/* Is it even a path that we are interested in? */
>> +	ent = hashmap_get_entry_from_hash(data->paths, strhash(path), path,
>> +					  struct last_modified_entry, hashent);
>> +	if (!ent)
>> +		return;
>
> Yup, so this here is the filter to figure out whether we care for a
> path, which uses the `paths` map we have populated at the beginning.
>
>> +	/* Have we already found a commit? */
>> +	if (ent->commit)
>> +		return;
>
> Can this case even be hit? We remove the entry from the map once we have
> seen it, so I'd expect that we never hit the same commit map entry
> twice. If so, can this be converted to a `BUG()` or am I missing the
> obvious?

I was wondering about that. But took it over from the original code, and
left it in. I believe it's from a version where entries weren't removed
from the hashmap. I agree a `BUG()` would be a better approach, or
even better simply delete this condition.

>> +	/*
>> +	 * Is it arriving at a version of interest, or is it from a side branch
>> +	 * which did not contribute to the final state?
>> +	 */
>> +	if (!oideq(oid, &ent->oid))
>> +		return;
>> +
>> +	ent->commit = data->commit;
>> +	if (data->callback)
>> +		data->callback(path, data->commit, data->callback_data);
>> +
>> +	hashmap_remove(data->paths, &ent->hashent, path);
>
> And we end up removing that entry from paths so that we don't revisit it
> in the future. After all, we're only interested in a single commit per
> path.

True. So it doesn't even make sense a `struct last_modified_entry` has a
`commit` attribute. I will delete that in next version.

>> +	free(ent);
>> +}
>> +
>> +static void last_modified_diff(struct diff_queue_struct *q,
>> +		       struct diff_options *opt UNUSED, void *cbdata)
>> +{
>> +	struct last_modified_callback_data *data = cbdata;
>> +
>> +	for (int i = 0; i < q->nr; i++) {
>> +		struct diff_filepair *p = q->queue[i];
>> +		switch (p->status) {
>> +		case DIFF_STATUS_DELETED:
>> +			/*
>> +			 * There's no point in feeding a deletion, as it could
>> +			 * not have resulted in our current state, which
>> +			 * actually has the file.
>> +			 */
>> +			break;
>> +
>> +		default:
>> +			/*
>> +			 * Otherwise, we care only that we somehow arrived at
>> +			 * a final path/sha1 state. Note that this covers some
>> +			 * potentially controversial areas, including:
>> +			 *
>> +			 *  1. A rename or copy will be found, as it is the
>> +			 *     first time the content has arrived at the given
>> +			 *     path.
>> +			 *
>> +			 *  2. Even a non-content modification like a mode or
>> +			 *     type change will trigger it.
>
> Curious, but sensible. We're looking for the last time a specific tree
> entry was changed, and that of course includes modifications. I could
> totally see that we may eventually want to add a flag that ignores such
> mode changes and only presents content changes. But for now I agree that
> this is sensible.
>
>> +			 * We take the inclusive approach for now, and find
>> +			 * anything which impacts the path. Options to tweak
>> +			 * the behavior (e.g., to "--follow" the content across
>> +			 * renames) can come later.
>> +			 */
>> +			mark_path(p->two->path, &p->two->oid, data);
>> +			break;
>> +		}
>> +	}
>> +}
>> +
>> +int last_modified_run(struct last_modified *lm, last_modified_callback cb, void *cbdata)
>> +{
>> +	struct last_modified_callback_data data;
>> +
>> +	data.paths = &lm->paths;
>> +	data.callback = cb;
>> +	data.callback_data = cbdata;
>> +
>> +	lm->rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	lm->rev.diffopt.format_callback = last_modified_diff;
>> +	lm->rev.diffopt.format_callback_data = &data;
>> +
>> +	prepare_revision_walk(&lm->rev);
>> +
>> +	while (hashmap_get_size(&lm->paths)) {
>
> Okay, and this is the core of our logic: we continue walking the tree
> until there are no more paths that we care about.
>
>> diff --git a/last-modified.h b/last-modified.h
>> new file mode 100644
>> index 0000000000..42a819d979
>> --- /dev/null
>> +++ b/last-modified.h
>> @@ -0,0 +1,27 @@
>> +#ifndef LAST_MODIFIED_H
>> +#define LAST_MODIFIED_H
>> +
>> +#include "commit.h"
>> +#include "revision.h"
>> +#include "hashmap.h"
>> +
>> +struct last_modified {
>> +	struct hashmap paths;
>> +	struct rev_info rev;
>> +};
>> +
>> +void last_modified_init(struct last_modified *lm,
>> +		     struct repository *r,
>> +		     const char *prefix,
>> +		     int argc, const char **argv);
>> +
>> +void last_modified_release(struct last_modified *);
>> +
>> +typedef void (*last_modified_callback)(const char *path,
>> +				    const struct commit *commit,
>> +				    void *data);
>> +int last_modified_run(struct last_modified *lm,
>> +		   last_modified_callback cb,
>> +		   void *cbdata);
>> +#endif /* LAST_MODIFIED_H */
>
> It would be nice to have some documentation for each of these functions
> as well as a bit of a higher-level conceptual info.

Will do.

-- 
Cheers,
Toon
