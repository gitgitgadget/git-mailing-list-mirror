Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFE61FF40
	for <e@80x24.org>; Wed, 21 Dec 2016 18:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755764AbcLUSK6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Dec 2016 13:10:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64574 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752790AbcLUSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2016 13:10:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FA345856D;
        Wed, 21 Dec 2016 13:10:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bBnfZKeK/uOg
        ikzOa/5lnG6qpKY=; b=mIG+7DeZP2YqbzaGpMawlvbp/NLZfnUhqOtVtaF7e3Gb
        +0ZmazXKGQktgZTUMrCyFhH0/mWMq0uBYCzEizHy+GBjOHk3jXYmOvuQUacWCCdr
        FU9TzdTi6u6qGgcHT2FsjjX0KMoilbL8I8jFxPEqOEz7ti3960KMfjc8ui21Vkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=nPHucz
        TF1CqZVxCEOGTQrX9mCCoNIuIhuw9BfMiFRf5e3x9GW1ieVmGWKcxOObbS8Nxd9O
        VfS0EYWrBEplAhUKB8Gjj8C6EjpSmF+i7RCd4DpxjVdxKdiFX8JuZdAjNUkQAjnq
        7rphlspxXtC4QVofDDqv2c3P+3we1K0RO1uUY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 96FF75856C;
        Wed, 21 Dec 2016 13:10:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12A4D5856B;
        Wed, 21 Dec 2016 13:10:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] string-list: make compare function compatible with qsort(3)
References: <c7bac0b7-c555-162f-7880-0355831cee48@web.de>
Date:   Wed, 21 Dec 2016 10:10:54 -0800
In-Reply-To: <c7bac0b7-c555-162f-7880-0355831cee48@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 21 Dec 2016 10:36:41 +0100")
Message-ID: <xmqqy3z9i24x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D1477B04-C7A8-11E6-9161-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> The cmp member of struct string_list points to a comparison function
> that is used for sorting and searching of list items.  It takes two
> string pointers -- like strcmp(3), which is in fact the default;
> cmp_items() provides a qsort(3) compatible interface by passing the
> string members of two struct string_list_item pointers to cmp.
>
> One shortcoming is that the comparison function is restricted to workin=
g
> with the string members of items; util is inaccessible to it.  Another
> one is that the value of cmp is passed in a global variable to
> cmp_items(), making string_list_sort() non-reentrant.

I think it is insane to make util accessible to the comparison
function in the first place.

A string-list is primarily a table of strings that can be used to
quickly look up a string in it (or detect absense of it), and
optionally set and get the data associated to that string.  If you
allow the comparison function to take anything other than the string
itself into account, you can no longer binary search unless you
force callers to specify what to put in util when a string is added
to the table, and you also remove the ability to modify util once a
string is added to the table.

The string-list API exposes the "append without sorting and then
sort before starting to look up efficiently with a binary search",
and I think that is its biggest misdesign.  Such an optimization
would have been hidden from callers in a correctly designed API by
making sure sorting happens lazily when a function that wants to see
a sorted nature of the list for the first time, but somehow we ended
up with an API with separate functions _insert() and _append() with
an explicit _sort().  It then leads to unsorted_*_lookup() and
similar mess, that imply that a string-list can be used not as a
look-up table but just an unordered bag of items.  In our attempt to
make it serve as these two quite different things, it has become
good API for neither of its two uses.  The caller is forced to know
when the list is not sorted and unsorted_* variant must be used, for
example.  "Perhaps it makes it even more flexible if we made util
available to ordering decision" is a line of thinking that makes it
even worse.

I do agree that non-reentrancy is an issue that is worth solving,
though.

