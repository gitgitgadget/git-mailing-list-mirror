Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FCC72018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759692AbcHEVQj (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:16:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55563 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S937157AbcHEVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:16:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 06EA131D98;
	Fri,  5 Aug 2016 17:16:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gE2HIUr7VS3EFHhRj7oKAxwevB4=; b=NpdeaB
	+z3L3oVVrwJkQ0pLvqwPIUdwltVJjK8DbJtZNdcWmj5tS2DzLoyukprteuSVdsSK
	gBAA4rHVt7SC+8vV3r5xAmbYnNUAHWaWGV0ve2dcHhbRfNrOH7ea+pU8+y/Nh3BE
	Ou1PvzohuWqGCv4g/liurUruqorMStbkxWGI4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DBokAZZojG/NwmpTkl3p5V4H9vkRD0ka
	Aj1KaHCoblluZRpfq3RrKrgbZxmpXvZNTG0QD0eQpQ2kDCpNqDcuMFoBeWxFngcI
	hVoO6juZ1FK9Jxmhl65EGHGM+xgT8q2jBlpzzz2mcbMt7ezW0Cvhz/EAwlbPAqWA
	8SWIJY3jE54=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F1AAF31D97;
	Fri,  5 Aug 2016 17:16:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D69231D96;
	Fri,  5 Aug 2016 17:16:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de
Subject: Re: [PATCH 5/6] submodule update: add super-reference flag
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-6-sbeller@google.com>
Date:	Fri, 05 Aug 2016 14:16:32 -0700
In-Reply-To: <20160804195159.7788-6-sbeller@google.com> (Stefan Beller's
	message of "Thu, 4 Aug 2016 12:51:58 -0700")
Message-ID: <xmqq1t22x6fj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3DADE82-5B51-11E6-8777-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

That's a bit sketchy description.  From the title, I expected that
we would see one additional 'unsigned super_reference : 1;' field in
some structure, but that is not what is happening.  The log message
needs to describe what these string list are and why they are needed
a bit better.

At least, please don't name a multiple_word field "multipleword" ;-)

> @@ -715,6 +716,15 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>  		for_each_string_list_item(item, &suc->references)
>  			argv_array_pushl(&child->args, "--reference", item->string, NULL);
>  	}
> +	if (suc->superreferences.nr) {
> +		struct string_list_item *item;
> +		for_each_string_list_item(item, &suc->superreferences) {
> +			strbuf_reset(&sb);
> +			argv_array_pushf(&child->args, "--reference=%s/%s",
> +					 relative_path(item->string, suc->prefix, &sb),
> +					 sub->path);

The phrase "super reference" made me imagine it is some kind of
"reference" that is applicable to the superproject, but this code
smells like it is a "prefix to create reference suited for use in
submodule".  Whatever it is, it should be explained better (than "no
desciption" which is what we have here ;-), and given a name that
match the explanation.

Thanks.
