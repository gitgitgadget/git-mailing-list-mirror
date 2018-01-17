Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B9831F406
	for <e@80x24.org>; Wed, 17 Jan 2018 19:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750948AbeAQTEg (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 14:04:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54001 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeAQTEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 14:04:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D805BD6E5;
        Wed, 17 Jan 2018 14:04:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TsRtDzV1YSK29pJIqeUQDHhcEII=; b=i9TqQW
        AnapT87BrOg8KUkHpnNI1kmoS0SavmwNtrHct3TUnPHuyc1aUmxHAxJkvkJ8bHuA
        i8QmhcllLPDN1HgXL+uLk5TAD7yeCmm1GzEU47iiVBCP1iJAb5f3/cgwhEnwYgIn
        Zgt5UfxRGd5ARyU4gsxe52Ne6wfkQFOelz6eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nvNnEsANLP/+8SNRwi3rGbTqXH+Vxzxh
        I4uo2Z3e7CFoj2M0n132USrdpoy2RxoDuHop7XSmx9qa7LLRu4A09ndxeF3T9dI5
        gd9733oiF3LZhPT7dofqSHzauTIMKiVUCqRnY9ZN0OcNwvcegCqaFE5fhrhJSN6t
        j1F/lGfkX4E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 749B7BD6E4;
        Wed, 17 Jan 2018 14:04:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7083BD6E1;
        Wed, 17 Jan 2018 14:04:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     git@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
References: <20180117184828.31816-1-hch@lst.de>
Date:   Wed, 17 Jan 2018 11:04:32 -0800
In-Reply-To: <20180117184828.31816-1-hch@lst.de> (Christoph Hellwig's message
        of "Wed, 17 Jan 2018 19:48:28 +0100")
Message-ID: <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 412B2228-FBB9-11E7-B984-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> fsync is required for data integrity as there is no gurantee that
> data makes it to disk at any specified time without it.  Even for
> ext3 with data=ordered mode the file system will only commit all
> data at some point in time that is not guaranteed.

It comes from this one:

commit aafe9fbaf4f1d1f27a6f6e3eb3e246fff81240ef
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Jun 18 15:18:44 2008 -0700

    Add config option to enable 'fsync()' of object files
    
    As explained in the documentation[*] this is totally useless on
    filesystems that do ordered/journalled data writes, but it can be a
    useful safety feature on filesystems like HFS+ that only journal the
    metadata, not the actual file contents.
    
    It defaults to off, although we could presumably in theory some day
    auto-enable it on a per-filesystem basis.
    
    [*] Yes, I updated the docs for the thing.  Hell really _has_ frozen
        over, and the four horsemen are probably just beyond the horizon.
        EVERYBODY PANIC!
    
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0e25b2c92..9a1cec5c8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -866,10 +866,8 @@ core.whitespace::
>  core.fsyncObjectFiles::
>  	This boolean will enable 'fsync()' when writing object files.
>  +
> -This is a total waste of time and effort on a filesystem that orders
> -data writes properly, but can be useful for filesystems that do not use
> -journalling (traditional UNIX filesystems) or that only journal metadata
> -and not file contents (OS X's HFS+, or Linux ext3 with "data=writeback").
> +This option is enabled by default and ensures actual data integrity
> +by calling fsync after writing object files.

I am somewhat sympathetic to the desire to flip the default to
"safe" and allow those who know they are already safe to tweak the
knob for performance, and it also makes sense to document that the
default is "true" here.  But I do not see the point of removing the
four lines from this paragraph; the sole effect of the removal is to
rob information from readers that they can use to decide if they
want to disable the configuration, no?
