Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F249C43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 17:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9D422465E
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 17:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="s4Zye1CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLQRn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:43:28 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64514 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbfLQRn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 12:43:28 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 36A209A428;
        Tue, 17 Dec 2019 12:43:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4puxefGXivw5E3s49FZ5+VaH1P4=; b=s4Zye1
        CLzz6bicJ2uPhia5vts9xzraDRHoBpaBd770oap4Kt+7qbA3DoI1SYmLmwbQRpo5
        kxssmp1jV17hMBPDl0OM472aGOEDpgYJVRxu6K0IrxHyuBMt9aUcu58F6w8yO9gs
        R2QkhtKJSPrl8Pxenh6yDr0DJhZKc5z3Cu498=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Pkz4Lky5nDU7M9IGiNdir06b54bka9N/
        8ZgUBGLA1TUjY7vk2mtKnOa98BpptRtYNNR79QMS6V+qs3U0PWMAR+Xw5yjrOaRf
        nhFCC3nWrsKodeVzaAX+H6j3glGNH+QCln84t6U53yQG/Zr7SM1IIfph9H5x/0KV
        yE7iFOwUTfw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2F1FA9A426;
        Tue, 17 Dec 2019 12:43:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 55C459A425;
        Tue, 17 Dec 2019 12:43:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 10/15] bugreport: add config values from safelist
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-11-emilyshaffer@google.com>
        <xmqq4ky3j3w4.fsf@gitster-ct.c.googlers.com>
        <20191216234036.GK135450@google.com>
Date:   Tue, 17 Dec 2019 09:43:23 -0800
In-Reply-To: <20191216234036.GK135450@google.com> (Emily Shaffer's message of
        "Mon, 16 Dec 2019 15:40:36 -0800")
Message-ID: <xmqqfthij1ac.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA0BEC38-20F4-11EA-B8A5-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>> But that is too simple-minded.  If we wanted to safelist foo.*.bar,
>> where '*' can be anything, walking on the list of safe variables
>> would not work.  We must have a hash table that knows "foo.*.bar" is
>> allowed, and while walking all the configuration keys, when we see
>> foo.a.bar, we consult "foo.*.bar" as well as "foo.a.bar" to see if
>> it is whitelisted, or something like that.
>
> ...unless we want to use wildcards like you suggest.
>
> But I'm not sure it's a good idea. I envision someone writing another
> Git add-on, which offers someone to specify "user.password" ...

Wildcarding the leaf level of two (or for that matter three) level
names like "user.*" in your example is of course a nonsense way to
use the safelist.  But think about three-level names where the
second level is designed to be used for user-supplied token to give
things of similar nature a name the user can use to distinguish
things.  If remote.origin.url is worth reporting, wouldn't
remote.upstream.url also be?  Shouldn't remote.*.url be the way to
say "the URL field for each and every remote is a safe thing to
report" in the safelist?
