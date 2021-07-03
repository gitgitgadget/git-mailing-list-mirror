Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A4C07E97
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463936145C
	for <git@archiver.kernel.org>; Sat,  3 Jul 2021 10:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhGCKIg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 3 Jul 2021 06:08:36 -0400
Received: from mout.web.de ([212.227.17.11]:39867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhGCKIf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Jul 2021 06:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1625306745;
        bh=+TAo//fbu0gj2pNQawLYJbyAwNlgU92Oh3l0QBn5t84=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=TcQnEZJ4UQFnaQVVd4nIu99T041nv2yM4EzyrNdlDb23Ox5iyDPY4SloV1YpOnYQJ
         BtJE46J5HED8uythvYbkXmEtGyacMyZQ7uASBqEZjkMeqEcukjzHSxjO9mXxP867zq
         SQW0WVJ4gzCqXD4JhJhturZPmmsxL5XQcXi9JErU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.158.105]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MKIzC-1m1GQR0c5u-001iyS; Sat, 03 Jul 2021 12:05:45 +0200
Subject: Re: [PATCH v2 1/5] speed up alt_odb_usable() with many alternates
To:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-2-e@80x24.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fc342ddd-1b35-62cc-dd4b-e0462d595819@web.de>
Date:   Sat, 3 Jul 2021 12:05:44 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629205305.7100-2-e@80x24.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VWgot2Y7Gdj2Rk9Du5S1ik+KUIo9NZTg2O7FDijo7lY8O3GeR/r
 pxOArumjw/Jm0QxKeZyveqhElLaO+h/u4zBC1GYdgwPmaXB1L9grSrNkztvNeIgOuS0n6Yp
 BhZGsqsi9G8X3OX1jQugO83tNcn9rqJBHJ+OfLG/yZNf1FlGEE2UMht1mQKzBuoGlcgn3ZN
 x+nhYdR5dAU/NDfGIFFQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EEbE4DHhU4I=:o5COKe2h5vi2SYa/KBvOGN
 TsSJ3zsAwQN+ZaxLod49XXhEPrSy/GYkzrjF2tDfvIJTw6ugER8Kf8EqwqB3lceHT/qAZR4LA
 nydT+UqSQ0vwk1GhYxzd4PQBffqJyNuRR5ObJJiKwmdLNv1O9ie8hCTegNbx98E7fAakiGXBj
 vfwexUFlIf0a1iM3FVhWtgNYozr2QYz9P+JMPUuDpHaEKwWF+r87ZER4eVNj/kc8EUcz+0Ywh
 gPw04UA2OiY/yLfmFN1ASiAh/5yxp9Ta6pB/jRuClPJEYbdXPD5nuQI+1VmfyvRb5Kp4uCetO
 PpyznsalthZWe1TJgZX12HAAH8blQFrzIF4azFpVoQRha2d7D19F3bkQPKvfB6pwzj1OvMshO
 SazoD48Z9TBb/mrTQw8JCWZks7jRD7tTlOvicLvMSsxsEct9HxS+/JnBuejIuUSBmtF7k/djc
 sjY1FUcNwdWf4FKec48QxloD1KIHyIKwWT0qMwbuO5zScWOvzkZ6D/qE2KPabRsKfSr00SKoT
 joVmdkP4lDjhE9UYJtBHDWd8mAN3xiImN6Cvk/cTHjMX2ADSfD+/fcLJ+/Y5WOGb2JWbm+HGm
 N9xA4W+U1MjKwgELiPcDP5q0iRd7Xzk78I/FcQhmQ8N87IgP0hxOQuPDrg7hvHUI2Rg1uhU8w
 fJgojvozz/R2uFNqEyyilKUb738RewKpVZRPx10xDKbQ3SzWJ1V/Jz+L5mMue6M+ql/LrrXuk
 mSK/KfVEYBpyBUCscKyVp2xu8x0lIiajv3ulra4trRifGuKcrWUE3qdvjisbkpic9BRwVAEx/
 DwX0ndTgk4OHxSy8BRyJ004AyIkSwC3a+hbwPDG2wc26C61ovXEDDUHDCh9jdseP2LvZYaoQy
 OG80vup/s/dxunWoTJUUH7pTebXdzrMPM2AZ61d1at9oHrJhg59wHXpSJktyMUe9bTRf5c1oO
 CeAs223bXZh+UCe6rHg7fB6qJyyfMezlwSqIzrFpK1Z4hFvoAHlANQTzl0dLgSKS+qvarYQQe
 5ywQHkswLG9Myp60W+oZghFSVEvHrV4wXQHx3ZMQy9gdeLkkntmLMrQXUukSlnNSIVhAnyr5q
 QL3EfnByA1oJ7DAh3UgQPfOW9d6d8jr7nrL
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.21 um 22:53 schrieb Eric Wong:
> With many alternates, the duplicate check in alt_odb_usable()
> wastes many cycles doing repeated fspathcmp() on every existing
> alternate.  Use a khash to speed up lookups by odb->path.
>
> Since the kh_put_* API uses the supplied key without
> duplicating it, we also take advantage of it to replace both
> xstrdup() and strbuf_release() in link_alt_odb_entry() with
> strbuf_detach() to avoid the allocation and copy.
>
> In a test repository with 50K alternates and each of those 50K
> alternates having one alternate each (for a total of 100K total
> alternates); this speeds up lookup of a non-existent blob from
> over 16 minutes to roughly 2.7 seconds on my busy workstation.

Yay for hashmaps! :)

> Note: all underlying git object directories were small and
> unpacked with only loose objects and no packs.  Having to load
> packs increases times significantly.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  object-file.c  | 33 ++++++++++++++++++++++-----------
>  object-store.h | 17 +++++++++++++++++
>  object.c       |  2 ++
>  3 files changed, 41 insertions(+), 11 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index f233b440b2..304af3a172 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -517,9 +517,9 @@ const char *loose_object_path(struct repository *r, =
struct strbuf *buf,
>   */
>  static int alt_odb_usable(struct raw_object_store *o,
>  			  struct strbuf *path,
> -			  const char *normalized_objdir)
> +			  const char *normalized_objdir, khiter_t *pos)
>  {
> -	struct object_directory *odb;
> +	int r;
>
>  	/* Detect cases where alternate disappeared */
>  	if (!is_directory(path->buf)) {
> @@ -533,14 +533,22 @@ static int alt_odb_usable(struct raw_object_store =
*o,
>  	 * Prevent the common mistake of listing the same
>  	 * thing twice, or object directory itself.
>  	 */
> -	for (odb =3D o->odb; odb; odb =3D odb->next) {
> -		if (!fspathcmp(path->buf, odb->path))
> -			return 0;
> +	if (!o->odb_by_path) {
> +		khiter_t p;
> +
> +		o->odb_by_path =3D kh_init_odb_path_map();
> +		assert(!o->odb->next);
> +		p =3D kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);

So on the first run you not just create the hashmap, but you also
pre-populate it with the main object directory.  Makes sense.  The
hashmap wouldn't even be created in repositories without alternates.

> +		if (r < 0) die_errno(_("kh_put_odb_path_map"));

Our other callers don't handle a negative return code because it would
indicate an allocation failure, and in our version we use ALLOC_ARRAY,
which dies on error.  So you don't need that check here, but we better
clarify that in khash.h.

> +		assert(r =3D=3D 1); /* never used */
> +		kh_value(o->odb_by_path, p) =3D o->odb;
>  	}
>  	if (!fspathcmp(path->buf, normalized_objdir))
>  		return 0;
> -
> -	return 1;
> +	*pos =3D kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
> +	if (r < 0) die_errno(_("kh_put_odb_path_map"));

Dito.

> +	/* r: 0 =3D exists, 1 =3D never used, 2 =3D deleted */
> +	return r =3D=3D 0 ? 0 : 1;

The comment indicates that khash would be nicer to use if it had an
enum for the kh_put return values.  Perhaps, but that should be done in
another series.

I like the solution in oidset.c to make this more readable, though: Call
the return value "added" instead of "r" and then a "return !added;"
makes sense without additional comments.

>  }
>
>  /*
> @@ -566,6 +574,7 @@ static int link_alt_odb_entry(struct repository *r, =
const char *entry,
>  {
>  	struct object_directory *ent;
>  	struct strbuf pathbuf =3D STRBUF_INIT;
> +	khiter_t pos;
>
>  	if (!is_absolute_path(entry) && relative_base) {
>  		strbuf_realpath(&pathbuf, relative_base, 1);
> @@ -587,23 +596,25 @@ static int link_alt_odb_entry(struct repository *r=
, const char *entry,
>  	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] =3D=3D '/')
>  		strbuf_setlen(&pathbuf, pathbuf.len - 1);
>
> -	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir)) {
> +	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos)) {
>  		strbuf_release(&pathbuf);
>  		return -1;
>  	}
>
>  	CALLOC_ARRAY(ent, 1);
> -	ent->path =3D xstrdup(pathbuf.buf);
> +	/* pathbuf.buf is already in r->objects->odb_by_path */

Tricky stuff (to me), important comment.

> +	ent->path =3D strbuf_detach(&pathbuf, NULL);
>
>  	/* add the alternate entry */
>  	*r->objects->odb_tail =3D ent;
>  	r->objects->odb_tail =3D &(ent->next);
>  	ent->next =3D NULL;
> +	assert(r->objects->odb_by_path);
> +	kh_value(r->objects->odb_by_path, pos) =3D ent;
>
>  	/* recursively add alternates */
> -	read_info_alternates(r, pathbuf.buf, depth + 1);
> +	read_info_alternates(r, ent->path, depth + 1);
>
> -	strbuf_release(&pathbuf);
>  	return 0;
>  }
>
> diff --git a/object-store.h b/object-store.h
> index ec32c23dcb..20c1cedb75 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -7,6 +7,8 @@
>  #include "oid-array.h"
>  #include "strbuf.h"
>  #include "thread-utils.h"
> +#include "khash.h"
> +#include "dir.h"
>
>  struct object_directory {
>  	struct object_directory *next;
> @@ -30,6 +32,19 @@ struct object_directory {
>  	char *path;
>  };
>
> +static inline int odb_path_eq(const char *a, const char *b)
> +{
> +	return !fspathcmp(a, b);
> +}

This is not specific to the object store.  It could be called fspatheq
and live in dir.h.  Or dir.c -- a surprising amount of code seems to
necessary for that negation (https://godbolt.org/z/MY7Wda3a7).  Anyway,
it's just an idea for another series.

> +
> +static inline int odb_path_hash(const char *str)
> +{
> +	return ignore_case ? strihash(str) : __ac_X31_hash_string(str);
> +}

The internal Attractive Chaos (__ac_*) macros should be left confined
to khash.h, I think.  Its alias kh_str_hash_func would be better
suited here.

Do we want to use the K&R hash function here at all, though?  If we
use FNV-1 when ignoring case, why not also use it (i.e. strhash) when
respecting it?  At least that's done in builtin/sparse-checkout.c,
dir.c and merge-recursive.c.  This is just handwaving and yammering
about lack of symmetry, but I do wonder how your performance numbers
look with strhash.  If it's fine then we could package this up as
fspathhash..

And I also wonder how it looks if you use strihash unconditionally.
I guess case collisions are usually rare and branching based on a
global variable may be more expensive than case folding..

Anyway, just ideas; kh_str_hash_func would be OK as well.

> +
> +KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
> +	struct object_directory *, 1, odb_path_hash, odb_path_eq);
> +
>  void prepare_alt_odb(struct repository *r);
>  char *compute_alternate_path(const char *path, struct strbuf *err);
>  typedef int alt_odb_fn(struct object_directory *, void *);
> @@ -116,6 +131,8 @@ struct raw_object_store {
>  	 */
>  	struct object_directory *odb;
>  	struct object_directory **odb_tail;
> +	kh_odb_path_map_t *odb_by_path;
> +
>  	int loaded_alternates;
>
>  	/*
> diff --git a/object.c b/object.c
> index 14188453c5..2b3c075a15 100644
> --- a/object.c
> +++ b/object.c
> @@ -511,6 +511,8 @@ static void free_object_directories(struct raw_objec=
t_store *o)
>  		free_object_directory(o->odb);
>  		o->odb =3D next;
>  	}
> +	kh_destroy_odb_path_map(o->odb_by_path);
> +	o->odb_by_path =3D NULL;
>  }
>
>  void raw_object_store_clear(struct raw_object_store *o)
>
