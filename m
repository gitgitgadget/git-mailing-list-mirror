Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBC51F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbdAYTvW (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:51:22 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51421 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751667AbdAYTvV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:51:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3A8263DFA;
        Wed, 25 Jan 2017 14:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MwTyUksPP9L5b0QL6by5pFN5PFM=; b=YBKoow
        NzRYo8ICuv2zNMT0r4ijkOZ3LbqR2ej6BhrjT7Lb3DEAccXH3cJiEO8QQyvfv95u
        igVOWt0IhXKeb7XMlYIjix5GoudJXJTk6TtyiADLHb5XGQm28yO9P+dAcGMdqEAR
        HIsrC6LCcuB4juh9XQZztyTyzH9et16VK3hsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kVfrSFRMbDP2qqjD+JF4pvmkyl9Ah0dR
        8EB5vitbwJHU6k/nRe04GBmssrrYPEZmIsNzsVjDYc96WkmGOLnC4UOPhc427kOy
        WHo+dvlK750n/oeKZcfiy15+m+rjh5x/zWpVUa4pnxFGOrROaf6U/0Nj9xb8TCZ9
        kthPlcSo4YA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9D6263DF9;
        Wed, 25 Jan 2017 14:51:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0CA163DF8;
        Wed, 25 Jan 2017 14:51:18 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 11/12] receive-pack: treat namespace .have lines like alternates
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
        <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net>
Date:   Wed, 25 Jan 2017 11:51:17 -0800
In-Reply-To: <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 23 Jan 2017 19:48:05 -0500")
Message-ID: <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3A4852A-E337-11E6-B76A-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Namely, de-duplicate them. We use the same set as the
> alternates, since we call them both ".have" (i.e., there is
> no value in showing one versus the other).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/receive-pack.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 8f8762e4a..c55e2f993 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -251,8 +251,9 @@ static void show_ref(const char *path, const unsigned char *sha1)
>  }
>  
>  static int show_ref_cb(const char *path_full, const struct object_id *oid,
> -		       int flag, void *unused)
> +		       int flag, void *data)
>  {
> +	struct oidset *seen = data;
>  	const char *path = strip_namespace(path_full);
>  
>  	if (ref_is_hidden(path, path_full))
> @@ -263,8 +264,11 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
>  	 * refs, so that the client can use them to minimize data
>  	 * transfer but will otherwise ignore them.
>  	 */
> -	if (!path)
> +	if (!path) {
> +		if (oidset_insert(seen, oid))
> +			return 0;
>  		path = ".have";
> +	}

This is very sensible as an optimization that does not change
semantics.

This is an unrelated tangent, but there may want to be a knob to
make the code return here without even showing, to make the
advertisement even smaller and also to stop miniscule information
leakage?  If the namespaced multiple projects are totally unrelated
(i.e. "My sysadmin gave me a write access only to this single
directory, so I am using the namespace feature to host these three
projects that have nothing to do with each other"), showing objects
of other namespaces will buy us nothing and the user is better off
without this code showing these refs as ".have".

>  	show_ref(path, oid->hash);
>  	return 0;
>  }
> @@ -287,7 +291,7 @@ static void write_head_info(void)
>  
>  	for_each_alternate_ref(show_one_alternate_ref, &seen);
>  	oidset_clear(&seen);
> -	for_each_ref(show_ref_cb, NULL);
> +	for_each_ref(show_ref_cb, &seen);
>  	if (!sent_capabilities)
>  		show_ref("capabilities^{}", null_sha1);
