Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D68C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CFB761C89
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 23:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGFXDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 19:03:55 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46826 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhGFXDy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 19:03:54 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id C622A1F8C6;
        Tue,  6 Jul 2021 23:01:15 +0000 (UTC)
Date:   Tue, 6 Jul 2021 23:01:15 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] speed up alt_odb_usable() with many alternates
Message-ID: <20210706230115.GA8624@dcvr>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-2-e@80x24.org>
 <fc342ddd-1b35-62cc-dd4b-e0462d595819@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc342ddd-1b35-62cc-dd4b-e0462d595819@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> wrote:
> Am 29.06.21 um 22:53 schrieb Eric Wong:
> > With many alternates, the duplicate check in alt_odb_usable()
> > wastes many cycles doing repeated fspathcmp() on every existing
> > alternate.  Use a khash to speed up lookups by odb->path.
> >
> > Since the kh_put_* API uses the supplied key without
> > duplicating it, we also take advantage of it to replace both
> > xstrdup() and strbuf_release() in link_alt_odb_entry() with
> > strbuf_detach() to avoid the allocation and copy.
> >
> > In a test repository with 50K alternates and each of those 50K
> > alternates having one alternate each (for a total of 100K total
> > alternates); this speeds up lookup of a non-existent blob from
> > over 16 minutes to roughly 2.7 seconds on my busy workstation.
> 
> Yay for hashmaps! :)
> 
> > Note: all underlying git object directories were small and
> > unpacked with only loose objects and no packs.  Having to load
> > packs increases times significantly.
> >
> > Signed-off-by: Eric Wong <e@80x24.org>
> > ---
> >  object-file.c  | 33 ++++++++++++++++++++++-----------
> >  object-store.h | 17 +++++++++++++++++
> >  object.c       |  2 ++
> >  3 files changed, 41 insertions(+), 11 deletions(-)
> >
> > diff --git a/object-file.c b/object-file.c
> > index f233b440b2..304af3a172 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -517,9 +517,9 @@ const char *loose_object_path(struct repository *r, struct strbuf *buf,
> >   */
> >  static int alt_odb_usable(struct raw_object_store *o,
> >  			  struct strbuf *path,
> > -			  const char *normalized_objdir)
> > +			  const char *normalized_objdir, khiter_t *pos)
> >  {
> > -	struct object_directory *odb;
> > +	int r;
> >
> >  	/* Detect cases where alternate disappeared */
> >  	if (!is_directory(path->buf)) {
> > @@ -533,14 +533,22 @@ static int alt_odb_usable(struct raw_object_store *o,
> >  	 * Prevent the common mistake of listing the same
> >  	 * thing twice, or object directory itself.
> >  	 */
> > -	for (odb = o->odb; odb; odb = odb->next) {
> > -		if (!fspathcmp(path->buf, odb->path))
> > -			return 0;
> > +	if (!o->odb_by_path) {
> > +		khiter_t p;
> > +
> > +		o->odb_by_path = kh_init_odb_path_map();
> > +		assert(!o->odb->next);
> > +		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
> 
> So on the first run you not just create the hashmap, but you also
> pre-populate it with the main object directory.  Makes sense.  The
> hashmap wouldn't even be created in repositories without alternates.
> 
> > +		if (r < 0) die_errno(_("kh_put_odb_path_map"));
> 
> Our other callers don't handle a negative return code because it would
> indicate an allocation failure, and in our version we use ALLOC_ARRAY,
> which dies on error.  So you don't need that check here, but we better
> clarify that in khash.h.
> 
> > +		assert(r == 1); /* never used */
> > +		kh_value(o->odb_by_path, p) = o->odb;
> >  	}
> >  	if (!fspathcmp(path->buf, normalized_objdir))
> >  		return 0;
> > -
> > -	return 1;
> > +	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
> > +	if (r < 0) die_errno(_("kh_put_odb_path_map"));
> 
> Dito.
> 
> > +	/* r: 0 = exists, 1 = never used, 2 = deleted */
> > +	return r == 0 ? 0 : 1;
> 
> The comment indicates that khash would be nicer to use if it had an
> enum for the kh_put return values.  Perhaps, but that should be done in
> another series.

Agreed for another series.  I've also found myself wishing khash
used enums.  But I'm also not sure how much changing of 3rd
party code we should be doing...

> I like the solution in oidset.c to make this more readable, though: Call
> the return value "added" instead of "r" and then a "return !added;"
> makes sense without additional comments.
> 
> >  }
> >
> >  /*
> > diff --git a/object-store.h b/object-store.h
> > index ec32c23dcb..20c1cedb75 100644
> > --- a/object-store.h
> > +++ b/object-store.h
> > @@ -7,6 +7,8 @@
> >  #include "oid-array.h"
> >  #include "strbuf.h"
> >  #include "thread-utils.h"
> > +#include "khash.h"
> > +#include "dir.h"
> >
> >  struct object_directory {
> >  	struct object_directory *next;
> > @@ -30,6 +32,19 @@ struct object_directory {
> >  	char *path;
> >  };
> >
> > +static inline int odb_path_eq(const char *a, const char *b)
> > +{
> > +	return !fspathcmp(a, b);
> > +}
> 
> This is not specific to the object store.  It could be called fspatheq
> and live in dir.h.  Or dir.c -- a surprising amount of code seems to
> necessary for that negation (https://godbolt.org/z/MY7Wda3a7).  Anyway,
> it's just an idea for another series.

No JS here for godbolt, but there's also a bunch of "!fspathcmp"
here that could probably be changed to fspatheq.

> > +
> > +static inline int odb_path_hash(const char *str)
> > +{
> > +	return ignore_case ? strihash(str) : __ac_X31_hash_string(str);
> > +}
> 
> The internal Attractive Chaos (__ac_*) macros should be left confined
> to khash.h, I think.  Its alias kh_str_hash_func would be better
> suited here.
> 
> Do we want to use the K&R hash function here at all, though?  If we
> use FNV-1 when ignoring case, why not also use it (i.e. strhash) when
> respecting it?  At least that's done in builtin/sparse-checkout.c,
> dir.c and merge-recursive.c.  This is just handwaving and yammering
> about lack of symmetry, but I do wonder how your performance numbers
> look with strhash.  If it's fine then we could package this up as
> fspathhash..

Yeah, I think fspathhash should be path_hash in merge-recursive.c
(and path_hash eliminated).

I don't have performance numbers, and I doubt hash function
performance is much overhead, here.  I used X31 since it was
local to khash.

I would prefer we only have one non-cryptographic hash
implementation to reduce cognitive overhead, so maybe we can
drop X31 entirely for FNV-1.  I'd also prefer we only have khash
or hashmap, not both.

> And I also wonder how it looks if you use strihash unconditionally.
> I guess case collisions are usually rare and branching based on a
> global variable may be more expensive than case folding.

*shrug* I'll let somebody with more appropriate systems do
benchmarks, there.  But it could be an easy switch once
fspathhash is in place.
