Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14936C433EF
	for <git@archiver.kernel.org>; Thu, 19 May 2022 10:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiESKE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 06:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiESKE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 06:04:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76D99C2C7
        for <git@vger.kernel.org>; Thu, 19 May 2022 03:04:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A11D18FD0B;
        Thu, 19 May 2022 06:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Owq37fuBX7ivel1HDJgrV35yS+G1V6qdzrXyUecsY3c=; b=b8iN
        q+uMdWDVygx6jwZIyCs5faBXQBjUiTve30T2TdQOhTp1aLgP/Rnq5lvnDwgUn1F/
        /P5Uky4Yn8dekqDYcIUm78PQXYIluXqYE15bCxVRem6EBY5Yocir08euldDpmQIk
        lwwegyDYFTlCAJmgCKPPuBm6IAO0MRInIyu0Pr4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 833EF18FD0A;
        Thu, 19 May 2022 06:04:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E41A18FD09;
        Thu, 19 May 2022 06:04:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, derrickstolee@github.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 08/17] builtin/pack-objects.c: --cruft without
 expiration
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1652915424.git.me@ttaylorr.com>
        <94fe03cc65716b6102e2d71df49d4ae5a1a60dc7.1652915424.git.me@ttaylorr.com>
Date:   Thu, 19 May 2022 03:04:18 -0700
Message-ID: <xmqq7d6hsusd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D049D58-D75B-11EC-A8BD-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> @@ -3870,6 +4034,20 @@ static int option_parse_unpack_unreachable(const struct option *opt,
>  	return 0;
>  }
>  
> +static int option_parse_cruft_expiration(const struct option *opt,
> +					 const char *arg, int unset)
> +{
> +	if (unset) {
> +		cruft = 0;
> +		cruft_expiration = 0;
> +	} else {
> +		cruft = 1;
> +		if (arg)
> +			cruft_expiration = approxidate(arg);
> +	}
> +	return 0;
> +}

It is somewhat sad that we have to invent this function, instead of
using parse_opt_expiry_date_cb().
