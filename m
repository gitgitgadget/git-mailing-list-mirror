Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F334DCDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344605AbjJKW1d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 18:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJKW1c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:27:32 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE691
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:27:30 -0700 (PDT)
Received: (qmail 20182 invoked by uid 109); 11 Oct 2023 22:27:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Oct 2023 22:27:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10887 invoked by uid 111); 11 Oct 2023 22:27:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Oct 2023 18:27:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Oct 2023 18:27:28 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH] upload-pack: add tracing for fetches
Message-ID: <20231011222728.GC518221@coredump.intra.peff.net>
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 11, 2023 at 04:04:02PM +0000, Robert Coup via GitGitGadget wrote:

> Improve this by emitting a Trace2 JSON event from upload-pack with
> summary information on the contents of a fetch request.
> 
> * haves, wants, and want-ref counts can help determine (broadly) between
>   fetches and clones, and the use of single-branch, etc.
> * shallow clone depth, tip counts, and deepening options.
> * any partial clone filter type.

I think this is a reasonable thing to have. I see Taylor left a more
detailed review, but I did notice one thing...

> +static void trace2_fetch_info(struct upload_pack_data *data)
> +{
> +	struct json_writer jw = JSON_WRITER_INIT;
> +
> +	jw_object_begin(&jw, 0);
> +	{
> +		jw_object_intmax(&jw, "haves", data->haves.nr);
> +		jw_object_intmax(&jw, "wants", data->want_obj.nr);
> +		jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
> +		jw_object_intmax(&jw, "depth", data->depth);
> +		jw_object_intmax(&jw, "shallows", data->shallows.nr);
> +		jw_object_bool(&jw, "deepen-since", data->deepen_since);
> +		jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
> +		jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
> +		if (data->filter_options.choice)
> +			jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
> +		else
> +			jw_object_null(&jw, "filter");
> +	}
> +	jw_end(&jw);
> +
> +	trace2_data_json("upload-pack", the_repository, "fetch-info", &jw);
> +
> +	jw_release(&jw);
> +}

Generating the json output isn't entirely trivial (and certainly
involves allocations), but we throw it away unused if tracing isn't
enabled. Maybe we'd want something like:

  if (!trace2_is_enabled())
          return;

at the top of the function? It looks like other callers of
jw_object_begin() have a similar issue, and this is probably premature
optimization to some degree. It just feels like it should be easy for
tracing to be zero-cost (beyond a single conditional) when it's
disabled.

-Peff
