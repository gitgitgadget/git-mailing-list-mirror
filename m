Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8830C433E0
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A382620C09
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVbkwi5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbgFSTf0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:35:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55366 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388038AbgFSTfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:35:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 14FC170E29;
        Fri, 19 Jun 2020 15:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Iq5Z/7rMZh9ApOyNT4rHLtO6Rv8=; b=UVbkwi
        5efjWeJUrNHzV9Jqrg7Wlbc5S9r0qW6JUmCASbNG7aVKuAjX9RJ4hPcQnct51jKl
        6nDCPVyBHuq/brTZW84mB6XdfEb3Vidh9XSBhwuw5W2I4ebpd0HreAH0/1G3Jzp7
        zRR0fa6zrlBhVM4ypHrIIMY6wbPDCMOSa8S90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KzMWIHhzB7rMBwAWKm59Z4ZvCLTla4Gs
        NfboD/Tjp7pXTGo8/vChKe5/Zts8AGnCLbvRr+77VrlqRVIprj8uS6s+Wz16cvfn
        6JVikfqqtYIh1oKyi4jtJyTIqhtLlbt7LyOHy4gV33MsQXXJmijMSTOwfOH7SkFz
        t0h7Zi/+93U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BEC570E28;
        Fri, 19 Jun 2020 15:35:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 58EE970E27;
        Fri, 19 Jun 2020 15:35:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: [Possible Bug] Use of write on size-limited platforms
In-Reply-To: <028c01d6464b$235346c0$69f9d440$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 19 Jun 2020 11:05:52 -0400")
References: <015c01d63ddd$97d65080$c782f180$@nexbridge.com>
        <20200615215937.GA636737@coredump.intra.peff.net>
        <002801d64365$b6fdc2d0$24f94870$@nexbridge.com>
        <20200616080200.GA650578@coredump.intra.peff.net>
        <028c01d6464b$235346c0$69f9d440$@nexbridge.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Fri, 19 Jun 2020 12:35:19 -0700
Message-ID: <xmqq4kr6hmrs.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02EDABAC-B264-11EA-8581-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On June 16, 2020 4:02 AM, Peff wrote:
>> To: Randall S. Becker <rsbecker@nexbridge.com>
>> Cc: git@vger.kernel.org
>> Subject: Re: [Possible Bug] Use of write on size-limited platforms
>> 
>> On Mon, Jun 15, 2020 at 06:38:34PM -0400, Randall S. Becker wrote:
>> 
>> > > So I think this really ought to be using write_in_full(). There's
>> > > only one caller, and I think it would be improved by the switch. Do
>> > > you want to write a patch?
>> > >
>> > > You could make an argument that the fwrite() version ought to also
>> > > loop, since it's possible to get a partial write there, too. But we
>> > > don't do that in general. I suspect in practice most stdio
>> > > implementations will keep writing until they see an error, and most
>> > > callers don't bother checking stdio errors at all, or use ferror().
>> >
>> > I'll give the patch a go. It is very simple. Would you suggest
>> > removing the strbuf_write_fd() as part of this patch since it only
>> > impacts bugreport.c?
>> 
>> I could go either way on that. IMHO it isn't offering much over a bare
>> write_in_full() call. The "don't call write() if there are 0 bytes"
>> logic is part of write_in_full() already.
>
> Patch delivered.

I think these go in the right direction and would be good with minor
fixes.  I do agree with the other reviewer that dumping all the
contents of the buffer to die() may not be what we want (do we even
need to see the contents at all?).  Even though I do not mind too
much about the unneeded {braces}, I'd prefer to see it fixed if we
are rerolling the patch for other reason anyway.  And I think 2 and
3 can and should be a single patch---if we are removing a function
that is no longer used, we should remove both its decl and defn at
the same time.

Thanks.
