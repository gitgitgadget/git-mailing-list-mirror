Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DA8F20193
	for <e@80x24.org>; Mon, 24 Oct 2016 20:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939006AbcJXU35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 16:29:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52184 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935599AbcJXU34 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 16:29:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3995A479CA;
        Mon, 24 Oct 2016 16:29:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9lDYp24NyHzkPQjRRMqPp1SRRLU=; b=KrLJp5
        kV7j0uxJ3XkuI3ZzrkYk3TSYQdVdGdPo6I1xewyAvPiA9vm80RygDUjiFxeE+N4D
        xDvBGGemAKDinHfVD5vYPqZYC7dWE/nGtAYsyHUcZ483SHNIxlfwNp5P3g2yBl0U
        iVM84UNtJMVZUx4wcBg2wd7qwlqxTUzD+5TSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rz/h3VBdU9JvrVUsjYHrHtIf1vQz1cD2
        N65zUCTlkXHaWlHgy6P4jn8sRzDKu+PV4Qz6UcQym1AAY1j0UpQ5xUXJAjdxbWqH
        C8Z1QquFlYK8TlkxPLP+DCJdI6c2dWjUocbunGB+prBfvcdwYYnZ+kQSvjEGMYBL
        g/UhzSK0qYE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 31427479C9;
        Mon, 24 Oct 2016 16:29:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB855479C8;
        Mon, 24 Oct 2016 16:29:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 28/36] attr: keep attr stack for each check
References: <20161022233225.8883-1-sbeller@google.com>
        <20161022233225.8883-29-sbeller@google.com>
        <xmqqmvht5zwx.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZ_7eG4uCXwyg0F=-hjmuT1dCAATSRnY293qkNC6siM5Q@mail.gmail.com>
Date:   Mon, 24 Oct 2016 13:29:52 -0700
In-Reply-To: <CAGZ79kZ_7eG4uCXwyg0F=-hjmuT1dCAATSRnY293qkNC6siM5Q@mail.gmail.com>
        (Stefan Beller's message of "Mon, 24 Oct 2016 12:32:32 -0700")
Message-ID: <xmqqlgxd32yn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F87ACC2-9A28-11E6-BBD1-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I looked for a platform independent way to get a thread id as a natural
> number, i.e. I want to get 1,2,3,... such that I could have just added
> list/array of attr stacks to each check, which would be the
> <check, thread> tuple you envision.
>
> However I think we do not really need it to be per check.  If we had
> an easy portable way of getting such a thread id, I would have implemented
> a list of stacks per thread first. (Because each thread only looks at one
> check at a time.)

It seems that by "list of stacks per thread", you mean "there is a
list of stacks, each thread uses one and only element of that list",
but I do not think it would be desirable.

"Each thread only looks at one check at a time" is false.  For
example, "write_archive_entry()" would use one check that is
specific to "git archive" to learn about "export-ignore" and
"export-subst" attributes, while letting convert_to_write_tree()
called via sha1_file_to_archive() called via write_entry() method
(i.e. write_tar_entry() or write_zip_entry()) to use a separate
check that is specific to the convert.c API.

>> With manipulation of attr stack protected with a single Big
>> Attributes Lock, this should be safe.  It may not perform very well
>> when used by multiple threads, though ;-)
>
> I agree. So maybe it is not really a good fit for general consumption yet.

I would still think it is a good first step.  It may already be
thread-safe, but may not be thread-ready from performance point of
view.  IOW, this would not yet help an attempt to make the callers
faster by making them multi-threaded.

