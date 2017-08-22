Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF2AE208D0
	for <e@80x24.org>; Tue, 22 Aug 2017 22:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdHVWhH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 18:37:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64751 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752247AbdHVWhG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 18:37:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 414C591376;
        Tue, 22 Aug 2017 18:37:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EBHtgo8oBBGob5f1+jh6u2r6V2M=; b=bIohNu
        Zewa5kjsbFLJsZY/pmdH2i7UzjWSpjqOv5VZIGacVMATIxpT0Nd5d35w5Ktx9v/w
        uiY4340/tW5tT8dvHMfOuUjWXemLYtof7KrEqDR0PaZHhFayPhN7cErI8nLPZ/TL
        njuXRcoav2hLcL8gN6GiPynX+ux7+5aJXpxUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v6ieqFpxbdRE5YaCoFFvQx+AdaolZ/Ug
        yAu+srCfK1aDa6QsuWKt1PsPWQbTS1tG6AkwD0/9AoPvY7pQFDxM/1bf/KmB+I/W
        w6wi3G9cKBfGjS6AwqgpRGHh6PXcZSk++T1RUkS6HfUoLLTexq7hV6+KulqorJY9
        YLps8KH5Na0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A48A91375;
        Tue, 22 Aug 2017 18:37:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2D3E91372;
        Tue, 22 Aug 2017 18:37:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 2/4] submodule--helper: introduce for_each_submodule_list()
References: <20170821161515.23775-1-pc44800@gmail.com>
        <20170821161515.23775-2-pc44800@gmail.com>
Date:   Tue, 22 Aug 2017 15:37:04 -0700
In-Reply-To: <20170821161515.23775-2-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Mon, 21 Aug 2017 21:45:13 +0530")
Message-ID: <xmqqefs31b73.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CB04020-878A-11E7-B9B9-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> -static void init_submodule(const char *path, const char *prefix, int quiet)
> +static void for_each_submodule_list(const struct module_list list,
> +				    submodule_list_func_t fn, void *cb_data)

It may not be wrong per-se, but can't this just be for_each_submodule()?

Your "justification" may be that this makes it clear that you are
iterating over module_list and not other kind of group of
submodules, but I would say the design of the subsystem is broken if
some places use a list of submodules while some other places use an
array of submodules to represent a group of submodules.  Especially
when there is a dedicated type to hold a group of submodules,
i.e. struct module-list, that type should be used consistently
throughout the subsystem and API, no?

>  {
> +	int i;
> +	for (i = 0; i < list.nr; i++)
> +		fn(list.entries[i], cb_data);
> +}

Also, did you really want to pass the structure by value?  At least
in C, it is more customary to pass these things by pointer, i.e.

	for_each_submodule(struct module_list *list,
			   for_each_submodule_fn fn,
			   void *cb_data)
	{
		for (i = 0; i < list->nr; i++)
			...

Otherwise you'd be making a copy on stack unnecessarily (ok, "const"
might hint a smart compiler to turn this inefficient code to pass it
by pointer, but I do not think it is a particulary good to rely on
such things).

