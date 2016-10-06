Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8078C207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934797AbcJFTXq (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:23:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53787 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934725AbcJFTXo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:23:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E3F344DD2;
        Thu,  6 Oct 2016 15:23:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=6q0hij2dV6eSZazbQ2/hBZETQps=; b=lWnFAjXu9C/fsiRFSeeQ
        xI6KZpJxXDUJ71rqiHFQyutcSbz0NkL+8zlQQus8visV564pElmpOI9l1kK7uALM
        H5HFXwBv82HJf+Yb2GE1EsJ7qF86AbIQZahMD/eA45l86XyYoR2zDslQAVC9Jf20
        aXpEpze9BeqQQXx+rDwrsB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ayyb24av6XE1vJAXwXWqAzE4t5IGeEg4W7+F7xOi6SEW7X
        MXwIh5o0P3Eni5aHlDe0RbAtWqCMKSbp6soOwfdUK2VL0BW39s58mPspz00UXYxu
        L9AOLZ0UqHUiWN9DQPlAI8ChGXNnLgydwjQZT5WApLQUOIOuZBBxVqS8CbZz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 775BD44DD1;
        Thu,  6 Oct 2016 15:23:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ED1F744DD0;
        Thu,  6 Oct 2016 15:23:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 05/25] sequencer: allow the sequencer to take custody of malloc()ed data
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
        <cover.1473590966.git.johannes.schindelin@gmx.de>
        <942aa559a0af9b52e079c5c78fa313f49b87d50d.1473590966.git.johannes.schindelin@gmx.de>
        <xmqqzinc295y.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610051338530.35196@virtualbox>
Date:   Thu, 06 Oct 2016 12:23:40 -0700
Message-ID: <xmqqeg3tjn7n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64C17DAC-8BFA-11E6-927D-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you prefer to accept such sloppy work, I will change it of course,
> feeling dirty that it has my name on it.

I do want neither leaks nor sloppyness, and I thought that was
understood by everybody, hence I thought the last round made it
clear that _entrust() must not exist.

Let's try again.

We manage lifetime of a field in a structure in one of three ways in
our codebase [*1*].

 * A field can always point at a borrowed piece of memory that the
   destruction of the containing structure or re-assignment to the
   field do not have to free the current value of the field.  This
   is a minority, simply because it is rare for a field to be always
   able to borrow from others.  The destruction of the containing
   structure or re-assignment to the field needs to do nothing
   special.

 * A field can own the piece of memory that it points at.  The
   destruction of the containing structure or re-assignment to the
   field needs to free the current value of the field [*2*].  A
   field that can be assigned a value from the configuration (which
   is typically xstrdup()'ed) is an example of such a field, and if
   a command line option also can assign to the field, we'd need to
   xstrdup() it, even though we know we could borrow from argv[],
   because cleaning-up needs to be able to free(3) it.

 * A field can sometimes own and sometimes borrow the memory, and it
   is accompanied by another field to tell which case it is, so that
   cleaning-up can tell when it needs to be free(3)d.  This is a
   minority case, and we generally avoid it especially in modern
   code for small allocation, as it makes the lifetime rule more
   complex than it is worth.

The _entrust() thing may have been an excellent fourth option if it
were cost-free.  xstrdup() that the second approach necessitates for
literal strings (like part of argv[]) would become unnecessary and
we can treat as if all the fields in a structure were all borrowing
the memory from elsewhere (in fact, _entrust() creates the missing
owners of pieces of memory that need to be freed later); essentially
it turns a "mixed ownership" case into the first approach.

But it is not cost-free.  The mechanism needs to allocate memory to
become the missing owner and keep track of which pieces of memory
need to be freed later, and the resulting code does not become any
easier to follow.  The programmer still needs to know which ones to
_entrust() just like the programmer in the model #2 needs to make
sure xstrdup() is done for appropriate pieces of memory--the only
difference is that an _entrust() programmer needs to mark the pieces
of memory to be freed, while a #2 programmer needs to xstrdup() the
pieces of memory that are being "borrowed".

So let's not add the fourth way to our codebase.  "mixed ownership"
case should be turned into "field owns the memory", i.e. approach #2.


[Footnotes]

*1* It is normal for different fields in the same structure follow
    different lifetime rules.

*2* Unless leaks are allowed, that is.  I think we have instances
    where "git cmd --opt=A --opt=B" allocates and stores a new piece
    of memory that is computed based on A and store it to a field,
    and then overwrites the field with another allocation of a value
    based on B without freeing old value, saying "the caller can
    avoid passing the same thing twice, and such a leak is miniscule
    anyway".  That is not nice, and we've been reducing them over
    time.
