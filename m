Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E77C433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 00:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB4B611C4
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 00:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhKFBBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Nov 2021 21:01:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63856 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbhKFBBE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Nov 2021 21:01:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EAACE9045;
        Fri,  5 Nov 2021 20:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lRUDSz9PbKIojXJKw+/WsfhKhVS5393so6ROjQ
        2wvT8=; b=Pacm3Nb01SZC2gvRkPX40zYTPm//vWBeodMw1AJ0PrsdYzP2iiG01y
        l9gXo5myzlhHFtGqWGSuvqoirVue9gHZMXalRLIadCKZj8QtzK0Wwkt6I2Xj/dBP
        WhXm7ZfaLPUKaZOeRF+nUDQV5mJiTZaVE4Ckzd5vMsRKsThUTeZMg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 464F5E9044;
        Fri,  5 Nov 2021 20:58:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A437AE9043;
        Fri,  5 Nov 2021 20:58:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file: force flush of stdout on empty string
References: <pull.1124.git.git.1636149400.gitgitgadget@gmail.com>
        <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
Date:   Fri, 05 Nov 2021 17:58:07 -0700
In-Reply-To: <2d687baeed82e7b90d383bad8e209f50e0ce8c87.1636149400.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Fri, 05 Nov 2021 21:56:39
        +0000")
Message-ID: <xmqqsfwaumlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A3485FB4-3E9C-11EC-AE9F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -405,6 +405,11 @@ static void batch_one_object(const char *obj_name,
>  	int flags = opt->follow_symlinks ? GET_OID_FOLLOW_SYMLINKS : 0;
>  	enum get_oid_result result;
>  
> +	if (opt->buffer_output && obj_name[0] == '\0') {
> +		fflush(stdout);
> +		return;
> +	}
> +

This might work in practice, but it a bad design taste to add this
change here.  The function is designed to take an object name
string, and it even prepares a flag variable needed to make a call
to turn that object name into object data.  We do not need to
contaminate the interface with "usually this takes an object name,
but there are these other special cases ...".  The higher in the
callchain we place special cases, the better the lower level
functions become, as that allows them to concentrate on doing one
single thing well.

>  	result = get_oid_with_context(the_repository, obj_name,
>  				      flags, &data->oid, &ctx);
>  	if (result != FOUND) {
> @@ -609,7 +614,11 @@ static int batch_objects(struct batch_options *opt)
>  			data.rest = p;
>  		}
>  
> -		batch_one_object(input.buf, &output, opt, &data);
> +		 /*
> +		  * When in buffer mode and input.buf is an empty string,
> +		  * flush to stdout.
> +		  */

Checking "do we have the flush instruction (in which case we'd do
the flush here), or do we have textual name of an object (in which
case we'd call batch_one_object())?" here would be far cleaner and
results in an easier-to-explain code.  With a cleanly written code
to do so, it probably does not even need a new comment here.

This brings up another issue.  Is "flushing" the *ONLY* special
thing we would ever do in this codepath in the future?  I doubt so.
Squatting on an "empty string" is a selfish design that hurts those
who will come after you in the future, as they need to find other
ways to ask for a "special thing".

If we are inventing a special syntax that allows us to spell
commands that are distinguishable from a validly-spelled object name
to cause something special (like "flushing the output stream"),
perhaps we want to use a bit more extensible and explicit syntax and
use it from day one?

For example, if no string that begins with three dots can ever be a
valid way to spell an object name, perhaps "...flush" might be a
better "please do this special thing" syntax than an empty string.
It is easily extensible (the next special thing can follow suit to
say "...$verb" to tell the machinery to $verb the input).  When we
compare between an empty string and "...flush", the latter clearly
is more descriptive, too.

Note that I offhand do not know if "a valid string that name an
object would never begin with three-dot" is true.  Please check
if that is true if you choose to use it, or you can find and use
another convention that allows us to clearly distinguish the
"special" instruction and object names.

Thanks.

> +		 batch_one_object(input.buf, &output, opt, &data);
>  	}
>  
>  	strbuf_release(&input);
