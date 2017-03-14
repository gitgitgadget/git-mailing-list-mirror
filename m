Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 055E420373
	for <e@80x24.org>; Tue, 14 Mar 2017 19:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbdCNT2R (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 15:28:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57405 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750861AbdCNT2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 15:28:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A45BA706AF;
        Tue, 14 Mar 2017 15:28:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2Mwpwse4Wx2D2OMij2qjiJ3lWfw=; b=IYW5xX
        Z6Kf3a6Nz05y6V8mVGjcg3kQNyVXJZ+z684KzpCLr6rk59AjXeDZrrbkSWWcDxvc
        zFZiKxlicRJY6LQtB/2wtq9MHFq7jdaMCePFuLfPwq4Tz3pUO1eXAqT42OfJpGMn
        zcblA7v9ym8cv85rNQMuZQt7qiRt7+Z5LSqww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rbEBqGmG63SSvyflLemuswQovPSJbGja
        QC2d7pV3dZGZIHQOYg7A/p+vFPwjK+FPf+QxB0W87K6ZNXB96IvukX8jwxS+bsVV
        bJKcQpOtoL1NWPiDk9T87nOsHK1xVlsL2DMtwuEIGL3f+8Qv50it6HLS6jgro9K0
        jbVRzEWyluU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CD3E706AE;
        Tue, 14 Mar 2017 15:28:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0769706AD;
        Tue, 14 Mar 2017 15:28:13 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 06/10] submodule update: add `--init-active` switch
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-7-bmwill@google.com>
Date:   Tue, 14 Mar 2017 12:28:12 -0700
In-Reply-To: <20170313214341.172676-7-bmwill@google.com> (Brandon Williams's
        message of "Mon, 13 Mar 2017 14:43:37 -0700")
Message-ID: <xmqqr31ziroz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DEEAC06-08EC-11E7-B1BE-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +static void module_list_active(struct module_list *list)
> +{
> +	int i;
> +
> +	if (read_cache() < 0)
> +		die(_("index file corrupt"));
> +
> +	gitmodules_config();
> +
> +	for (i = 0; i < active_nr; i++) {
> +		const struct cache_entry *ce = active_cache[i];
> +
> +		if (!S_ISGITLINK(ce->ce_mode) ||
> +		    !is_submodule_initialized(ce->name))
> +			continue;

This, because "is_submodule_initialized()" is not "is it
initialized?" but "is it interesting?", will catch a submodule
that used to be uninteresting but has become interesting (e.g. a new
submodule added to somewhere in "lib/" when submodule.active lists
"lib/" as one of the pathspecs to match interesting submodules) and
automatically updates it.

I anticipate that a corresponding "please deinitialize ones that are
no longer interesting" coming in the series ;-)  Without it, the
interested set will only grow without shrinking.

> +		ALLOC_GROW(list->entries, list->nr + 1, list->alloc);
> +		list->entries[list->nr++] = ce;
> +		while (i + 1 < active_nr &&
> +		       !strcmp(ce->name, active_cache[i + 1]->name))
> +			/*
> +			 * Skip entries with the same name in different stages
> +			 * to make sure an entry is returned only once.
> +			 */
> +			i++;
> +	}
> +}
