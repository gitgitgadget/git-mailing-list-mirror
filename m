Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF11020286
	for <e@80x24.org>; Wed, 13 Sep 2017 21:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdIMVhE (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 17:37:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54504 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751746AbdIMVfP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 17:35:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26E2B9F4EC;
        Wed, 13 Sep 2017 17:35:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5R1kceKCfeJzWh8op3NLWjE8LuY=; b=T9pItc
        W0+qNZokvY8Bzp6EATvN6nOFckyUiPHvsN9fUpMQdqbmgtH7bLloPhhb4LRECxOO
        +S/9HPivbZM2f2gvreDV35WVcIZx5XvYDUriBNKXysxKN4y6VGfuYzWpBAJd1o+9
        7oddpzoFDgg7XkgbkQUP2zZYexClCEBgn67NA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PnTS6ououJnuvhVHCSL7Aa5DypCa0mxV
        UA0nGCeEDt9Dv9mV96recHR/jPzcVVRqLcSg57egz98WLAMhNDkDLOVbrZvUUSpA
        031DBR3mJHRUPE3ubAro73rzZaSSyxyDHExPUgGTiv4NGSahidjM2qIdt6ffM8lG
        RnXZkAvPm2Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DF2C9F4EB;
        Wed, 13 Sep 2017 17:35:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6A7919F4EA;
        Wed, 13 Sep 2017 17:35:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/20] Read `packed-refs` using mmap()
References: <cover.1505319366.git.mhagger@alum.mit.edu>
Date:   Thu, 14 Sep 2017 06:35:13 +0900
In-Reply-To: <cover.1505319366.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Wed, 13 Sep 2017 19:15:54 +0200")
Message-ID: <xmqqbmme1dv2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DC0075A-98CB-11E7-B3F1-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Following lots of work to extract the `packed_ref_store` into a
> separate module and decouple it from the `files_ref_store`, it is now
> possible to fundamentally change how the `packed-refs` file is read.
>
> * `mmap()` the whole file rather than `read()`ing it.
>
> * Instead of parsing the complete file at once into a `ref_cache`,
>   parse the references out of the file contents on demand.
>
> * Use a binary search to find, very quickly, the reference or group of
>   references that needs to be read. Parse *only* those references out
>   of the file contents, without creating in-memory data structures at
>   all.

Oooh, juicy and very exciting.

> ...
> This branch applies on top of mh/packed-ref-transactions. It can also
> be obtained from my git fork [1] as branch `mmap-packed-refs`.
>
> Michael
>
> [1] https://github.com/mhagger/git

Thanks for working on this. I expect that it will take more than a
few hours for me to pick it up, but I am looking forward to it.

