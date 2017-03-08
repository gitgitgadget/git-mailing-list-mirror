Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2382720135
	for <e@80x24.org>; Wed,  8 Mar 2017 22:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753908AbdCHW2q (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 17:28:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63022 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752287AbdCHW2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 17:28:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A205E70262;
        Wed,  8 Mar 2017 17:28:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ubtO2aWWQy4gGxJdFuAsAugaN50=; b=PAGRj6
        EB4/u+3bKg62keTxIgmL3lmx3B2OUhp9pjpsQ26fO7i5KrqhdGS3xro/nZAJ8IPi
        fxDslWwJr1KODygRUP50ZfkMbaV5fz9UTOjB4FmDIWoo1UD8vLW5o6QZf121BW5q
        6ZMJBAAR2TZAr+1lJZRS8RyYmzoYS28GhwCVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R2tNvB1Ip4RIKVSw1Oz0Z9KvpC7SmnoE
        VWYEpiQTFNF7yP6snwuqNMqg2E4Ht31GVQ3R8ceSY+VADNaZfLG8FcvnyCoGWZN6
        YcPzSioaib2403hkNW/bBy/wqFfQlzk8E+A5XEZfFQrWBRHseckR018aJ9YPg4fF
        Valn3rzaf9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 989C170261;
        Wed,  8 Mar 2017 17:28:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E7AA27025F;
        Wed,  8 Mar 2017 17:28:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     szeder.dev@gmail.com, email@benjaminfuchs.de, git@vger.kernel.org,
        sandals@crustytoothpaste.net, ville.skytta@iki.fi
Subject: Re: [PATCHv3] rev-parse: add --show-superproject-working-tree
References: <xmqq60jk488v.fsf@gitster.mtv.corp.google.com>
        <20170308192037.21847-1-sbeller@google.com>
Date:   Wed, 08 Mar 2017 14:28:42 -0800
In-Reply-To: <20170308192037.21847-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 8 Mar 2017 11:20:37 -0800")
Message-ID: <xmqqmvcv1jz9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96B1E226-044E-11E7-AAD0-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +--show-superproject-working-tree
> +	Show the absolute path of the top-level directory of
> +	the superproject. A superproject is a repository that records
> +	this repository as a submodule.

The top-level directory of the superproject's working tree?

Describe error conditions, like "you get an error if there is no
such project"?

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index e08677e559..2549643267 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -12,6 +12,7 @@
>  #include "diff.h"
>  #include "revision.h"
>  #include "split-index.h"
> +#include "submodule.h"
>  
>  #define DO_REVS		1
>  #define DO_NOREV	2
> @@ -779,6 +780,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  					puts(work_tree);
>  				continue;
>  			}
> +			if (!strcmp(arg, "--show-superproject-working-tree")) {
> +				const char *superproject = get_superproject_working_tree();
> +				if (superproject)
> +					puts(superproject);
> +				continue;

When is superproject NULL?  Shouldn't we die with "there is no
superproject that uses us as a submodule"?

I can accept "it is not an error to ask for the root of the
superproject's working tree when we do not have any---that is one
way to ask if we have a superproject or not".  But if that is the
case, the code can stay the same, but the documentation should say
so, something like...

	Show the absolute path of the root of the superproject's
	working tree (if exists) that uses the current repository as
	its submodule.  Outputs nothing if the current repository is
	not used as a submodule by any project.

