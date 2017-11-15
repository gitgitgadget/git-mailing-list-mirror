Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6F11202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 01:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756737AbdKOBMW (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 20:12:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53334 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756733AbdKOBMU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 20:12:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1DD3BC515;
        Tue, 14 Nov 2017 20:12:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bedPVE1iqkam+IwG1F3gbrUHSho=; b=kxfzrA
        MMhWjXa2JqzknkFgyx5ohXXOcQzesL+iaOWKHqJnlo6yEntaxA7Q00XV1IZY9OJ9
        XmIa05y6aXivVDBR59P+XHL1SI6AZUA9bwCP7pFD77dnhhPC2eTrzTkryhQohj2O
        Sx54jC90z/jWPLrgq7eiVqFZuW5tXr3nXm+44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iCD60hiRyZEdiPrDoM9gXM/KQZ1JtDxo
        OEqXbPnj24TB+PHS3IIm63uTr5L0jIg//041PXlbXqfBEB3M7B65WsWk3XgPDUdr
        EaxXTuzL7ZQ4kPz6MR2gvK0NgJiuE+wqJiXuQnR075nFPnBCFKjoUtib4F5DysfC
        EIblnFJZ4Jk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98E63BC514;
        Tue, 14 Nov 2017 20:12:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05260BC513;
        Tue, 14 Nov 2017 20:12:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through parallelization
References: <20171109141737.47976-1-benpeart@microsoft.com>
        <20171109141737.47976-2-benpeart@microsoft.com>
        <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
        <7e5a9fde-67fc-2bb9-51b6-54bdaed162db@gmail.com>
        <xmqq7eut8y36.fsf@gitster.mtv.corp.google.com>
        <7428e41e-b705-f377-1951-b11af851c4d5@gmail.com>
        <xmqq7eus3nr2.fsf@gitster.mtv.corp.google.com>
        <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com>
Date:   Wed, 15 Nov 2017 10:12:10 +0900
In-Reply-To: <73fd93cd-91f4-1286-732c-cd8185fe2027@gmail.com> (Ben Peart's
        message of "Tue, 14 Nov 2017 10:40:00 -0500")
Message-ID: <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02727B1A-C9A2-11E7-A250-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> I have no thoughts or plans for changes in the future of IEOT (which I
> plan to rename ITOC).  At this point in time, I can't even imagine
> what else we'd want as the index only contains cache entries, ...

Yeah, but the thing is that this is open source, and the imagination
of the originator of the initial idea does not limit how the code
and data structure evolves.

Back when I added the index extensions to the system, I didn't have
perfect foresight, and I didn't have specific plans to add anything
beyond "TREE" to optimize "write-tree" and "diff-index --cached".

In hindsight, I got one thing right and one thing wrong.

Even though I didn't have any plan to add a mandatory extension, I
made the code to ignore optional ones and error out on mandatory
ones if an index extension section is not understood.  It turns out
that later (in fact much later---the "TREE" extension dates back to
April 2006, while "link" came in June 2014) we could add the
split-index mode without having to worry about older versions of Git
doing random wrong things when they see this new extension, thanks
to that design decision.  That went well.

On the other hand, I didn't think things through to realize that
some operations may want to peek only the extensions without ever
using the main table, that some other operations may want to read
some extensions first before reading the main table, or more
importantly, that these limitations would start mattering once Git
becomes popular enough and starts housing a project tree with very
many paths in the main table.  

I really wish somebody had brought it up as a potential issue during
the review---I would have defined the extended index format to have
the simple extension at the end that points back to the tail end of
the main table back then, and we wouldn't be having this back and
forth now.  But I was just too happy and excited that I have found a
room to squeeze extension sections into the index file format
without breaking existing implementations of Git (which checked the
trailer checksum matches to the result of hashing the whole thing,
and read the recorded number of entries from the main table, without
even noticing that there is a gap in between), and that excitement
blinded me.

> I understand the risk but the list of offsets into the cache entries
> is pretty simple as well. I prefer the simplicity of a single TOC
> extension that gives us random access to the entire index rather than
> having to piece one together using multiple extensions.  That model
> has its own set of risks and tradeoffs.

I thought that you are not using the "where does the series of
extensions begin" information in the first place, no?  That piece of
information is useful independent of the usefulness of "index into
the main table to list entries where the prefix-compression is
reset".  So if anything, I'd prefer the simplicity of introducing
that "where does the series of extensions begin" that does not say
anything else, and build on other things like ITOC as mere users of
the mechanism.

