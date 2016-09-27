Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13859207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 05:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbcI0F16 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 27 Sep 2016 01:27:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:48561 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751018AbcI0F15 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 01:27:57 -0400
Received: (qmail 17021 invoked by uid 109); 27 Sep 2016 05:27:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 05:27:57 +0000
Received: (qmail 11761 invoked by uid 111); 27 Sep 2016 05:28:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Sep 2016 01:28:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2016 01:27:54 -0400
Date:   Tue, 27 Sep 2016 01:27:54 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <novalis@novalis.org>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Subject: Re: [PATCH 2/2] fsck: handle bad trees like other errors
Message-ID: <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
 <1474918365-10937-3-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1474918365-10937-3-git-send-email-novalis@novalis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 03:32:45PM -0400, David Turner wrote:

> Instead of dying when fsck hits a malformed tree object, log the error
> like any other and continue.  Now fsck can tell the user which tree is
> bad, too.

Cool. I think the lack of this is what made me drag my feet on the first
patch. Thanks for finishing it off.

> diff --git a/fsck.c b/fsck.c
> index c9cf3de..4a3069e 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -347,8 +347,9 @@ static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *op
>  		return -1;
>  
>  	name = get_object_name(options, &tree->object);
> -	init_tree_desc(&desc, tree->buffer, tree->size);
> -	while (tree_entry(&desc, &entry)) {
> +	if (init_tree_desc_gently(&desc, tree->buffer, tree->size))
> +		return -1;
> +	while (tree_entry_gently(&desc, &entry)) {

I wondered if other callers would be happy with init_tree_desc_gently().
Grepping for init_tree_desc(), it seems like it would be a fairly
trivial conversion for most of them, because they almost invariably run
unpack_trees() right afterwards, and so have to deal with errors from
it.

So perhaps in the long run we can convert them all. But certainly that
does not need to be part of this series.

> +test_expect_success 'unparseable tree object' '
> +	test_when_finished "git update-ref -d refs/heads/wrong" &&
> +	test_when_finished "remove_object 307e300745b82417cc1a903f875c7d22e45ef907" &&
> +	test_when_finished "remove_object f506a346749bb96f52d8605ffba9fb93d46b5ffd" &&
> +	mkdir -p .git/objects/30 mkdir -p .git/objects/f5 &&
> +	cp ../t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907 .git/objects/30/7e300745b82417cc1a903f875c7d22e45ef907 &&
> +	cp ../t1450/bad-objects/f506a346749bb96f52d8605ffba9fb93d46b5ffd .git/objects/f5/06a346749bb96f52d8605ffba9fb93d46b5ffd &&

This needs the same $TEST_DIRECTORY treatment as t1007.

> +	git update-ref refs/heads/wrong 307e300745b82417cc1a903f875c7d22e45ef907 &&
> +	test_must_fail git fsck 2>out &&
> +	grep "warning: empty filename in tree entry" out &&
> +	grep "f506a346749bb96f52d8605ffba9fb93d46b5ffd" out &&
> +	! grep "fatal: empty filename in tree entry" out
> +'

I'd also expect these to be test_i18ngrep, but I see that t1450 is quite
bad about this in general. I'm OK with adding them as greps and leaving
a conversion of the whole script until later.

> diff --git a/t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907 b/t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907
> new file mode 100644
> index 0000000..6e23d62
> --- /dev/null
> +++ b/t/t1450/bad-objects/307e300745b82417cc1a903f875c7d22e45ef907
> @@ -0,0 +1,4 @@
> +xŽAÂ E]sŠ¹€f°@ÄÁ0Z[
> +õú¢é	\ýüÅ{ÿižcIòP²÷4Û)Ó+b&ôÙ]êØR`êœ2Üš¶–)exØ-:xÖ¼ø×%mö×ûž§”ÇHÕd{-áˆ
> +Q¿ÍÒ€è‡w,pë
> +ßçâ&ë?Þ
> \ No newline at end of file

Yikes. :)

I wonder if some printfs, similar to what I showed in the last patch,
combined with "hash-object --literally", could make these tests more
readable and avoid the binary goo.

> -static void decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size)
> +static int decode_tree_entry(struct tree_desc *desc, const char *buf, unsigned long size, struct strbuf *err)
>  {

I know we used the "err" strbuf pattern in the ref code, and it makes
sense there where we have a lot of different functions with public
interfaces. But here, we literally just feed the result to die() or
warning(). I wonder if a nicer interface would be:

  typedef void (*err_fn)(const char *, ...);

  static int decode_tree_entry(struct tree_desc *desc,
                               const char *buf, unsigned long size,
			       err_fn err)
  {
         ...
         if (size < 23 || buf[size - 21]) {
	        err("too-short tree object");
		return -1;
	 }
  }

I dunno. Maybe that is overengineering. I guess we only hit the strbufs
in the error path (which used to die!), so nobody really cares that much
about the extra allocation.

> +int init_tree_desc_gently(struct tree_desc *desc, const void *buffer, unsigned long size)
> +{
> +	struct strbuf err = STRBUF_INIT;
> +	int result = init_tree_desc_internal(desc, buffer, size, &err);
> +	if (result)
> +		warning("%s", err.buf);
> +	strbuf_release(&err);
> +	return result;
>  }

I also wonder if this ought to be "error()" and not "warning()". I think
it's pretty common for fsck to spit out errors from sub-code but keep going.

-Peff
