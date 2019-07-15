Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C55D1F461
	for <e@80x24.org>; Mon, 15 Jul 2019 17:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfGOR5W (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jul 2019 13:57:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51219 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731078AbfGOR5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jul 2019 13:57:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0090215D5F6;
        Mon, 15 Jul 2019 13:57:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqKBe4HDijv/OATv0J4dY3lfJbM=; b=x1LUGc
        ECeZr9jFm12u/MhY8W0e2A3WoSDpo/cMrbHBDL33+ptzv28AHLb97+wWFbzDsrfA
        fO4j5heY16JW/W0lyDMJHYERuVi4e8TWbWXO+za8NlLBz6rev6uMKJAPUCgcNhYk
        GGTOwSagfkBzEhHfa5uS+8QrhWOZLOaK8O+/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aiK2Cm5KkIrS2rC30Tc4wCyVDdz5sqx/
        AFACzM6nPlPMvTry49a18XB1F5wdpbZNwBGXruzEVRAkH9gMre5RbKCVhN6RoHV3
        P450K5tfrNsRVpo2EW+DBHG+LEkOVXt4F6RrTk9DELV6Td/UyzlNxqXOCvFZOk4J
        jrN1/h6J4k8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC4E115D5F4;
        Mon, 15 Jul 2019 13:57:19 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 48A8815D5F3;
        Mon, 15 Jul 2019 13:57:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com,
        martin.agren@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [GSoC][PATCH 1/1] rebase -i: add --ignore-whitespace flag
References: <20190712185015.20585-1-rohit.ashiwal265@gmail.com>
        <20190712185015.20585-2-rohit.ashiwal265@gmail.com>
Date:   Mon, 15 Jul 2019 10:57:18 -0700
In-Reply-To: <20190712185015.20585-2-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sat, 13 Jul 2019 00:20:15 +0530")
Message-ID: <xmqqlfwz41vl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD16D208-A729-11E9-BF91-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> +	if (opts->ignore_whitespace) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		if (opts->strategy_opts)
> +			strbuf_addstr(&buf, opts->strategy_opts);
> +
> +		strbuf_addstr(&buf, " --ignore-space-change");
> +		free(opts->strategy_opts);

Is this call to free() safe?

> +		opts->strategy_opts = strbuf_detach(&buf, NULL);
> +	}
> +
> @@ -1821,6 +1836,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (options.rebase_merges) {
> +		if (options.ignore_whitespace)
> +			die(_("cannot combine '--rebase-merges' with "
> +			      "'--ignore-whitespace'"));

Hmph, this is unfortunate.  The patch is not making things worse, though.




