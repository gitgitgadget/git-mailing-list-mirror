Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6211E1F462
	for <e@80x24.org>; Fri, 31 May 2019 20:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfEaUsZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 16:48:25 -0400
Received: from resqmta-po-04v.sys.comcast.net ([96.114.154.163]:34810 "EHLO
        resqmta-po-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbfEaUsY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 31 May 2019 16:48:24 -0400
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-04v.sys.comcast.net with ESMTP
        id Wnnqhmd64d4wBWoRrhgsL1; Fri, 31 May 2019 20:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559335703;
        bh=JBE8Ya66thbKoAbFeL4kkWaWFuSB3uFg1exhT6/jPQc=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=6NLkloirBmcQoQYU49bbqTLRIgyBqgs32NC3k3wmlx8CX7Vao3KMMnzWw4ooGZGH6
         0U3XoVxlj85eH6OOfWc6S5tIlgBqyTPA6Z7MlxpKKRRirYS5QsFxVhaEbJGtRmYfqP
         aIfmjfU7uxPhnGMboBh5DSj63bDXY47uAsLkj30uidr0B3ZWPHtNfFgpCQJWws/qKr
         xxl3dCWT4JjpZHGJKL2hoFst8jzYXHVbaxPDe00E7WUEAMMVLFjv2tR29zYpFMe6w+
         CvgwkM9qubE1E5G/6LbCdU8a0yZMFTQVuwdcnH+Cdq3pNFWxU8TVTou8kpc9s7Bc3h
         hKBzvxY2/TfOg==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:a4f1:9a8c:7e29:36eb])
        by resomta-po-18v.sys.comcast.net with ESMTPSA
        id WoRphaR8btBiqWoRqheb3I; Fri, 31 May 2019 20:48:23 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Fri, 31 May 2019 13:48:21 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190531204821.GC4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <1f95597eedc4c651868601c0ff7c4a4d97ca4457.1558484115.git.matvore@google.com>
 <20190528215359.GB133078@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528215359.GB133078@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 28, 2019 at 02:53:59PM -0700, Emily Shaffer wrote:
> > +	} else if (skip_prefix(arg, "combine:", &v0)) {
> > +		int sub_parse_res = parse_combine_filter(
> > +			filter_options, v0, errbuf);
> > +		if (sub_parse_res)
> > +			return sub_parse_res;
> > +		return 0;
> 
> Couldn't the three lines above be said more succinctly as "return
> sub_parse_res;"?

Oh yes, that's much better. Don't even need the sub_parse_res variable.

> > +static int digit_value(int c, struct strbuf *errbuf) {
> > +	if (c >= '0' && c <= '9')
> > +		return c - '0';
> > +	if (c >= 'a' && c <= 'f')
> > +		return c - 'a' + 10;
> > +	if (c >= 'A' && c <= 'F')
> > +		return c - 'A' + 10;
> 
> I'm sure there's something I'm missing here. But why are you manually
> decoding hex instead of using strtol or sscanf or something?
> 

I'll have to give this a try. Thank you for the suggestion.

> > +static int has_reserved_character(
> > +	struct strbuf *sub_spec, struct strbuf *errbuf)
> > +{
> > +	const char *c = sub_spec->buf;
> > +	while (*c) {
> > +		if (*c <= ' ' || strchr(RESERVED_NON_WS, *c))
> > +			goto found_reserved;
> > +		c++;
> > +	}
> > +
> > +	return 0;
> > +
> > +found_reserved:
> 
> What's the value of doing this in a goto instead of embedded in the
> while loop?
> 

That's to reduce indentation. Note that if I "inlined" the goto logic in the
while loop, I'd get at least 5 tabs of indentation, and the error message would
be split across a couple lines.

> > +
> > +	result = gently_parse_list_objects_filter(filter_options->lhs,
> > +						  sub_specs[0]->buf,
> > +						  errbuf) ||
> > +		parse_combine_filter(filter_options->rhs,
> > +				      sub_specs[1]->buf,
> > +				      errbuf);
> 
> I guess you're recursing to combine filter 2 onto filter 1 which has
> been combined onto filter 0 here. But why not just use a list or array?
> 

I switched this to use an array at your and Jeff's proddings, and it's much
better now. Thanks! It will be in the next roll-up.

> >  
> >  void list_objects_filter_release(
> >  	struct list_objects_filter_options *filter_options)
> >  {
> > +	if (!filter_options)
> > +		return;
> >  	free(filter_options->filter_spec);
> >  	free(filter_options->sparse_oid_value);
> >  	free(filter_options->sparse_path_value);
> > +	list_objects_filter_release(filter_options->lhs);
> > +	free(filter_options->lhs);
> > +	list_objects_filter_release(filter_options->rhs);
> > +	free(filter_options->rhs);
> 
> Is there a reason that the free shouldn't be included in
> list_objects_filter_release()? Maybe this is a common style guideline
> I've missed, but it seems to me like I'd expect a magic memory cleanup
> function to do it all, and not leave it to me to free.
> 

Because there are a couple times the list_objects_filter_options struct is
allocated on the stack or inline in some other struct. This is similar to how
strbuf and other such utility structs are used.

> Jeff H had a comment about this too, but this seems unwieldy for >2
> filters. (I also personally don't like using set index to incidate
> lhs/rhs.) Why not an array of multiple `struct sub`? There's a macro
> utility to generate types and helpers for an array of arbitrary struct
> that may suit...
> 

This code is now cleaner that it's using an array.

> > +static enum list_objects_filter_result filter_combine(
> > +	struct repository *r,
> > +	enum list_objects_filter_situation filter_situation,
> > +	struct object *obj,
> > +	const char *pathname,
> > +	const char *filename,
> > +	struct filter_context *ctx)
> > +{
> > +	struct filter_combine_data *d = ctx->data;
> > +	enum list_objects_filter_result result[2];
> > +	enum list_objects_filter_result combined_result = LOFR_ZERO;
> > +	int i;
> > +
> > +	for (i = 0; i < 2; i++) {
> 
> I suppose your lhs and rhs are in sub[0] and sub[1] in part for the sake
> of this loop. But I think it would be easier to understand what is going
> on if you were to perform the loop contents in a helper function (as the
> name of the function would provide some more documentation).
> 

Agreed, this is how it will be done in the next roll-up.

> I see that you tested that >2 filters works okay. But by doing it the
> way you have it seems like you're setting up to need recursion all over
> the place to check against all the filters. I suppose I don't see the
> benefit of doing all this recursively, as compared to doing it
> iteratively.

Somehow, the recursive appraoch made more sense to me when I was first writing
the code. But using an array is nicer.
