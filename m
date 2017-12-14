Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952721F404
	for <e@80x24.org>; Thu, 14 Dec 2017 22:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753530AbdLNWM5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 17:12:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53058 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752886AbdLNWM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 17:12:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6CBFCA6F9;
        Thu, 14 Dec 2017 17:12:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EsgC7Ihdv5x+2g263Z4cWBRY5IU=; b=M5NJeA
        9sskLqJk+DYVUOSgPpzPN3Qlpgmi5XLM5OkCd6czq3yaR3lUsBa3ocWJFCPT0C4y
        FxgyhT280UUOAsHy2qCxzSRwG2w/kjhYseXMcn03C1w0vdbszXxLuXglNzqYLxSd
        F6puHJrKEJIy2mmSMHuqLah0OoZ/TPPlgBbGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LBoBDtbPlG/sWCP/ESBHYKtpYIU3VhI4
        c2g+N7hLbLGRHXeXjBmr+EdiP7lEHfSUHeCZSGiTFGMlSj/CI0AMwzkWSe7gEeh6
        8DfRyuVh5vxmcU7T1dPB/JnbL/JKHTmGHjGyoRAl+98aVEvsnbiFXTmUoUCh2CEu
        zirazEZa1cU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD696CA6F8;
        Thu, 14 Dec 2017 17:12:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 37860CA6F7;
        Thu, 14 Dec 2017 17:12:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org
Subject: Re: [PATCH 1/2] clone, fetch: remove redundant transport check
References: <cover.1513287544.git.jonathantanmy@google.com>
        <cover.1513287544.git.jonathantanmy@google.com>
        <d1fd27a5a102129aa16ecf6e6c19014f7b60b543.1513287544.git.jonathantanmy@google.com>
Date:   Thu, 14 Dec 2017 14:12:53 -0800
In-Reply-To: <d1fd27a5a102129aa16ecf6e6c19014f7b60b543.1513287544.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 14 Dec 2017 13:44:44 -0800")
Message-ID: <xmqqmv2lrmai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF406ED0-E11B-11E7-AF7C-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Prior to commit a2d725b7bdf7 ("Use an external program to implement
> fetching with curl", 2009-08-05), if Git was compiled with NO_CURL, the
> get_refs_list and fetch methods in struct transport might not be
> populated, hence the checks in clone and fetch. After that commit, all
> transports populate get_refs_list and fetch, making the checks in clone
> and fetch redundant. Remove those checks.

I do not agree with the above justification.  We could view these
checks as serving to future-proof the callers for (initially buggy)
transports that we have not seen, so the current set of transports
not triggering is not a good enough reason to remove them.

But I do agree with the removal of these checks for another reason.
A call into transport_get_remote_refs() or transport_fetch_refs()
would segfault if these necessary fields are not filled in a buggy
transport under development anyway.

And more importantly, if it is desirable to have a check that is
more friendly than merely segfaulting, such a check must be added to
the implementation of transport API that knows the implementation
details like "fetching would require get_refs_list and fetch
fields"; the consumers of the API is a wrong place to do so.

Thanks.

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/clone.c | 3 ---
>  builtin/fetch.c | 3 ---
>  2 files changed, 6 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index dbddd98f8..979af0383 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1083,9 +1083,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		warning(_("--local is ignored"));
>  	transport->cloning = 1;
>  
> -	if (!transport->get_refs_list || (!is_local && !transport->fetch))
> -		die(_("Don't know how to clone %s"), transport->url);
> -
>  	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
>  
>  	if (option_depth)
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 225c73492..09eb1fc17 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1094,9 +1094,6 @@ static int do_fetch(struct transport *transport,
>  			tags = TAGS_UNSET;
>  	}
>  
> -	if (!transport->get_refs_list || !transport->fetch)
> -		die(_("Don't know how to fetch from %s"), transport->url);
> -
>  	/* if not appending, truncate FETCH_HEAD */
>  	if (!append && !dry_run) {
>  		retcode = truncate_fetch_head();
