Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F797202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 03:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760830AbdKRDhI (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 22:37:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1760807AbdKRDhG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 22:37:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E3BFBB978;
        Fri, 17 Nov 2017 22:37:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uwXUPufPxHAdfQh7dMtWmiNTx9s=; b=PEZ81l
        glVggpsqlMFYa+y8X0SEaVDBdihE/obSOrmGnyu3qTuAOqVgEx9oV0nPxYdhBjo7
        dRwWJ9Y36K8h+7IzhDtD7M5jaaxvq3xdnjIv3KLTbCvAnhdOTXNZlunQl2cXENF/
        roYAPX5G6QzwiGQ7cP1etqDyspcWzjy0JVJAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OL6vPPO6ACQa3l7Blz7V0Wevtb2eoU5m
        uPD4n4g6dJ0Bk42DESAhnsPGPEizBEmeyJStOSaGkOAbBUN18tFgIsFvJq4R76ET
        NpYij/JRKfzCJT3Jg/St3fm5Gvoh0BoQcd8qeIVFFSAUs0SXNKwW6UwFZViNdqAB
        fLT3/BB0YCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76B0EBB977;
        Fri, 17 Nov 2017 22:37:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EA7AABB976;
        Fri, 17 Nov 2017 22:37:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     hsed@unimetic.com
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH V4] config: add --expiry-date
References: <xmqqlgj7xcuf.fsf@gitster.mtv.corp.google.com>
        <20171118022727.30179-1-hsed@unimetic.com>
Date:   Sat, 18 Nov 2017 12:37:03 +0900
In-Reply-To: <20171118022727.30179-1-hsed@unimetic.com> (hsed@unimetic.com's
        message of "Sat, 18 Nov 2017 02:27:27 +0000")
Message-ID: <xmqq8tf4qmu8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF0A82F6-CC11-11E7-A3D8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hsed@unimetic.com writes:

> diff --git a/config.c b/config.c
> index 903abf953..64f8aa42b 100644
> --- a/config.c
> +++ b/config.c
> @@ -990,6 +990,16 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
>  	return 0;
>  }
>  
> +int git_config_expiry_date(timestamp_t *timestamp, const char *var, const char *value)
> +{
> +	if (!value)
> +		return config_error_nonbool(var);
> +	if (parse_expiry_date(value, timestamp))
> +		return error(_("'%s' for '%s' is not a valid timestamp"),
> +			     value, var);
> +	return 0;
> +}
> +

I think this is more correct even within the context of this
function than dying, which suggests the need for a slightly related
(which is not within the scope of this change) clean-up within this
file as a #leftoverbits task.  I think dying in these value parsers
goes against the point of having die_on_error bit in the
config-source structure; Heiko and Peff CC'ed for b2dc0945 ("do not
die when error in config parsing of buf occurs", 2013-07-12).

Thanks; will queue.
