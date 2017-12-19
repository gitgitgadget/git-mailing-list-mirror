Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ACAC1F406
	for <e@80x24.org>; Tue, 19 Dec 2017 16:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdLSQHI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 11:07:08 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58019 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751352AbdLSQHE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 11:07:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8491D0C69;
        Tue, 19 Dec 2017 11:07:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KB7CmC+QQu/WUMcb4N0lpFgrlyE=; b=BFCdFH
        +Q6hPcov2G1Ip3bSmtzShvl1PDfU2rJ2v/hUKHbtv0tFS5k+PWEedHvo1pKntcvc
        rCyH5A2RmGcPlIFvFZjJJ38Q6PUTTAKbo9Zckqxebt82JiGe5P8eU/DDUvxsY3VI
        /5ir+zLQ/WwAA6lfG/PCkAfinxhknvc7KlUMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mFMuJGehKABTpZSDUoyW0z95ijJrugPU
        mRolLKZPnT1Eu74bHqEbX57uScGycaqH3/1Cdtd3u2Z0Nu3x+I8RYgY14CbqcxEB
        0OHXMtAu0NqW3UVwhsJKM/TVDqLD8hsjmCs4TbQHLtp9qQzBqkebK1e+rNvZYBOM
        mdtTdCHmd3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0472D0C68;
        Tue, 19 Dec 2017 11:07:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 62879D0C65;
        Tue, 19 Dec 2017 11:07:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Carlsson\, Magnus" <Magnus.Carlsson@arris.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fetching commit instead of ref
References: <1513600223353.28799@arris.com>
        <xmqqh8snyiz0.fsf@gitster.mtv.corp.google.com>
        <1513672915856.50628@arris.com>
Date:   Tue, 19 Dec 2017 08:07:02 -0800
In-Reply-To: <1513672915856.50628@arris.com> (Magnus Carlsson's message of
        "Tue, 19 Dec 2017 08:41:56 +0000")
Message-ID: <xmqqtvwmwvkp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A7029A44-E4D6-11E7-8E39-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlsson, Magnus" <Magnus.Carlsson@arris.com> writes:

> I understand that you don't want to allow people fetching single
> commits all the time, but is there a reason that you don't allow
> SHA instead of references when you fetch an entire tree?

I do not think we don't want to allow "single commit" fetch.  We do
not allow fetching histories from an arbitrary point in the graph,
unless we can prove that what gets fetched is what the serving end
intended to expose to the fetcher---you should view it as a security
issue.

The default way to determine that a fetch request is getting only
the things the serving end wanted to publish is to see the requested
tips of the histories to be fetched are all pointed by refs.  Which
means that a client of a hosting site can rewind and repoint a ref
after pushing a wrong branch that contained undesirable matter by
accident.  Moving the ref to make the undesirable object unreachable
is all that is needed to "hide" it from the public view, even when
the client does not have a way to trigger "gc" immediately on the
hosting site.

There are variants of this security measure.  If the hosting site is
willing to spend extra cycles, we could loosen the "is the request
fetching only what is published?" check to see if the requested tips
are reachable from the tips of refs, instead of exactly at refs.  It
preserves "a mistake can be hidden with a forced push" property the
same way as above, but it is costly and is prone to abuse.

If you are confident about your pushes all the time, you can take
a stance "anything in the repository is meant to be read".  That is
what the "allowAnySHA1InWant" does.  Not everybody however wants to
do this for obvious reasons, so it is not a default.


