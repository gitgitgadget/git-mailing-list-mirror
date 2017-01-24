Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3C3220A17
	for <e@80x24.org>; Tue, 24 Jan 2017 02:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdAXC2p (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 21:28:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751815AbdAXC2o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 21:28:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 53BD5632F5;
        Mon, 23 Jan 2017 21:28:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GqTsmbcKTo3NdtWAbQYcDVEekD8=; b=rJ5mK1
        F13d+HS/U7R6n8h0O2wQ1bg/kEsfMbWCvV6rXPoinNVetJmM01qvNxaF7MTGabkB
        ZRXCTXpzRvRprZOtSh1n78lhuHxUEZvFKi6w+k6yrC7M8ayp6dDq4mscfVZEpoz1
        QoujG2f5MrFr/FwURnGm3LZvNXp4Pz2SR+pCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PJcyW7E1x6qvYA6n3PJcjrEh/kExwkcg
        I9+fcEat/pqfOS+/xkvRCGsBbglnP2SBGHdo85+KyZgB5nM4WY8wiykOCgqNWC33
        2+xeFDoF5fVL+fhr7JyU8/czoXk45IOOFLF2FBpQtL/uaMtXCWRtpnXwAli1lYKP
        we9uRM95z1Q=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B237632F4;
        Mon, 23 Jan 2017 21:28:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B17D7632F3;
        Mon, 23 Jan 2017 21:28:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check structure
References: <20170112235354.153403-1-bmwill@google.com>
        <20170123203525.185058-1-bmwill@google.com>
        <20170123203525.185058-26-bmwill@google.com>
        <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
        <20170123220614.GA187696@google.com>
        <20170124011135.GB187696@google.com>
Date:   Mon, 23 Jan 2017 18:28:41 -0800
In-Reply-To: <20170124011135.GB187696@google.com> (Brandon Williams's message
        of "Mon, 23 Jan 2017 17:11:35 -0800")
Message-ID: <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D2D1F316-E1DC-11E6-81C5-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> ... It seems like breaking the question and answer up
> doesn't buy you much in terms of reducing allocation churn and instead
> complicates the API with needing to keep track of two structures instead
> of a one.

In my mind, the value of having a constant check_attr is primarily
that it gives us a stable pointer to serve as a hashmap key,
i.e. the identifier for each call site, in a later iteration.

Of course, in order to populate the "question" array, we'd need the
interning of attribute names to attr objects, which need to be
protected by mutex, and you would probably not want to do that every
time the control hits the codepath.

But all of the above comes from my intuition, and I'll very much
welcome to be proven wrong with an alternative design, or better
yet, a working code based on an alternative design ;-).
