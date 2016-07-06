Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97E5A2070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbcGFPaJ (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:30:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753840AbcGFPaI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 11:30:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 138842991E;
	Wed,  6 Jul 2016 11:30:07 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bn3EbawL0oJGv9ZJMdeBqWpP8V0=; b=g/QiSz
	4jXE1BoLBMFtZbliuZeaO/YXbrwmJ77m2+keRUOd8giVsanTXDHfO0FLOs6NfiWb
	s2/MMh1rGq6rWgy8TAZgSIBvtrY9Jmm/FxYyuePRJF8vUw4cwldFIZL8Qtoe25GS
	Ze4w67QJSUtbW7FfPQZ+VpfB3MHzqXbpFyEiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JrfKhoVb+RvlyjFp6SwldWWokurrYasz
	E7mPIMnSN7HK3RhxvfgZ9r5KefB8aiRMHgsKTpuIXLmtgN/qHFUPPtWjAQ4K0npm
	GdQ8ysckraSi8gqhZU1vq4GR/oEOI1/chC4liUOlZY5VpZiYl7gKuzEcAo1VPn6q
	CuCYY/CC63o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B7452991C;
	Wed,  6 Jul 2016 11:30:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 822B32991B;
	Wed,  6 Jul 2016 11:30:06 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/9] merge-recursive: clarify code in was_tracked()
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<dd3e2cf842fd5e11e31914aa55b8b995e8d3d75c.1467199553.git.johannes.schindelin@gmx.de>
	<xmqq4m8b4zdd.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607011057180.12947@virtualbox>
	<xmqq7fd51ijr.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607020906560.12947@virtualbox>
Date:	Wed, 06 Jul 2016 08:30:04 -0700
In-Reply-To: <alpine.DEB.2.20.1607020906560.12947@virtualbox> (Johannes
	Schindelin's message of "Sat, 2 Jul 2016 09:20:24 +0200 (CEST)")
Message-ID: <xmqqr3b6u6mb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 844D3242-438E-11E6-9C71-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> To understand why we're not done yet, the crucial point is *not* that the
> return value encodes the insert position. The crucial point is that
> despite asking for an index entry matching a specific name, we might not
> find one, *even if there is one*.

I've been wondering why you keep saying "even though we didn't ask,
we look for stage#0", and now I see why.  The cache_pos() interface
*is* about finding the stage#0 entry for the given path.

When it finds none, it indicates where a stage#0 entry of that path
would be inserted, which by the sort-order would give us where
higher stage entries for the path would be found (if there is any).
There is no parameter for you to tell it to find stage#2, and "even
though we didn't ask" is showing (and being the source of) the
confusion.

And I did not want a misleading comment to spread the confusion;
that is why I was reacting strongly.

As you pointed out, we can return early without falling into the
generic "we are still looking at the same path" codepath when we
find thestage#0 entry, so I wouldn't mind doing something like the
following.

static int was_tracked(const char *path)
{
	int pos = cache_name_pos(path, strlen(path));

        if (0 <= pos)
	        /* we have been tracking this path */
        	return 1;

	/*
         * Look for an unmerged entry for the path,
         * specifically stage #2, which would indicate
         * that "our" side before the merge started
         * had the path tracked (and resulted in a conflict).
         */
	for (pos = -1 - pos;
             pos < active_nr && !strcmp(path, active_cache[pos]->name);
	     pos++)
		if (ce_stage(active_cache[pos]) == 2)
			return 1;
	return 0;
}
