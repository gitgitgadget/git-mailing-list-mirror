Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08FB0201C2
	for <e@80x24.org>; Tue, 14 Mar 2017 20:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbdCNUZN (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 16:25:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58739 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752831AbdCNUZM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 16:25:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9346D6BE8D;
        Tue, 14 Mar 2017 16:25:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fgECNaRY5p3auHESyPLWnwya7I8=; b=jNPiAY
        CE1Z2JmdrBwLgBHVTWzQhF83NAfDEPzbBnCuDFEh6/DQYlNXBq2yrAnV/qxF9pGS
        cRDMBxiPRtnW9qIwHLPudJOEegZAonlWQKEnuIsbB17vRMm260HJjkWn7EGXyvy0
        KYaPp8h14S3bohOzwElw6gUmONhnqXSApDTLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lTprvbgHOhVuoU9up9v2Tw8zaa4JV0ME
        TXPYc8Jyr0kD+AllmRuVnb2/uga2Up+aYK7VPQ5By/kXPVUYZsRX/3FaRT41VeqS
        bE9izTKALsToCdr3gYYd4I++4xUMXzyS64I35CZrG3yhLSpoZN4thU+aAH8Bt80Z
        F6HHsIfytKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85C266BE8B;
        Tue, 14 Mar 2017 16:25:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E5C676BE8A;
        Tue, 14 Mar 2017 16:25:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] submodule--helper clone: check for configured submodules using helper
References: <20170309012345.180702-1-bmwill@google.com>
        <20170313214341.172676-1-bmwill@google.com>
        <20170313214341.172676-5-bmwill@google.com>
        <xmqq4lyvka1i.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ20Jy_A8SPJte7U0iZZB97P0Sn_PqAMfwp40sAj6Y=RA@mail.gmail.com>
Date:   Tue, 14 Mar 2017 13:25:08 -0700
In-Reply-To: <CAGZ79kZ20Jy_A8SPJte7U0iZZB97P0Sn_PqAMfwp40sAj6Y=RA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Mar 2017 11:40:15 -0700")
Message-ID: <xmqq60jbip23.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 520A2FD4-08F4-11E7-92D4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I am wondering what was meant by the comment "We must not fall back to..."
>> that is being removed---is that because sub->url can come from .gitmodules
>> that is in-tree, not from .git/config?
>
> Yes. We want to check for the submodule being "initialized", i.e.
> having a url in .git/config. (and the struct submodule reads in both .git/config
> and .gitmodules and overlays them with a given precedence order)

OK, thanks.

I agree that the current code happens to be OK but the arrangement
looks rather brittle to me.  It seems the code liberally call
gitmodules_config() without making sure it is early enough to do so
(iow, git_config() for submodule-related stuff has not been done and
will be done before the values read there are the ones that are
used).

