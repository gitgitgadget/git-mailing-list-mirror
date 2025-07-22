Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7C926B085
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199467; cv=none; b=JAkiRR5h5XBVWpMce8MCv72FZi7IFGOWs1lWyUM79+0H4R+P+L/dRs5HVC++SmAzVUQyY2IHlgbPskOiYG5dmDiI0DXqYLnQ1cfhS2LDWN8js6PyjsojjsinPjCHJtVJulHIwoNeaCFwLFD6sPgwQvOPGzQcGU0KtGVa1SdvB94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199467; c=relaxed/simple;
	bh=3uQhjWYqustIIejgsf9S+7QCf2cpgiPDdcmnMnzrMRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j/uxObQH/AmD4bb1346uJRgxQlD1l0ip7BENXhjPC8zhWwAQ+dqWduFxrawI4vf9JB4+3fbjwJ/LvElL0/WpxHr2PRj3p/+AaDMInnJTZwl/0hDgrQfIMpB/klM9uDHllMieGEHUZCBaO/UvscH9zDnL7nPXIIr0R39VbIvV++E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=IRj/saUF; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="IRj/saUF"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753199460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zp8mGIE7nZSzOnm6Q2QtrG7DKD1tZEH3gZPURhJQl+Y=;
	b=IRj/saUFpYtO6UcxBVXgolOIWzZPwyc+QHnj8u1DZ2VWghXX77WtN5b2AlMgqXCHb57QPF
	p+bx4Q5IpW2ITiw/HnRSIUCDPuTv7qAUiNfmeVoZdYDs5C+CP6j7AmYYO+psRqQVDb/70t
	dr9QEgfdbOaHwpp9TIPhhAnrURP+D5s=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 1/6] last-modified: new subcommand to show when files
 were last modified
In-Reply-To: <aHmPHcNQYlhGo8JB@nand.local>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-1-toon@iotcl.com> <aHmPHcNQYlhGo8JB@nand.local>
Date: Tue, 22 Jul 2025 17:50:49 +0200
Message-ID: <877c00kyw6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Jul 16, 2025 at 03:35:13PM +0200, Toon Claes wrote:
>>  11 files changed, 549 insertions(+)
>>  create mode 100644 Documentation/git-last-modified.adoc
>>  create mode 100644 builtin/last-modified.c
>>  create mode 100755 t/t8020-last-modified.sh
>
> I'm admittedly not entirely sure what the best way to review this patch
> is given its size and my previous exposure to (similar) code.

Yeah, I wasn't sure how to approach this. I didn't want to come in with
a big bang with the final version, but give the reviewers the change to
see the improvements (and complexity) come in gradually.

>> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
>> new file mode 100644
>> index 0000000000..63993bc1c9
>> --- /dev/null
>> +++ b/builtin/last-modified.c
>> @@ -0,0 +1,289 @@
>> +#include "git-compat-util.h"
>> +#include "builtin.h"
>> +#include "commit.h"
>> +#include "config.h"
>> +#include "diff.h"
>> +#include "diffcore.h"
>> +#include "hashmap.h"
>> +#include "hex.h"
>> +#include "log-tree.h"
>> +#include "object-name.h"
>> +#include "object.h"
>> +#include "parse-options.h"
>> +#include "quote.h"
>> +#include "repository.h"
>> +#include "revision.h"
>> +
>> +struct last_modified_entry {
>> +	struct hashmap_entry hashent;
>> +	struct object_id oid;
>> +	const char path[FLEX_ARRAY];
>> +};
>
> As a general comment on this patch, I am a little sad to see that many
> of the implementation details have been moved back into the builtin
> itself and not in their own last-modified.ch file(s).
>
> Apologies if this was already discussed earlier in the thread and I
> simply missed it, but can you comment on why the last-modified internals
> were moved into the builtin?

Wasn't discussed yet, and this only happened in this last version.
Basically my idea was: there's no one else using this, why put it at the
root level anyway? Also, it relies heavily on `setup_revisions()`. In my
first iterations `argc` and `argv` from the builtin were passed on
directly to the root-level `last-modified.[ch]` subsystem. This is a
little awkward, putting so much raw user-input handling in the
subsystem.


> Even in the earliest version of 'blame-tree' that I could find (from
> 26999d045b (add blame-tree command, 2012-10-20) in my fork) many of the
> internals were written in blame-tree.c instead of builtin/blame-tree.c.
>
>> +static int last_modified_entry_hashcmp(const void *unused UNUSED,
>> +				       const struct hashmap_entry *hent1,
>> +				       const struct hashmap_entry *hent2,
>> +				       const void *path)
>> +{
>> +	const struct last_modified_entry *ent1 =
>> +		container_of(hent1, const struct last_modified_entry, hashent);
>> +	const struct last_modified_entry *ent2 =
>> +		container_of(hent2, const struct last_modified_entry, hashent);
>> +	return strcmp(ent1->path, path ? path : ent2->path);
>> +}
>> +
>> +struct last_modified {
>> +	struct hashmap paths;
>> +	struct rev_info rev;
>> +	int recursive, tree_in_recursive;
>
> Can we either make these two part of a bitfield, or at least declare
> them separately?
>
>> +};
>> +
>> +static void last_modified_release(struct last_modified *lm)
>> +{
>> +	hashmap_clear_and_free(&lm->paths, struct last_modified_entry, hashent);
>> +	release_revisions(&lm->rev);
>> +}
>> +
>> +typedef void (*last_modified_callback)(const char *path,
>> +				       const struct commit *commit, void *data);
>> +
>> +struct last_modified_callback_data {
>> +	struct commit *commit;
>> +	struct hashmap *paths;
>> +
>> +	last_modified_callback callback;
>> +	void *callback_data;
>> +};
>
> I can't quite tell what the purpose of this struct is in conjunction
> with the last_modified_callback type above.

Yeah, this is kind of a remnant of when there was a last-modified
subsystem. In current implementation, where all code lives in the
builtin, there's no good reason to keep this callback struct.

> The last_modified_callback type makes sense as a generic callback
> function that callers can pass to get <path, commit> pairs, along with
> an arbitrary "data" pointer.
>
> But then you define a last_modified_callback_data struct that, which
> made me think that it would be used as the data type passed to the
> callback. In other words, given the existence of this struct, I would
> have expected the function pointer above to be defined like:
>
>     typedef void (*last_modified_callback)(const char *path,
>                                            const struct commit *commit,
>                                            struct last_modified_callback_data *data);
>
> But the fact that the _data struct contains a last_modified_callback
> function pointer gives us a hint at what's going on here. It seems like
> last_modified_callback_data is used to store some bookkeeping
> information and dispatch calls to the "callback" function pointer.
>
> I think that the fact the struct's name ends with "_data" is what is
> confusing to me. I think this would be a little clearer if you renamed
> this "struct last_modified_callback" and the function pointer to
> "last_modified_callback_fn" or similar.
>
> (The irony is not lost on me that these comments would be applicable to
> GitHub's version of this code, too :-s).

Hey, that's no excuse to keep it like this. I think keeping the callback
infrastructure depends on whether bring back the last-modified
subsystem. In that case, I will address your comments. If not, I think
we can get rid of it completely.


>> +static int populate_paths_from_revs(struct last_modified *lm)
>> +{
>> +	int num_interesting = 0;
>> +	struct diff_options diffopt;
>> +
>> +	memcpy(&diffopt, &lm->rev.diffopt, sizeof(diffopt));
>> +	copy_pathspec(&diffopt.pathspec, &lm->rev.diffopt.pathspec);
>> +	/*
>> +	 * Use a callback to populate the paths from revs
>> +	 */
>> +	diffopt.output_format = DIFF_FORMAT_CALLBACK;
>> +	diffopt.format_callback = add_path_from_diff;
>> +	diffopt.format_callback_data = lm;
>> +
>> +	for (size_t i = 0; i < lm->rev.pending.nr; i++) {
>> +		struct object_array_entry *obj = lm->rev.pending.objects + i;
>> +
>> +		if (obj->item->flags & UNINTERESTING)
>> +			continue;
>> +
>> +		if (num_interesting++)
>> +			return error(_("can only get last-modified one tree at a time"));
>
> This error text is a little difficult to parse, but I'm not sure that I
> have a great suggestion for improving it. The equivalent from GitHub's
> fork is "can only blame one tree at a time", and I think the difficulty
> in parsing is that "last-modified" isn't a verb.

Oh yeah, I've been struggling with that myself as well. I'm open to a
rename, if you've got a better name?

-- 
Cheers,
Toon
