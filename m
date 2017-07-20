Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C1A1F600
	for <e@80x24.org>; Thu, 20 Jul 2017 21:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936288AbdGTVsy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 17:48:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55461 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932346AbdGTVsx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 17:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 44CCF7C931;
        Thu, 20 Jul 2017 17:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LEm+bTuDfbIq5SKYYHs3JBDxAGI=; b=aRhvlq
        KwXjH5VmiIOUtuDs6MImv9b9+SUMw/30Ilet6ulaesWRSg14vmO539613+ZVxF+Q
        VaBzKLkaLvEyrzFHovo10kZMky1X6jwybikUrlHLq3tiJidJ3DXIUHlfDWw5gbYC
        mgilVMohbQEvl/2XLxzIoJQ2eHZKPoZstMP9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uuFCm6idQkpI3TPJAOFfbZLDEOUuIp50
        93Xqp7vtwkznIDPeeblC7ihtQ19TkufQ+tvdxHOR+XJQNpL7EY18WBEjKc1AAvR2
        1MuemAV8jef5f2GTIzPlVbtOCsawICwL7/tgByC1bKvkDWbWgs2jZa2KBSBH/4/D
        dxum/LEO8SY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D5C37C930;
        Thu, 20 Jul 2017 17:48:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F1587C92E;
        Thu, 20 Jul 2017 17:48:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] sha1_file: use access(), not lstat(), if possible
References: <alpine.DEB.2.21.1.1707191450570.4193@virtualbox>
        <20170719171251.11906-1-jonathantanmy@google.com>
Date:   Thu, 20 Jul 2017 14:48:50 -0700
In-Reply-To: <20170719171251.11906-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 19 Jul 2017 10:12:51 -0700")
Message-ID: <xmqqbmoekce5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 380CCEBA-6D95-11E7-834D-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In sha1_loose_object_info(), use access() (indirectly invoked through
> has_loose_object()) instead of lstat() if we do not need the on-disk
> size, as it should be faster on Windows [1].

That sounds as if Windows is the only thing that matters.  "It is
faster in general, and is much faster on Windows" would have been
more convincing, and "It isn't slower, and is much faster on
Windows" would also have been OK.  Do we have any measurement, or
this patch does not yield any measuable gain?  

By the way, the special casing of disk_sizep (which is only used by
the batch-check feature of cat-file) is somewhat annoying with or
without this patch, but this change makes it even more so by adding
an extra indentation level.  I do not think of a way to make it less
annoying offhand, and I do not think this change needs to address it
in any way, but I am mentioning this as a hint to bystanders who may
want to find something small that can be cleaned up ;-)

Thanks.

>
> [1] https://public-inbox.org/git/alpine.DEB.2.21.1.1707191450570.4193@virtualbox/
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> Thanks for the information - here's a patch. Do you, by any chance, know
> of a web page (or similar thing) that I can cite for this?
> ---
>  sha1_file.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index fca165f13..81962b019 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2920,20 +2920,19 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  
>  	/*
>  	 * If we don't care about type or size, then we don't
> -	 * need to look inside the object at all. Note that we
> -	 * do not optimize out the stat call, even if the
> -	 * caller doesn't care about the disk-size, since our
> -	 * return value implicitly indicates whether the
> -	 * object even exists.
> +	 * need to look inside the object at all. We only check
> +	 * for its existence.
>  	 */
>  	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
> -		const char *path;
> -		struct stat st;
> -		if (stat_sha1_file(sha1, &st, &path) < 0)
> -			return -1;
> -		if (oi->disk_sizep)
> +		if (oi->disk_sizep) {
> +			const char *path;
> +			struct stat st;
> +			if (stat_sha1_file(sha1, &st, &path) < 0)
> +				return -1;
>  			*oi->disk_sizep = st.st_size;
> -		return 0;
> +			return 0;
> +		}
> +		return has_loose_object(sha1) ? 0 : -1;
>  	}
>  
>  	map = map_sha1_file(sha1, &mapsize);
