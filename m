Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 157351F404
	for <e@80x24.org>; Mon, 26 Mar 2018 15:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeCZPNU (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 11:13:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43334 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751249AbeCZPNT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 11:13:19 -0400
Received: (qmail 1278 invoked by uid 109); 26 Mar 2018 15:13:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Mar 2018 15:13:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20100 invoked by uid 111); 26 Mar 2018 15:14:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Mar 2018 11:14:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2018 11:13:17 -0400
Date:   Mon, 26 Mar 2018 11:13:17 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v7 00/13] nd/pack-objects-pack-struct updates
Message-ID: <20180326151317.GA24425@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com>
 <20180324063353.24722-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180324063353.24722-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 07:33:40AM +0100, Nguyễn Thái Ngọc Duy wrote:

> +unsigned long oe_get_size_slow(struct packing_data *pack,
> +			       const struct object_entry *e)
> +{
> +	struct packed_git *p;
> +	struct pack_window *w_curs;
> +	unsigned char *buf;
> +	enum object_type type;
> +	unsigned long used, avail, size;
> +
> +	if (e->type_ != OBJ_OFS_DELTA && e->type_ != OBJ_REF_DELTA) {
> +		read_lock();
> +		if (sha1_object_info(e->idx.oid.hash, &size) < 0)
> +			die(_("unable to get size of %s"),
> +			    oid_to_hex(&e->idx.oid));
> +		read_unlock();
> +		return size;
> +	}
> +
> +	p = oe_in_pack(pack, e);
> +	if (!p)
> +		die("BUG: when e->type is a delta, it must belong to a pack");
> +
> +	read_lock();
> +	w_curs = NULL;
> +	buf = use_pack(p, &w_curs, e->in_pack_offset, &avail);
> +	used = unpack_object_header_buffer(buf, avail, &type, &size);
> +	if (used == 0)
> +		die(_("unable to parse object header of %s"),
> +		    oid_to_hex(&e->idx.oid));
> +
> +	unuse_pack(&w_curs);
> +	read_unlock();
> +	return size;
> +}

It took me a while to figure out why this treated deltas and non-deltas
differently. At first I thought it was an optimization (since we can
find non-delta sizes quickly by looking at the headers).  But I think
it's just that you want to know the size of the actual _delta_, not the
reconstructed object. And there's no way to ask sha1_object_info() for
that.

Perhaps the _extended version of that function should learn an
OBJECT_INFO_NO_DEREF flag or something to tell it return the true delta
type and size. Then this whole function could just become a single call.

But short of that, it's probably worth a comment explaining what's going
on.

> +static void prepare_in_pack_by_idx(struct packing_data *pdata)
> +{
> +	struct packed_git **mapping, *p;
> +	int cnt = 0, nr = 1 << OE_IN_PACK_BITS;
> +
> +	if (getenv("GIT_TEST_FULL_IN_PACK_ARRAY")) {
> +		/*
> +		 * leave in_pack_by_idx NULL to force in_pack[] to be
> +		 * used instead
> +		 */
> +		return;
> +	}

Minor nit, but can we use git_env_bool() here? It's just as easy, and
it's less surprising in some corner cases.

>  struct object_entry *packlist_alloc(struct packing_data *pdata,
>  				    const unsigned char *sha1,
>  				    uint32_t index_pos)
>  {
>  	struct object_entry *new_entry;
>  
> +	if (!pdata->nr_objects) {
> +		prepare_in_pack_by_idx(pdata);
> +		if (getenv("GIT_TEST_OE_SIZE_BITS")) {
> +			int bits = atoi(getenv("GIT_TEST_OE_SIZE_BITS"));;
> +			pdata->oe_size_limit = 1 << bits;
> +		}
> +		if (!pdata->oe_size_limit)
> +			pdata->oe_size_limit = 1 << OE_SIZE_BITS;
> +	}

Ditto here; I think this could just be:

  pdata->oe_size_limit = git_env_ulong("GIT_TEST_OE_SIZE_BITS",
                                       (1 << OE_SIZE_BITS));

>  	if (pdata->nr_objects >= pdata->nr_alloc) {
>  		pdata->nr_alloc = (pdata->nr_alloc  + 1024) * 3 / 2;
>  		REALLOC_ARRAY(pdata->objects, pdata->nr_alloc);
> +
> +		if (!pdata->in_pack_by_idx)
> +			REALLOC_ARRAY(pdata->in_pack, pdata->nr_alloc);
>  	}

I was going to complain that we don't use ALLOC_GROW() here, but
actually that part is in the context. ;)

> @@ -35,7 +36,9 @@ enum dfs_state {
>   *
>   * "size" is the uncompressed object size. Compressed size of the raw
>   * data for an object in a pack is not stored anywhere but is computed
> - * and made available when reverse .idx is made.
> + * and made available when reverse .idx is made. Note that when an
> + * delta is reused, "size" is the uncompressed _delta_ size, not the
> + * canonical one after the delta has been applied.

s/an delta/a delta/

> +Running tests with special setups
> +---------------------------------
> +
> +The whole test suite could be run to test some special features
> +that cannot be easily covered by a few specific test cases. These
> +could be enabled by running the test suite with correct GIT_TEST_
> +environment set.
> +
> +GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
> +
> +GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
> +path where there are more than 1024 packs even if the actual number of
> +packs in repository is below this limit.
> +
> +GIT_TEST_OE_SIZE_BITS=<bits> exercises the uncommon pack-objects
> +code path where we do not cache objecct size in memory and read it
> +from existing packs on demand. This normally only happens when the
> +object size is over 2GB. This variable forces the code path on any
> +object larger than 2^<bits> bytes.

It's nice to have these available to test the uncommon cases. But I have
a feeling nobody will ever run them, since it requires extra effort (and
takes a full test run).

I see there's a one-off test for GIT_TEST_FULL_IN_PACK_ARRAY, which I
think is a good idea, since it makes sure the code is exercised in a
normal test suite run. Should we do the same for GIT_TEST_OE_SIZE_BITS?

Also, s/objecct/object/. :)

> [...]

I haven't done an in-depth read of each patch yet; this was just what
jumped out at me from reading the interdiff.

-Peff
