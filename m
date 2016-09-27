Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F4320986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933920AbcI0P57 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:57:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55845 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753547AbcI0P55 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 11:57:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 807BA3E9FD;
        Tue, 27 Sep 2016 11:57:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AIyEJ3Fhpk/FiO6J6lMr/eFSRUE=; b=BXkxb1
        SYohZPc6xLSUtZe8u3BfR7jd7PzRLwpzd62iWLWa6+ubBg9S6thKNDyf9RmCjL8B
        6dVUjPK6Je4bJxMfjUmPBj3dzEM/2waX7g8WVMzf4MBVIRvL9+AUjrewE7B8+0bc
        FlcA8gvlQGwOfbBpfR7YtJmYE988pdR4+1L1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQVoX+UkvKuDyqFYH/duUjkukLwN6nqE
        Pip1v10gNsKGuElpsXpiMjEdSPfMqaqg77wNyvdDxBUfnyojWAiopXe0Jz8LZT1u
        /M5MMsJfCNXJHAqbqHOuTnrUVueJQHJhVPBGBTSYLCZdD7HQeWA2nai2yLvoiuBJ
        MDjRJuftwXc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 785FE3E9FC;
        Tue, 27 Sep 2016 11:57:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E074D3E9FB;
        Tue, 27 Sep 2016 11:57:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Gustavo Grieco <gustavo.grieco@imag.fr>, git@vger.kernel.org
Subject: Re: Possible integer overflow parsing malformed objects in git 2.10.0
References: <1825523389.8224664.1474812766424.JavaMail.zimbra@imag.fr>
        <381383122.8376940.1474943423005.JavaMail.zimbra@imag.fr>
        <20160927080755.evlq3sfkyoolixop@sigill.intra.peff.net>
Date:   Tue, 27 Sep 2016 08:57:53 -0700
In-Reply-To: <20160927080755.evlq3sfkyoolixop@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 27 Sep 2016 04:07:55 -0400")
Message-ID: <xmqqponpqqri.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 279F386E-84CB-11E6-86F8-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That being said, the parse_sha1_header() function clearly does not
> detect overflow at all when parsing the size. So on a 32-bit system, you
> end up with:
>
>   $ git fsck
>   fatal: Out of memory, malloc failed (tried to allocate 4294967141 bytes)
>
> which is not correct, but I'm not sure it's a security problem.  Integer
> overflows are an issue if they cause us to under-allocate, and then to
> write more bytes than we allocated. In this case, I would expect
> unpack_sha1_rest() to never write more bytes than the "size" we parsed
> and allocated (and to complain if the number of bytes we get from the
> zlib sequence do not exactly match the claimed size).
>
> So a more interesting example is more like "ULONG_MAX + 5", where we
> would overflow to 5 bytes. And we'd hope that unpack_sha1_rest does not
> ever write more than 5 bytes. From my reading and a few tests with gdb,
> it does not. However, it also does not notice that there were more bytes
> that we didn't use.
>
> So I think there's room for improved diagnosis of bogus situations
> (including integer overflows), but I don't see any actual security bugs.

I agree with the overall conclusion.  This does look like an attempt
to throw random fuzz at Git and see if and how it breaks, and in this
particular one Git is simply doing the right thing (and the fault lies
in the way how ASAN is used and how its result was interpreted).

Throwing random fuzz to see what breaks is not a bad thing to do
per-se, but anybody who does so without wearing a black hat needs to
keep two things in mind:

 * When a random fuzz attempt does uncover a security issue,
   reporting it here on this list is a grossly irresponsible way to
   disclose the issue.  We have the git-security list for that.

 * A random fuzz may stop Git and that may be perfectly legit thing
   to happen, e.g. the data may request a large but still valid
   amount of memory to be allocated that happens not to fit in the
   hardware the fuzz attempt is being run, and xmalloc() may detect
   the situation and die, like the above example.  False positives
   are expected and you want to make sure you cull them before
   making your reports.  Otherwise, they will unnecessary burden
   people who are doing real work, i.e. reproduce and correct
   problems that may be security related that are irresponsibly
   disclosed here quickly enough to minimize damage.

Thanks.

