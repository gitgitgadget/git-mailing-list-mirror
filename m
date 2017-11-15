Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D56E3202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 04:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753931AbdKOElE (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 23:41:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64426 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752551AbdKOElC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 23:41:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D32A8978B4;
        Tue, 14 Nov 2017 23:41:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S0unxnZVWbDhXD7EPfo7MBH4BXs=; b=YYNodw
        1+gWPk4f0jn5prlvKTWBdVBE45hfoouOyTZvGdGbm1q0zBawdD7ryXFOcoq6Fyt1
        dl8a7xh5rPVlj79WdMraN9USSd7g/n1ISRBZBmryuZW8G7OW9SbN+/V/sAjOOPoF
        tAGlqI0Ct/0OcA8XCND8f1QiVPZ4e+cu+0Gx8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RVjkMRXuNk7Cuzr1J+VwRdTL7ayH3CTy
        0otyxIn7LBeguZ02jARldk+70ukAJhtLxIGmiCpUOHbEDESPwaLTR4rQQJdUNiDv
        tYYAv1f5gkAWjajb/jWfM4KoZIikvCGa4/aj/8HgH2tAUJDrqkkaXy0AXgg7OW+s
        tA6wUAk33/o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB3A2978AF;
        Tue, 14 Nov 2017 23:41:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34214978AD;
        Tue, 14 Nov 2017 23:41:01 -0500 (EST)
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
        <xmqqwp2s1h1x.fsf@gitster.mtv.corp.google.com>
        <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com>
Date:   Wed, 15 Nov 2017 13:40:59 +0900
In-Reply-To: <9ba23d2c-2198-55d7-5a02-69879fbbb3cb@gmail.com> (Ben Peart's
        message of "Tue, 14 Nov 2017 23:16:39 -0500")
Message-ID: <xmqq1sl017dw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E6DAD12-C9BF-11E7-9430-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> OK.  I'll call this new extension "EOIE" ("end of index
> entries"). Other than the standard header/footer, it will only contain
> a 32 bit offset to the beginning of the extension entries.  I'll
> always write out that extension unless you would prefer it be behind a
> setting (if so, what do you want it called and what should the default
> be)?  I won't add support in update-index for this extension.

To make it robust, if I were doing this, I would at least add a checksum
of some sort.  

As each extension section consists of 4-byte extension type, 4-byte
size, followed by that many bytes of the "meat" of the section, what
I had in mind when I suggested this backpointer was something like:

    "EOIE" <32-bit size> <32-bit offset> <20-byte hash>

where the size of the extension section is obviously 24-byte to
cover the offset plus hash, and the hash is computed over extension
types and their sizes (but not their contents---this is not about
protecting against file corruption and not worth wasting the cycles
for hashing) for all the extension sections this index file has
(except for "EOIE" at the end, for obvious reasons).  E.g. if we
have "TREE" extension that is N-bytes long, "REUC" extension that is
M-bytes long, followed by "EOIE", then the hash would be

	SHA-1("TREE" + <binary representation of N> +
	      "REUC" + <binary representation of M>)

Then the reader would

 - Seek back 32-byte from the trailer to ensure it sees "EOIE"
   followed by a correct size (24?)

 - Jump to the offset and find 4-bytes that presumably is the type
   of the first extension, followed by its size.  

 - Feed these 8-bytes to the hash, skip that section based on its
   size (while making sure we won't run off the end of the file,
   which is a sign that we thought EOIE exists when there wasn't).
   Repeat this until we hit where we found "EOIE" (or we notice our
   mistake by overrunning it).

 - Check the hash to make sure we got it right.

> Since the goal was to find a way to load the IEOT extension before the
> cache entries, I'll also refactor the extension reading loop into a
> function that takes a function pointer and add a
> preread_index_extension() function that can be passed in when that
> loop is run before the cache entries are loaded.  When the loop is run
> again after the cache entries are loaded, it will pass in the existing
> read_index_extension() function.  Extensions can then choose which
> function they want to be loaded in.
>
> The code to read/write/use the IEOT to parallelize the cache entry
> loading will stay behind a config setting that defaults to false (at
> least for now).  I'll stick with "core.fastindex" until someone can
> (please) propose a better name.

Sounds good.
