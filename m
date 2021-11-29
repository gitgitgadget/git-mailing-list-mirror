Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6D7C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351001AbhK2TZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:25:25 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54610 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhK2TXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:23:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2582915FC36;
        Mon, 29 Nov 2021 14:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DbsPQHl+YDBYNX6pXHX2GUpZSQtv2vSMMiIFAK
        b3NrA=; b=qBP4F6JXIDl9jvnkkHOj8LmaslxWzKu6+jPclXSyyyQXjs2Wuy3M8X
        ZiuegbEWggUVqzIHIYVBclpq56F0UCivkecoj5V/IXCcN8ELStiIYaH5eE0dvz+C
        LtsSMiEht0R86wzMNX63FyQTnfV1LJrfuJvPyMo4KRgt8FZiYqerI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1D76B15FC35;
        Mon, 29 Nov 2021 14:20:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A14715FC33;
        Mon, 29 Nov 2021 14:20:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 5/5] refs/debug: trim trailing LF from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
        <0288e743eb2e96e2effd6b0b90c6f885009bf337.1637855872.git.gitgitgadget@gmail.com>
        <xmqqilwf72nf.fsf@gitster.g>
        <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
Date:   Mon, 29 Nov 2021 11:19:59 -0800
In-Reply-To: <CAFQ2z_N20ESyzkPLdGbS9q8HEHGB7_gmaX8FUBR=jGqXLGcL1Q@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 29 Nov 2021 19:29:18 +0100")
Message-ID: <xmqq1r2y7ork.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5927D1AC-5149-11EC-8B74-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Nov 26, 2021 at 9:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The API promises to have only LF, not CRLF, at the end, so
>> strbuf_trim_trailing_newline() is a bit overkill (and if payload
>> happened to end with CR, we would lose it).
>
> it would be best if there was a way to escape characters (ie. "\n" =>
> "\\n"). Do we have a function for that?

Mere escaping would not work in a backward compatible way, without a
trick.  It was envisioned that we probably could encode *and* signal
the fact that the message is encoded by appending a trailing SP at
the end of the message.  See the log message of 523fa69c (reflog:
cleanse messages in the refs.c layer, 2020-07-10) for details.

Having said that, that is about introducing a whole new reflog
message format (whose use is signalled by the trailing SP), and I
would prefer it to happen

 (1) after we integrate with reftable, and

 (2) implemented as an option in the normalize_reflog_message()
     function, so that no ref backends has to worry about it.

outside this topic.

> I beg to differ - despite this being fewer lines of code, I think
> pointer arithmetic is best avoided if possible.

I think repeated allocation and deallocation is best avoided, and
that is why I recommended it.  I do not see anything to fear in
poiter arithmetic, as long as it is done clearly (e.g. in a narrow
scope) and correctly.

If trace_printf() does not allow counted bytes "%.*s", the whole
discussion is moot; I didn't go back to check.
