Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3C7C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AEF2225E
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aySLKqYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKBTfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:35:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58257 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgKBTfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:35:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FBA08E0CD;
        Mon,  2 Nov 2020 14:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KH7MpT2+L+a8
        Srq8uKltAAhUsHk=; b=aySLKqYCQrjBa3HhcrMbbC/km+ye76NDF+od3/RPkhxy
        on7mtasHIRyW4P1qtrvtunLt8VpPoEjpWzDs4uSCZ7fPpvKu8xHwD3j1Jml8O9W9
        vMrBAmEioBVy1HelaQMv86GHR1sF0Ouepg26RH3c03srfWL3phPJuK/hWS5mJJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=seeRYw
        opunuUXdlKUbdKnSThXfn+dYf9vXL0UZ79TmfWTwd8sAjuiGYWolTO2hKJeWQ4MA
        yDpk3sEyazOIR2/nd+Vfx7j/v7aaqhB44TfTJ/6PuoEzVavLz+FPTWzjaG3FaD2v
        +PPJ05jHtGZuUJyRJgXgIeMWzbp4XLUtYpVZc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 855568E0CC;
        Mon,  2 Nov 2020 14:35:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 032DC8E0CB;
        Mon,  2 Nov 2020 14:35:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, git@jeffhostetler.com,
        chriscool@tuxfamily.org, peff@peff.net, newren@gmail.com,
        jrnieder@gmail.com, martin.agren@gmail.com
Subject: Re: [PATCH v3 10/19] unpack-trees: add basic support for parallel
 checkout
References: <cover.1603937110.git.matheus.bernardino@usp.br>
        <2bdc13664e65a25607b8ecb4c0ea54fb2dad482c.1603937110.git.matheus.bernardino@usp.br>
Date:   Mon, 02 Nov 2020 11:35:37 -0800
In-Reply-To: <2bdc13664e65a25607b8ecb4c0ea54fb2dad482c.1603937110.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Wed, 28 Oct 2020 23:14:47 -0300")
Message-ID: <xmqq361rv9fa.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96397442-1D42-11EB-B04C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> This new interface allows us to enqueue some of the entries being
> checked out to later call write_entry() for them in parallel. For now,
> the parallel checkout machinery is enabled by default and there is no
> user configuration, but run_parallel_checkout() just writes the queued
> entries in sequence (without spawning additional workers).

In other words, this would show the worst case overhead caused by
the framework to allow parallel checkout, relative to the current
code.  Which is quite a sensible and separate step to have in the
series.  I like it.

> The next
> patch will actually implement the parallelism and, later, we will make
> it configurable.

OK.

> When there are path collisions among the entries being written (which
> can happen e.g. with case-sensitive files in case-insensitive file
> systems), the parallel checkout code detects the problem and marks the
> item with PC_ITEM_COLLIDED. Later, these items are sequentially fed to
> checkout_entry() again. This is similar to the way the sequential code
> deals with collisions, overwriting the previously checked out entries
> with the subsequent ones. The only difference is that, when we start
> writing the entries in parallel, we won't be able to determine which of
> the colliding entries will survive on disk (for the sequential
> algorithm, it is always the last one).

Sure.  "The last one" determinism does not buy us very much, but it
is prudent to keep such a behavioural difference in mind.

> I also experimented with the idea of not overwriting colliding entries,
> and it seemed to work well in my simple tests. However, because just on=
e
> entry of each colliding group would be actually written, the others
> would have null lstat() fields on the index. This might not be a proble=
m
> by itself, but it could cause performance penalties for subsequent
> commands that need to refresh the index: when the st_size value cached
> is 0, read-cache.c:ie_modified() will go to the filesystem to see if th=
e
> contents match. As mentioned in the function:
>
>     * Immediately after read-tree or update-index --cacheinfo,
>     * the length field is zero, as we have never even read the
>     * lstat(2) information once, and we cannot trust DATA_CHANGED
>     * returned by ie_match_stat() which in turn was returned by
>     * ce_match_stat_basic() to signal that the filesize of the
>     * blob changed.  We have to actually go to the filesystem to
>     * see if the contents match, and if so, should answer "unchanged".
>
> So, if we have N entries in a colliding group and we decide to write an=
d
> lstat() only one of them, every subsequent git-status will have to read=
,
> convert, and hash the written file N - 1 times, to check that the N - 1
> unwritten entries are dirty. By checking out all colliding entries (lik=
e
> the sequential code does), we only pay the overhead once.

And the cost is to writing them out N times is not free, either, I
presume?

But I do not see the point of wasting engineering effort by trying
to make it more efficient to create a corrupt working tree that is
unusable because some paths that ought to exist are missing, so I
think it is OK.

> Co-authored-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
> Co-authored-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  Makefile            |   1 +
>  entry.c             |  17 +-
>  parallel-checkout.c | 368 ++++++++++++++++++++++++++++++++++++++++++++
>  parallel-checkout.h |  27 ++++
>  unpack-trees.c      |   6 +-
>  5 files changed, 416 insertions(+), 3 deletions(-)
>  create mode 100644 parallel-checkout.c
>  create mode 100644 parallel-checkout.h
>
> diff --git a/Makefile b/Makefile
> index 1fb0ec1705..10ee5e709b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -945,6 +945,7 @@ LIB_OBJS +=3D pack-revindex.o
>  LIB_OBJS +=3D pack-write.o
>  LIB_OBJS +=3D packfile.o
>  LIB_OBJS +=3D pager.o
> +LIB_OBJS +=3D parallel-checkout.o
>  LIB_OBJS +=3D parse-options-cb.o
>  LIB_OBJS +=3D parse-options.o
>  LIB_OBJS +=3D patch-delta.o
> diff --git a/entry.c b/entry.c
> index 9d79a5671f..6676954431 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -7,6 +7,7 @@
>  #include "progress.h"
>  #include "fsmonitor.h"
>  #include "entry.h"
> +#include "parallel-checkout.h"
> =20
>  static void create_directories(const char *path, int path_len,
>  			       const struct checkout *state)
> @@ -426,8 +427,17 @@ static void mark_colliding_entries(const struct ch=
eckout *state,
>  	for (i =3D 0; i < state->istate->cache_nr; i++) {
>  		struct cache_entry *dup =3D state->istate->cache[i];
> =20
> -		if (dup =3D=3D ce)
> -			break;
> +		if (dup =3D=3D ce) {
> +			/*
> +			 * Parallel checkout creates the files in no particular
> +			 * order. So the other side of the collision may appear
> +			 * after the given cache_entry in the array.
> +			 */
> +			if (parallel_checkout_status() =3D=3D PC_RUNNING)
> +				continue;
> +			else
> +				break;
> +		}
> =20
>  		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
>  			continue;
> @@ -536,6 +546,9 @@ int checkout_entry_ca(struct cache_entry *ce, struc=
t conv_attrs *ca,
>  		ca =3D &ca_buf;
>  	}
> =20
> +	if (!enqueue_checkout(ce, ca))
> +		return 0;
> +
>  	return write_entry(ce, path.buf, ca, state, 0);

It it is not wrong but feels strange that paths that cannot be
handled by parallel codepath for whatever reason are written using
the fallback code, but the fallback actually touches the disk before
the queued paths for parallel writeout ;-) What's the reason why
some paths cannot be handled by the new codepath again?  Also, can a
path that is handled by the fallback code collide with other paths
that are handled by the parallel codepath, and what happens for
these paths?

>  }
> =20
> diff --git a/parallel-checkout.c b/parallel-checkout.c
> new file mode 100644
> index 0000000000..981dbe6ff3
> --- /dev/null
> +++ b/parallel-checkout.c
> @@ -0,0 +1,368 @@
> +#include "cache.h"
> +#include "entry.h"
> +#include "parallel-checkout.h"
> +#include "streaming.h"
> +
> +enum pc_item_status {
> +	PC_ITEM_PENDING =3D 0,
> +	PC_ITEM_WRITTEN,
> +	/*
> +	 * The entry could not be written because there was another file
> +	 * already present in its path or leading directories. Since
> +	 * checkout_entry_ca() removes such files from the working tree befor=
e
> +	 * enqueueing the entry for parallel checkout, it means that there wa=
s
> +	 * a path collision among the entries being written.
> +	 */
> +	PC_ITEM_COLLIDED,
> +	PC_ITEM_FAILED,
> +};
> +
> +struct parallel_checkout_item {
> +	/* pointer to a istate->cache[] entry. Not owned by us. */
> +	struct cache_entry *ce;
> +	struct conv_attrs ca;
> +	struct stat st;
> +	enum pc_item_status status;
> +};
> +
> +struct parallel_checkout {
> +	enum pc_status status;
> +	struct parallel_checkout_item *items;
> +	size_t nr, alloc;
> +};
> +
> +static struct parallel_checkout parallel_checkout =3D { 0 };

Can't we let this handled by BSS by not explicitly giving an initial
value?

> +enum pc_status parallel_checkout_status(void)
> +{
> +	return parallel_checkout.status;
> +}
> +
> +void init_parallel_checkout(void)
> +{
> +	if (parallel_checkout.status !=3D PC_UNINITIALIZED)
> +		BUG("parallel checkout already initialized");
> +
> +	parallel_checkout.status =3D PC_ACCEPTING_ENTRIES;
> +}
> +
> +static void finish_parallel_checkout(void)
> +{
> +	if (parallel_checkout.status =3D=3D PC_UNINITIALIZED)
> +		BUG("cannot finish parallel checkout: not initialized yet");
> +
> +	free(parallel_checkout.items);
> +	memset(&parallel_checkout, 0, sizeof(parallel_checkout));
> +}
> +
> +static int is_eligible_for_parallel_checkout(const struct cache_entry =
*ce,
> +					     const struct conv_attrs *ca)
> +{
> +	enum conv_attrs_classification c;
> +
> +	if (!S_ISREG(ce->ce_mode))
> +		return 0;
> +
> +	c =3D classify_conv_attrs(ca);
> +	switch (c) {
> +	case CA_CLASS_INCORE:
> +		return 1;
> +
> +	case CA_CLASS_INCORE_FILTER:
> +		/*
> +		 * It would be safe to allow concurrent instances of
> +		 * single-file smudge filters, like rot13, but we should not
> +		 * assume that all filters are parallel-process safe. So we
> +		 * don't allow this.
> +		 */
> +		return 0;
> +
> +	case CA_CLASS_INCORE_PROCESS:
> +		/*
> +		 * The parallel queue and the delayed queue are not compatible,
> +		 * so they must be kept completely separated. And we can't tell
> +		 * if a long-running process will delay its response without
> +		 * actually asking it to perform the filtering. Therefore, this
> +		 * type of filter is not allowed in parallel checkout.
> +		 *
> +		 * Furthermore, there should only be one instance of the
> +		 * long-running process filter as we don't know how it is
> +		 * managing its own concurrency. So, spreading the entries that
> +		 * requisite such a filter among the parallel workers would
> +		 * require a lot more inter-process communication. We would
> +		 * probably have to designate a single process to interact with
> +		 * the filter and send all the necessary data to it, for each
> +		 * entry.
> +		 */
> +		return 0;
> +
> +	case CA_CLASS_STREAMABLE:
> +		return 1;
> +
> +	default:
> +		BUG("unsupported conv_attrs classification '%d'", c);
> +	}
> +}

OK, the comments fairly clearly explain the reason for each case.
Good.

> +static int handle_results(struct checkout *state)
> +{
> +	int ret =3D 0;
> +	size_t i;
> +	int have_pending =3D 0;
> +
> +	/*
> +	 * We first update the successfully written entries with the collecte=
d
> +	 * stat() data, so that they can be found by mark_colliding_entries()=
,
> +	 * in the next loop, when necessary.
> +	 */
> +	for (i =3D 0; i < parallel_checkout.nr; ++i) {

We encourage post_increment++ when there is no particular reason to
do otherwise in this codebase (I won't repeat in the remainder of
this review).

> +static int reset_fd(int fd, const char *path)
> +{
> +	if (lseek(fd, 0, SEEK_SET) !=3D 0)
> +		return error_errno("failed to rewind descriptor of %s", path);
> +	if (ftruncate(fd, 0))
> +		return error_errno("failed to truncate file %s", path);
> +	return 0;
> +}

This is in the error codepath when streaming fails, and we'll later
attempt the normal "read object in-core, write it out" codepath, but
is it enough to just ftruncate() it?  I am wondering why it is OK
not to unlink() the failed one---is it the caller who is responsible
for opening the file descriptor to write to, and at the layer of the
caller of this helper there is no way to re-open it, or something
like that?

	... /me looks ahead and it seems the answer is "yes".

> +static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item,=
 int fd,
> +			       const char *path)
> ...
> +	if (filter) {
> +		if (stream_blob_to_fd(fd, &pc_item->ce->oid, filter, 1)) {
> +			/* On error, reset fd to try writing without streaming */
> +			if (reset_fd(fd, path))
> +				return -1;
> +		} else {
> +			return 0;
> +		}
> +	}
> +
> +	new_blob =3D read_blob_entry(pc_item->ce, &size);
> ...
> +	wrote =3D write_in_full(fd, new_blob, size);

> +static int check_leading_dirs(const char *path, int len, int prefix_le=
n)
> +{
> +	const char *slash =3D path + len;
> +
> +	while (slash > path && *slash !=3D '/')
> +		slash--;

It is kind of surprising that we do not give us an easy-to-use
helper to find the separtor between dirname and basename.  If there
were, we do not even need this helper function with an unclear name
(i.e. "check" does not mean much to those who are trying to
understand the caller---"leading directories are checked for
what???" will be their question).

Perhaps create or find such a helper to remove this function and use
has_dirs_only_path() directly in the caller?

> +	return has_dirs_only_path(path, slash - path, prefix_len);
> +}

> +static void write_pc_item(struct parallel_checkout_item *pc_item,
> +			  struct checkout *state)
> +{
> +	unsigned int mode =3D (pc_item->ce->ce_mode & 0100) ? 0777 : 0666;
> +	int fd =3D -1, fstat_done =3D 0;
> +	struct strbuf path =3D STRBUF_INIT;
> +
> +	strbuf_add(&path, state->base_dir, state->base_dir_len);
> +	strbuf_add(&path, pc_item->ce->name, pc_item->ce->ce_namelen);
> +
> +	/*
> +	 * At this point, leading dirs should have already been created. But =
if
> +	 * a symlink being checked out has collided with one of the dirs, due=
 to
> +	 * file system folding rules, it's possible that the dirs are no long=
er

Is "file system folding rule" clear to readers of the code after
this patch lands?  It isn't at least to me.

> +	 * present. So we have to check again, and report any path collisions=
.
> +	 */
> +	if (!check_leading_dirs(path.buf, path.len, state->base_dir_len)) {
> +		pc_item->status =3D PC_ITEM_COLLIDED;
> +		goto out;
> +	}

Thanks.
