Return-Path: <SRS0=d/2q=6J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16DBC2BA19
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 04:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8028D20706
	for <git@archiver.kernel.org>; Sat, 25 Apr 2020 04:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HJVAx8Nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgDYEwO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Apr 2020 00:52:14 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62969 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgDYEwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Apr 2020 00:52:13 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 08C25D4C04;
        Sat, 25 Apr 2020 00:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7grEZwwAvKPGsBl8sp/Krfyp7sY=; b=HJVAx8
        NqBWwBfios88nNCsNNSY/i7mmPWyUZ8gT+U6s0jIcAFFdB8MEQ5V5oLEECSYzVBa
        9rJeuBF2xlMEvWMEOfq5fMQ6vcpVw19M//iEP085mkB8djtJeOGsaaHKIhL0EbSw
        +UTc8cYj217YGFvzjvs3eBoKRcwqDictCsN9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YRIg4lc7bmiweCJe/I7SW1YoHYA0ySmC
        aWngfEzJ1tX/IMJMGBYUZMGpn4fFP8lBMa/cuQp6RJlXIpt+07sLu/Q3cBLuHpYZ
        XYhkB6BdMp5TojF+fYMVdRLrXiemZiFjVmEtEUrKl/88qCm0lh+djbp5oXXT7l3J
        Y8qwjQs/iDw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 00CE6D4C03;
        Sat, 25 Apr 2020 00:52:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 49D3DD4C02;
        Sat, 25 Apr 2020 00:52:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: collect list of populated hooks
References: <20200424233800.200439-1-emilyshaffer@google.com>
Date:   Fri, 24 Apr 2020 21:52:07 -0700
In-Reply-To: <20200424233800.200439-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Fri, 24 Apr 2020 16:38:00 -0700")
Message-ID: <xmqqsggs9ngo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8512C17E-86B0-11EA-BD36-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Without a definitive list of hook names within the code, we compile our
> own list from the documentation. This is likely prone to bitrot. To
> reduce the amount of code humans need to read, we turn the list into a
> string_list and iterate over it (as we are calling the same find_hook
> operation on each string). However, since bugreport should primarily be
> called by the user, the performance loss from massaging the string
> seems acceptable.

In this iteration we no longer are collecting the hook names into
string list, but just formating the findings in a strbuf, no?

> @@ -33,6 +35,53 @@ static void get_system_info(struct strbuf *sys_info)
>  	get_libc_info(sys_info);
>  }
>  
> +static void get_populated_hooks(struct strbuf *hook_info, int nongit)
> +{
> +	/*
> +	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> +	 * so below is a transcription of `git help hooks`. Later, this should
> +	 * be replaced with some programmatically generated list (generated from
> +	 * doc or else taken from some library which tells us about all the
> +	 * hooks)
> +	 */

Yes, I recall that we discussed adding some annotation to
documentation and extracting this automatically.

> +	const char *hook[] = {

Is it worth making this "static const"?

> +	if (nongit) {
> +		strbuf_addstr(hook_info,
> +			"not run from a git repository - no hooks to show\n");
> +		return;
> +	}
> +
> +	for (i=0; i < ARRAY_SIZE(hook); i++)

Style: SP around = in "i=0".

> +	get_header(&buffer, "Enabled Hooks");
> +	get_populated_hooks(&buffer, nongit_ok);
> +

Sounds good, otherwise.

