Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B22209AB
	for <e@80x24.org>; Wed,  6 Sep 2017 01:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753649AbdIFBYl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 21:24:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50917 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753574AbdIFBYe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 21:24:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EDA6AF477;
        Tue,  5 Sep 2017 21:24:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=XeqG5b4PMK2Hp6VWiwLZfg9PmLw=; b=dHjqSCxm7hRQdPZ5nObW
        KtDnaHoVm3av97RDsmtxUV90FMwlwYoQfk2yZJ3PwTh982G3ZbfIpj86u7uiz06r
        ktCLwpt6DomzvHpt/MhkhODIZX1py6qF6BYkjn2DxcmYyh0j7UDeg4JxqUAHrJJs
        q+BEcgkfzileI7/WbZ5862o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=TVTvda7CQPy83JFvB6+yYHOUFIKl/nVEKUUS2OZNPFceIb
        FQMgUpSLnLBVVlpjDqUSDUy2NR5rfpGYNz7wkRdzjv3CJmCGFsBeNgCss//nrmDp
        BulhIDtqbLhEJCM6R3BTtRxlyd6zFryj2xFbp2ZyGZvwE9tcv/4LcAaQK6M6U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 34DC7AF476;
        Tue,  5 Sep 2017 21:24:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 90941AF475;
        Tue,  5 Sep 2017 21:24:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org,
        jeffhost@microsoft.com, peff@peff.net
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
        <20170830185922.10107-1-git@jeffhostetler.com>
        <20170830185922.10107-2-git@jeffhostetler.com>
Date:   Wed, 06 Sep 2017 10:24:31 +0900
Message-ID: <xmqqo9qoaab4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 23807FC8-92A2-11E7-929B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> This is to address concerns raised by ThreadSanitizer on the
> mailing list about threaded unprotected R/W access to map.size with my previous
> "disallow rehash" change (0607e10009ee4e37cb49b4cec8d28a9dda1656a4).  See:
> https://public-inbox.org/git/adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com/
>
> Add API to hashmap to disable item counting and to disable automatic rehashing.  
> Also include APIs to re-enable item counting and automatica rehashing.
>
> When item counting is disabled, the map.size field is invalid.  So to
> prevent accidents, the field has been renamed and an accessor function
> hashmap_get_size() has been added.  All direct references to this
> field have been been updated.  And the name of the field changed
> to map.private_size to communicate thie.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  attr.c                  | 14 ++++---
>  builtin/describe.c      |  2 +-
>  hashmap.c               | 31 +++++++++++-----
>  hashmap.h               | 98 ++++++++++++++++++++++++++++++++++++++-----------
>  name-hash.c             |  6 ++-
>  t/helper/test-hashmap.c |  2 +-
>  6 files changed, 113 insertions(+), 40 deletions(-)

I feel somewhat stupid to say this, especially after seeing many
people applaud this patch, but I do not seem to be able to even
build Git with this patch.  I am getting:

    common-main.o: In function `hashmap_get_size':
    /home/gitster/w/git.git/hashmap.h:260: multiple definition of `hashmap_get_size'
    fast-import.o:/home/gitster/w/git.git/hashmap.h:260: first defined here
    libgit.a(argv-array.o): In function `hashmap_get_size':
    /home/gitster/w/git.git/hashmap.h:260: multiple definition of `hashmap_get_size'
    fast-import.o:/home/gitster/w/git.git/hashmap.h:260: first defined here
    libgit.a(attr.o): In function `hashmap_get_size':
    ...

and wonder if others are building with different options or something..

> diff --git a/hashmap.h b/hashmap.h
> index 7a8fa7f..7b8e6f4 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -253,6 +253,19 @@ static inline void hashmap_entry_init(void *entry, unsigned int hash)
>  }
>  
>  /*
> + * Return the number of items in the map.
> + */
> +inline unsigned int hashmap_get_size(struct hashmap *map)

I think this must become static inline like everybody else in this
file, at least.

I also wonder if this header is excessively inlining too many
functions without measuring first, but that is a different story.
