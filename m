Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3A73202A5
	for <e@80x24.org>; Mon,  2 Oct 2017 08:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdJBIZZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 04:25:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50259 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751206AbdJBIZS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 04:25:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D23B3A5F00;
        Mon,  2 Oct 2017 04:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eDqtUAq1kXZmODwfHR+6ajf8WnM=; b=XyECJQ
        QEd/QYx8+kbiPrLrLO3sPMNhC4gWzg2L5xKYbHGU16HytxUg7g9g2+iMg6AJVeRe
        eZ0FSE4M/4wZh2mVdNbDsjdcWilsFLUXjWSHyzJZkmerY5RXYKtCNLLVHofY8Lr1
        8b1cXyHW8Y3C6/4HlBu52aVMpbRe5hTCfizlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vtxuEZ/Es5LHPkZhtddLuVTgJDjbf7vE
        KGDXTwbnjGAqgEq2NsjnqOrKyZUAYY1Fe7OQpDbdMUI55k0knOjhurKEQo1I+nRo
        5HUCL2AZIQgm8Bt+FbhKQ7Ti/PdiLAXpZQM1RYxBtWhK0fx8kawfTyL8BCE4fSPM
        5OF8lM7jYDM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C21FCA5EFF;
        Mon,  2 Oct 2017 04:25:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C632DA5EFE;
        Mon,  2 Oct 2017 04:25:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Masaya Suzuki <masayasuzuki@google.com>, demerphq@gmail.com,
        The Keccak Team <keccak@noekeon.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] technical doc: add a design doc for hash function transition
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
        <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
        <20170307001709.GC26789@aiede.mtv.corp.google.com>
        <CAJo=hJtoX9=AyLHHpUJS7fueV9ciZ_MNpnEPHUz8Whui6g9F0A@mail.gmail.com>
        <20170928044320.GA84719@aiede.mtv.corp.google.com>
        <xmqqo9puvy1w.fsf@gitster.mtv.corp.google.com>
        <20170929173413.GI19555@aiede.mtv.corp.google.com>
Date:   Mon, 02 Oct 2017 17:25:15 +0900
In-Reply-To: <20170929173413.GI19555@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 29 Sep 2017 10:34:13 -0700")
Message-ID: <xmqq3772ot1w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 386A14CC-A74B-11E7-B5B3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>> +6. Skip fetching some submodules of a project into a NewHash
>>> +   repository. (This also depends on NewHash support in Git
>>> +   protocol.)
>>
>> It is unclear what this means.  Around submodule support, one thing
>> I can think of is that a NewHash tree in a superproject would record
>> a gitlink that is a NewHash commit object name in it, therefore it
>> cannot refer to an unconverted SHA-1 submodule repository.  But it
>> is unclear if the above description refers to the same issue, or
>> something else.
>
> It refers to that issue.

We may want to find a way to make it clear, then.

>> It makes me wonder if we want to add the hashname in this object
>> header.  "length" would be different for non-blob objects anyway,
>> and it is not "compat metadata" we want to avoid baked in, yet it
>> would help diagnose a mistake of attempting to use a "mixed" objects
>> in a single repository.  Not a big issue, though.
>
> Do you mean that adding the hashname into the computation that
> produces the object name would help in some use case?

What I mean is that for SHA-1 objects we keep the object header to
be "<type> <length> NUL".  For objects in newer world, use the
object header to "<type> <hash> <length> NUL", and include the
hashname in the object name computation.

> For loose objects, it would be nice to name the hash in the file, so
> that "file" can understand what is happening if someone accidentally
> mixes types using "cp".  The only downside is losing the ability to
> copy blobs (which have the same content despite being named using
> different hashes) between repositories after determining their new
> names.  That doesn't seem like a strong downside --- it's pretty
> harmless to include the hash type in loose object files, too.  I think
> I would prefer this to be a "magic number" instead of part of the
> zlib-deflated payload, since this way "file" can discover it more
> easily.

Yeah, thanks for doing pros-and-cons for me ;-)

>> If it is a goal to eventually be able to lose SHA-1 compatibility
>> metadata from the objects, then we might want to remove SHA-1 based
>> signature bits (e.g. PGP trailer in signed tag, gpgsig header in the
>> commit object) from NewHash contents, and instead have them stored
>> in a side "metadata" table, only to be used while converting back.
>> I dunno if that is desirable.
>
> I don't consider that desirable.

Agreed.  Let's not go there.

>> Hmm, as the corresponding packfile stores object data only in
>> NewHash content format, it is somewhat curious that this table that
>> stores CRC32 of the data appears in the "Tables for each object
>> format" section, as they would be identical, no?  Unless I am
>> grossly misleading the spec, the checksum should either go outside
>> the "Tables for each object format" section but still in .idx, or
>> should be eliminated and become part of the packdata stream instead,
>> perhaps?
>
> It's actually only present for the first object format.  Will find a
> better way to describe this.

I see.  One way to do so is to have it upfront before the "after
this point, these tables repeat for each of the hashes" part of the
file.

>> Oy.  So we can go from a short prefix to the pack location by first
>> finding it via binsearch in the short-name table, realize that it is
>> nth object in the object name order, and consulting this table.
>> When we know the pack-order of an object, there is no direct way to
>> go to its location (short of reversing the name-order-to-pack-order
>> table)?
>
> An earlier version of the design also had a pack-order-to-pack-offset
> table, but we weren't able to think of any cases where that would be
> used without also looking up the object name that can be used to
> verify the integrity of the inflated object.

The primary thing I was interested in knowing was if we tried to
think of any case where it may be useful and then didn't think of
any---I couldn't but I know I am not imaginative enough, and I
wanted to know you guys didn't, either.
