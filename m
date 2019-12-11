Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06250C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1C121556
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 19:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YMizp1re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKTdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:33:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50283 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKTdo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 14:33:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 12CF093EA5;
        Wed, 11 Dec 2019 14:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=DqAw/ISkL2AJiwxMY4GigdafEbY=; b=YMizp1
        ree2PK+27uZKNe9yEcVt4Zb8+FX1YUcROIeAOS2R7DagXLhHsdtUBt8lKBC09GzB
        cnaKQJ2mKIaAZcaKZTBeafbvt/uPba3B8M/2BKIAdHoZ4YgXNcuOAYpa1spXefPX
        gaJ4o1aG8fNVoLXdMPbWxonPNkWzlXwh/JEMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kZYc8xNbvZpB543KgOC7Nwwa8X/+fupA
        ch9GWMBP7H8D8ah/GpwWel14Pv3QQUe2RelLa9ZBIoINxTrKQngqioBY1VRbcEJB
        HkFV8Ch3zHMLW7ZBya9x+Lmh5pReDNIcQG/dpTsCkpAEk/nvmqzr6KgVTImRo4Dg
        qUbl0nsgaek=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B04593EA4;
        Wed, 11 Dec 2019 14:33:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 31B6793EA2;
        Wed, 11 Dec 2019 14:33:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] hook: teach --porcelain mode
In-Reply-To: <20191210023335.49987-7-emilyshaffer@google.com> (Emily Shaffer's
        message of "Mon, 9 Dec 2019 18:33:35 -0800")
References: <20191210023335.49987-1-emilyshaffer@google.com>
        <20191210023335.49987-7-emilyshaffer@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Wed, 11 Dec 2019 11:33:38 -0800
Message-ID: <xmqqimmmodwt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22EC44FC-1C4D-11EA-B0FA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> It might be desirable - for a user script, or a scripted Git command -
> to run the appropriate set of hooks from outside of the compiled Git
> binary. So, teach --porcelain in a way that enables the following:
>
>   git hook --list --porcelain pre-commit | xargs -I% sh "%"
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

> +--porcelain::
> +	Print in a machine-readable format suitable for scripting.
> +
> ...
> +static int print_hook_list(const struct strbuf *hookname, int porcelain)
>  {
>  	struct list_head *head, *pos;
>  	struct hook *item;
> @@ -25,10 +25,14 @@ static int print_hook_list(const struct strbuf *hookname)
>  
>  	list_for_each(pos, head) {
>  		item = list_entry(pos, struct hook, list);
> +		if (item) {
> +			if (porcelain)
> +				printf("%s\n", item->command.buf);
> +			else
> +				printf("%.3d\t%s\t%s\n", item->order,
> +				       config_scope_to_string(item->origin),
> +				       item->command.buf);
> +		}

So, a Porcelain script cannot learn where the hook command comes
from, or what the precedence order of each line of the output is?

