Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 422F21FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932343AbdJ0Q6G (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 12:58:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61910 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932340AbdJ0Q6F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 12:58:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0930B916F;
        Fri, 27 Oct 2017 12:58:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=792Na/T8fk3bNxEezhpS7Nq6n14=; b=DjZhE8
        m/j+cMLgnaZ9U6MPBmV+F+80hIwsE8aZHUJeHLo7+pkcS1M/rWHHfmmOn61zNSMJ
        0zuWp1Uzdo0m2eB8S5i5kcsLuDQpV4WH63EUaUd5rUkhnTTSLIIR4pNH5x2T78SN
        0Au2raEJn8fTBYaVGh73uDRJsmGUo/+SVegpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cjuWuOgG5gC7stK4HiCRIS0oGxfBLNIo
        eWAb4znC+a3bdj48M4lZzRrUZAZU9BcSs/qYc/nVFYfzprokl8Ch9B3NpxqOxWat
        7iubnI0BLQ+4jixq5MvTOjhi/AGIFovsYApqqse2332qk50wzdICiJ8HYe0z9cIV
        bBP8eogIbU8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B674FB916E;
        Fri, 27 Oct 2017 12:58:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2E79AB916D;
        Fri, 27 Oct 2017 12:58:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey Okoshkin <a.okoshkin@samsung.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, pclouds@gmail.com,
        Ivan Arishchenko <i.arishchenk@samsung.com>
Subject: Re: [PATCH] diff: fix lstat() error handling in diff_populate_filespec()
References: <CGME20171027093331epcas2p1a945263c12b8ba608492693da4e3eff2@epcas2p1.samsung.com>
        <72e8146b-d4ab-ad7e-6afd-9168806eeca2@samsung.com>
        <xmqq3764czv9.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 28 Oct 2017 01:58:02 +0900
In-Reply-To: <xmqq3764czv9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sat, 28 Oct 2017 01:35:54 +0900")
Message-ID: <xmqqy3nwbk9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF7D3DB4-BB37-11E7-9C25-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Andrey Okoshkin <a.okoshkin@samsung.com> writes:
>
>> I'm not sure why only ENOENT error of lstat() is considered as an
>> error but passing by other errno values leads to reading of
>> uninitialized 'struct stat st' variable.  It means that the
>> populated 'diff_filespec' structure may be incorrectly filled.
>
> Entirely correct.  There is no fundamental reason to try special
> casing ENOENT, unless we are clearing the "this is an error" bit
> when the errno is ENOENT---but this code does not even do so.  All
> errors are errors---we wanted to know the result of lstat() to carry
> on, and we couldn't figure out the status.  We do not want to die
> immediately (instead we want to show diffs for other paths), so
> substituting the result with an empty string is the least bad thing
> we can do at this point in the code.

By the way, if the reason why we are hitting this lstat(2) (not the
reason why lstat(2) is failing) is not because !s->oid.valid
(i.e. we are reading the working tree side because that is what is
on one side of the comparison) but because reuse_worktree_file()
told us to (i.e. we actually are trying to fill the filespec with
the blob contents, but found that we have already the same content
in a working tree file and found it more efficient to read from
there, rather than doing the read_sha1_file() on the s->oid.hash),
it probably is better to fall back to the other side of the if/else
when we see an error from this lstat(2) and pretend as if we got
false from reuse_worktree_file().  

That would allow us continue with the correct information we
originally wanted to use; after all, reusing is merely an
optimization.
