Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F8FB1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752569AbdAYTLH (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:11:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54356 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752404AbdAYTLF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:11:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4193662648;
        Wed, 25 Jan 2017 14:11:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VkHUO/Ex/nR7cqhQXITVu0rXc5s=; b=BkONyw
        iLB5QfTQWyqXK0EphO5E2RQx8yU1pW3rtlXcEXteD9xMjK2BW5iiSUv6YVb0WXZ3
        6l/d4/MXi/gKqCA188iqXiOSY2TWoyrHVKKk/NNVMb9HtzzzqZIW+TqWKFt7itKT
        aBSvm4THywLiMUbo+KIXefLWXtPKnz3hryFQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OiWqIJ3mzmnu1ZGmh1H9X7+uMC2qDjEb
        PnyJkxMIyYJsb6V5teQ0OsV9fOXPuwGsG0LcXNGhUABUbl00brMnCbhMgwKqfbsf
        QCY6QffHF13i4W3rC1hRCD8pQ4O/JB3tmTs0QyX9+sTCAsDEagK9rOfdjKA3WBX+
        VnMDIQ2/Nj4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 190CD62647;
        Wed, 25 Jan 2017 14:11:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CDDB62644;
        Wed, 25 Jan 2017 14:11:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/12] clone: disable save_commit_buffer
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004500.v7geae55w6zeax7m@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 11:11:01 -0800
In-Reply-To: <20170124004500.v7geae55w6zeax7m@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:45:01 -0500")
Message-ID: <xmqqmvefaray.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03B3A154-E332-11E6-8C1E-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Normally git caches the raw commit object contents in
> "struct commit". This makes it fast to run parse_commit()
> followed by a pretty-print operation.
>
> For commands which don't actually pretty-print the commits,
> the caching is wasteful (and may use quite a lot of memory
> if git accesses a large number of commits).
>
> For fetching operations like clone, we already disable

s/clone/fetch/ you meant?

> In one real-world case with a large number of tags, this
> cut about 10MB off of clone's heap usage. Not spectacular,
> but there's really no downside.

"There is no downside" is especially true in the modern world post
v2.1, where get_commit_buffer() is what everybody has to go through
to access this information.  I would have been very hesitant to
accept a patch like this one if we didn't do that clean-up, as a
stray codepath could have just done "commit->buffer" and segfaulted
or said "ah, there is no message", neither of which is satisfactory.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/clone.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5ef81927a..3fca45e7e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -858,6 +858,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	struct refspec *refspec;
>  	const char *fetch_pattern;
>  
> +	save_commit_buffer = 0;
>  	packet_trace_identity("clone");
>  	argc = parse_options(argc, argv, prefix, builtin_clone_options,
>  			     builtin_clone_usage, 0);
