Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C961C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 22:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiC2Wge (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 18:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiC2Wgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 18:36:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BB81FDFDA
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 15:34:49 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C15221973AD;
        Tue, 29 Mar 2022 18:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Cika7dhEf1QEdyuwTWVn0MJcaXKpDp/UrAtYSD
        1FgWA=; b=ORVBAup+caN8NLoxgRA4XxQp626pjPAFDEzttLcHqUi8QrQ+slcaE7
        kg/cpGu/QA2lOq68RYwSccMOTR3oKin/a4fJiQCO9VNfkN4RUbOoPKDYAObJ8dVB
        HsLZ+NZ+zOykEULNwSGzipEdq8TeEZwkoC3kDJ72udDiv/1/xcBGE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B96A01973AC;
        Tue, 29 Mar 2022 18:34:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 01DC71973AB;
        Tue, 29 Mar 2022 18:34:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v3 2/3] transfer.advertiseObjectInfo: add object-info
 config
References: <20220208235631.732466-1-calvinwan@google.com>
        <20220328191112.3092139-1-calvinwan@google.com>
        <20220328191112.3092139-3-calvinwan@google.com>
Date:   Tue, 29 Mar 2022 15:34:45 -0700
In-Reply-To: <20220328191112.3092139-3-calvinwan@google.com> (Calvin Wan's
        message of "Mon, 28 Mar 2022 19:11:11 +0000")
Message-ID: <xmqqy20sqtfe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6F6E0C36-AFB0-11EC-9CA6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Currently, object-info is always advertised by the server. Add a
> config option to optionally advertise it. A subsequent patch uses this
> option for testing.
>
> ---
>  Documentation/config/transfer.txt |  4 ++++
>  protocol-caps.c                   | 11 +++++++++++
>  protocol-caps.h                   |  6 ++++++
>  serve.c                           |  2 +-
>  4 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
> index b49429eb4d..14892a3155 100644
> --- a/Documentation/config/transfer.txt
> +++ b/Documentation/config/transfer.txt
> @@ -77,3 +77,7 @@ transfer.unpackLimit::
>  transfer.advertiseSID::
>  	Boolean. When true, client and server processes will advertise their
>  	unique session IDs to their remote counterpart. Defaults to false.
> +
> +transfer.advertiseObjectInfo::
> +	Boolean. When true or not set, server processes will advertise its
> +	ability to accept `object-info` command requests
> \ No newline at end of file

Carefully proofread before sending your changes out ;-)

By mimicking the style of the previous item more closely, i.e.

	Boolean. When true, ... requests. Defaults to true.

it would make it easier to read, I suspect.

> diff --git a/protocol-caps.c b/protocol-caps.c
> index bbde91810a..f290e3cca2 100644
> --- a/protocol-caps.c
> +++ b/protocol-caps.c
> @@ -8,6 +8,9 @@
>  #include "object-store.h"
>  #include "string-list.h"
>  #include "strbuf.h"
> +#include "config.h"
> +
> +static int advertise_object_info = -1;

It strikes me somewhat odd that this is the _first_ such capability
that needs a variable here to control if it is advertised or not
depending on the configuration file settings.

In other words, "Why doesn't transfer.advertiseSID also have a
similar thing in this file?" should be the first question that comes
to any reviewers' mind.

Perhaps we just invented a better way to handle such conditional
capability, in which case we may want to port the existing ones that
do not use the same arrangement over to the new way.  Even though it
would be outside the scope of the series, it would be a good way to
make sure we won't accumulate too much technical debt to leave some
hint somewhere near here or in protoco-caps.h where this patch
touches.  I cannot quite tell what is going on.

> int object_info_advertise(struct repository *r, struct strbuf *value)
> {
> 	if (advertise_object_info == -1 &&
> 	    git_config_get_bool("transfer.advertiseObjectInfo", &advertise_object_info))
> 		advertise_object_info = 0;
> 	return advertise_object_info;
> }

"If unset(yet), try to get_bool() and if it fails, set it to 0"

So advertise_object_info becomes true only if transfer.advertiseObjectInfo
is set to true?

It is inconsistent with what we read in the documentation, isn't it?

> diff --git a/protocol-caps.h b/protocol-caps.h
> index 15c4550360..36f7a46b37 100644
> --- a/protocol-caps.h
> +++ b/protocol-caps.h
> @@ -5,4 +5,10 @@ struct repository;
>  struct packet_reader;
>  int cap_object_info(struct repository *r, struct packet_reader *request);
>  
> +/*
> + * Advertises object-info capability if "objectinfo.advertise" is either
> + * set to true or not set
> + */
> +int object_info_advertise(struct repository *r, struct strbuf *value);
> +
>  #endif /* PROTOCOL_CAPS_H */
> diff --git a/serve.c b/serve.c
> index b3fe9b5126..fb4ad367a7 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -133,7 +133,7 @@ static struct protocol_capability capabilities[] = {
>  	},
>  	{
>  		.name = "object-info",
> -		.advertise = always_advertise,
> +		.advertise = object_info_advertise,
>  		.command = cap_object_info,
>  	},
>  };

This is a good step to add a test to see if the server does honor
the (1) lack of (2) true set to and (3) false set to the
configuration variable and sends (or does not send) the capability.
