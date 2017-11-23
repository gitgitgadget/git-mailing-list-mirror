Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B894520954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752340AbdKWCrF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:47:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64635 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752324AbdKWCrE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:47:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0034DA076A;
        Wed, 22 Nov 2017 21:47:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f9Dh1radVwrg+6Kha2D0bxBTcY4=; b=ff8IgJ
        6DHi4Mw0lCam56NPMt7kZtKqSbAySOTXfYaJTC36gpRSGowi62uTn6VULW45Ucj8
        Am4TXv20GLqVKCRaHEIDJ+Vu6RDkSSZa0Uz3ExmLht98T+EotAeHiVRsErg9K7WO
        BS/nF1dmHiFQQN/P1GFkoby/Mdv8GmZo/l8/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QvBJmr+f7K1IpV8dVgJaVhjqLx+/6BDh
        dQXr9vKV1PHubjDp1rsDDRb+WBVMXpscyrSDUBMXu0v2oU8fx2RAbJoj42JSKY+Y
        ePrDRelIjzaSCNmfGkpZi4PDnjB64TgS2OCQfjmTvi0PFClOFbUc7C5IzwkL4lIt
        tjJyGeCK9nc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C3EC8A0769;
        Wed, 22 Nov 2017 21:47:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43883A0768;
        Wed, 22 Nov 2017 21:47:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] xdiff/xpatience: support anchoring line(s)
References: <20171121221717.155301-1-jonathantanmy@google.com>
        <20171122234152.72901-1-jonathantanmy@google.com>
        <xmqqa7zdsqb6.fsf@gitster.mtv.corp.google.com>
        <xmqq3755sprp.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 23 Nov 2017 11:47:02 +0900
In-Reply-To: <xmqq3755sprp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 23 Nov 2017 11:16:42 +0900")
Message-ID: <xmqqh8tlr9sp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95F72802-CFF8-11E7-BA22-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> What do we do when
>
>     git diff --histogram --patience
>
> is given?  Do we warn?  If we don't, perhaps it may not be too bad
> if 
>
>     git diff --histogram --patience-anchor=foo
>     git diff --patience-anchor=foo --histogram
>
> did not get any warning.  Instead we just implicitly turn any
> occurence of --patience-anchor=foo into --patience followed by the
> same option, and assume that the user wanted the usual "last one
> wins" semantics.  It would turn patience on for the former, and
> ignore the anchor for the latter and use historgram.

Thinking about this a bit more, I do like the basic idea of the UI
even better.  What we could do is to sell this to the end users as a
new kind of diff algorithm choice (i.e. myers, patience, ... will
gain a new friend) that internally happens to be implemented by
piggybacking on patience (just like minimal is piggybacking on
myers) and call it "anchor".  Then just like this command line

    git diff --histogram --patience

makes the last one win without complaint, it is sane that these
command lines

    git diff --histogram --anchored=<pattern>
    git diff --anchored=<pattern> --histogram

make the last one win without complaint, either.

Hmm?

