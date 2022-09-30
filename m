Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0E2C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 06:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiI3GVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 02:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiI3GVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 02:21:02 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50051A2A
        for <git@vger.kernel.org>; Thu, 29 Sep 2022 23:21:00 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDB2B157B00;
        Fri, 30 Sep 2022 02:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=m6m2yQZ6fu4lQd2fxVh+fEw6v+PgVxU4Kl5XPy6tJzk=; b=UWDh
        g/HZJ2NS9q0ED2uxjNt3OgfPRpk40cY7DUjogpeHzIRNOwq6ESDOUZ4TnMHOpKDd
        28Wy7lLHK+wGTjOuyxCHaKqlmiB7dpwQjvfd3AE7PxrgILohGoupmuJG6Y9ALuws
        baA272WnnYVkblJ7n0gvH/mbeEQ3yx7lB9QWsBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B43CD157AFF;
        Fri, 30 Sep 2022 02:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25A4F157AFD;
        Fri, 30 Sep 2022 02:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
        <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Sep 2022 23:20:58 -0700
Message-ID: <xmqqczbdl6wl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0CBC1AEC-4088-11ED-8FA1-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
>
> Roaring bitmaps are said to be more efficient (most of the time) than
> ewah bitmaps. So Git might gain some optimization if it support roaring
> bitmaps. As Roaring library has all the changes it needed to implement
> roaring bitmaps in Git, Git can learn to write roaring bitmaps. However,
> all the changes are backward-compatible.
>
> Teach Git to write roaring bitmaps.

That is way underexplained.   At least cover what the plans are, so
that readers do not have to ask these questions:

 * When is the choice of bitmap type is made?  Is it fixed at
   repository initialization time and once chosen other kinds cannot
   be used?

 * Is the bitmap file self describing?  How does a reader know
   between ewah and roaring codepaths to use to read a given bitmap
   file?  Is there enough room for extending the set of bitmap
   formats, or we cannot add other formats easily?

> Mentored-by: Taylor Blau <me@ttaylorr.com>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> ---
>  Makefile                |   1 +
>  bitmap.c                | 225 +++++++++++++++++++++++++++
>  bitmap.h                |  33 ++++
>  builtin/diff.c          |  10 +-
>  ewah/bitmap.c           |  61 +++++---
>  ewah/ewok.h             |  37 ++---
>  pack-bitmap-write.c     | 326 ++++++++++++++++++++++++++++++----------
>  pack-bitmap.c           | 114 +++++++-------
>  pack-bitmap.h           |  22 ++-
>  t/t5310-pack-bitmaps.sh |  17 +++
>  10 files changed, 664 insertions(+), 182 deletions(-)
>  create mode 100644 bitmap.c
>  create mode 100644 bitmap.h
>
> diff --git a/Makefile b/Makefile
> index e9537951105..9ca19b3ca8d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -900,6 +900,7 @@ LIB_OBJS += archive.o
>  LIB_OBJS += attr.o
>  LIB_OBJS += base85.o
>  LIB_OBJS += bisect.o
> +LIB_OBJS += bitmap.o
>  LIB_OBJS += blame.o
>  LIB_OBJS += blob.o
>  LIB_OBJS += bloom.o
> diff --git a/bitmap.c b/bitmap.c
> new file mode 100644
> index 00000000000..7d547eb9f53
> --- /dev/null
> +++ b/bitmap.c
> @@ -0,0 +1,225 @@
> +#include "bitmap.h"
> +#include "cache.h"
> +
> +static enum bitmap_type bitmap_type = INIT_BITMAP_TYPE;

"INIT" is a strange name for "UNINITIALIZED".  Especially ...

> +void *roaring_or_ewah_bitmap_init(void)
> +{
> +	switch (bitmap_type)
> +	{

(Style)

> +	case EWAH:
> +		return ewah_new();
> +	case ROARING:
> +		return roaring_bitmap_create();
> +	default:

... here, you use it to mean exactly that.

> +		error(_("bitmap type not initialized\n"));
> +		return NULL;

Do you really need the global variable that holds the bitmap type?

Wouldn't it be easier to write code that needs to deal with both
types (e.g. in a repository with existing ewah bitmap, you want to
do a repack and index the result using the roaring bitmap) if you
passed the type through the callchain as a parameter?

It may be that the codepath that reads from an existing bitmap file
says "ah, the file given to us seems to be in format X (either EWAH
or ROARING or perhaps something else), so let's call bitmap_init(X)
to obtain the in-core data structure to deal with that file".  When
that happens, you may probably need to have two cases in the default:
arm of this switch statement, i.e. one to diagnose a BUG() to pass
an uninitialized bitmap type to the codepath, and the other to
diagnose a runtime error() to have read a bitmap file whose format
this version of Git does not understand.

> +void *roaring_or_raw_bitmap_copy(void *bitmap)
> +{
> +	switch (bitmap_type)
> +	{
> +	case EWAH:
> ...
> +int roaring_or_ewah_bitmap_set(void *bitmap, uint32_t i)
> +{
> +	switch (bitmap_type) {
> +	case EWAH:
> +...
> +void roaring_or_raw_bitmap_set(void *bitmap, uint32_t i)
> +{
> +	switch (bitmap_type)
> +	{
> +	case EWAH:
> +...
> +void roaring_or_raw_bitmap_unset(void *bitmap, uint32_t i)
> +{
> +	switch (bitmap_type)
> +	{
> +	case EWAH:
> +...

These repetitive patterns makes me wonder if void *bitmap
is a good type to be passing around.  Shouldn't it be a struct with
its first member being a bitmap_type, and another member being what
these functions are passing to the underlying bitmap format specific
functions as "bitmap"?  E.g.

    void bitmap_unset(struct bitmap *bm, uint32_t i)
    {
	switch (bm->type) {
	case EWAH:
		ewah_bitmap_remove(bm->u.ewah, i);
		break;
	...


> \ No newline at end of file

Careful.

> diff --git a/bitmap.h b/bitmap.h
> new file mode 100644
> index 00000000000..d75400922cc
> --- /dev/null
> +++ b/bitmap.h
> @@ -0,0 +1,33 @@
> +#ifndef __BITMAP_H__
> +#define __BITMAP_H__
> +
> +
> +#include "git-compat-util.h"
> +#include "ewah/ewok.h"
> +#include "roaring/roaring.h"
> +
> +enum bitmap_type {
> +	INIT_BITMAP_TYPE = 0,

"UNINITIALIZED_BITMAP_TYPE", probably.

> +void *roaring_or_ewah_bitmap_init(void);

I would strongly suggest reconsider these names.  What if you later
want to add the third variant?  roaring_or_ewah_or_xyzzy_bitmap_init()?

Instead just use the most generic name, like "bitmap_init", perhaps
something along the lines of ...

    struct bitmap {
	enum bitmap_type type;
	union {
	    struct ewah_bitmap *ewah;
	    struct roaring_bitmap *roaring;
	} u;	
    };

    struct bitmap *bitmap_new(enum bitmap_type type)
    {
	struct bitmap *bm = xmalloc(sizeof(*bm));

	bm->type = type;
	switch (bm->type) {
	case EWAH:
	    bm->u.ewah = ewah_new();
	    break;
	case ROARING:
	    bm->u.roaring = roaring_bitmap_create();
	    break;
        default:
	    die(_("unknown bitmap type %d"), (int)type);
	}
	return bm;
    }

I dunno.

