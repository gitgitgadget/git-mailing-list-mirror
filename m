Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27AC51FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 19:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965821AbcLVTdu (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 14:33:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54413 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754244AbcLVTdt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 14:33:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00A7F589D2;
        Thu, 22 Dec 2016 14:33:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/+TS1osZhoOztNtCVhB0WOBdy5w=; b=DovE+S
        Rkt+TG+rEzqOXnVQe7v5inW9KPYVJBrcZSIcOTFNbIHu2m554wo4FCKdng+fArJz
        SaKo3MN1XR53mTgDbJuMMbblpaRJ8hIPrcbOnpBFd0UTOtUIK4B3WzSJibaMNIwV
        x0YtVLA/UkOZVgWT2iiJNOmE4uJ7FPc56wEgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wBuzjRNcMeyYOOncrxHD95l2+0DKAF/9
        r3nYCQpY4ySWtO8mTYtGP5uUitlTEq6GcazyU5VWfVIte/NWzlSyI85iqUWfuMjB
        7HZIBHlUiaQKqN2di6zPd5gGdgQfPb0LaKepPtsnWywDAbOtOuHCWvCCBbWwiMqr
        oEULD7dtVIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E838B589D1;
        Thu, 22 Dec 2016 14:33:47 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 63BB7589D0;
        Thu, 22 Dec 2016 14:33:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        sbeller@google.com, peff@peff.net, jacob.keller@gmail.com,
        ramsay@ramsayjones.plus.com, tboegi@web.de, pclouds@gmail.com
Subject: Re: [PATCH bw/realpath-wo-chdir] real_path: canonicalize directory separators in root parts
References: <1481241494-6861-1-git-send-email-bmwill@google.com>
        <1481566615-75299-1-git-send-email-bmwill@google.com>
        <097e3e2e-f46d-b0aa-be9c-68c274c5e3dc@kdbg.org>
        <20161221223304.GA119874@google.com>
        <0c9aa347-d64e-b7d7-9b07-52d844d76252@kdbg.org>
        <20161222173301.GB119874@google.com>
Date:   Thu, 22 Dec 2016 11:33:46 -0800
In-Reply-To: <20161222173301.GB119874@google.com> (Brandon Williams's message
        of "Thu, 22 Dec 2016 09:33:01 -0800")
Message-ID: <xmqqmvfng3mt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EDFA8B0-C87D-11E6-B66D-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 12/22, Johannes Sixt wrote:
>> Am 21.12.2016 um 23:33 schrieb Brandon Williams:
>> >On 12/21, Johannes Sixt wrote:
>> >>+/* copies root part from remaining to resolved, canonicalizing it on the way */
>> >>+static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
>> >>+{
>> >>+	int offset = offset_1st_component(remaining->buf);
>> >>+
>> >>+	strbuf_reset(resolved);
>> >>+	strbuf_add(resolved, remaining->buf, offset);
>> >>+#ifdef GIT_WINDOWS_NATIVE
>> >>+	convert_slashes(resolved->buf);
>> >>+#endif
>> >
>> >So then the only extra cononicalization that is happening here is
>> >converting '\\server\share' to '//server/share'? (or 'c:\' to 'c:/')
>> 
>> Correct. All other directory separators are canonicalized by the
>> primary function, strbuf_realpath.
>
> Sounds good. Logically everything looks good to me.  And I like that
> setting 'resolved' to the root of an abs path is pulled out into a
> helper function.  It took me a couple extra seconds to realize that
> offset_1st_component returns 0 with a relative path, which makes causes
> the call to get_root_part to essentially be a noop (ie nothing is
> resolved).
>
> Thanks for helping get this to work on windows!

Thanks, both.  

Let's move the topic with this patch to 'next'.  Further
micro-optimization can be done incrementally if desired.



