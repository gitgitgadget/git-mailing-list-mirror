Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8E1C433DB
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B7923B46
	for <git@archiver.kernel.org>; Fri, 22 Jan 2021 23:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbhAVX56 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jan 2021 18:57:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:36008 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbhAVXx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jan 2021 18:53:56 -0500
Received: (qmail 15654 invoked by uid 109); 22 Jan 2021 23:53:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Jan 2021 23:53:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20326 invoked by uid 111); 22 Jan 2021 23:53:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Jan 2021 18:53:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 22 Jan 2021 18:53:11 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 3/8] builtin/index-pack.c: write reverse indexes
Message-ID: <YAtlZ49mTfTGg11/@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <5b18ada61113faa9dc1de584366cb39b6a449ec6.1610576805.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b18ada61113faa9dc1de584366cb39b6a449ec6.1610576805.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 05:28:15PM -0500, Taylor Blau wrote:

>  OPTIONS
> @@ -33,7 +34,14 @@ OPTIONS
>  	file is constructed from the name of packed archive
>  	file by replacing .pack with .idx (and the program
>  	fails if the name of packed archive does not end
> -	with .pack).
> +	with .pack). Incompatible with `--rev-index`.

I wondered which option was incompatible, but couldn't see from the
context. It is "index-pack -o", which kind of makes sense. We can derive
"foo.rev" from "foo.idx", but normally "-o" does not do any deriving.

So I was all set to say "OK, we can live without it", but...

> @@ -1824,7 +1851,16 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	if (from_stdin && hash_algo)
>  		die(_("--object-format cannot be used with --stdin"));
>  	if (!index_name && pack_name)
> -		index_name = derive_filename(pack_name, "idx", &index_name_buf);
> +		index_name = derive_filename(pack_name, ".pack", "idx", &index_name_buf);
> +
> +	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
> +	if (rev_index) {
> +		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
> +		if (index_name)
> +			rev_index_name = derive_filename(index_name,
> +							 ".idx", "rev",
> +							 &rev_index_name_buf);
> +	}

...here we do end up deriving ".rev" from ".idx" anyway. So I guess we
probably could support "-o".  I also wonder what happens with "git
index-pack -o foo.idx" when pack.writeReverseIndex is set. It looks like
it would just work because of this block. But then shouldn't
"--rev-index" work, too? And indeed, there is a test for that at the end
of the patch! So is the documentation just wrong?

I admit to finding the use of opts.flags versus the rev_index option a
bit confusing. It seems like they are doing roughly the same thing, but
influenced by different sources. It seems like we should be able to have
a single local variable (then that goes on to set opts.flags for any
sub-functions we call). Or maybe two, if we need to distinguish config
versus command-line, but then they should have clear names
(rev_index_config and rev_index_cmdline or something).

As an aside, looking at derive_filename(), it seems a bit weird that one
argument has a dot in the suffix and the other does not. I guess you are
following the convention from write_special_file(), which omits it in
the newly-added suffix. But it is slightly awkward to omit it for the
old suffix in derive_filename(), because we want to strip_suffix() it
all at once.

Probably not that big a deal, but if anybody feels strongly, then
derive_filename() could do:

  if (!strip_suffix(pack_name, strip, &len) ||
      !len || pack_name[len] != '.')
	die("does not end in .%s", strip);

> @@ -1578,6 +1591,12 @@ static int git_index_pack_config(const char *k, const char *v, void *cb)
>  		}
>  		return 0;
>  	}
> +	if (!strcmp(k, "pack.writereverseindex")) {
> +		if (git_config_bool(k, v))
> +			opts->flags |= WRITE_REV;
> +		else
> +			opts->flags &= ~WRITE_REV;
> +	}
>  	return git_default_config(k, v, cb);
>  }

IMHO we'll eventually want to turn this feature on by default. In which
case we'll have to update every caller which is checking the config
manually. Should we hide this in a function that looks up the config,
and sets the default? Or alternatively, I guess, they could all use some
shared initializer for "flags".

> +	# Intentionally corrupt the reverse index.
> +	chmod u+w $rev &&
> +	printf "xxxx" | dd of=$rev bs=1 count=4 conv=notrunc &&
> +
> +	test_must_fail git index-pack --rev-index --verify \
> +		$packdir/pack-$pack.pack 2>err &&
> +	grep "validation error" err
> +'

This isn't that subtle of a corruption, because we are corrupting the
first 4 bytes, which is the magic signature. Maybe something further in
the actual data would be interesting instead of or in addition?

I dunno. There are a lot of edge cases around corruption (likewise, we
might care how the normal reading code-path perceives a signature
corruption like this). I'm not sure it's all that interesting to test
all of them.

> +test_expect_success 'index-pack infers reverse index name with -o' '
> +	git index-pack --rev-index -o other.idx $packdir/pack-$pack.pack &&
> +	test_path_is_file other.idx &&
> +	test_path_is_file other.rev
> +'

Hey, we _do_ support "--rev-index -o". Is it just the documentation that
is wrong?

-Peff
