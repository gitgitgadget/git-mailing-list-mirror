Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31913C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1640D60EB6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhINTD6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:03:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:47330 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhINTD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:03:57 -0400
Received: (qmail 25280 invoked by uid 109); 14 Sep 2021 19:02:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 19:02:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26990 invoked by uid 111); 14 Sep 2021 19:02:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 15:02:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 15:02:38 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs
 mode
Message-ID: <YUDxzhAnzI5Anm6F@coredump.intra.peff.net>
References: <cover.1631331139.git.me@ttaylorr.com>
 <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com>
 <YTzYYfBGqG87O5mN@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YTzYYfBGqG87O5mN@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:25:05PM -0400, Taylor Blau wrote:

> > Before calling string_list_clear(). I.e. we didn't strdup(), but during
> > free() we pretend that we did, because we did, just not in
> > string_list_append().
> 
> Good catch. It's kind of gross, but the result is:
> 
> --- 8< ---
> 
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 77488b6b7b..e6cab975e3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -64,7 +64,7 @@ static struct option *add_common_options(struct option *prev)
> 
>  static void read_packs_from_stdin(struct string_list *to)
>  {
> -	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT_NODUP;

Did you mean to use STRING_LIST_INIT_NODUP on the string-list
declaration?

>  	while (strbuf_getline(&buf, stdin) != EOF) {
>  		string_list_append(to, strbuf_detach(&buf, NULL));
>  	}
> @@ -107,6 +107,11 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>  		ret = write_midx_file_only(opts.object_dir, &packs,
>  					   opts.preferred_pack, opts.flags);
> 
> +		/*
> +		 * pretend strings are duplicated to free the memory allocated
> +		 * by read_packs_from_stdin()
> +		 */
> +		packs.strdup_strings = 1;
>  		string_list_clear(&packs, 0);
> 
>  		return ret;

I think the root of the problem here is the non-idiomatic use of
strbuf_getline(). The usual thing (and in fact the thing done by the
quite-similar code in read_packs_list_from_stdin() in pack-objects.c)
is not to detach, because strbuf_getline() will reset the buffer each
time. I.e.:

  struct string_list to = STRING_LIST_INIT_DUP;
  ...
  struct strbuf buf = STRBUF
  while (strbuf_getline(&buf, stdin) != EOF)
	string_list_append(to, &buf);
  strbuf_release(&buf);

That avoids any clever string-list allocation games. The number of heap
allocations is about the same (one strbuf and N list items, versus N
strbufs and 0 list items). There's a little extra copying (from the
strbuf into the list items), but the strings themselves are more
efficiently allocated (strbuf may over-allocate, and we lock in
that choice forever by handing over the string).

Not that efficiency probably matters either way for this spot. I'd do it
this way because it's simple and idiomatic for our code base.

-Peff
