Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36201FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932645AbcLGVIe (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 16:08:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51238 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753450AbcLGVIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 16:08:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3244756646;
        Wed,  7 Dec 2016 16:08:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=c86nnnfe3UrweoOdsMGSMacBtgY=; b=v6sPnM
        AVHCw4YWPIDYAwllZZOqOai2v+knVHU2UjFYU2wkMkiLLUOhFPxPT+fzA3vwbut2
        Bq34sGQZj9+S4X6S4nZEqkDgy6i3xT3geMII0TIFngAgjXJsch8ccP2RQEOGzw/D
        2PktF0GntAfPJ9y3my36zU6D1qSlOZIC6h6/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=APtsQ7XDmiDTnbWVGkSQo6ZGbv80yXsS
        PPcBOiZjAyrs8ahTI9OHq1cE/DYQQEBviR4hinPs2ocaritjtTuirgX6kFGUBKZz
        5gymIoL4fJ+h2KexBBWxKrXq6Ys41ePQrEFeyYvBLF5BVlXAcmgBCTyfsHpyC8Tj
        FOMqS1lICwc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27FF556645;
        Wed,  7 Dec 2016 16:08:17 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F6F456643;
        Wed,  7 Dec 2016 16:08:16 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 1/3] wt-status: implement opportunisitc index update correctly
References: <xmqqd1h3y506.fsf@gitster.mtv.corp.google.com>
        <20161207194105.25780-1-gitster@pobox.com>
        <20161207194105.25780-2-gitster@pobox.com>
        <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
Date:   Wed, 07 Dec 2016 13:08:15 -0800
In-Reply-To: <CAGZ79kZHGqU2y19_uKhtVuE6vhspzPNpw-nVDnm8gLQ8u528kQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 7 Dec 2016 12:48:34 -0800")
Message-ID: <xmqqmvg7wips.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45BC1C58-BCC1-11E6-B55E-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So my first question I had to answer was if we do the right thing here,
> i.e. if we could just fail instead. But we want to continue and just
> not write back the index, which is fine.
>
> So we do not have to guard refresh_cache, but just call
> update_index_if_able conditionally.

An explanation with stepping back a little bit may help.

You may be asked to visit a repository of a friend, to which you do
not have write access to but you can still read.  You may want to do
"diff", "status" or "describe" there.

In order to avoid getting fooled into thinking some paths are dirty
only because the cached stat information does not match, these need
to refresh the in-core index before doing their "comparison" to
report which paths are different (in "diff"), what are the modified
but not staged paths (in "status"), and if there is a need to add
the "-dirty" suffix (in "describe").

Since we are doing the expensive "bunch of lstat()" anyway, if we
could write it back to the index, it would help future operations in
the same repository--that is the reasoning behind the opportunistic
updates.  It is perfectly OK if we do not have write access to the
repository and cannot write update the index.

