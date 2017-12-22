Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACA501F406
	for <e@80x24.org>; Fri, 22 Dec 2017 19:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756149AbdLVT5E (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 14:57:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56451 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755940AbdLVT5D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 14:57:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7B1EBBC2F6;
        Fri, 22 Dec 2017 14:57:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4sGh4FZCBycLe0u3qBt+heNKfcM=; b=jqtm1c
        0OJriwRYW5zfrhjrvv9O8jHBP4golCxYhVG5HxOR/uCDe+cgldVNkqkwGDZ8amYl
        8SY9fVeVkwTnEv1l27xdheMC3OK3wbk9oolGlM/S2JT5rambjcvE0Gf94DZu72jy
        LprIRq7xssotkbv5IKkDhDs3pu0CQ2Fyl9fvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVpjZ8SOYWQgRJ1Hqe4a/5RUdr5bZ/o9
        2XsEJZg8Lz9jRLnXQSXrplITay5bNSttuSYgS96KH4AnqYH9Lhp6agVTc9lOXpoK
        wXHh+f0peiFExoLD+FGlrY7AUWzuhryc6Qh/dgsrZ1x3crHitoJpx/AM1wcl3ujS
        aW890gYAhiU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72C4CBC2F5;
        Fri, 22 Dec 2017 14:57:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8394BC2F4;
        Fri, 22 Dec 2017 14:57:01 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jrnieder@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 3/4] unpack-trees: Fix same() for submodules
References: <20171220221725.129162-1-sbeller@google.com>
        <20171220221725.129162-4-sbeller@google.com>
Date:   Fri, 22 Dec 2017 11:57:00 -0800
In-Reply-To: <20171220221725.129162-4-sbeller@google.com> (Stefan Beller's
        message of "Wed, 20 Dec 2017 14:17:24 -0800")
Message-ID: <xmqq3742sfhv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46ABA414-E752-11E7-BEC5-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The function same(a, b) is used to check if two entries a and b are the
> same.  As the index contains the staged files the same() function can be
> used to check if files between a given revision and the index are the same.
>
> In case of submodules, the gitlink entry is showing up as not modified
> despite potential changes inside the submodule.
>
> Fix the function to examine submodules by looking inside the submodule.
> This patch alone doesn't affect any correctness garantuees, but in

guarantees?  I somehow misread this as orangutan ;-)

> combination with the next patch this fixes the new test introduced
> earlier in this series.
>
> This may be a slight performance regression as now we have to
> inspect any submodule thouroughly.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  unpack-trees.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index bf8b602901..4d839e8edb 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1427,6 +1427,8 @@ static int same(const struct cache_entry *a, const struct cache_entry *b)
>  		return 1;
>  	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
>  		return 0;
> +	if (S_ISGITLINK(b->ce_mode) && should_update_submodules())
> +		return !oidcmp(&a->oid, &b->oid) && !is_submodule_modified(b->name, 0);

Isn't this is working at the wrong level?

It is technically correct to say "the function is used to check if
two entries a and be are the same", but that statement misses a more
important aspect of the function.  It is asked if these two things
are the same and does not get involved in seeing if the working tree
is dirty with respect to (one of) the entries it was passed.

For example, a virtual merge in a recursive merge would not (and
should not) care if local changes exist in the working tree, and
this function does not get any hint if it is to
look at the working tree to tell such a case and the outermost merge
apart.

Somebody has to be careful not to stomp on local changes in the
outmost merge in a recursive merge, but I do not think this function
is designed to be the place to do so.  Isn't a submodule with
"potential changes" the same way?



>  	return a->ce_mode == b->ce_mode &&
>  	       !oidcmp(&a->oid, &b->oid);
>  }
