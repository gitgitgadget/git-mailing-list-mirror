Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3F3520356
	for <e@80x24.org>; Tue, 18 Jul 2017 18:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdGRSxw (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 14:53:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51214 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751392AbdGRSxv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 14:53:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 579877BB77;
        Tue, 18 Jul 2017 14:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s//ei4u9h83A5T+Bp8AzDRo+e8A=; b=b2la0R
        eupquMO2VaGpe3cBXwdbiol7cPoZPHCuwFbHSwhnrOV3TDhyi1uTJqu+JJ3D0x6Z
        kaGFi5sSKnpItiieqkht+ivFoQpFBzwWmpeM4CfFV65yAUzyO0xhiVkwJiD/PShy
        K0PHwOgG60pH2KFVUUjl0XI8hJwh6stz+mCx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=na0C/UKkTia00C11G1gXsPfa7aQkGv/J
        A7I4oJsVVjGETuo6HjXPXZzLF08IyPVvn+QF7B9Zfh/Nw3FI+fc+WAT8q1qMFcTf
        D3Y2gTfoD8SowN2Z6ts2x7tTJfQ6jI1WQixNdI9/sFO28cgLrdze51CzZNi/4+yG
        eg0999xKIeA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5113A7BB76;
        Tue, 18 Jul 2017 14:53:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B32A87BB75;
        Tue, 18 Jul 2017 14:53:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
Subject: Re: reftable: new ref storage format
References: <CAJo=hJtyof=HRy=2sLP0ng0uZ4=S-DpZ5dR1aF+VHVETKG20OQ@mail.gmail.com>
        <CAMy9T_GsgDewHhe1heH7t2qPZuE3XQOKzoxc50-fLmOqm=6ZzQ@mail.gmail.com>
        <CAJo=hJv36tYuxHuso7NrPkfE9hApGfn=iP8g_8+MeM8L91h09g@mail.gmail.com>
        <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com>
Date:   Tue, 18 Jul 2017 11:53:49 -0700
In-Reply-To: <CAMy9T_Fuf3YoHzsLgx-fcX5OQBNXw8xOvrPEpffkYjWGBpNsMQ@mail.gmail.com>
        (Michael Haggerty's message of "Mon, 17 Jul 2017 18:43:35 -0700")
Message-ID: <xmqqa841poea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7039DFDC-6BEA-11E7-9DE3-61520C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On second thought, the idea of having HEAD (or maybe all pseudorefs)
> in the same system would open a few interesting possibilities that
> derive from having a global, atomic view of all references:
>
> 1. We could store backlinks from references to the symbolic references
> that refer to them. This would allow us to update the reflogs for
> symbolic refs properly. (Currently, there is special-case code to
> update the reflogs for HEAD when the reference that it points at is
> modified, but not for other symrefs.)
>
> 2. We could store "peeled" versions of symbolic refs. These would have
> to be updated whenever the pointed-at reference is updated, but that
> would have two nice advantages: HEAD would usually be resolvable based
> on the top reftable in the stack, and it would be resolvable in one
> step (without having the follow the symref explicitly).

Interesting.  I think FETCH_HEAD is the only thing that would not
mesh well with the "one ref records one object name, or refers to
another ref" paradigm, and I think it is OK to leave it that way,
even in the new pluggable ref backend world order.

It still bothers me that the way refs.c special-cases what you call
pseudo refs seems somewhat inconsistent, which I found by accident
the other day while running t1405 and reported in a separate thread.
When we start adding a reftable backend, I suspect we'd need to dig
further, but if I recall the symptom correctly, writing them out is
still passed to the main (i.e. files) backend, while reading them is
done directly in refs.c layer without consulting any backend, and
that made it impossible to optionally tweak the filename used to
store refs in the files backend.




