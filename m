Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71FD1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 18:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfGOSFH (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 14:05:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62568 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbfGOSFG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 14:05:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B05DA8691C;
        Mon, 15 Jul 2019 14:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xB0rlyJ/eDLQvozSRvbuvqftv9k=; b=yRVjpk
        M3z+6EsBGDzFfbIjkcPvdZZyGVCRrVXCCxPs8jq9Fg30D6NGrWf5Fu82vm2VeMVZ
        3YluGJCaDBO6ny7GAFsQtv8tilqIzw/FVHPA0SNG2uZIJvYqWf9BbpDIoPX99i2p
        mEN21Y7B5kSSDPOeFfB1vl73X4nxXFAYkdmNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=leI/gEDyBuFZxCqpYHfKbWiqE+Vf5Kls
        BnKUvZE7w6UdwYR3gDmRCdjgahDXD63Y/bmCqNJoDmqAtX4aT8PBKk3CQVdRgbmH
        H5ypowhcz8FDJJYl6XFIVNhodxwimvVEMhI1/7Z0ome43nGlvLAvBfPwga1p/XPB
        W6iWIYsuqLM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A85CA8691A;
        Mon, 15 Jul 2019 14:05:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C808886915;
        Mon, 15 Jul 2019 14:04:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        martin.agren@gmail.com, Johannes.Schindelin@gmx.de,
        newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH 1/2] sequencer: add NULL checks under read_author_script
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
        <20190712185357.21211-2-rohit.ashiwal265@gmail.com>
Date:   Mon, 15 Jul 2019 11:04:56 -0700
In-Reply-To: <20190712185357.21211-2-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sat, 13 Jul 2019 00:23:56 +0530")
Message-ID: <xmqqh87n41iv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F94E5E0-A72B-11E9-B7B5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> +	if (name)
> +		*name = kv.items[name_i].util;
> +	else
> +		free(kv.items[name_i].util);
> +	if (email)
> +		*email = kv.items[email_i].util;
> +	else
> +		free(kv.items[email_i].util);
> +	if (date)
> +		*date = kv.items[date_i].util;
> +	else
> +		free(kv.items[date_i].util);
>  	retval = 0;

Some of the .util field may have been freed and others may have
taken possession by the caller at this point.

>  finish:
>  	string_list_clear(&kv, !!retval);

And we tell string_list_clear() not to free the .util field, so
kv.items[].util won't leak, which is good.
