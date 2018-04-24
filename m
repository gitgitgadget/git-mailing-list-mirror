Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ABF51F424
	for <e@80x24.org>; Tue, 24 Apr 2018 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeDXOqq (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 10:46:46 -0400
Received: from smtp90.ord1c.emailsrvr.com ([108.166.43.90]:55020 "EHLO
        smtp90.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751454AbeDXOqo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 10:46:44 -0400
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Apr 2018 10:46:44 EDT
Received: from smtp4.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp4.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id 95C0BA04C3
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 10:41:29 -0400 (EDT)
Received: from smtp98.ord1d.emailsrvr.com (relay.ord1c.rsapps.net [172.28.255.120])
        by smtp4.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTPS id 8E1ACA051B
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 10:41:29 -0400 (EDT)
Received: from smtp21.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp21.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id CB84A6006B;
        Tue, 24 Apr 2018 10:41:28 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp21.relay.ord1d.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 925B860065;
        Tue, 24 Apr 2018 10:41:28 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 24 Apr 2018 10:41:28 -0400
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
To:     =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org
References: <20180413170129.15310-1-mgorny@gentoo.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <48116b46-1596-1c89-a15c-5ffa98997d01@xiplink.com>
Date:   Tue, 24 Apr 2018 10:41:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413170129.15310-1-mgorny@gentoo.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-04-13 01:01 PM, Michał Górny wrote:
> Currently git does not control mtimes of files being checked out.  This
> means that the only assumption you could make is that all files created
> or modified within a single checkout action will have mtime between
> start time and end time of this checkout.  The relations between mtimes
> of different files depend on the order in which they are checked out,
> filesystem speed and timestamp precision.

Thanks for scratching this old itch [1]!

Big +1 from me.  We've had incremental smoke-test rebuilds fail because 
of inconsistent file timestamps.

		M.

[1] https://public-inbox.org/git/50C79D1F.1080709@xiplink.com/

> Git repositories sometimes contain both generated and respective source
> files.  For example, the Gentoo 'user syncing' repository combines
> source ebuild files with generated metadata cache for user convenience.
> Ideally, the 'git checkout' would be fast enough that (combined with low
> timestamp precision) all files created or modified within a single
> checkout would have matching timestamp.  However, in reality the cache
> files may end up being wrongly 'older' than source file, requiring
> unnecessary recheck.
> 
> The opposite problem (cache files not being regenerated when they should
> have been) might also occur.  However, it could not be solved without
> preserving timestamps, therefore it is out of scope of this change.
> 
> In order to avoid unnecessary cache mismatches, force a matching mtime
> between all files created by a single checkout action.  This seems to be
> the best course of action.  Matching mtimes do not trigger cache
> updates.  They also match the concept of 'checkout' being an atomic
> action.  Finally, this change does not break backwards compatibility
> as the new result is a subset of the possible previous results.
> 
> For example, let's say that 'git checkout' creates two files in order,
> with respective timestamps T1 and T2.  Before this patch, T1 <= T2.
> After this patch, T1 == T2 which also satisfies T1 <= T2.
> 
> A similar problem was previously being addressed via git-restore-mtime
> tool.  However, that solution is unnecessarily complex for Gentoo's use
> case and does not seem to be suitable for 'seamless' integration.
> 
> The patch integrates mtime forcing via adding an additional member of
> 'struct checkout'.  This seemed the simplest way of adding it without
> having to modify prototypes and adjust multiple call sites.  The member
> is set to the current time in check_updates() function and is afterwards
> enforced by checkout_entry().
> 
> The patch uses utime() rather than futimes() as that seems to be
> the function used everywhere else in git and provided some MinGW
> compatibility code.
> 
> Signed-off-by: Michał Górny <mgorny@gentoo.org>
> ---
>   cache.h        |  1 +
>   entry.c        | 12 +++++++++++-
>   unpack-trees.c |  1 +
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/cache.h b/cache.h
> index bbaf5c349..9f0a7c867 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1526,6 +1526,7 @@ struct checkout {
>   	const char *base_dir;
>   	int base_dir_len;
>   	struct delayed_checkout *delayed_checkout;
> +	time_t checkout_mtime;
>   	unsigned force:1,
>   		 quiet:1,
>   		 not_new:1,
> diff --git a/entry.c b/entry.c
> index 2101201a1..7ee5a6d28 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -411,6 +411,7 @@ int checkout_entry(struct cache_entry *ce,
>   {
>   	static struct strbuf path = STRBUF_INIT;
>   	struct stat st;
> +	int ret;
>   
>   	if (topath)
>   		return write_entry(ce, topath, state, 1);
> @@ -473,5 +474,14 @@ int checkout_entry(struct cache_entry *ce,
>   		return 0;
>   
>   	create_directories(path.buf, path.len, state);
> -	return write_entry(ce, path.buf, state, 0);
> +	ret = write_entry(ce, path.buf, state, 0);
> +
> +	if (ret == 0 && state->checkout_mtime != 0) {
> +		struct utimbuf t;
> +		t.modtime = state->checkout_mtime;
> +		if (utime(path.buf, &t) < 0)
> +			warning_errno("failed utime() on %s", path.buf);
> +	}
> +
> +	return ret;
>   }
> diff --git a/unpack-trees.c b/unpack-trees.c
> index e73745051..e1efefb68 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -346,6 +346,7 @@ static int check_updates(struct unpack_trees_options *o)
>   	state.quiet = 1;
>   	state.refresh_cache = 1;
>   	state.istate = index;
> +	state.checkout_mtime = time(NULL);
>   
>   	progress = get_progress(o);
>   
> 
