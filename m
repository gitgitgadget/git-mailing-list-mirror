Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C277620229
	for <e@80x24.org>; Tue,  1 Nov 2016 17:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbcKARb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 13:31:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61931 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751797AbcKARb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 13:31:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D95E49CE1;
        Tue,  1 Nov 2016 13:31:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZxAp/NcEKLXzA5ZI2yyJ6eRfCQo=; b=oGxx2S
        oZS1UOguI+53j2JoQjEKO1/osC9f5s8g614dBMM9OcY1s2i2sf6jkYsmq2Mz2zcj
        OP4quFvlwBjqpSOxFMQ7oAL4hL6O3Fd6XbybsX1aalnAYm2M3Cccha2lP+2Jnz4Q
        1dGVR6n9VUzXl/xJfEx1sjy2FyCbgYwZQD7QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qyHQ8tN94JI7ayai3F+9fImjmx53JYx/
        C0vS/eNymNjMzZrpxibMgWQY6dpeE6hpE6BjuUZoWEIpx79zsiRtvrGkpoIHlva3
        VmAmpYJM5B9EqXlC1vvH3fD26s+SGm7gCN5q0SjaQKaDvf5x63NS0DN/Hg8E0tdC
        9NhjpeLg6ss=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3634449CDF;
        Tue,  1 Nov 2016 13:31:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B171A49CDE;
        Tue,  1 Nov 2016 13:31:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 3/6] grep: add submodules as a grep source type
References: <20161027223834.35312-1-bmwill@google.com>
        <1477953496-103596-1-git-send-email-bmwill@google.com>
        <1477953496-103596-4-git-send-email-bmwill@google.com>
Date:   Tue, 01 Nov 2016 10:31:24 -0700
In-Reply-To: <1477953496-103596-4-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 31 Oct 2016 15:38:13 -0700")
Message-ID: <xmqq37jbqf83.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C8D41E-A059-11E6-BC73-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add `GREP_SOURCE_SUBMODULE` as a grep_source type and cases for this new
> type in the various switch statements in grep.c.
>
> When initializing a grep_source with type `GREP_SOURCE_SUBMODULE` the
> identifier can either be NULL (to indicate that the working tree will be
> used) or a SHA1 (the REV of the submodule to be grep'd).  If the
> identifier is a SHA1 then we want to fall through to the
> `GREP_SOURCE_SHA1` case to handle the copying of the SHA1.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Conceptually, it somehow feels strange to have SUBMODULE in this
set.

Source being SHA1 means we are doing a recursive grep in a tree
structure that is stored in the object store, being FILE means we
are reading from the filesystem, being BUF means we are fed in-core
buffer (e.g. to implement the "log --grep='string in message'").  It
is unclear how SUBMODULE fits in that picture, as we do not have a
caller that uses the type at this step yet.  Hopefully it will
become obvious why this new type belongs to that set as the series
progresses ;-)

>  grep.c | 16 +++++++++++++++-
>  grep.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 1194d35..0dbdc1d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1735,12 +1735,23 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>  	case GREP_SOURCE_FILE:
>  		gs->identifier = xstrdup(identifier);
>  		break;
> +	case GREP_SOURCE_SUBMODULE:
> +		if (!identifier) {
> +			gs->identifier = NULL;
> +			break;
> +		}
> +		/*
> +		 * FALL THROUGH
> +		 * If the identifier is non-NULL (in the submodule case) it
> +		 * will be a SHA1 that needs to be copied.
> +		 */
>  	case GREP_SOURCE_SHA1:
>  		gs->identifier = xmalloc(20);
>  		hashcpy(gs->identifier, identifier);
>  		break;
>  	case GREP_SOURCE_BUF:
>  		gs->identifier = NULL;
> +		break;
>  	}
>  }
>  
> @@ -1760,6 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
>  	switch (gs->type) {
>  	case GREP_SOURCE_FILE:
>  	case GREP_SOURCE_SHA1:
> +	case GREP_SOURCE_SUBMODULE:
>  		free(gs->buf);
>  		gs->buf = NULL;
>  		gs->size = 0;
> @@ -1831,8 +1843,10 @@ static int grep_source_load(struct grep_source *gs)
>  		return grep_source_load_sha1(gs);
>  	case GREP_SOURCE_BUF:
>  		return gs->buf ? 0 : -1;
> +	case GREP_SOURCE_SUBMODULE:
> +		break;
>  	}
> -	die("BUG: invalid grep_source type");
> +	die("BUG: invalid grep_source type to load");
>  }
>  
>  void grep_source_load_driver(struct grep_source *gs)
> diff --git a/grep.h b/grep.h
> index 5856a23..267534c 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -161,6 +161,7 @@ struct grep_source {
>  		GREP_SOURCE_SHA1,
>  		GREP_SOURCE_FILE,
>  		GREP_SOURCE_BUF,
> +		GREP_SOURCE_SUBMODULE,
>  	} type;
>  	void *identifier;
