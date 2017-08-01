Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980F42047F
	for <e@80x24.org>; Tue,  1 Aug 2017 20:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbdHAUPX (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 16:15:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63604 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752363AbdHAUPV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 16:15:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F0E3AB19A;
        Tue,  1 Aug 2017 16:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jBDDGD3gUTULYXw8zP09zGoHLRM=; b=NDYZIf
        okfboNFhSnXrfR4yBLoKXZeTAfWQJMqnOOPWBBZzsk7CVmchKF87R5Kl4YvOY/BX
        L4LBQ620Xa/UdTUA3/F91W8Y4/egm8QVAvsXA1bJeoVa47mwSW4eAKWeryR69zXY
        USIOt1vd8o9DOnbPzeHWVxd5OpIUTG1yq9zvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SV87PBCBePt5qjZu80XNvmgd7g8gmouU
        BmBWV1lb8OuJDFePjjMZivjvg2a3hs6FSvtv8fFuApUnb3M9512b4TDrfbiE2qL8
        9jTQ2cproPrm6eiqBEfSK2TYqUaufc2fEcv2vR0cjW8iQzX724pOOSKpvlnI5Bjj
        fwm4H1C012E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8592BAB199;
        Tue,  1 Aug 2017 16:15:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E8FDDAB196;
        Tue,  1 Aug 2017 16:15:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH v2 0/5] Fsck for lazy objects, and (now) actual invocation of loader
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501532294.git.jonathantanmy@google.com>
        <xmqq4ltsi9or.fsf@gitster.mtv.corp.google.com>
        <20170731160533.0a446244@twelve2.svl.corp.google.com>
        <xmqq379bgqlx.fsf@gitster.mtv.corp.google.com>
        <20170801174502.GR13924@aiede.mtv.corp.google.com>
Date:   Tue, 01 Aug 2017 13:15:18 -0700
In-Reply-To: <20170801174502.GR13924@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 1 Aug 2017 10:45:02 -0700")
Message-ID: <xmqqfudbf3jd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2436778C-76F6-11E7-BE72-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> If we are deeply worried about this kind of broken connectivity, there
> is another case to care about: the server can "promise" to serve
> requests for some object (e.g., the tree pointed to by the server's
> "master") and then decide it does not want to fulfill that promise
> (e.g., that tree pointed to private key material and "master" was
> rewound to avoid it).  

I think I've already covered that in my message (i.e. "we need to
assume more than the normal Git").  In short, it is not our problem,
but the "lazy-object" service's problem.  If developers cannot trust
the "central server", most likely owned by the organization that
employs them and forces them to offload the access to these objects
to the "central server", I think there is much larger problem there.

> In the promises model, how we do we get a fresh
> understanding of what the server wants to promise now?

Yes, that is one of the things that needs to be designed if we want
to officially support lazy-objects like structure.  We need a way to
incrementally adjust the cut-off point, below which it is the
responsibility of the "other side" to ensure that necessary objects
are available (on demand), and above which it is a local
repository's responsibility to notice corrupted and/or missing
objects.

