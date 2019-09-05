Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B03371F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbfIEWTz (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:19:55 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62144 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389656AbfIEWTz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:19:55 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C410865E0;
        Thu,  5 Sep 2019 18:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yEOtDdEIMZWfc0rZZps57l+XyPc=; b=Lny819
        ocXeuefq6EK7YJbowBwiTLO7c8j5dpmktu4srwLFR0n1z+aJcZrRYyADP7R6PWV6
        aSWQmtYaqFijJm8DyVoHmLRzCZoDkEUQZJcB78mOtRLgDA0yYQ+cPOCuDOcwhD/r
        6fCQsjy1tAs1myFcLB/n9YHxKExFeuufgtDjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RDpv0kdFpAP2SPMV/vCLElRnsJKcMRVF
        iPFga93RdnuGxj+0j2UQPpyaZkY8PPCvi8InCC+JLTbMVYBSfU0rWB1cpQg159th
        J3e4SG9JuBSza5MQPWls6qGRv/2fXZxzxPb/asJJufvVpVp565OIbjM13D0HQtEd
        B8408IsW/o4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93E44865DF;
        Thu,  5 Sep 2019 18:19:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C23A2865DD;
        Thu,  5 Sep 2019 18:19:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
References: <cover.1567563244.git.me@ttaylorr.com>
        <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
        <20190904030456.GA28836@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 15:19:48 -0700
In-Reply-To: <20190904030456.GA28836@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 3 Sep 2019 23:04:56 -0400")
Message-ID: <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 473189A8-D02B-11E9-ABC9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I don't think parse_commit_no_graph() returning 0 assures us that
> get_commit_tree() and friends will return non-NULL.
>
> This is similar to the case discussed recently where a failed parse of a
> tag may leave "tag->tagged == NULL" even though "tag->obj.parsed" is
> set.
>
> Here an earlier parsing error could cause (*list)->object.parsed to be
> true, but with (*list)->maybe_tree still NULL. Our call to
> parse_commit_no_graph() here would silently return "yep, already tried
> to parse this", and then we'd still segfault.
> ...
> And I think there's literally no way for this function to tell the
> difference between "no parent" and "there was an earlier error, but we
> set the parsed flag anyway and the parent flag is invalid".
>
> I think that argues against Junio's response in:

Fair enough.  Forcing later users to reattempt parsing (and failing
the same way) would be safer and it should also be sufficient as we
are talking about how to handle a broken repository, i.e. an error
case.
