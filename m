Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07AFA1FA21
	for <e@80x24.org>; Fri,  6 Oct 2017 04:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750813AbdJFETY (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 00:19:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54619 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750732AbdJFETY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 00:19:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A1789B44C;
        Fri,  6 Oct 2017 00:19:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CvQ0QQQy+oAEL7x8Qy4brNunJMY=; b=DNRP5D
        I64TOBIti6a9ncQ6jRCWokXxQ+cXAIQ4Igt7iCsjkIe51oWQegixqw3JSiGTKf/j
        awiRV7roQcEZGdWMg0WPac6KP8YgIiS1apgnvimRYOcHjh/NNHD6WSIgO9FMydVA
        3Fu2si2LEImge3kyDgBbzeHoN7infQ5t4frYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Lo9Q7SJQyzhYAReD9YiidP0o+vPV2W8h
        qr3HMdLqvAl17F3yGmQmcFABnqwO4Srskb+XUNCDx/eG+JmFN39o9Tnl9ERBLWRy
        JCUN0Q3W8OCXxRDI4QBsHG0B3b9zjuSfGyutHBvYtx5LiHcnmZ1ivraKYYbY9Dj6
        geQZKi8DOhM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 517FC9B449;
        Fri,  6 Oct 2017 00:19:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 846049B447;
        Fri,  6 Oct 2017 00:19:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] sha1_loose_object_info: handle errors from unpack_sha1_rest
References: <20171005055952.t5ef7hyolyevoj3d@sigill.intra.peff.net>
Date:   Fri, 06 Oct 2017 13:19:21 +0900
In-Reply-To: <20171005055952.t5ef7hyolyevoj3d@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 5 Oct 2017 01:59:52 -0400")
Message-ID: <xmqqr2ugykl2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87CBCF74-AA4D-11E7-A740-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When a caller of sha1_object_info_extended() sets the
> "contentp" field in object_info, we call unpack_sha1_rest()
> but do not check whether it signaled an error.
>
> This causes two problems:
>
>   1. We pass back NULL to the caller via the contentp field,
>      but the function returns "0" for success. A caller
>      might reasonably expect after a successful return that
>      it can access contentp without a NULL check and
>      segfault.
>
>      As it happens, this is impossible to trigger in the
>      current code. There is exactly one caller which uses
>      contentp, read_object(). And the only thing it does
>      after a successful call is to return the content
>      pointer to its caller, using NULL as a sentinel for
>      errors. So in effect it converts the success code from
>      sha1_object_info_extended() back into an error!
>
>      But this is still worth addressing avoid problems for
>      future users of "contentp".
>
>   2. Callers of unpack_sha1_rest() are expected to close the
>      zlib stream themselves on error. Which means that we're
>      leaking the stream.
>
> The problem in (1) comes from from c84a1f3ed4 (sha1_file:
> refactor read_object, 2017-06-21), which added the contentp
> field.  Before that, we called unpack_sha1_rest() via
> unpack_sha1_file(), which directly used the NULL to signal
> an error.
>
> But note that the leak in (2) is actually older than that.
> The original unpack_sha1_file() directly returned the result
> of unpack_sha1_rest() to its caller, when it should have
> been closing the zlib stream itself on error.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Obviously correct.  (2) is as old as Git itself; it eventually
blames down to e83c5163 ("Initial revision of "git", the information
manager from hell", 2005-04-07), where read-cache.c::unpack_sha1_file()
liberally returns NULL without cleaning up the zstream.

Thanks.

>  sha1_file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 09ad64ce55..10c3a0083d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1124,10 +1124,14 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	} else if ((status = parse_sha1_header_extended(hdr, oi, flags)) < 0)
>  		status = error("unable to parse %s header", sha1_to_hex(sha1));
>  
> -	if (status >= 0 && oi->contentp)
> +	if (status >= 0 && oi->contentp) {
>  		*oi->contentp = unpack_sha1_rest(&stream, hdr,
>  						 *oi->sizep, sha1);
> -	else
> +		if (!*oi->contentp) {
> +			git_inflate_end(&stream);
> +			status = -1;
> +		}
> +	} else
>  		git_inflate_end(&stream);
>  
>  	munmap(map, mapsize);
