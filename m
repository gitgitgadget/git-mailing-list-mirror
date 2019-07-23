Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C94FD1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 17:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390800AbfGWRdV (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 13:33:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61727 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732740AbfGWRdV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 13:33:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 567278270F;
        Tue, 23 Jul 2019 13:33:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Vd88pbX2niGIy9FyI/Y7PmJl9/0=; b=bR5OwB
        MJm6unuuxqHpSyf3DJzQpMshLVelqsnm+jovDbqXrAZvh9M7E4BLRAwgURYBBfHr
        IeSOzUIxU0hwIAJjtNcpcDuj2uH2SHcTz8HpD9mFCYFakoopuDHf86Jc5EOWYis8
        QFin2K02vsuJBD5u/gMD7wHfCe7yFwRU0EbF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WX6H2CGeI/7SyVrlNCyZ9Mv0/X1/mFg1
        5uCIipeCm8Cz1mkNW55WYfpMvGADYZRDBs9wBzG7Uy9aup5/pjdoJjtWFNrSgmbJ
        v9RZ9Z93ICgvkrN9ytP0BO+FdJ3K0NfEzSPuovoanjwM3m4k9Qt+A4TZ0qvQMkYV
        eVMnbPih6Aw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4EC528270E;
        Tue, 23 Jul 2019 13:33:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5240682708;
        Tue, 23 Jul 2019 13:33:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     thibault.jamet@gmail.com
Cc:     git@vger.kernel.org, thibault.jamet@adevinta.com
Subject: Re: [PATCH] Close transport helper on protocol error
References: <20190722212250.44011-1-thibault.jamet@gmail.com>
Date:   Tue, 23 Jul 2019 10:33:10 -0700
In-Reply-To: <20190722212250.44011-1-thibault.jamet@gmail.com> (thibault
        jamet's message of "Mon, 22 Jul 2019 23:22:50 +0200")
Message-ID: <xmqq5znsu04p.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1F02F0E-AD6F-11E9-8280-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

thibault.jamet@gmail.com writes:

> Subject: Re: [PATCH] Close transport helper on protocol error

Perhaps

    Subject: transport: close helper on protocol error

> +static int disconnect_helper(struct transport *transport);
> +
> +static int disconnect_helper_data(struct helper_data *data);

Even after reading it twice, disconnect_helper_data() does not ring
the "this is to disconnect the helper process, based on what is
contained in a helper_data instance" bell, which you wanted to ring.
It sounds like it is trying to disconnect "helper_data" from
something unsaid.

I think the root cause of this awkwardness is because this split of
the function into two is suboptimal.  There is only one existing
caller of disconnect_helper() and it passes transport->data (and the
"data" is of type helper_data).  As it is a file-scope static
function, why not just change the type of the parameter from the
whole transport to just helper_data, without introducing the new
function to hold the bulk of the original code?

> +static int release_helper(struct transport *transport);
> +
>  static struct child_process *get_helper(struct transport *transport)
>  {
>  	struct helper_data *data = transport->data;
> @@ -155,8 +161,10 @@ static struct child_process *get_helper(struct transport *transport)
>  	while (1) {
>  		const char *capname, *arg;
>  		int mandatory = 0;
> -		if (recvline(data, &buf))
> +		if (recvline(data, &buf)){
> +			release_helper(transport);
>  			exit(128);
> +		}

This, together with other exit(128) we see in this patch now have
release_helepr() in front of it, which is in line with what the log
message claims that the patch does.

I however wonder if we want to do a bit more, perhaps with atexit().
I am not hinting-suggesting to do so (as you said, if the init
process ought to take care of the zombies, the patch under review
might already be unneeded, and atexit() makes things even worse),
but having trouble to convince that this patch stops at the right
place.

Thanks.
