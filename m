Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE6C433F5
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiBRSUD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:20:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiBRSUC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:20:02 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A101007
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:19:45 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1246318D77C;
        Fri, 18 Feb 2022 13:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sPT8GEnr4Aw9
        qf1kaRfSMVzBRToXZXrN363UNw8F7/0=; b=INwVm1lsmdItePmu/RCZF6hzBnbu
        sPdDvbZ/CmYLHp5ezyU3WOb0AgPF8N8OUDUJbAsxZ1HQsLZRE8H9Saw/rA7eAnRD
        cXYnK9WF92tIXKRPtwl3lRRN6VP5C/6eqkf2+QbX0Xgagl0TxFxUQ1mK5SonlX/e
        pQYejTW0t80YMy8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BA8B18D77B;
        Fri, 18 Feb 2022 13:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 76A8E18D773;
        Fri, 18 Feb 2022 13:19:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Andrzej Hunt <ajrhunt@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: Whether to keep using UNLEAK() in built-ins
References: <cover-0.2-00000000000-20220216T081844Z-avarab@gmail.com>
        <patch-2.2-e3e78c9e40b-20220216T081844Z-avarab@gmail.com>
        <xmqqa6equ1rq.fsf@gitster.g> <xmqqtucyslz9.fsf@gitster.g>
        <220218.861r00ib86.gmgdl@evledraar.gmail.com>
Date:   Fri, 18 Feb 2022 10:19:41 -0800
In-Reply-To: <220218.861r00ib86.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 18 Feb 2022 13:35:12 +0100")
Message-ID: <xmqqwnhs11he.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 57B599F2-90E7-11EC-ACC5-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>>> Specifically, the cited commit turned an existing strbuf_release()
>>> on &err into UNLEAK().  If that and the other strbuf (sb) were so
>>> easily releasable, why didn't we do so back then already?
>>
>> I suspect that the answer to the above question is because these
>> allocations are in the top-level cmd_commit() function, which is
>> never called recursively or repeatedly as a subroutine.  The only
>> significant thing that happens after we return from it is to exit.
>>
>> In such a code path, marking a variable as UNLEAK() is a better
>> thing to do than calling strbuf_release().  Both will work as a way
>> to squelch sanitizers from reporting a leak that does not matter,
>> but calling strbuf_release() means we'd spend extra cycles to return
>> pieces of memory to the pool, even though we know that the pool
>> itself will be cleaned immediately later at exit.
>>
>> We already have UNLEAK to tell sanitizers not to distract us from
>> spotting and plugging real leaks by reporting these apparent leaks
>> that do not matter.  It is of somewhat dubious value to do a "we
>> care too much about pleasing sanitizer and spend extra cycles at
>> runtime while real users are doing real work" change.

> Per https://lore.kernel.org/git/87a6k8daeu.fsf@evledraar.gmail.com/ the
> real goal I have in mind here is to use the built-ins as a stand-in for
> testing whether the underlying APIs are leak-free.
>
> Because of that having to reason about UNLEAK() doing the right thing o=
r
> not is just unneeded distraction. Yes for a "struct strbuf" it won't
> matter, but most of what we UNLEAK() is more complex stuff like "struct
> rev_info". We won't really make headway making revision.c not leak
> memory without using "git log" et al as the test subjects for whether
> that API leaks.

I have to say that you have a wrong goal and wrong priority.  The
number of UNLEAK in cmd_foo() functions is not even a poor
approximation of our progress.

Imagine that a subsystem that are repeatedly set-up and used during
a single program invocation was leaky.  Let's say a program calls
diff_setup() to prepare the diff_options structure, feeds two things
to compare, and calls diff_flush() to show the comparison result,
but let's assume this sequence leaks some resources.

Now cmd_diff() may be such a program that does a setup, feeds two
trees, calls diff_flush() and exits.  If we didn't do anything to
it, diff_options may "leak".  Marking it with UNLEAK may be a good
measure, if we want to keep the leak checker from reporting a leak
that does not matter in practice so that we can concentrate on
plugging real leaks that matter.

But consider cmd_log(), running something like "git log -p".  It
iterates over commits, does the <setup, compare two trees, flush>
repeatedly for each commit it encounters during the walk on the same
diff_options structure.  Now, the leak in the code path does matter.
If diff_flush() is left leaky, it will show up in the leak checker's
output, and that is reporting real leaks that matter.  The thing is,
the <setup, compare, flush> sequence whose leak matters is not in
cmd_log(); it is much deeper in the revision walking machinery.  We
do not want to paper over such leaks with UNLEAK.

See the difference?  The number of UNLEAK OUTside built-ins does
matter.  We do not want to have UNLEAK there to hide leaks in
possible callees that may be called arbitrary number of times in
arbitrary order.  Compared to that, UNLEAK in cmd_foo() to mark an
on-stack variable that was used only once without even a recursion
is purely to squelch the leak checker from reporting leaks that does
not matter.  For simple things like strbuf on stack of the top-level
cmd_foo() functions, we could even leave strbuf_release() not called
and leave the resource reclamation to _exit(2).  That would cause
the leak checkers to report them and distract us, and UNLEAK is a
better way to squelch the distraction without wasting extra cycles
at runtime to actually free them.

So, don't look at "built-ins as a stand-in".  It is a wrong
direction to go in to let the "leak checker" tail wag the dog.

Thanks.
