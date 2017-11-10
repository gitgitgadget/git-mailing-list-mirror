Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D49201C8
	for <e@80x24.org>; Fri, 10 Nov 2017 04:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755968AbdKJEqk (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 23:46:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60975 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755858AbdKJEqj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 23:46:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9172B9FB4;
        Thu,  9 Nov 2017 23:46:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ysCSn/VQgj+97q3PfDo3ZHHiKrs=; b=hz70bP
        aQdhdCqZlImZ6x04nh5CUGPwFisgCDGzpyy5oYYmhA3mp29p+PAqySo0XhWVON2/
        1K1e7R4/alDHI9coxXfWfdKmqYybv/quvl6k7DY1L5DZv0ZvQV3eX4shL580RQ1g
        l+YehQwxQMBRAjG9s7xLANFNw/VbvTtge5ED0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dcsouLsknsexEFEiQuTGHvCRritdN4Fx
        UI4Q0UF1ssGo/r+VC3OkO4vUlgbwtfBlhTOiB+WA9mUBCt7A+ny1n7vRvdlZW25Q
        CYg10eO2iimSqwLhHRPzTnI0u75m7aXhlO3yplVM4pQZsWGHUKirwyjpPqAdU7wu
        py47FN5/bQQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0E98B9FB3;
        Thu,  9 Nov 2017 23:46:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DE71B9FB2;
        Thu,  9 Nov 2017 23:46:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, chriscool@tuxfamily.org,
        Johannes.Schindelin@gmx.de, alexmv@dropbox.com, peff@peff.net
Subject: Re: [PATCH v1 1/4] fastindex: speed up index load through parallelization
References: <20171109141737.47976-1-benpeart@microsoft.com>
        <20171109141737.47976-2-benpeart@microsoft.com>
Date:   Fri, 10 Nov 2017 13:46:36 +0900
In-Reply-To: <20171109141737.47976-2-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 9 Nov 2017 09:17:34 -0500")
Message-ID: <xmqqbmkahhar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22B2CD40-C5D2-11E7-8249-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> To make this work for V4 indexes, when writing the index, it periodically
> "resets" the prefix-compression by encoding the current entry as if the
> path name for the previous entry is completely different and saves the
> offset of that entry in the IEOT.  Basically, with V4 indexes, it
> generates offsets into blocks of prefix-compressed entries.

You specifically mentioned about this change in your earlier
correspondence on this series, and it reminds me of Shawn's reftable
proposal that also is heavily depended on prefix compression with
occasional reset to allow scanning from an entry in the middle.  I
find it a totally sensible design choice.

> To enable reading the IEOT extension before reading all the variable
> length cache entries and other extensions, the IEOT is written last,
> right before the trailing SHA1.

OK, we have already closed the door for further enhancements to
place something other than the index extensions after this block by
mistakenly made it the rule that the end of the series of extended
sections must coincide with the beginning of the trailing checksum,
so it does not sound all that bad to insist on this particular one
to be the last, I guess.  But see below...

> The format of that extension has the signature bytes and size at the
> beginning (like a normal extension) as well as at the end in reverse
> order to enable parsing the extension by seeking back from the end of
> the file.

I think this is a reasonable workaround to allow a single extension
that needs to be read before the main index is loaded.  

But I'd suggest taking this approach one step further.  Instead,
what if we introduce a new extension EOIE ("end of index entries")
whose sole purpose is to sit at the end of the series of extensions
and point at the beginning of the index extension section of the
file, to tell you where to seek in order to skip the main index?

That way, you can

 - seek to the end of the index file;

 - go backward skiping the trailing file checksum;

 - now you might be at the end of the EOIE extension.  seek back
   necessary number of bytes and verify EOIE header, pick up the
   recorded file offset of the beginning of the extensions section.

 - The 4-byte sequence you found may happen to match EOIE but that
   is not enough to be sure that you indeed have such an extension.
   So the following must be done carefully, allowing the possibility
   that there wasn't any EOIE extension at the end.
   Seek back to that offset, and repeat these three steps to skip
   over all extensions:

   - read the (possible) 4-byte header
   - read the (possible) extsize (validate that this is a sane value)
   - skip that many bytes

   until you come back to the location you assumed that you found
   your EOIE header, to make sure you did not get fooled by bytes
   that happened to look like one.  Some "extsize" you picked up
   during that process may lead you beyond the end of the index
   file, which would be a sure sign that what you found at the end
   of the index file was *not* the EOIE extension but a part of
   some other extension who happened to have these four bytes at the
   right place.

which would be a lot more robust way to allow any extensions to be
read before the main body of the index.

And a lot more importantly, we will leave the door open to allow
more than one index extensions that we would prefer to read before
reading the main body if we do it this way, because we can easily
skip things over without spending cycles once we have a robust way
to find where the end of the main index is.  After all, the reason
you placed IEOT at the end is not because you wanted to have it at
the very end.  You only wanted to be able to find where it is
without having to parse the variable-length records of the main
index.  And there may be other index extensions that wants to be
readable without reading the main part just like IEOT, and we do not
want to close the door for them.

Hmm?
