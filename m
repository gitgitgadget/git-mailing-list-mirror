Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67BD020365
	for <e@80x24.org>; Tue,  3 Oct 2017 08:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbdJCIuq (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 04:50:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61159 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751156AbdJCIup (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 04:50:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D55D9AAAC0;
        Tue,  3 Oct 2017 04:50:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t8TWO7Hbw6t2CLIndfEvP9KmBF0=; b=cDPzi/
        8HuSCp5JXtyW7U/UtIWY+wUUv+Q8DwjbnnJ+j4Skm9Q/tLdNawZzX+21d39/TusM
        LbnzrmuBqGT2tu5KKArAvUAMxn82ueIBFD25ZSoCvO4uQNprR6/+UxlQLeAJcedt
        RW51W83V55Kil/nQO+sbXJHXMtA4AJk6JmASY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QwCjdRgwjiwFC3owfIR+UqdRRtrSFvrH
        A/GVPewqkcAdDI3CmUU8ael2U4YDeW930o9i+XZtMfNf8wN0N//wF49RfhzK2JL9
        1m50m9wYSQbzJrhJ7oHZnmpXGtvPEOPmzvybJUjEZEle8KYlxfWJOYbtMKuVVZ15
        w7dL+xmEMtQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B0F61AAABF;
        Tue,  3 Oct 2017 04:50:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 20146AAABE;
        Tue,  3 Oct 2017 04:50:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Ben Peart <peartben@gmail.com>
Subject: Re: [PATCH 00/18] Partial clone (from clone to lazy fetch in 18 patches)
References: <cover.1506714999.git.jonathantanmy@google.com>
        <CAP8UFD1WiceKDX9s0hszXXKy+TOxAOvHZyr002HMYkkgbFgD7w@mail.gmail.com>
Date:   Tue, 03 Oct 2017 17:50:42 +0900
In-Reply-To: <CAP8UFD1WiceKDX9s0hszXXKy+TOxAOvHZyr002HMYkkgbFgD7w@mail.gmail.com>
        (Christian Couder's message of "Tue, 3 Oct 2017 08:15:33 +0200")
Message-ID: <xmqq8tgsipi5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F123FD4E-A817-11E7-AE93-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Could you give a bit more details about the use cases this is designed for?
> It seems that when people review my work they want a lot of details
> about the use cases, so I guess they would also be interesting in
> getting this kind of information for your work too.
>
> Could this support users who would be interested in lazily cloning
> only one kind of files, for example *.jpeg?

I do not know about others, but the reason why I was not interested
in finding out "use cases" is because the value of this series is
use-case agnostic.

At least to me, the most interesting part of the series is that it
allows you to receive a set of objects transferred from the other
side that lack some of objects that would otherwise be required to
be here for connectivity purposes, and it introduces a mechanism to
allow object transfer layer, gc and fsck to work well together in
the resulting repository that deliberately lacks some objects.  The
transfer layer marks the objects obtained from a specific remote as
such, and gc and fsck are taught not to try to follow a missing link
or diagnose a missing link as an error, if a missing link is
expected using the mark the transfer layer left.

and it does so in such a way that it is use-case agnostic.  The
mechanism does not care how the objects to be omitted were chosen,
and how the omission criteria were negotiated between the sender and
the receiver of the pack.

I think the series comes with one filter that is size-based, but I
view it as a technology demonstration.  It does not have to be the
primary use case.  IOW, I do not think the series is meant as a
declaration that size-based filtering is the most important thing
and other omission criteria are less important.

You should be able to build path based omission (i.e. narrow clone)
or blobtype based omission.  Depending on your needs, you may want
different object omission criteria.  It is something you can build
on top.  And the work done on transfer/gc/fsck in this series does
not have to change to accommodate these different "use cases".


