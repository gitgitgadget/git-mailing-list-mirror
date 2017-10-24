Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F328202DD
	for <e@80x24.org>; Tue, 24 Oct 2017 06:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbdJXGsQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 02:48:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55580 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750863AbdJXGsP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 02:48:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 48FF5998DA;
        Tue, 24 Oct 2017 02:48:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=v9eUhIu3FY6TsRw7Q1lYBHQmTkc=; b=IJSj64
        oTRZ0Tyqe+w9DwoArcSlKgf8VrICReVNA0kJjXceP1QK7/dLlCH6AHp/m6fdI/Ov
        B5nYi5f3u5nEAlVG+XcPquzx/lWgf/bJJQ7wFW4wySg/BM8YVNYMV3k+AZ5UXmLC
        4rtGQmzPbzR5tR9rH6k7QMzUgmWm+C2EWqN0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kphtTzpGt7DKTxGg1MHQhvFb0Lw/UEPS
        CuGALiEIU3unQXvgF6D7dyPGgBHbeZircS6pGb/Nr90qooZ220y5TttdJpApRGxw
        iEjUIDLSQ0/YK2PnstV9itQFNznGx7mkE58HhGEKJOd+yw6cRnpwRsR1z0F82am1
        gWTsgUHPyVk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F0EC998D9;
        Tue, 24 Oct 2017 02:48:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99242998D8;
        Tue, 24 Oct 2017 02:48:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [RFC] protocol version 2
References: <20171020171839.4188-1-bmwill@google.com>
Date:   Tue, 24 Oct 2017 15:48:10 +0900
In-Reply-To: <20171020171839.4188-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 20 Oct 2017 10:18:39 -0700")
Message-ID: <xmqqbmkxkpn9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D6BFF8C-B887-11E7-AD9E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>   * Capabilities were implemented as a hack and are hidden behind a NUL
>     byte after the first ref sent from the server during the ref
>     advertisement:
> ...
>
>   * Various other technical debt (e.g. abusing capabilities to
>     communicate agent and symref data, service name set using a query
>     parameter).

This sounds like a duplicate of the above.

>  Special Packets
> -----------------
>
> In protocol v2 these special packets will have the following semantics:
>
>   * '0000' Flush Packet (flush-pkt) - indicates the end of a message
>   * '0001' End-of-List delimiter (delim-pkt) - indicates the end of a list

After reading the remainder of the document twice, I do not think
the reason why we want to introduce a new type delim-pkt is
explained and justified well enough.  If a command request takes a
command packet, zero or more capability packets, a mandatory
delimiter packet, zero or more parameter packets and a mandatory
flush packet, then you can use the same "flush" as delimiter in the
middle.  The delimiter will of course become useful if you can omit
it when not necessary (e.g. after seeing capabilities, you may see a
flush and you will know there is no parameters and save the need to
send one "delim").

I actually have a reasonable guess why you want to have a separate
delimiter (which has nothing to do with "optional delim can be
omitted"), but I want to see it explained in this document clearly
by its designer(s).

>     command-request = command
>                       capability-list
>                       delim-pkt
>                       (command specific parameters)
>                       flush-pkt
>     command = PKT-LINE("command=" key LF)
>
> The server will then acknowledge the command and requested capabilities
> by echoing them back to the client and then launch into the command.
>
>     acknowledge-request = command
>                           capability-list
>                           delim-pkt
>                           execute-command
>     execute-command = <defined by each command>

It is not quite clear what the value of "echoing them back" is,
especially if that is done by always echoing verbatim.  A reader may
naturally expect, when capabilities are exchanged between two
parties, these are negotiated so that the only ones that are
commonly supported by both ends would be used, or something like
that.

> A particular command can last for as many rounds as are required to
> complete the service (multiple for negotiation during fetch and push or
> no additional trips in the case of ls-refs).

OK.

>  Commands in v2
> ~~~~~~~~~~~~~~~~
>
> Services are the core actions that a client wants to perform (fetch,
> push, etc).  Each service has its own set of capabilities and its own
> language of commands (think 'want' lines in fetch).  Optionally a
> service can take in initial parameters or data when a client sends it
> service request.

So a service (like "fetch") employ a set of "command"s (like "want",
"have, etc)?  In the earlier part of the document, we did not see
any mention of "service" and instead saw only "command" mentioned.
Is the state machine on both ends and the transition between states
implicit?  E.g. when one side throws "want" command and the other
side acknowledges, they understand implicitly that they are now in a
"fetch" service session, even though there is nothing that said over
the wire that they are doing so?  One reason I am wondering about
this is what we should do if a command verb may be applicable in
multiple services.

After reading the earlier protocol exchange explanation, I was sort
of expecting that "fetch" would be the command and "want", "have",
and "ack" lines would be exchanged as "command specific parameters",
so a sudden introduction of "services" here was a bit of impedance
mismatch to me.

>  Ls-refs
> ---------
>
> Ls-refs can be looked at as the equivalent of the current ls-remote as
> it is a way to query a remote for the references that it has.  Unlike
> the current ls-remote, the filtering of the output is done on the server
> side by passing a number of parameters to the server-side command
> instead of the filtering occurring on the client.
>
> Ls-ref takes in the following parameters:
>
>   --head, --tags: Limit to only refs/heads or refs/tags

I see no need for the above two as long as "refs/heads/*", etc. are
understood.

>   --refs: Do not show peeled tags or pseudorefs like HEAD

So showing peeled tags is the default?  Then I can sort-of see why
"I am not interested in peeled result".  

I do not see why "do not show HEAD, MERGE_HEAD, etc." is needed,
though.  It should be sufficient to just ask for refs/* if you are
interested only in other things, no?

>   --symref: In addition to the object pointed by it, show the underlying
>             ref pointed by it when showing a symbolic ref

Sort of OK--it probably is easier to always send this, as symbolic
refs are minority anyway, though.

>   <refspec>: When specified, only references matching the given patterns
>              are displayed.

I do not think you meant <refspec> here.

The side that is listing what it has has no reason to know what the
recipient plans to do with the result, so you must be only sending
the LHS of a refspec.  If your explanation says "given patterns",
then replace <refspec> with <pattern>.  Do not abuse a term that has
specific and established meaning for something else.

> The output of ls-refs is as follows:
>
>     output = (no-refs / list-of-refs)
> 	     *symref
>              *shallow
>              flush-pkt
>
>     no-refs = PKT-LINE(zero-id SP no-refs LF)

Can't your list-of-refs have 0 element?  I do not see why you need
no-refs here.  It's not like you need a dummy line, to the end of
which you need to append NUL plus hidden capabilities ;-)

>     list-of-refs = *ref
>     ref = PKT-LINE((tip / peeled) LF)
>     tip = obj-id SP refname
>     peeled = obj-id SP refname "^{}"
>
>     symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
>     shallow = PKT-LINE("shallow" SP obj-id LF)

Thanks.
