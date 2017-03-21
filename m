Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860A12095B
	for <e@80x24.org>; Tue, 21 Mar 2017 15:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757637AbdCUPwJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 11:52:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50513 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757145AbdCUPvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 11:51:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3DACF88BD4;
        Tue, 21 Mar 2017 11:51:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O3C8Ko4gt1HA44EZ2wsGwcgFjV0=; b=VTvdVu
        fPjARgRxz+Va4NdgUi3R4mqXVnpiGLE7M7fmJxDAU6GRBHjIYvRfEryxbD74PUre
        +S52SYEcQgaj72WjoLFfTl83MDDd1BPX+VhKhq1TABEterXNzgXkiu5XY/pP+O/Q
        oWwceY03JQSM2wj7Y2bMWifpcetQh3y7p1xFY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lRmTZ+8bs7/s4tCb92EzProeCrDLbfNI
        SdeoHU6n7Ye6qMWPEs/TXyZgdTrN/teGtxLya19jt+iVLFLxaBeFW9bDlBsTk9yh
        +ik77Sgh91mIgireg3Vn6xV3n0CA69SoGJS2kYB72XK/ZiXLXK1CYFe2thuvNVGW
        AiAsA1ei7FA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 363AB88BD3;
        Tue, 21 Mar 2017 11:51:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C16188BD2;
        Tue, 21 Mar 2017 11:51:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com
Subject: Re: [PATCH v3 0/2] bringing attributes to pathspecs
References: <20170310185908.171589-1-bmwill@google.com>
        <20170313182322.27539-1-bmwill@google.com>
        <CACsJy8BRTuH=xv_xvQPOkVaRcMXKnjgT77SXkwLkZ6aAvcTyHg@mail.gmail.com>
Date:   Tue, 21 Mar 2017 08:51:47 -0700
In-Reply-To: <CACsJy8BRTuH=xv_xvQPOkVaRcMXKnjgT77SXkwLkZ6aAvcTyHg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 21 Mar 2017 17:51:29 +0700")
Message-ID: <xmqqr31qsk4s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AFE856E-0E4E-11E7-9FBC-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> The series updated match_pathspec(), but that's only one of two
> pathspec filtering functions. The other is tree_entry_interesting()
> (e.g. for "git grep <tree>"). Do you have plans to support :(attr)
> there too? "No" is a perfectly fine answer (and it will end up in my
> forever growing backlog).
>
> The thing about tree_entry_interesting() is, we would want to stop
> traversing subtrees as soon as possible. Naively implemented, we would
> need to traverse all subtrees so we can call match_attrs(). That's not
> great. Oii I'm rambling.. I don't know yet how to implement this thing
> efficiently.

Thanks for great insights.  

It indeed will become issue when an overly broad pathspec pattern is
combined with an attribute requirement, e.g. ".:(attr=X)", and we
may have to devise a way to tell that there won't be any paths with
that satisfy the attribute requirement before descending into a tree
as an optimization.
