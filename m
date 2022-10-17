Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1511C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 18:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiJQSC5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 14:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJQSCz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 14:02:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D9965279
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 11:02:54 -0700 (PDT)
Received: (qmail 27513 invoked by uid 109); 17 Oct 2022 18:02:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 18:02:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9282 invoked by uid 111); 17 Oct 2022 18:02:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 14:02:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 14:02:53 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com,
        gitster@pobox.com
Subject: Re: [PATCH] builtin/repack.c: remove redundant pack-based bitmaps
Message-ID: <Y02YzYS172skpbAb@coredump.intra.peff.net>
References: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <393fd4c6db78cd694e6d4dfcf24f17e2850ccd99.1665601403.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2022 at 03:05:33PM -0400, Taylor Blau wrote:

> When we write a MIDX bitmap after repacking, it is possible that the
> repository would be left in a state with both pack- and multi-pack
> reachability bitmaps.
> 
> This can occur, for instance, if a pack that was kept (either by having
> a .keep file, or during a geometric repack in which it is not rolled up)
> has a bitmap file, and the repack wrote a multi-pack index and bitmap.
> 
> When loading a reachability bitmap for the repository, the multi-pack
> one is always preferred, so the pack-based one is redundant. Let's
> remove it unconditionally, even if '-d' isn't passed, since there is no
> practical reason to keep both around. The patch below does just that.

Yeah, this is certainly a reasonable thing to be doing. I wonder if you
want to share the story of why the original midx-bitmap series did not
include this patch. It is (IMHO, at least) an interesting debugging
tale.

>  builtin/repack.c  | 40 +++++++++++++++++++++++++++++++++++++---
>  t/t7700-repack.sh | 21 +++++++++++++++++++++
>  2 files changed, 58 insertions(+), 3 deletions(-)

The patch looks good. Two very minor comments, though I'd be happy
enough to see it merged as-is:

> +static void remove_redundant_bitmaps(struct string_list *include,
> +				     const char *packdir)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	struct string_list_item *item;
> +	size_t packdir_len;
> +
> +	strbuf_addstr(&path, packdir);
> +	strbuf_addch(&path, '/');
> +	packdir_len = path.len;
> +
> +	/*
> +	 * Remove any pack bitmaps corresponding to packs which are now
> +	 * included in the MIDX.
> +	 */
> +	for_each_string_list_item(item, include) {
> +		strbuf_addstr(&path, item->string);
> +		strbuf_strip_suffix(&path, ".idx");
> +		strbuf_addstr(&path, ".bitmap");
> +
> +		if (unlink(path.buf) && errno != ENOENT)
> +			die_errno(_("could not remove stale bitmap: %s"),
> +				  path.buf);

We could downgrade this to a warning, since there is no downside to
retaining those files (aside from wasted space). In
remove_redundant_pack(), we call into unlink_pack_path(), which just
ignores unlink errors (though arguably it should at least warn).

> @@ -1059,10 +1088,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  						refs_snapshot ? get_tempfile_path(refs_snapshot) : NULL,
>  						show_progress, write_bitmaps > 0);
>  
> +		if (ret) {
> +			string_list_clear(&include, 0);
> +			return ret;
> +		}
> +
> +		if (write_bitmaps)
> +			remove_redundant_bitmaps(&include, packdir);
> +
>  		string_list_clear(&include, 0);
> -
> -		if (ret)
> -			return ret;
>  	}

You could avoid having to repeat the string-list cleanup here by
structuring it like:

  if (!ret && write_bitmaps)
	remove_redundant_bitmaps(&include, packdir);

  /* as before, clear string list and possibly return ret */

Since it's only one line, it's not that big a deal, but it simplifies
the flow.

It's correct either way, of course. One thing I did have to do while
reviewing this was look at this hunk in place. The context omits that
this is in the "if (write_midx)" conditional, which is of course very
important. ;)

-Peff
