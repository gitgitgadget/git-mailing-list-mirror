Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 944E220899
	for <e@80x24.org>; Wed, 23 Aug 2017 20:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbdHWUMb (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 16:12:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62369 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932443AbdHWUMb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 16:12:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 714F59E5FD;
        Wed, 23 Aug 2017 16:12:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vE9ogOd6BVJ+SpOroeTpXLePaY4=; b=jNBZPS
        WuCJ507cbxNJKrPpmCSj0SIQaimBI42DVS4Wtj47DEr7zvQdlCV/DGL+IGzLE7w0
        i/3ybxbvIibvdah948RMtRWzMnAXIGOCquSbbCR5dAvR+35w6AyibQScXASliz2l
        DR4AXW5+YO+tHx4crveTxZxHTNB6uUYI5ICl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rjQgcrbzMkvlQIhZfU8466MfkjtXznR+
        ji38+IUlBTaAqEkp7RiYj8Wz19xWlkDkI0M8j3T+wbypE7TCUQ5SeJma3FI81Hwl
        N8KYQYm6eXEExj+oATP4UBbnexe7h9zh9tJWYsRjj/7PQ4zLnfUvmRc8flWysLkg
        qgRL+6aLK+k=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6904A9E5FC;
        Wed, 23 Aug 2017 16:12:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C42A39E5FB;
        Wed, 23 Aug 2017 16:12:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>, <peff@peff.net>
Subject: Re: [PATCH v3 1/4] imap-send: return with error if curl failed
References: <087f5907-6558-ce32-2f5c-2e418522c030@morey-chaisemartin.com>
        <da29995c-3c56-ac43-9f8f-12bf381711f3@morey-chaisemartin.com>
Date:   Wed, 23 Aug 2017 13:12:28 -0700
In-Reply-To: <da29995c-3c56-ac43-9f8f-12bf381711f3@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Tue, 22 Aug 2017 17:56:16
        +0200")
Message-ID: <xmqqy3qaxcur.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63E245E6-883F-11E7-8892-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

> curl_append_msgs_to_imap always returned 0, whether curl failed or not.
> Return a proper status so git imap-send will exit with an error code
> if womething wrong happened.
>
> Signed-off-by: Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
> ---
>  imap-send.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/imap-send.c b/imap-send.c
> index b2d0b849b..09f29ea95 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -1490,7 +1490,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
>  	curl_easy_cleanup(curl);
>  	curl_global_cleanup();
>  
> -	return 0;
> +	return res == CURLE_OK;
>  }
>  #endif

Wait a bit.  Did you mean "res != CURLE_OK"?  If we got an OK, we
want to return 0 as success, because the value we return from here
is returned by cmd_main() as-is to main() and to the outside world,
no?


