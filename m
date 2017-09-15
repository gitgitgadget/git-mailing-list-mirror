Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2537320A21
	for <e@80x24.org>; Fri, 15 Sep 2017 04:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdIOEu2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 00:50:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64013 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbdIOEu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 00:50:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0469B46DC;
        Fri, 15 Sep 2017 00:50:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rUPFXIf0cylzy1UiENKi6yCCY10=; b=tUfFVz
        OnA+2HSnBtnyegnuOLj3dN8zZmOFQFVfom8b734dBvRv5qRtQmup9XX4VvtSsIcG
        Y3HfiOEQp/rm+k0UBUDkr52L8TVWQxz7vUislQowpP+I5uf9WmIukbxYbI/XtJOk
        KXhgVd2PQrq4PG+aPs+YNn/vKMeHh8XFu09RY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sVjHlE9oYXNN70fLNLqBRHln5RsfVkzp
        YfUub8NEHp87siZTUc2VdI+UhzClZ40z0MSVrqjKzGsr1OWaEL7YKIpaHRfavvfN
        0b/KUGxTttHnI3vaWcuso/qt3jL5pNggGi9yMQRE5dFz2Tr4eCgaAE69GstnS1XG
        dr+UfLR7hlU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A86F5B46DB;
        Fri, 15 Sep 2017 00:50:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17059B46DA;
        Fri, 15 Sep 2017 00:50:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] imap_send: setup_curl: retreive credentials if not set in config file
References: <828c6333-0ba0-2a01-324e-f910a8042ca1@morey-chaisemartin.com>
        <accffa40-3559-5f65-3149-aaa86a2278fc@morey-chaisemartin.com>
Date:   Fri, 15 Sep 2017 13:50:25 +0900
In-Reply-To: <accffa40-3559-5f65-3149-aaa86a2278fc@morey-chaisemartin.com>
        (Nicolas Morey-Chaisemartin's message of "Thu, 14 Sep 2017 09:52:06
        +0200")
Message-ID: <xmqqshfoy38u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 647B0404-99D1-11E7-B6A8-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com> writes:

>  
> +	if (cred.username)
> +		if (res == CURLE_OK)
> +			credential_approve(&cred);
> +#if LIBCURL_VERSION_NUM >= 0x070d01
> +		else if (res == CURLE_LOGIN_DENIED)
> +#else
> +		else
> +#endif
> +			credential_reject(&cred);
> +
> +	credential_clear(&cred);
> +

As my copy of GCC seemed to be worried about readers getting
confused by the if/else cascade, I'd place an extra pair of braces
around this, i.e.

	if (cred.username) {
		if (res == CURLE_OK)
			credential_approve(&cred);
		else /* or "else if DENIED" */
			credential_reject(&cred);
	}
	credential_clear(&cred);

while queuing this patch.

