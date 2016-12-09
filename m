Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C29AB1FBB0
	for <e@80x24.org>; Fri,  9 Dec 2016 00:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbcLIA3A (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 19:29:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51810 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751611AbcLIA27 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 19:28:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D049955082;
        Thu,  8 Dec 2016 19:28:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MjpY7LL5tY+Z5NIn/30tmWRRQe4=; b=mooiLn
        nC6Usy88d+EDj4MOUV8qcmIH4fBj6OqUI1nIpS48vwvgmU23KWR1S7IQrw6pNekw
        gkfKbCS8TZoKOBoomOTEvCcVs2nkeLy7hbl8qZZsDS+OeuPnhSTX/3rA8iCymQ8S
        yRFJcX5zTvZZxLduHT1Xx8ZvgkhIUSjyVEgEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=W34PpCrP23lkMEERPn5nEZKPxRNTLiuJ
        JqGWsFcF166UVlvJMpntuj3w96mI4z/XBaUlSSa0C6aXafUVSO2O5xe0G4NpwVPz
        KRJWmqSBOAuoSMJwspy0iL80zHSytcZVUyi42SGTFxxd9OppNt8/jkv1f6TyiInh
        Wzndw1PPU6I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C8F6555081;
        Thu,  8 Dec 2016 19:28:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44EED55080;
        Thu,  8 Dec 2016 19:28:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 14/16] pathspec: create strip submodule slash helpers
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
        <1481223550-65277-1-git-send-email-bmwill@google.com>
        <1481223550-65277-15-git-send-email-bmwill@google.com>
Date:   Thu, 08 Dec 2016 16:28:56 -0800
In-Reply-To: <1481223550-65277-15-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Thu, 8 Dec 2016 10:59:08 -0800")
Message-ID: <xmqqfulyrlmf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 798E3314-BDA6-11E6-BE59-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +static void strip_submodule_slash_cheap(struct pathspec_item *item)
> +{
> +	int i;
> +
> +	if ((item->len >= 1 && item->match[item->len - 1] == '/') &&
> +	    (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
> +	    S_ISGITLINK(active_cache[i]->ce_mode)) {
> +		item->len--;
> +		item->match[item->len] = '\0';
> +	}
> +}

I know that this is merely a moved code, but while I was reading
this, it triggered "Do not make an assignment inside if condition"
check.  But more importantly, is the code even correct?  If the path
for the submodule is unmerged, we would get a negative i that points
at the conflicting entry; don't we want to do something about it, at
least when we have a submodule entry at stage #2 (i.e. ours)?
