Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D2B620323
	for <e@80x24.org>; Thu, 16 Mar 2017 21:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbdCPVRm (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 17:17:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59058 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753830AbdCPVRl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 17:17:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B5236842F;
        Thu, 16 Mar 2017 17:17:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aQUcmDAGlWMuUZaUzSmKwy/K6gA=; b=bzz9ju
        NnEMU5xvyGkfABzIYu0Hx201ITr55CqMQEdtrjr8LvGB+8kAa3ixCrgSPmDnPj73
        hxfdnRSlJjL6hsJL77H7O/S7FZeRGuZtgpWC1zqTT1dy9N7arS+6cGuV6C7Q5P4d
        DO7hrDgwFax/4CbxFh1/Rh6Mk1lpvaN0Hd3ns=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rqir8tL/BVS6aYfKCCiOeGExqRXJ4h+o
        g6o6VL1ru3Lo46YrBjmhgZwirgoe0VOU8Hcd57P3yKG6x/+q+WpJbDVMSvuSR9ii
        XlJl78ey7+HYy7rZay81/Jx8badTjJxhobJBWgXOC3jyOO4Uyq0sKJxt0SXqNmk0
        dt1dQZ2NdSI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4408B6842E;
        Thu, 16 Mar 2017 17:17:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87FA86842D;
        Thu, 16 Mar 2017 17:17:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>, markbt@efaref.net,
        git@jeffhostetler.com
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
        <xmqqinnafml4.fsf@gitster.mtv.corp.google.com>
        <90381e66-d91f-6412-6294-701f5f780645@google.com>
Date:   Thu, 16 Mar 2017 14:17:32 -0700
In-Reply-To: <90381e66-d91f-6412-6294-701f5f780645@google.com> (Jonathan Tan's
        message of "Thu, 16 Mar 2017 10:31:09 -0700")
Message-ID: <xmqq7f3oc45v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F89B8344-0A8D-11E7-9417-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On 03/15/2017 10:59 AM, Junio C Hamano wrote:
>> ...
>> but I am wondering how you would extend the proposed system to do
>> so.  Would you add "fetch-size-limited-blob-in-tree-pack" that runs
>> parallel to "fetch-blob-pack" request?  Would you add a new type of
>> request packet "want-blob-with-expression" for fbp-request, which is
>> protected by some "protocol capability" exchange?
>>
>> If the former, how does a client discover if a particular server
>> already supports the new "fetch-size-limited-blob-in-tree-pack"
>> request, so that it does not have to send a bunch of "want" request
>> by enumerating the blobs itself?  If the latter, how does a client
>> discover if a particular server's "fetch-blob-pack" already supports
>> the new "want-blob-with-expression" request packet?
>
> I'm not sure if that use case is something we need to worry about (if
> you're downloading x * 10MB, uploading x * 50B shouldn't be a problem,
> I think), but if we want to handle that use case in the future, I
> agree that extending this system would be difficult.

Yeah, the example was solely to see how the system was to be
extended, as one of the selling point of the proposal was:

    > === Endpoint support for forward compatibility
    >
    > This "server" endpoint requires that the first line be understood, but
    > will ignore any other lines starting with words that it does not
    > understand. This allows new "commands" to be added (distinguished by
    > their first lines) and existing commands to be "upgraded" with
    > backwards compatibility.

> The best way I can think of right now is for the client to send a
> fetch-blob-pack request with no "want" lines and at least one
> "want-tree" line, ...

So it is not by adding new type of "request" that sits next to
"fetch-blob-pack" request, but by adding a new way to drive that
existing "fetch-blob-pack" request.  

> and then if there is an error (which will happen if
> the server is old, and therefore sees that there is not at least
> "want" line), to retry with the "want" lines. This allows us to add
> alternative ways of specifying blobs later (if we want to), but also
> means that upgrading a client without upgrading the corresponding
> server incurs a round-trip penalty.

And the lack of "capability negotiation" is substituted by "assume
the better server, fallback to lower common denominator by detecting
errors"?

> Alternatively we could add rudimentary support for trees now and add
> filter-by-size later ...

I am not particularly interested in "blobs in this tree" request.
It was merely an example to make it easier to discuss the main
point, which is the bigger picture that the proposal was painting
around "forward compatibility".

Thanks.
