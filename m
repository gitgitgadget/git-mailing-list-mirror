Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6872120953
	for <e@80x24.org>; Wed, 15 Mar 2017 17:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdCOR7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 13:59:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53632 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750847AbdCOR7H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 13:59:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 304067D1DD;
        Wed, 15 Mar 2017 13:59:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fQifuVKnMpJCg/Kw/0WX+JTfERU=; b=s35CZr
        SfQUOyz/8WnDoF+Ak1gDW8bgVpnCKjB3PYgSPELmIVXBe8/V3EP3HhQgwKWJaQOA
        o+HF/xt8ekZCTV/rq+vItsQ6q4R6DKcP4uqoqzkjClIymMNheoOfu4Oi9hYYRrUx
        a3zpTQ/L6cXFT602IFVFvvQ6Q4vhkhS/AoesU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wk2YB8nGEsX2NvTQzC1U25MKozqt77oe
        HSsE4/vGVL4ZX5oT+4bjS1bELydvPqDD5jrfGfXJKq74wHdZ2R5jgRkzMxoHT0iZ
        NmcCiz4jRSKuzrYmYLEUxaqO35XMb493YZbEfsjyvFPWOz/IDRAJ3+p+pRR2+h96
        xPgoLJ6CdSA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29D787D1DC;
        Wed, 15 Mar 2017 13:59:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C48B7D1DB;
        Wed, 15 Mar 2017 13:59:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>, markbt@efaref.net,
        git@jeffhostetler.com
Subject: Re: Proposal for "fetch-any-blob Git protocol" and server design
References: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com>
Date:   Wed, 15 Mar 2017 10:59:03 -0700
In-Reply-To: <ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com> (Jonathan Tan's
        message of "Tue, 14 Mar 2017 15:57:57 -0700")
Message-ID: <xmqqinnafml4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13E35BE4-09A9-11E7-87F7-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> == Design
>
> A new endpoint "server" is created. The client will send a message in
> the following format:
>
> ----
> fbp-request = PKT-LINE("fetch-blob-pack")
>               1*want
>               flush-pkt
> want = PKT-LINE("want" SP obj-id)
> ----
>
> The client may send one or more SHA-1s for which it wants blobs, then
> a flush-pkt.

By "SHA-1s for which it wants blobs", you mean that "want" only
allows one exact blob object name?  I think it is necessary to
support that mode of operation as a base case, and it is a good
starting point.

When you know

 - you have a "partial" clone that initially asked to contain only
   blobs that are smaller than 10MB, and

 - you are now trying to do a "git checkout v1.0 -- this/directory"
   so that the directory is fully populated

instead of enumerating all the missing blobs from the output of
"ls-tree -r v1.0 this/directory" on separate "want" requests, you
may want to say "I want all the blobs that are not smaller than 10MB
in this tree object $(git rev-parse v1.0:this/directory)".

I am not saying that you should add something like this right away,
but I am wondering how you would extend the proposed system to do
so.  Would you add "fetch-size-limited-blob-in-tree-pack" that runs
parallel to "fetch-blob-pack" request?  Would you add a new type of
request packet "want-blob-with-expression" for fbp-request, which is
protected by some "protocol capability" exchange?

If the former, how does a client discover if a particular server
already supports the new "fetch-size-limited-blob-in-tree-pack"
request, so that it does not have to send a bunch of "want" request
by enumerating the blobs itself?  If the latter, how does a client
discover if a particular server's "fetch-blob-pack" already supports
the new "want-blob-with-expression" request packet?

> === Endpoint support for forward compatibility
>
> This "server" endpoint requires that the first line be understood, but
> will ignore any other lines starting with words that it does not
> understand. This allows new "commands" to be added (distinguished by
> their first lines) and existing commands to be "upgraded" with
> backwards compatibility.
