Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F9A1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 20:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754387AbeAKUbs (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 15:31:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56216 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754365AbeAKUbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 15:31:48 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 83666C42B2;
        Thu, 11 Jan 2018 15:31:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BZDojOyOv9XLeUcdgb9X9aE3onE=; b=s+wnWP
        G8jkZiG/Mxp89ELMZOvKa8RfcVJWun674iMH/C68agDY+S02be8cRsGuF0MPpPX+
        07rraaSJbt9MfKubmyKTuGIrZP2jkg9dwDJyR9R6KZB308Yug+tfuLkROPz5M4za
        gjvAeuh2mq0EEtB2eTJ3SC4D1RGViym4kFKRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BV5aXKKQEvLR70YFql0nFeGhROKrmrJe
        fggjb6Ut5xRRVZrRrdh8YziRKTaE1SjUfh6Sx7XRckQ7rsTgf/uIPz/QMFF1xiM8
        9bc04XEtPWoqt02VKJ4RrbUfhapqDUVssKOH2WVwSI9MQc48lDIHNUbqrqZa1JYA
        AhYVvTP4oJo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A89FC42B1;
        Thu, 11 Jan 2018 15:31:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7354C42B0;
        Thu, 11 Jan 2018 15:31:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com, sbeller@google.com
Subject: Re: [PATCH v2 1/2] submodule: port submodule subcommand 'sync' from shell to C
References: <20180109175703.4793-1-pc44800@gmail.com>
        <20180111201721.25930-1-pc44800@gmail.com>
        <20180111201721.25930-2-pc44800@gmail.com>
Date:   Thu, 11 Jan 2018 12:31:45 -0800
In-Reply-To: <20180111201721.25930-2-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Fri, 12 Jan 2018 01:47:20 +0530")
Message-ID: <xmqqshbcxhla.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71D709DC-F70E-11E7-8CE6-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> +		} else {
> +			sub_origin_url = xstrdup(sub->url);
> +			super_config_url = xstrdup(sub->url);
> +		}
> +	} else {
> +		sub_origin_url = "";
> +		super_config_url = "";
> +	}
> + ...
> +cleanup:
> +	if (strlen(super_config_url))
> +		free(super_config_url);
> +	if (strlen(sub_origin_url))
> +		free(sub_origin_url);

The above is ugly and veriy likely to be wrong; imagine that
sub->url was an empty string to begin with.

Doing xstrdup("") before assigning the constant to *_url would be a
lot more sensible and maintainable solution for things like this.
