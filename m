Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68DC41FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbcLHS6o (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 13:58:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64010 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751577AbcLHS6n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 13:58:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13991544D4;
        Thu,  8 Dec 2016 13:58:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZbzhOrBsfGzYhhVlbQulyWu+GWk=; b=Ykwt+p
        7Hlz/xUfQBMe48AzCsWP2WE6mAtKG61B4IdnGdnQo527Uno76F3FV5oOudS6QbZZ
        QCtC5MrFHUga1ucDLMig075TwO2hLS5MAPsyqG6CsFRR3TNGfgVxI7bK1uG1KBVq
        31R9Hwm2qpv0FD/4ipaAo9XJ9HPaN2XSQ7gaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ah6eOVPT8CnTMRIlhHn9M/+7pb8KSjX9
        S8IQ6nGI0VyDB01pBpl73Z5bFbG+VMYJ/42o2rUqywjOMBUeh3pvQ9mUf6Wv3WMv
        yz7XM8jKiPh8Y7TQT+UrOHvyLGFlIJKI3eITPC2VUKU/XzZ72i4sfrx9xHlhwsAy
        ZS90rUuO0WI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B7A5544D3;
        Thu,  8 Dec 2016 13:58:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 61DFD544D2;
        Thu,  8 Dec 2016 13:58:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
References: <20161207153627.1468-1-Karthik.188@gmail.com>
        <CA+P7+xquordVY19dypqNcAuQqoRbFmHhzb0w+HXCaJmm_Ex7zQ@mail.gmail.com>
Date:   Thu, 08 Dec 2016 10:58:39 -0800
In-Reply-To: <CA+P7+xquordVY19dypqNcAuQqoRbFmHhzb0w+HXCaJmm_Ex7zQ@mail.gmail.com>
        (Jacob Keller's message of "Wed, 7 Dec 2016 16:01:48 -0800")
Message-ID: <xmqqa8c6tfhc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55C63D4C-BD78-11E6-A02E-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

>> +       are left behind.  If a displayed ref has fewer components than
>> +       `<N>`, the command aborts with an error.
>>
>
> Would it make more sense to not die and instead just return the empty
> string? On the one hand, if we die() it's obvious that you tried to
> strip too many components. But on the other hand, it's also somewhat
> annoying to have the whole command fail because we happen upon a
> single ref that has fewer components?
>
> So, for positive numbers, we simply strip what we can, which may
> result in the empty string, and for negative numbers, we keep up to
> what we said, while potentially keeping the entire string. I feel
> that's a better alternative than a die() in the middle of a ref
> filter..
>
> What are other people's thoughts on this?

There probably are three ways to handle a formatting request that
cannot be satisfied for some refs but not others [*1*].  I agree
with you that dying the whole thing is probably the least useful
one.

We already format "%(taggername)" into an empty string when the ref
points at an object that is not an annotated tag, and substituting
an unsatisifiable request "%(refname:lstrip=N)" with an empty string
for a ref whose name does not have enough number of components is in
line with that existing practice.

The other possibility is to omit refs that cannot be formatted
according to the format specifier.  We do not currently have
provision for doing so, but it may not be bad if we can say:

    $ git for-each-ref \
	--require="%(taggername)" \
	--require="%(refname:lstrip=4)" \
	--format="%(refname:short)" \
	refs/tags/

to list _only_ annotated tags that has at least 4 components from
refs/tags/ hierarchy.

The "--require" thing obviously is an orthogonal feature, that
nobody has asked for, and does not have to exist.  For the purpose
of this review thread, I think it is OK to just conclude:

    "--format" should replace "%(any unsatisifiable atom)" with an
    empty string.

Thanks.

[Footnote]

*1* A malformed formatting request (e.g. %(if) that is not closed)
    cannot be satisified but that is true for all refs and is
    outside of the scope of this discussion.  The command should die
    and I think it already does.
