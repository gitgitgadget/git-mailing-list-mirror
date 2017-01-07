Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFC9120756
	for <e@80x24.org>; Sat,  7 Jan 2017 21:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdAGVq0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jan 2017 16:46:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56359 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750981AbdAGVqY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2017 16:46:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C35085CF86;
        Sat,  7 Jan 2017 16:46:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VJAYT4upBWIjbezK29UygvekzQE=; b=wjADSj
        37BIk+P7FV9x/vLJ+e3SfWd9hePgNfwxh9yHbhuqVXe/kZuLCmWfYbc8dsqofGMk
        VbXMSOdx5D0YZftY1EuOha8U8BqeUyOladdS/djtQrq2gjFjPr4qesgPsw5AjWya
        M8XQ3VecxGjtLeHSqq6GDh/gh6iMYJtILt+yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jTc6Mry91s9roSsQuzCdOBKSYjyWDw1i
        UOh9gIwmfmHfWZoJKoCaOObyJDyqJXz2lRDNQlYTLyWrYIpugxJdqd1zkEQvwYU0
        mj3N87e5V+4Es1FvK/cF1a9BvQG67yNnHbjjiIGty3/VQZMPez/vdiWsciGZJoAm
        x6LxLJ0o1ec=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BAD3F5CF85;
        Sat,  7 Jan 2017 16:46:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1AF495CF82;
        Sat,  7 Jan 2017 16:46:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 14/21] read-cache: touch shared index files when used
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
        <20161226102222.17150-15-chriscool@tuxfamily.org>
        <xmqqa8bhb32x.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
Date:   Sat, 07 Jan 2017 13:46:21 -0800
In-Reply-To: <CAP8UFD1EgOxcPi=tpiosKkYMcCZe+b6gwW0CKt2sE1NZ7gQv=A@mail.gmail.com>
        (Christian Couder's message of "Mon, 2 Jan 2017 15:09:12 +0100")
Message-ID: <xmqqo9zi35n6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BB735D70-D522-11E6-B48C-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> So what should we do if freshen_file() returns 0 which means that the
> freshening failed?

You tell me ;-)  as you are the one who is proposing this feature.

Isn't a failure to freshen it a grave error?  We are letting a
base/shared index file that is known to be in-use go stale and
eventually subject for garbage collection, and the user should be
notified in some way before the actual GC happens that renders the
index file unusable?

What is the failure mode after such a premature GC happens?  What
does the end-user see?  Can you try to (1) split the index (2)
modify bunch of entries (3) remove the base/shared index with /bin/rm
and then see how various Git commands fail?  Do they fail gracefully?

I am trying to gauge the seriousness of ignoring such an error here.
