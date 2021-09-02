Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD88C432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E465961051
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244725AbhIBJGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:37226 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233656AbhIBJGO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:14 -0400
Received: (qmail 21756 invoked by uid 109); 2 Sep 2021 09:05:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Sep 2021 09:05:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22726 invoked by uid 111); 2 Sep 2021 09:05:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Sep 2021 05:05:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 2 Sep 2021 05:05:15 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, hanwen@google.com
Subject: Re: [PATCH 1/3] fixup! refs: RFC: Reftable support for git-core
Message-ID: <YTCTyzfIQlme4xee@coredump.intra.peff.net>
References: <20210902053023.44006-1-carenas@gmail.com>
 <20210902053023.44006-2-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210902053023.44006-2-carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 10:30:21PM -0700, Carlo Marcelo Arenas Belón wrote:

> need to reorder the variables to hopefully make it easier to see why
> they might not be used since assert will compile out itself with -DNDEBUG.

This should probably lead with the reason for the patch (avoiding errors
with NDEBUG), and then mention any other bits (like "we also reorder for
clarity"). That makes the point of the patch easier to see.

> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 61ee144e19..5d733b0496 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -127,10 +127,11 @@ static void clear_reftable_log_record(struct reftable_log_record *log)
>  
>  static void fill_reftable_log_record(struct reftable_log_record *log)
>  {
> -	const char *info = git_committer_info(0);
>  	struct ident_split split = { NULL };
> -	int result = split_ident_line(&split, info, strlen(info));
>  	int sign = 1;
> +	MAYBE_UNUSED const char *info = git_committer_info(0);
> +	MAYBE_UNUSED int result = split_ident_line(&split, info, strlen(info));

I don't think you need MAYBE_UNUSED on "info"; it is always used, even
if the assert isn't compiled.

>  	assert(0 == result);

IMHO this would be better converted to:

  if (result)
	BUG("unable to parse output of get_committer_info()");

That solves the problem, avoids introducing head-scratching constructs
like MAYBE_UNUSED, and gives readers more of a clue about what we
expected.

-Peff

PS I do think it's pretty ugly that we have to re-split the ident from
   git_committer_info(), which just took the individual pieces and
   stuffed them into a string! But our ident functions are a little
   cumbersome here (we even have fmt_name(), but I think it's too picky
   about IDENT_STRICT). I suspect it could be fixed with some
   refactoring, but that's way out of scope for your series (and for the
   reftable series itself), so let's leave it for now.
