Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B111F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 22:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbcJKW6V (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 18:58:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50305 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754263AbcJKW6T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 18:58:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 539A143AFA;
        Tue, 11 Oct 2016 18:58:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xc/fMaOVltJhov+CwLAO/2I7hBE=; b=mXk1uj
        Uk030eN5qyfeO9rxs2sPSMVd5wPE5PWxcOY/64t5Z5jmF1VCefzm7gneEKepqlPR
        fzwAZ4BkaiXzCwbiVeAWQUqNLj1ArmaE+2VcswTZDabQbgMCLFBxFhkfUu0a51L4
        46qzvsnva89tVhnLuhPR0mj+93A0F5YhL3xL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uaVhsTicI7LTBU5a4yCcz8Cz8rwXCCUy
        8PytPzUNkbZTPTqES5xYZQGrB9hNP/y8E/j0VuxkWfkbQ3vcCfA6gtdoKhoo47bp
        RHahSSAl3eBo0BraHGeRKC22rQF3htu6hCJBsTabWOVb6t7GncjYAcfSO45xbSVt
        vcVNye2Uo2M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C17A43AF8;
        Tue, 11 Oct 2016 18:58:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C3BF243AF7;
        Tue, 11 Oct 2016 18:58:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ram Rachum <ram@rachum.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Make `git fetch --all` parallel?
References: <CANXboVZvfPkTQ10PWop+LgPFpc2bD3-u-e5ix0itGawiwCxOuQ@mail.gmail.com>
        <CAGZ79kZmrYZqi4+bSkRykn+Upt7bEyZ0N8VhiQ-h8DhSMym-FA@mail.gmail.com>
        <xmqqa8ea7bsh.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
Date:   Tue, 11 Oct 2016 15:58:15 -0700
In-Reply-To: <CAGZ79kZNvTvk4uZa8xhxZABKtzS9A5HoumJ37AacuZnHaZ4+Xw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 11 Oct 2016 15:50:36 -0700")
Message-ID: <xmqq60oy7at4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32D12D78-9006-11E6-858C-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Why did you put a "sleep 2" below?

The assumption was to fetch from faster and near the center of the
project universe early, so by giving them head-start, fetches that
start in later rounds may have chance to see newly updated remote
tracking refs when telling the poorer other ends what we have.

> At the very least we would need a similar thing as Jeff recently sent for the
> push case with objects quarantined and then made available in one go?

There is no race; ref updates are done only after objects are fully
finalized.  You can do the quarantine but that would defeat the "let
ones from the center of universe finish early so later ones from
poor periphery have more .have's to work with" idea, I suspect.

