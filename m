Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182FC1FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 06:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750858AbcLLGTe (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 01:19:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54604 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750720AbcLLGTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 01:19:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65B4C58F73;
        Mon, 12 Dec 2016 01:19:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=068+WZr0IUPjdOL1r6Qz6ADzFco=; b=BxBRHk
        DgMoBaYkUvW9qZK5NvQU6EYRwU5MdTKT/qPpy17Vkeh5LPJ8Jx4kKB4UfP/RE3GU
        66c04Q0b0Y2RkVNyHRiycfDvnYuRsXgKjIcM2uLVPKyVChpy2DiQXNYYsFQGXR28
        z0U9jwdvTET6wMej4J16L/rPrpCsNqbLIzzAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bBl6yj3r+ZF3s6DvyrZjZqQ+6YxltcBo
        nRENxzqRqT3ho/Uxdr4KP7xYHYi8u0wpbF7tWPXf5VHwl9r/S7TCqMtXc2qztamg
        5Fdc1GfVRJGnNv2kFUJeC8iyIjU4kDLcWkl9Vwx1v+TRNDksYHNPmZ73aTyE/ZuV
        UBjWLpL58MQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B3EE58F72;
        Mon, 12 Dec 2016 01:19:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC75A58F70;
        Mon, 12 Dec 2016 01:19:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 12/16] pathspec: create parse_long_magic function
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
        <1481223550-65277-1-git-send-email-bmwill@google.com>
        <1481223550-65277-13-git-send-email-bmwill@google.com>
        <xmqqwpf8pt0g.fsf@gitster.mtv.corp.google.com>
        <CAGZ79ka0P0rKF8QH3V0jC-O19eT0oaE+fJLGifbfmm3jC_SijA@mail.gmail.com>
        <xmqqk2b7ps08.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbbk4vdW_mbC0riXOf=31V9AQV7zKEh56G+sxjjzAr2-g@mail.gmail.com>
Date:   Sun, 11 Dec 2016 22:19:30 -0800
In-Reply-To: <CAGZ79kbbk4vdW_mbC0riXOf=31V9AQV7zKEh56G+sxjjzAr2-g@mail.gmail.com>
        (Stefan Beller's message of "Sun, 11 Dec 2016 21:38:26 -0800")
Message-ID: <xmqqfultoej1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1C56904-C032-11E6-85C3-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I do not see how it would work without further splitting the
>> attr_stack.  I think you made it per check[], but you would further
>> split it per <check, thread> before losing the mutex, no?
>
> Well I have not yet looked into it again, so my memories are
> rusty, but the <check> is read only, such that the answers only
> need to be per thread?

<check> is read-only, so as long as you populate the singleton
attr's beforehand, they can be shared across threads.  <answer>
of course needs an instance per thread, and that is why you have
them typically on stack.

The process of filling <answer> by asking for a set of attrs in
<check> for one <path> goes roughly like:

 - make sure attr_stack is set up for <path>, namely, the
   info/attributes and .gitattributes files for each leading
   directory are parsed.

 - go over the attr_stack entries and see what entries match <path>,
   and collect the result for <check> in <answer>

Before d90675c151 ("attr: keep attr stack for each check",
2016-11-10), I had only one instance of an attr stack [*1*], but
with that commit, you made it per <check>, which is a good move to
allow us to optimize by keeping only the attributes relevant to
<check> on the attr stack.

But it does not solve the threading issue.

If multiple threads are asking for the same set of attrs
(i.e. running the same codepath using the same <check>) but for
<path>s in different parts of the working tree (e.g. "git checkout"
that is multi-threaded, each thread asking for eol related
attributes and checking out different subdirectories), you'd need
mutex for correct operation at least, but that won't perform well
because you'd end up thrashing the attr stack.  You'd need to split
attr stack further and make it per (<check>, thread) tuple and you
no longer need mutex at that point, but not before that.


[footnote]

*1* This is because the attr subsystem originally wasn't designed to
    be used from multiple threads at the same time hence it was
    sufficient to have a single "currently interested are of the
    directory hierarchy".
