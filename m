Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A28C352A1
	for <git@archiver.kernel.org>; Wed,  7 Dec 2022 06:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLGGmk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Dec 2022 01:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGGmb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2022 01:42:31 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B922743ADD
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 22:42:30 -0800 (PST)
Received: (qmail 17952 invoked by uid 109); 7 Dec 2022 06:42:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Dec 2022 06:42:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30893 invoked by uid 111); 7 Dec 2022 06:42:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Dec 2022 01:42:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Dec 2022 01:42:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/3] object-file: emit corruption errors when detected
Message-ID: <Y5A11dOFgHP/ADcS@coredump.intra.peff.net>
References: <cover.1669839849.git.jonathantanmy@google.com>
 <cover.1670373420.git.jonathantanmy@google.com>
 <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9ddfff3585c293c9801570e395b514505796a43f.1670373420.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2022 at 04:40:52PM -0800, Jonathan Tan wrote:

> Note that in the RHS of this patch's diff, a check for ENOENT that was
> introduced in 3ba7a06552 (A loose object is not corrupt if it cannot
> be read due to EMFILE, 2010-10-28) is also removed. The purpose of this
> check is to avoid a false report of corruption if the errno contains
> something like EMFILE (or anything that is not ENOENT), in which case
> a more generic report is presented. Because, as of this patch, we no
> longer rely on such a heuristic to determine corruption, but surface
> the error message at the point when we read something that we did not
> expect, this check is no longer necessary.

You're right that this will not say "oops, the object is corrupted" when
we get EMFILE, etc, which is what 3ba7a06552 was fixing. But I think
after your patch, we would also never actually say "could not open
$path: too many open descriptors". I don't think that kicked in reliably
with the current code, but it seems like something we are losing in this
patch.

I.e., I think you'd want to also complain when map_loose_object()
returns anything but ENOENT. The errno value there is reliable-ish,
though it might be worth spending the extra work to preserve it across
the close() calls, just in case. Or if you split the open/mmap as Ævar
suggested, then it becomes:

  fd = open_loose_object(r, oid, &path);
  if (fd < 0) {
	if (errno != ENOENT)
		error_errno("unable to open loose object %s", path);
	return -1;
  }

  buf = map_loose_object_1(fd, path);
  if (!buf) {
	/* not much point in complaining here, as xmmap will die on
	 * error. In theory this could catch fstat() problems, but
	 * probably map_loose_object_1() itself should do so, since
	 * it already is special-casing empty files.
	 */
        close(fd);
	return -1;
  }

> diff --git a/object-file.c b/object-file.c
> index 596dd049fd..c7a513d123 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1215,7 +1215,8 @@ static int quick_has_loose(struct repository *r,
>   * searching for a loose object named "oid".
>   */
>  static void *map_loose_object_1(struct repository *r, const char *path,
> -			     const struct object_id *oid, unsigned long *size)
> +				const struct object_id *oid, unsigned long *size,
> +				char **mapped_path)
>  {
>  	void *map;
>  	int fd;
> @@ -1224,6 +1225,9 @@ static void *map_loose_object_1(struct repository *r, const char *path,
>  		fd = git_open(path);
>  	else
>  		fd = open_loose_object(r, oid, &path);
> +	if (mapped_path)
> +		*mapped_path = xstrdup(path);
> +

This introduces an extra malloc/free in every object lookup, even in the
success case where we don't even bother using the value. It's probably
not really noticeable, but it kind of feels wrong. Especially when
open_loose_object() already returns a pointer to long-ish term storage.

One solution is...

> @@ -1497,8 +1504,13 @@ static int loose_object_info(struct repository *r,
>  		break;
>  	}
>  
> +	if (status && (flags & OBJECT_INFO_DIE_IF_CORRUPT))
> +		die(_("loose object %s (stored in %s) is corrupt"),
> +		    oid_to_hex(oid), mapped_path);
> +

...we could just say "loose object %s is corrupt", which is generally
sufficient (outside of alternates, you can only have one copy anyway).

But if we want to retain it, we could just redo the lookup in the error
path, which is what the existing code (that you're deleting) does, via
stat_loose_object(). That's even more wasteful than an extra
malloc/free, but you only pay the cost for a corrupted object. It's
racy, of course, but probably not in a meaningful way in practice.

Alternatively, I like Ævar's suggestion to just split
map_loose_object(). Then this code would naturally have the path, via
calling open_loose_object() itself.

> diff --git a/object-store.h b/object-store.h
> index 1be57abaf1..01134ab5ec 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -447,6 +447,9 @@ struct object_info {
>   */
>  #define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
>  
> +/* Die if object corruption (not just an object being missing) was detected. */
> +#define OBJECT_INFO_DIE_IF_CORRUPT 64

I have a suspicion that the world would be a better place if these die()
calls simply went away, in favor of returning -1 up the stack. But I'm
OK leaving it as-is for the sake of trying not to do too many things at
once (I probably wouldn't have even mentioned it, except that if we do
want to end up there in the long run, we'd eventually have to rip out
this new flag and its associated plumbing).

-Peff
